
-- helper procedure for renaming conference tracks
CREATE OR REPLACE FUNCTION conference_track_rename( conference_id INTEGER, old_name TEXT, new_name TEXT ) RETURNS VOID AS $$  
  UPDATE conference_track SET conference_track = $3 WHERE conference_track = $2 AND conference_id = $1;
$$ LANGUAGE SQL;

