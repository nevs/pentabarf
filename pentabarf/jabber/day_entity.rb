require 'entity'
require 'momomoto/views'

class DayEntity < Entity
  def initialize(stream, jid, conference_id, day)
    super(stream, jid)
    @conference_id = conference_id
    @day = day
  end

  def disco_identity
    Jabber::DiscoIdentity.new('directory', "Day #{@day}", 'user')
  end

  def disco_items
    times = []
    Momomoto::View_find_event.find({:translated_id => 144, :conference_id => @conference_id, :day => @day}).each { |event|
      times.push(event.start_time) unless event.start_time.nil?
    }
    times.sort!.uniq!
    times.collect { |time| Jabber::DiscoItem.new(Jabber::JID.new("day-#{@day}-time-#{time.gsub(/:/, '')}", @jid.domain), "Day #{@day} - #{time}") }
  end
end
