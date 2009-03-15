class Release::Conference < Momomoto::Table

  schema_name 'release'

  fk_helper_single :release, Conference_release, [:conference_id,:conference_release_id]

  fk_helper_multiple :days, Release::Conference_day, [:conference_id,:conference_release_id]
  fk_helper_multiple :rooms, Release::Conference_room, [:conference_id,:conference_release_id]
  fk_helper_multiple :tracks, Release::Conference_track, [:conference_id,:conference_release_id]

end
