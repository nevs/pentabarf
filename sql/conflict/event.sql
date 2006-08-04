/*
 * Conflicts concerning one event
*/

CREATE OR REPLACE FUNCTION conflict.event( conference_id INTEGER ) RETURNS SETOF conflict.event_conflict AS $$
  DECLARE
    cur_conflict RECORD;
    cur_conflict_event conflict.event_conflict%ROWTYPE;
  BEGIN

    FOR cur_conflict IN
      SELECT * FROM pg_catalog.pg_proc
               INNER JOIN pg_catalog.pg_namespace ON (
                   pg_namespace.oid = pg_proc.pronamespace AND
                   pg_namespace.nspname = 'conflict' )
               INNER JOIN pg_catalog.pg_type ON (
                   pg_type.oid = pg_proc.prorettype AND
                   pg_type.typnamespace = pg_proc.pronamespace AND
                   pg_type.typname = 'event' )
    LOOP
      FOR cur_conflict_event IN
        EXECUTE 'SELECT ' || quote_literal( cur_conflict.proname ) || ' AS conflict, event_id FROM conflict.' || quote_ident( cur_conflict.proname ) || '(' || quote_literal( conference_id ) || ');'
      LOOP
        RETURN NEXT cur_conflict_event;
      END LOOP;
    END LOOP;
    RETURN;
  END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION event_without_speaker(conference_id INTEGER) RETURNS SETOF conflict.event AS $$
  DECLARE
    cur_conflict conflict_event%ROWTYPE;
  BEGIN
    FOR cur_conflict IN
      SELECT event_id FROM event
                      INNER JOIN 
    RETURN;
  END;
$$ LANGUAGE plpgsql;

-- returns all confirmed events without confirmed speaker/moderator
CREATE OR REPLACE FUNCTION conflict_event_no_speaker(integer) RETURNS SETOF conflict_event AS $$
  DECLARE
    cur_conference_id ALIAS FOR $1;
    cur_event conflict_event%ROWTYPE;
  BEGIN
-- Loop through all events
    FOR cur_event IN
      SELECT event_id 
        FROM event 
             INNER JOIN event_state USING (event_state_id)
             INNER JOIN event_state_progress USING (event_state_progress_id)
        WHERE event.conference_id = cur_conference_id AND
              event_state.tag = 'accepted' AND
              event_state_progress.tag = 'confirmed'
    LOOP
      IF NOT EXISTS (SELECT 1 FROM event_person 
                              INNER JOIN event_role USING (event_role_id) 
                              INNER JOIN event_role_state USING (event_role_state_id) 
                       WHERE event_person.event_id = cur_event.event_id AND
                             event_role.tag IN ('speaker', 'moderator') AND
                             event_role_state.tag = 'confirmed')
      THEN
        RETURN NEXT cur_event;
      END IF;
    END LOOP;
    RETURN;
  END;
$$ LANGUAGE 'plpgsql' RETURNS NULL ON NULL INPUT;


-- returns all events without coordinator
CREATE OR REPLACE FUNCTION conflict_event_no_coordinator(integer) RETURNS setof conflict_event AS $$
  DECLARE
    cur_conference_id ALIAS FOR $1;
    cur_event conflict_event%ROWTYPE;
  BEGIN
    -- Loop through all events
    FOR cur_event IN
      SELECT event_id FROM event INNER JOIN event_state USING (event_state_id)
        WHERE event.conference_id = cur_conference_id
    LOOP
      IF NOT EXISTS (SELECT 1 FROM event_person 
                                   INNER JOIN event_role USING (event_role_id)
                       WHERE event_person.event_id = cur_event.event_id AND
                             event_role.tag = 'coordinator')
      THEN
        RETURN NEXT cur_event;
      END IF;
    END LOOP;
    RETURN;
  END;
$$ LANGUAGE 'plpgsql' RETURNS NULL ON NULL INPUT;

