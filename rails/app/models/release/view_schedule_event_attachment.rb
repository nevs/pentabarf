class Release::View_schedule_event_attachment < Momomoto::Table

  schema_name "release"

  fk_helper_single :data, Release::Event_attachment, [:conference_release_id,:event_attachment_id]

end

