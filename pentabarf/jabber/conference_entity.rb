require 'entity'
require 'momomoto/tables'

class ConferenceEntity < Entity
  def initialize(stream, jid, base_url, conference_id)
    super(stream, jid, base_url)
    @conference_id = conference_id

    if Momomoto::Conference.find({:conference_id => @conference_id, :f_deleted => 'f'}, 1).nil?
      raise NoEntityException.new
    end
  end

  def disco_identity
    conference = Momomoto::Conference.find({:conference_id => @conference_id, :f_deleted => 'f'}, 1)
    name = conference.nil? ? 'Unknown conference' : conference.title
    Jabber::DiscoIdentity.new('directory', name, 'user')
  end

  def disco_items
    conference = Momomoto::Conference.find({:conference_id => @conference_id, :f_deleted => 'f'}, 1)
    days = conference.nil? ? 0 : conference.days

    items = []
    days.times { |day|
      items.push(Jabber::DiscoItem.new(Jabber::JID.new("day-#{day + 1}", @jid.domain), "Day #{day + 1}"))
    }
    items
  end
end
