require 'entity'
require 'momomoto/views'

class DayTimeEntity < Entity
  def initialize(stream, jid, base_url, conference_id, day, timestr)
    super(stream, jid, base_url)
    @conference_id = conference_id
    @day = day

    @time = nil
    timestr.scan(/^(\d\d)(\d\d)(\d\d)$/) { |t| @time = t.join(':') }
    if @time.nil?
      raise "Invalid time format: #{timestr}"
    end
  end

  def disco_identity
    Jabber::DiscoIdentity.new('directory', "Day #{@day}: #{@time.gsub(/:\d\d$/, '')}", 'user')
  end

  def disco_items
    res = []
    Momomoto::View_find_event.find({:translated_id => 144, :conference_id => @conference_id, :day => @day, :start_time => @time}).each { |event|
      res.push(Jabber::DiscoItem.new(Jabber::JID.new("event-#{event.event_id}", @jid.domain), event.title))
    }
    res
  end
end
