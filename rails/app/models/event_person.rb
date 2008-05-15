class Event_person < Momomoto::Table

  def self.log_content_columns
    columns.keys - [:event_person_id,:event_id]
  end

  def self.log_change_title( change )
    "#{Event.log_change_title( Event.select_single({:event_id=>change.event_id}))}: #{Person.log_change_title( Person.select_single(:person_id=>change.person_id))}"
   rescue
    ""
  end

  def self.log_change_url( change )
    {:controller=>'pentabarf',:action=>:event,:id=>change.event_id}
  end

end

