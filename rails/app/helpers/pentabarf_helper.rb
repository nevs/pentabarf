module PentabarfHelper

  def rating_bar_small( rating, fields)
    xml = Builder::XmlMarkup.new
    xml.td(:class=>"rating-bar-small") do
      fields.each do | field |
        xml.span(:class=>"negative p#{case rating[field] when 1 then '2' when 2 then '1' else '0' end}")
        xml.br unless field == fields.last
      end
    end
    xml.td(:class=>"rating-bar-small") do
      fields.each do | field |
        xml.span(:class=>"positive p#{case rating[field] when 4 then '1' when 5 then '2' else '0' end}")
        xml.br unless field == fields.last
      end
    end
    xml
  end

  def change_url( change )
    klass = change.class.table
    if klass.columns.key?(:conference_person_id)
      cperson = Conference_person.select_single({:conference_person_id=>change.conference_person_id})
      person = View_person.select_single({:person_id=>cperson.person_id})
      link_title = person.name
      link = url_for({:action=>:person,:id=>person.person_id})
    elsif klass.columns.key?(:person_id)
      person = View_person.select_single({:person_id=>change.person_id})
      link_title = person.name
      link = url_for({:action=>:person,:id=>person.person_id})
    elsif klass.columns.key?(:event_id)
      event = Event.select_single({:event_id=>change.event_id})
      link_title = "#{event.title} #{event.subtitle}"
      link = url_for({:action=>:event,:id=>event.event_id})
    elsif klass.columns.key?(:conference_id)
      conf = Conference.select_single({:conference_id=>change.conference_id})
      link_title = conf.title
      link = url_for({:action=>:conference,:id=>conf.conference_id})
    else
      raise "Could not determince change class for #{klass.table_name}"
    end
    [link,link_title]
  end

end

