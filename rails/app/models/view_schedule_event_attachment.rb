class View_schedule_event_attachment < Momomoto::Table

  fk_helper_single :data, Event_attachment, [:event_attachment_id]

end

