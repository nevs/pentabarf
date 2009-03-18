class Release::View_schedule_event < Momomoto::Table

  schema_name "release"

  fk_helper_multiple :links, Release::Event_link, [:conference_release_id,:event_id]
  fk_helper_multiple :persons, Release::View_schedule_event_person, [:conference_release_id,:event_id,:translated]
  fk_helper_multiple :attachments, Release::View_schedule_event_attachment, [:conference_release_id,:event_id,:translated]

end

