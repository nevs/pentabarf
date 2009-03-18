class View_schedule_event < Momomoto::Table

  fk_helper_multiple :links, Event_link, [:event_id]
  fk_helper_multiple :persons, View_schedule_event_person, [:event_id,:translated]
  fk_helper_multiple :attachments, View_schedule_event_attachment, [:event_id,:translated]

end

