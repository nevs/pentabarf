class Event_person < Momomoto::Table

  def self.log_content_columns
    columns.keys - [:event_person_id]
  end

  def self.log_change_title( change )
    conf = Conference.select_single(:conference_id=>change.conference_id).acronym rescue nil
    title = Event.select_single({:event_id=>change.event_id}).title rescue ""
    if conf
      "#{conf}: #{title}"
    else
      "#{title}"
    end
  end

  def self.log_change_url( change )
    {:controller=>'pentabarf',:action=>:event,:id=>change.event_id}
  end

end

