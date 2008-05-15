class Person_im < Momomoto::Table

  def self.log_content_columns
    columns.keys - [:person_id,:im_person_id]
  end

  def self.log_change_title( change )
    Person.log_change_title( Person.select_single({:person_id=>change.person_id}))
   rescue
    ""
  end

  def self.log_change_url( change )
    {:controller=>'pentabarf',:action=>:person,:id=>change.person_id}
  end

end