-- returns all accepted events with incomplete day/time/room
CREATE OR REPLACE FUNCTION conflict_event_incomplete(INTEGER) RETURNS SETOF conflict_event AS $$
  DECLARE
    cur_conference_id ALIAS FOR $1;
    cur_event conflict_event%ROWTYPE;
  BEGIN
    FOR cur_event IN
      SELECT event_id 
        FROM event 
             INNER JOIN event_state USING (event_state_id)
             INNER JOIN event_state_progress USING (event_state_progress_id)
        WHERE conference_id = cur_conference_id AND
              event_state.tag = 'accepted' AND
              event_state_progress.tag = 'confirmed' AND
              (day IS NULL OR 
               room_id IS NULL OR 
               start_time IS NULL) AND
              (day IS NOT NULL OR 
               room_id IS NOT NULL OR 
               start_time IS NOT NULL)
    LOOP
      RETURN NEXT cur_event;
    END LOOP;
    RETURN;
  END;
$$ LANGUAGE 'plpgsql' RETURNS NULL ON NULL INPUT;

-- returns all accepted events with missing tag
CREATE OR REPLACE FUNCTION conflict_event_missing_tag(INTEGER) RETURNS SETOF conflict_event AS $$
  DECLARE
    cur_conference_id ALIAS FOR $1;
    cur_event conflict_event%ROWTYPE;
  BEGIN
    FOR cur_event IN
      SELECT event_id 
        FROM event 
             INNER JOIN event_state USING (event_state_id)
        WHERE conference_id = cur_conference_id AND
              event_state.tag = 'accepted' AND
              event.tag IS NULL
    LOOP
      RETURN NEXT cur_event;
    END LOOP;
    RETURN;
  END;
$$ LANGUAGE 'plpgsql' RETURNS NULL ON NULL INPUT;

-- returns all accepted events with inconsistent tag
CREATE OR REPLACE FUNCTION conflict_event_inconsistent_tag(INTEGER) RETURNS SETOF conflict_event AS $$
  DECLARE
    cur_conference_id ALIAS FOR $1;
    cur_event conflict_event%ROWTYPE;
  BEGIN
    FOR cur_event IN
      SELECT event_id
        FROM event
             INNER JOIN event_state USING (event_state_id)
       WHERE event.tag IS NOT NULL AND
             conference_id = cur_conference_id AND
             event_state.tag = 'accepted' AND
             event.tag NOT SIMILAR TO '[a-z0-9\\_]+'
    LOOP
      RETURN NEXT cur_event;
    END LOOP;
    RETURN;
  END;
$$ LANGUAGE 'plpgsql' RETURNS NULL ON NULL INPUT;

-- returns all accepted events with no paper but the f_paper flag set
CREATE OR REPLACE FUNCTION conflict_event_no_paper(INTEGER) RETURNS SETOF conflict_event AS $$
  DECLARE
    cur_conference_id ALIAS FOR $1;
    cur_event conflict_event%ROWTYPE;
  BEGIN
    FOR cur_event IN
      SELECT event_id
        FROM event
             INNER JOIN event_state USING (event_state_id)
             INNER JOIN event_state_progress ON (
                event.event_state_progress_id = event_state_progress.event_state_progress_id AND
                event.event_state_id = event_state_progress.event_state_id AND
                event_state_progress.tag = 'confirmed'
              )
       WHERE conference_id = cur_conference_id AND
             event_state.tag = 'accepted' AND
             f_paper = 't' AND
             NOT EXISTS (SELECT 1 FROM event_attachment
                                       INNER JOIN attachment_type USING (attachment_type_id)
                                 WHERE event_attachment.event_id = event.event_id AND
                                       attachment_type.tag = 'paper' AND
                                       event_attachment.f_public = 't')
    LOOP
      RETURN NEXT cur_event;
    END LOOP;
    RETURN;
  END;
$$ LANGUAGE 'plpgsql' RETURNS NULL ON NULL INPUT;

