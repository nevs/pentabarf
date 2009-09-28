class Event_image < Momomoto::Table

  def self.log_hidden_columns
    [:image]
  end

  def self.log_content_columns
    columns.keys - [:event_id]
  end

  def self.log_change_url( change )
    {:controller=>'event',:action=>:edit,:event_id=>change.event_id}
  end

  def self.log_change_title( change )
    Event.log_change_title( Event.select_single({:event_id=>change.event_id}))
   rescue
    ""
  end

end

