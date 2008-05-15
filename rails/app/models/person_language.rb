class Person_language < Momomoto::Table

  def self.log_content_columns
    columns.keys - [:person_id]
  end

  def self.log_change_title( change )
    person = Person.select_single({:person_id=>change.person_id})
    person.name
   rescue
    ""
  end

  def self.log_change_url( change )
    {:controller=>'pentabarf',:action=>:person,:id=>change.person_id}
  end

end

