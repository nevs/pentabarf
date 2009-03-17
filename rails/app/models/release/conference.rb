class Release::Conference < Momomoto::Table

  schema_name 'release'

  fk_helper_single :release, Conference_release, [:conference_id,:conference_release_id]

  fk_helper_multiple :events, Release::View_schedule_event, [:conference_id,:conference_release_id]
  fk_helper_multiple :days, Release::View_schedule_day, [:conference_id,:conference_release_id]
  fk_helper_multiple :rooms, Release::View_schedule_room, [:conference_id,:conference_release_id]
  fk_helper_multiple :tracks, Release::View_schedule_track, [:conference_id,:conference_release_id]

end
