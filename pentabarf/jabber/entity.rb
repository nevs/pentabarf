require 'xmpp4r'
require 'xmpp4r/iq/query/discoinfo'
require 'xmpp4r/iq/query/discoitems'

require 'subscriptions'


##
# To be raised when the entity is invalid...
class NoEntityException < Exception
end


##
# Base class for all target entities
class Entity
  ##
  # Just pass stream and target jid
  def initialize(stream, jid, base_url)
    @stream = stream
    @jid = jid
    @base_url = base_url
  end

  ##
  # Return an URL for this entity
  # which can be included into notification messages
  def url
    nil
  end

  ##
  # Called when a recent change on this entity appears
  def notify_change(change)
    puts "Got #{change.title}"
    subscriptions = Subscriptions.new(@jid)

    msg = Jabber::Message.new
    msg.type = :headline
    msg.subject = "#{change.title}"
    msg.body = "#{msg.subject}\n\n#{url}\n\n#{change.changed_when} by #{change.name}"

    subscriptions.each_element { |item|
      if item.subscription == :from or item.subscription == :both
        msg.to = item.jid
        send(msg)
      end
    }
  end
  
  ##
  # Receive an XMPP stanza and dispatch according to class/type
  #
  # stanza.to is already handled by the Multiboy class
  def receive(stanza)
    if stanza.kind_of?(Jabber::Iq)
      if stanza.type == :get
        handle_iq_get(stanza)
      end
    elsif stanza.kind_of?(Jabber::Presence)
      handle_presence(stanza)
    elsif stanza.kind_of?(Jabber::Message)
    end
  end

  ##
  # Send an XMPP stanza
  #
  # stanza.from is automatically set
  # stanza:: [REXML::Element] XMPP stanza
  # resource:: [String] optional resource for stanza.from
  def send(stanza, resource=nil)
    stanza.from = Jabber::JID.new(@jid.node, @jid.domain, resource)
    @stream.send(stanza)
  end

  ##
  # Handle <tt><iq type='get'/></tt>
  def handle_iq_get(iq)
    answer = iq.answer
    answer.type = :result

    if iq.query.kind_of?(Jabber::IqQueryDiscoInfo)
      answer.query.add(disco_identity)
      disco_features.each { |var| answer.query.add(Jabber::DiscoFeature.new(var)) }
    elsif iq.query.kind_of?(Jabber::IqQueryDiscoItems)
      disco_items.each { |item| answer.query.add(item); puts "#{iq.to} contains #{item.jid}: #{item.iname}" }
    elsif iq.vcard.kind_of?(Jabber::IqVcard)
      v = vcard
      unless v.nil?
        answer.delete_element('vCard')
        answer.add(v)
      else
        answer.type = :error
        answer.add(Jabber::Error.new('feature-not-implemented'))
      end
    else
      answer.type = :error
      answer.add(Jabber::Error.new('feature-not-implemented'))
    end

    @stream.send(answer)
  end

  ##
  # Handle a <tt><presence/></tt> stanza
  def handle_presence(pres)
    subscriptions = Subscriptions.new(@jid)

    if pres.type == :subscribe
      response = Jabber::Presence.new
      response.to = pres.from.strip
      
      if handle_subscription_request(pres.from)
        subscriptions[pres.from].subscription = (subscriptions[pres.from].subscription == :to) ? :both : :from
        
        response.type = :subscribed
        send(response)

        send(presence.set_to(pres.from.strip))
      else
        response.type = :unsubscribed
        send(response)
      end
      
    elsif pres.type == :subscribed
      subscriptions[pres.from].subscription = (subscriptions[pres.from].subscription == :from) ? :both : :to
      
    elsif pres.type == :unsubscribe
      subscriptions[pres.from].subscription = (subscriptions[pres.from].subscription == :both) ? :to : :none

      response = Jabber::Presence.new
      response.to = pres.from.strip
      response.type = :unsubscribed
      send(response)
      
    elsif pres.type == :unsubscribed
      subscriptions[pres.from].subscription = (subscriptions[pres.from].subscription == :both) ? :from : :none
      
    elsif pres.type == :probe and [:from, :both].include?(subscriptions[pres.from].subscription)
      send(presence.set_to(pres.from.strip))
    end

    subscriptions.write_file
  end

  ##
  # Broadcast presence to all subscribers
  def broadcast_presence(type=nil)
    subscriptions = Subscriptions.new(@jid)
    begin
      pres = presence.set_type(type)
    rescue
      pres = Jabber::Presence.new.set_type(:unavailable)
    end

    subscriptions.each_element('item') { |item|
      send(pres.set_to(item.jid))
    }
  end

  ##
  # Accept subscription request
  # from:: [JID]
  # result:: [true] or [false]
  def handle_subscription_request(from)
    false
  end

  ##
  # Return an Array of Jabber::Presence elements
  # for each available resource
  # with *no* from and to attributes set
  def presence
    Jabber::Presence.new.set_type(:unavailable)
  end

  ##
  # DiscoIdentity of this entity
  # (defaults to empty)
  # result:: [Jabber::DiscoIdentity]
  def disco_identity
    Jabber::DiscoIdentity.new
  end

  ##
  # DiscoFeatures of this entity
  # result:: [Array] of [String]
  def disco_features
    [Jabber::IqQueryVersion.new.namespace, Jabber::IqQueryDiscoInfo.new.namespace, Jabber::IqQueryDiscoItems.new.namespace]
  end

  ##
  # Return children items
  #
  # result:: [Array] of [Jabber::DiscoItem]
  def disco_items
    []
  end

  def vcard
    nil
  end
end
