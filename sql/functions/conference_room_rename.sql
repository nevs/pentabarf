
-- helper procedure for renaming conference rooms
CREATE OR REPLACE FUNCTION conference_room_rename( conference_id INTEGER, old_name TEXT, new_name TEXT ) RETURNS VOID AS $$  
  UPDATE conference_room SET conference_room = $3 WHERE conference_room = $2 AND conference_id = $1;
$$ LANGUAGE SQL;

