require 'xmpp4r'
require 'xmpp4r/iq/query/roster'

class Subscriptions < REXML::Element
  ##
  # jid:: [JID] My JID
  def initialize(jid)
    super('subscriptions')
    attributes['jid'] = jid.to_s

    begin
      import(REXML::Document.new(File.new(filename)).root)
    rescue Exception => e
    end
  end

  def write_file
    output = File.new(filename, 'w')
    write(output, 0)
    output.close
  end

  ##
  # jid:: [JID] Foreign JID
  def [](jid)
    each_element('item') { |item|
      return(item) if item.jid.strip == jid.strip
    }
    add(Jabber::RosterItem.new(jid.strip))
  end

  def filename
    "subscriptions/" + attributes['jid'].gsub(/\//, '')
  end

  def typed_add(xe)
    if xe.kind_of?(REXML::Element) and xe.name == 'item'
      super(Jabber::RosterItem.import(xe))
    else
      super(xe)
    end
  end
end
