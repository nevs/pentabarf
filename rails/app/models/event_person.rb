class Event_person < Momomoto::Table

  def self.log_content_columns
    columns.keys - [:event_person_id]
  end

  def self.log_change_title( change )
    event = Event.select_single({:event_id=>change.event_id}).title rescue nil
    if event
      conf = Conference.select_single(:conference_id=>event.conference_id).acronym rescue nil
      if conf
        return "#{conf}: #{event.title}"
      else
        return event.title
      end
    end
    return ""
  end

  def self.log_change_url( change )
    {:controller=>'pentabarf',:action=>:event,:id=>change.event_id}
  end

end

