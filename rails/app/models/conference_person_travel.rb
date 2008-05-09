class Conference_person_travel < Momomoto::Table

  def self.log_content_columns
    columns.keys - [:conference_person_id]
  end

  def self.log_change_url( change )
    cp = Conference_person.select_single({:conference_person_id=>change.conference_person_id})
    {:controller=>'pentabarf',:action=>:person,:id=>cp.person_id}
  end

  def self.log_change_title( change )
    cp = Conference_person.select_single({:conference_person_id=>change.conference_person_id})
    person = Person.select_single({:person_id=>cp.person_id})
    begin
      conf = Conference.select_single({:conference_id=>change.conference_id})
      "#{conf.acronym}: #{person.name}"
    rescue
      person.name
    end
  end

end

