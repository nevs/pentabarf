class Release::View_schedule_event < Momomoto::Table

  schema_name "release"

  fk_helper_multiple :persons, Release::View_schedule_event_person, [:conference_release_id,:event_id,:translated]

end

