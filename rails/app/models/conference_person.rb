class Conference_person < Momomoto::Table

  def self.log_content_columns
    columns.keys - [:conference_person_id]
  end

  def self.log_change_url( change )
    {:controller=>'person',:action=>:edit,:person_id=>change.person_id}
  end

  def self.log_change_title( change )
    person = Person.select_single({:person_id=>change.person_id})
    begin
      conf = Conference.select_single({:conference_id=>change.conference_id})
      "#{conf.acronym}: #{person.name}"
    rescue
      Person.log_change_title( person )
    end
   rescue
    ""
  end

end

