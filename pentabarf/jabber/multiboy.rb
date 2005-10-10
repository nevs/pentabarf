$:.unshift('../lib')
require 'momomoto/momomoto'
require 'momomoto/views'

require 'xmpp4r'
require 'xmpp4r/helpers/version'

require 'conference_entity'
require 'day_entity'
require 'daytime_entity'
require 'event_entity'
require 'person_entity'

class Multiboy
  ##
  # Initialize the Multiboy component handler
  # * Stores conference_id, exception_jids from config
  # * Initializes Momomoto
  # * Connects/authenticates the component stream
  # * Hooks an xmpp4r Version Helper
  # * Calls Multiboy#register_callbacks
  def initialize(config)
    @conference_id = config['conference_id']
    @base_url = config['base_url']
    @exception_jids = config['exception_jids']
    @changes_poll_interval = (config['changes_poll_interval'].to_i == 0) ? 60 : config['changes_poll_interval'].to_i

    momomoto_config = YAML::load_file("../config/database.yml")["production"]
    puts "Initializing Momomoto to #{momomoto_config['username']}@#{momomoto_config['host']}:#{momomoto_config['port'].to_i}/#{momomoto_config['database']}"
    Momomoto::Base.connect(momomoto_config)
    
    puts "Initializing XMPP component #{config['jabber_id']} on #{config['host']}:#{config['port'].to_i}"
    #Jabber::debug = true
    @stream = Jabber::Component.new(Jabber::JID.new(config['jabber_id']), config['host'], config['port'].to_i)

    puts "Registering callbacks"
    register_callbacks

    puts "Hooking Version helper"
    Jabber::Helpers::Version.new(@stream, "Pentabarf Multiboy", "0.1", IO.popen('uname -sr').readlines.to_s)

    puts "Connecting XMPP component"
    @stream.connect
    puts "Authenticating XMPP component"
    @stream.auth(config['password'])

    puts "Broadcasting subscribed presences"
    Dir.new('subscriptions').each { |filename|
      next if filename =~ /^\./
      ent = entity(Jabber::JID.new(filename))
      ent.broadcast_presence unless ent.nil?
    }

    @poll_thread = Thread.new { changes_poll }

    # TODO: Handle stream disconnects!
  end

  def run
    Thread.stop
  rescue Interrupt => e
    puts "Interrupted"

    @poll_thread.kill

    puts "Broadcasting subscribed presences"
    Dir.new('subscriptions').each { |filename|
      next if filename =~ /^\./
      ent = entity(Jabber::JID.new(filename))
      ent.broadcast_presence(:unavailable) unless ent.nil?
    }

    @stream.close
  end

  ##
  # Register all three XMPP stanza callbacks,
  # which will be piped to Multiboy#dispatch_stanza
  def register_callbacks
    @stream.add_presence_callback { |pres|
      dispatch_stanza(pres)
    }
    @stream.add_iq_callback { |iq|
      dispatch_stanza(iq)
    }
    @stream.add_message_callback { |msg|
      dispatch_stanza(msg)
    }
  end

  ##
  # Return a custom entity selected by the jid
  def entity(jid)
    res = nil

    if jid.node == nil
      res = ConferenceEntity.new(@stream, jid, @base_url, @conference_id)
    else
      jid.node.scan(/^day-(\d+)$/) { |day,|
        res = DayEntity.new(@stream, jid, @base_url, @conference_id, day.to_i)
      }
      jid.node.scan(/^day-(\d+)-time-(\d+)$/) { |day,time,|
        res = DayTimeEntity.new(@stream, jid, @base_url, @conference_id, day.to_i, time)
      }
      jid.node.scan(/^event-(\d+)$/) { |event_id,|
        res = EventEntity.new(@stream, jid, @base_url, @conference_id, event_id.to_i)
      }
      jid.node.scan(/^person-(\d+)$/) { |person_id,|
        res = PersonEntity.new(@stream, jid, @base_url, @conference_id, person_id.to_i)
      }
    end

    res
  rescue NoEntityException => e
    nil
  end

  ##
  # Forward to target entity by stanza.to.node
  #
  # Does not respond to <tt>stanza.type == :error</tt>
  def dispatch_stanza(stanza)
    puts "Dispatching #{stanza.name} #{stanza.type} to #{stanza.to}"
    
    return if stanza.type == :error
    
    ent = entity(stanza.to)

    if ent
      ent.receive(stanza)
    else
      # Handle unknown target entity
      answer = stanza.answer
      answer.type = :error
      answer.add(Jabber::Error.new('item-not-found'))
      @stream.send(answer)
    end

    true  # Yes, everything handled here

  rescue Exception => e
    emsg = Jabber::Message.new
    emsg.subject = "Exception #{e.class}: #{e}"
    emsg.type = :headline
    emsg.body = "Exception #{e.class}: #{e}\n\n=== Backtrace ===\n#{e.backtrace.join("\n")}\n\n=== Stanza ===\n#{stanza.to_s}"
    emsg.from = @stream.jid
    @exception_jids.each { |jid|
      emsg.to = jid
      @stream.send(emsg)
    }
    true
  end

  def changes_poll
    ##
    # Controls whether to send notifications in an
    # iteration to omit this for the first poll.
    warmup = true

    puts "Initializing recent_changes polling"
    first_change = Momomoto::View_recent_changes.find({}, 1, 'changed_when desc')
    last_poll = first_change.changed_when
    last_changes = []
    puts "Last recent change was #{last_poll.inspect}"

    loop {
      puts "polling"
      changes = []
      Momomoto::View_recent_changes.find({:changed_when => {:ge => last_poll}}, nil, 'changed_when').each { |change|
        changes.push(change.changed_when)

        ##
        # We're running and tracking changes...
        unless warmup or last_changes.include?(change.changed_when)
          handle_change(change)
        end

        last_poll = change.changed_when
      }

      last_changes = changes
      sleep(@changes_poll_interval)

      warmup = false
    }
  end

  ##
  # Handle a record received from View_recent_changes
  def handle_change(change)
    puts "Changed: #{change[:type]} #{change[:id]} (#{change.title}) by #{change.changed_by}"

    ent = entity(Jabber::JID.new("#{change[:type]}-#{change[:id]}", @stream.jid.domain))
    unless ent.nil?
      ent.notify_change(change)
    end
  end
end
