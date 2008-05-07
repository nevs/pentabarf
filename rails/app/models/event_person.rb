class Event_person < Momomoto::Table

  def self.log_content_columns
    columns.keys - [:event_person_id]
  end

  def self.log_change_url( change )
    {:controller=>'pentabarf',:action=>:event,:id=>change.event_id}
  end

end

