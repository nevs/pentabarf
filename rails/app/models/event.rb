class Event < Momomoto::Table
  SubmissionFields = [:title,:subtitle,:paper,:slides,:language,:conference_track,:event_type,:abstract,:description,:resources,:duration,:submission_notes]

  def self.log_change_url( change )
    {:controller=>'pentabarf',:action=>:event,:id=>change.event_id}
  end

  def self.log_change_title( change )
    conf = Conference.select_single(:change.conference_id).acronym rescue ""
    "#{conf}: #{change.title}"
  end

end
