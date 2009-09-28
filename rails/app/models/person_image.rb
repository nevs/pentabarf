class Person_image < Momomoto::Table

  def self.log_hidden_columns
    [:image]
  end

  def self.log_content_columns
    columns.keys - [:person_id]
  end

  def self.log_change_title( change )
    Person.log_change_title( Person.select_single({:person_id=>change.person_id}))
   rescue
    ""
  end

  def self.log_change_url( change )
    {:controller=>'person',:action=>:edit,:person_id=>change.person_id}
  end

end

