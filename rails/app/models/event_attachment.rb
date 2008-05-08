class Event_attachment < Momomoto::Table

  def self.log_content_columns
    columns.keys - [:event_id]
  end

  def self.log_hidden_columns
    [:data]
  end

  def self.log_change_url( change )
    {:controller=>'pentabarf',:action=>:event,:id=>change.event_id}
  end

  def self.log_change_title( change )
    Event.select_single({:event_id=>change.event_id}).title rescue ""
  end

end