-- returns all accepted events with no paper but the f_slides flag set
CREATE OR REPLACE FUNCTION conflict_event_no_slides(INTEGER) RETURNS SETOF conflict_event AS $$
  DECLARE
    cur_conference_id ALIAS FOR $1;
    cur_event conflict_event%ROWTYPE;
  BEGIN
    FOR cur_event IN
      SELECT event_id
        FROM event
             INNER JOIN event_state USING (event_state_id)
             INNER JOIN event_state_progress ON (
                event.event_state_progress_id = event_state_progress.event_state_progress_id AND
                event.event_state_id = event_state_progress.event_state_id AND
                event_state_progress.tag = 'confirmed'
              )
       WHERE conference_id = cur_conference_id AND
             event_state.tag = 'accepted' AND
             f_slides = 't' AND
             NOT EXISTS (SELECT 1 FROM event_attachment
                                       INNER JOIN attachment_type USING (attachment_type_id)
                                 WHERE event_id = event.event_id AND
                                       attachment_type.tag = 'slides' AND
                                       event_attachment.f_public = 't')
    LOOP
      RETURN NEXT cur_event;
    END LOOP;
    RETURN;
  END;
$$ LANGUAGE 'plpgsql' RETURNS NULL ON NULL INPUT;

-- returns all events with inconsistent public links
CREATE OR REPLACE FUNCTION conflict_event_inconsistent_public_link(INTEGER) RETURNS SETOF conflict_event AS $$
  DECLARE
    cur_conference_id ALIAS FOR $1;
    cur_event conflict_event%ROWTYPE;
  BEGIN
    FOR cur_event IN
      SELECT event_id
        FROM event
       WHERE conference_id = cur_conference_id AND
             EXISTS (SELECT 1 FROM event_link
                             WHERE event_id = event.event_id AND
                                   url NOT SIMILAR TO '[a-z]+:%')
    LOOP
      RETURN NEXT cur_event;
    END LOOP;
    RETURN;
  END;
$$ LANGUAGE 'plpgsql' RETURNS NULL ON NULL INPUT;

-- returns all accepted events with no language set
CREATE OR REPLACE FUNCTION conflict_event_no_language(INTEGER) RETURNS SETOF conflict_event AS $$
  DECLARE
    cur_conference_id ALIAS FOR $1;
    cur_event conflict_event%ROWTYPE;
  BEGIN
    FOR cur_event IN
      SELECT event_id
        FROM event
             INNER JOIN event_state USING (event_state_id)
       WHERE conference_id = cur_conference_id AND
             event_state.tag = 'accepted' AND
             language_id IS NULL
    LOOP
      RETURN NEXT cur_event;
    END LOOP;
    RETURN;
  END;
$$ LANGUAGE 'plpgsql' RETURNS NULL ON NULL INPUT;

-- returns all accepted events with no conference track set
CREATE OR REPLACE FUNCTION conflict_event_no_track(INTEGER) RETURNS SETOF conflict_event AS $$
  DECLARE
    cur_conference_id ALIAS FOR $1;
    cur_event conflict_event%ROWTYPE;
  BEGIN
    FOR cur_event IN
      SELECT event_id
        FROM event
             INNER JOIN event_state USING (event_state_id)
       WHERE conference_id = cur_conference_id AND
             event_state.tag = 'accepted' AND
             conference_track_id IS NULL
    LOOP
      RETURN NEXT cur_event;
    END LOOP;
    RETURN;
  END;
$$ LANGUAGE 'plpgsql' RETURNS NULL ON NULL INPUT;

-- returns all events with a language not in conference_language 
CREATE OR REPLACE FUNCTION conflict_event_conference_language(INTEGER) RETURNS SETOF conflict_event AS $$
  DECLARE
    cur_conference_id ALIAS FOR $1;
    cur_event conflict_event%ROWTYPE;
  BEGIN
    FOR cur_event IN
      SELECT event_id
        FROM event
       WHERE event.conference_id = cur_conference_id AND
             event.language_id IS NOT NULL AND
             NOT EXISTS (SELECT 1 
                           FROM conference_language 
                          WHERE conference_id = cur_conference_id AND
                                language_id = event.language_id)
    LOOP
      RETURN NEXT cur_event;
    END LOOP;
    RETURN;
  END;
$$ LANGUAGE 'plpgsql' RETURNS NULL ON NULL INPUT;

CREATE OR REPLACE FUNCTION conflict_event_no_abstract(INTEGER) RETURNS SETOF conflict_event AS $$
  DECLARE
    cur_conference_id ALIAS FOR $1;
    cur_event conflict_event%ROWTYPE;
  BEGIN
    FOR cur_event IN
      SELECT event_id
        FROM event
       WHERE event.abstract IS NULL AND
             event.conference_id = cur_conference_id
    LOOP
      RETURN NEXT cur_event;
    END LOOP;
    RETURN;
  END;
