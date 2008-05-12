class Conference_person_link < Momomoto::Table

  def self.log_content_columns
    columns.keys - [:conference_person_id,:conference_person_link_id]
  end

  def self.log_change_url( change )
    person = Conference_person.select_single({:conference_person_id=>change.conference_person_id})
    {:controller=>'pentabarf',:action=>:person,:id=>person.person_id}
   rescue
    {}
  end

  def self.log_change_title( change )
    cp = Conference_person.select_single({:conference_person_id=>change.conference_person_id})
    person = Person.select_single({:person_id=>cp.person_id})
    person.name
   rescue
    ""
  end

end

