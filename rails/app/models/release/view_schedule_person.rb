class Release::View_schedule_person < Momomoto::Table

  schema_name "release"

  fk_helper_multiple :events, Release::View_schedule_event_person, [:conference_release_id,:person_id]

end

