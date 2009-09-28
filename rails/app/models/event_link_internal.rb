class Event_link_internal < Momomoto::Table

  def self.log_content_columns
    columns.keys - [:event_id,:event_link_internal_id]
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