$$ LANGUAGE 'plpgsql' RETURNS NULL ON NULL INPUT; 
CREATE OR REPLACE FUNCTION conflict_event_no_description(INTEGER) RETURNS SETOF conflict_event AS $$
  DECLARE
    cur_conference_id ALIAS FOR $1;
    cur_event conflict_event%ROWTYPE;
  BEGIN
    FOR cur_event IN
      SELECT event_id
        FROM event
       WHERE event.description IS NULL AND
             event.conference_id = cur_conference_id
    LOOP
      RETURN NEXT cur_event;
    END LOOP;
    RETURN;
  END;
$$ LANGUAGE 'plpgsql' RETURNS NULL ON NULL INPUT;

CREATE OR REPLACE FUNCTION conflict_event_abstract_length(INTEGER) RETURNS SETOF conflict_event AS $$
  DECLARE
    cur_conference_id ALIAS FOR $1;
    cur_conference RECORD;
    cur_event RECORD;
  BEGIN
    SELECT INTO cur_conference abstract_length, description_length FROM conference WHERE conference_id = cur_conference_id;
    FOR cur_event IN
      SELECT event_id
        FROM event
       WHERE conference_id = cur_conference_id AND 
             length(abstract) > cur_conference.abstract_length
    LOOP
      RETURN NEXT cur_event;
    END LOOP;
  END;
$$ LANGUAGE 'plpgsql' RETURNS NULL ON NULL INPUT;

CREATE OR REPLACE FUNCTION conflict_event_description_length(INTEGER) RETURNS SETOF conflict_event AS $$
  DECLARE
    cur_conference_id ALIAS FOR $1;
    cur_conference RECORD;
    cur_event RECORD;
  BEGIN
    SELECT INTO cur_conference abstract_length, description_length FROM conference WHERE conference_id = cur_conference_id;
    FOR cur_event IN
      SELECT event_id
        FROM event
       WHERE conference_id = cur_conference_id AND 
             length(description) > cur_conference.description_length
    LOOP
      RETURN NEXT cur_event;
    END LOOP;
  END;
$$ LANGUAGE 'plpgsql' RETURNS NULL ON NULL INPUT;

CREATE OR REPLACE FUNCTION conflict_event_accepted_without_timeslot(INTEGER) RETURNS SETOF conflict_event AS $$
  DECLARE
    cur_conference_id ALIAS FOR $1;
    cur_event RECORD;
  BEGIN
    FOR cur_event IN
      SELECT event_id
        FROM event
             INNER JOIN event_state ON (
               event_state.event_state_id = event.event_state_id AND
               event_state.tag = 'accepted' )
             INNER JOIN event_state_progress ON (
               event_state_progress.event_state_progress_id = event.event_state_progress_id AND
               event_state_progress.tag = 'confirmed' )
       WHERE event.conference_id = cur_conference_id AND
             ( event.start_time IS NULL OR 
               event.room_id IS NULL )
    LOOP
      RETURN NEXT cur_event;
    END LOOP;
  END;
$$ LANGUAGE 'plpgsql' RETURNS NULL ON NULL INPUT;

CREATE OR REPLACE FUNCTION conflict_event_unconfirmed_with_timeslot(INTEGER) RETURNS SETOF conflict_event AS $$
  DECLARE
    cur_conference_id ALIAS FOR $1;
    cur_event RECORD;
  BEGIN
    FOR cur_event IN
      SELECT event_id
        FROM event
             INNER JOIN event_state ON (
               event_state.event_state_id = event.event_state_id AND
               event_state.tag = 'accepted' )
             INNER JOIN event_state_progress ON (
               event_state_progress.event_state_progress_id = event.event_state_progress_id AND
               event_state_progress.tag != 'confirmed' )
       WHERE event.conference_id = cur_conference_id AND
             event.start_time IS NOT NULL AND
             event.room_id IS NOT NULL 
    LOOP
      RETURN NEXT cur_event;
    END LOOP;
  END;
$$ LANGUAGE 'plpgsql' RETURNS NULL ON NULL INPUT;

