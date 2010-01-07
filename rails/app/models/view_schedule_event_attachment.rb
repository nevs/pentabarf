class View_schedule_event_attachment < Momomoto::Table

  fk_helper_single :event_attachment, Event_attachment, [:event_attachment_id]

end

