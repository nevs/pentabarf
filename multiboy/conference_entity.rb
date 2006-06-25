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

  def handle_subscription_request(from)
    true
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

  def notify_change(change)
    broadcast_presence
  end

  def presence
    lines = []
    Momomoto::View_recent_changes.find({}, 5, 'changed_when desc').each { |change|
      lines.push("#{change.type} #{change.title} by #{change.name}")
    }
    Jabber::Presence.new.set_status(lines.join("\n"))
  end

  def handle_search(iq)
    if iq.type == :get
      answer = iq.answer
      answer.type = :result

      answer.query.replace_element_text('instructions', 'Please enter Pentabarf personae search criteria (42 results max.)')
      answer.query.replace_element_text('first', nil)
      answer.query.replace_element_text('last', nil)
      answer.query.replace_element_text('nick', nil)

      send(answer)
    elsif iq.type == :set
      answer = iq.answer(false)
      answer.type = :result
      answer.add(REXML::Element.new('query')).add_namespace('jabber:iq:search')
      
      first = (iq.query.first_element_text('first').to_s == '') ? nil : iq.query.first_element_text('first')
      last = (iq.query.first_element_text('last').to_s == '') ? nil : iq.query.first_element_text('last')
      nick = (iq.query.first_element_text('nick').to_s == '') ? nil : iq.query.first_element_text('nick')
      
      Momomoto::View_find_person.find({ :conference_id => @conference_id,
                                        :s_first_name => first,
                                        :s_last_name => last,
                                        :s_nickname => nick}, 42).each { |person|
        item = REXML::Element.new('item')
        item.attributes['jid'] = Jabber::JID.new("person-#{person.person_id}", @jid.domain).to_s
        item.replace_element_text('first', person.first_name)
        item.replace_element_text('last', person.last_name)
        item.replace_element_text('nick', person.nickname)

        answer.query.add(item)
      }

      send(answer)
    end
  end

  def disco_features
    super + ['jabber:iq:search']
  end
end
