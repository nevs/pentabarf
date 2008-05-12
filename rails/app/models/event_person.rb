class Event_person < Momomoto::Table

  def self.log_content_columns
    columns.keys - [:event_person_id,:event_id]
  end

  def self.log_change_title( change )
    event = Event.select_single({:event_id=>change.event_id})
    begin
      conf = Conference.select_single(:conference_id=>event.conference_id).acronym
      "#{conf}: #{event.title}"
    rescue
      event.title
    end
  end

  def self.log_change_url( change )
    {:controller=>'pentabarf',:action=>:event,:id=>change.event_id}
  end

end

