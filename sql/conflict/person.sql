/*
 * Conflicts concerning persons
*/


-- returns all conflicts related to persons
CREATE OR REPLACE FUNCTION conflict.person( conference_id INTEGER ) RETURNS SETOF conflict.person_conflict AS $$
  DECLARE
    cur_conflict RECORD;
    cur_conflict_person conflict.person_conflict%ROWTYPE;
  BEGIN

    FOR cur_conflict IN
      SELECT * FROM pg_catalog.pg_proc
               INNER JOIN pg_catalog.pg_namespace ON (
                   pg_namespace.oid = pg_proc.pronamespace AND
                   pg_namespace.nspname = 'conflict' )
               INNER JOIN pg_catalog.pg_type ON (
                   pg_type.oid = pg_proc.prorettype AND
                   pg_type.typnamespace = pg_proc.pronamespace AND
                   pg_type.typname = 'person' )
    LOOP
      FOR cur_conflict_person IN
        EXECUTE 'SELECT ' || quote_literal( cur_conflict.proname ) || ' AS conflict, person_id FROM conflict.' || quote_ident( cur_conflict.proname ) || '(' || quote_literal( conference_id ) || ');'
      LOOP
        RETURN NEXT cur_conflict_person;
      END LOOP;
    END LOOP;
    RETURN;
  END;
$$ LANGUAGE plpgsql;

-- returns all speaker/moderator without email
CREATE OR REPLACE FUNCTION conflict_person_no_email(integer) RETURNS SETOF conflict_person AS $$
  DECLARE
    cur_conference_id ALIAS FOR $1;
    cur_conflict conflict_person%rowtype;

  BEGIN

    FOR cur_conflict IN
      SELECT person_id FROM person
                            INNER JOIN event_person USING (person_id)
                            INNER JOIN event USING (event_id)
        WHERE person.email_contact IS NULL AND
              event.conference_id = cur_conference_id
    LOOP
      RETURN NEXT cur_conflict;
    END LOOP;

    RETURN;
  END;
$$ LANGUAGE 'plpgsql' RETURNS NULL ON NULL INPUT;

-- returns all persons with inconsistent public links
CREATE OR REPLACE FUNCTION conflict_person_inconsistent_public_link(integer) RETURNS SETOF conflict_person AS $$
  DECLARE
    cur_conference_id ALIAS FOR $1;
    cur_conflict conflict_person%rowtype;
  BEGIN

    FOR cur_conflict IN
      SELECT person_id
        FROM person
             INNER JOIN conference_person USING (person_id)
       WHERE conference_person.conference_id = cur_conference_id AND
             EXISTS (SELECT 1 FROM conference_person_link
                             WHERE conference_person_id = conference_person.conference_person_id AND
                                   url NOT SIMILAR TO '[a-z]+:%')
    LOOP
      RETURN NEXT cur_conflict;
    END LOOP;

    RETURN;
  END;
$$ LANGUAGE 'plpgsql' RETURNS NULL ON NULL INPUT;

CREATE OR REPLACE FUNCTION conflict_person_no_abstract(INTEGER) RETURNS SETOF conflict_person AS $$
  DECLARE
    cur_conference_id ALIAS FOR $1;
    cur_person conflict_person%ROWTYPE;
  BEGIN
    FOR cur_person IN
      SELECT person_id
        FROM person
             LEFT OUTER JOIN (
                 SELECT person_id,
                        abstract
                   FROM conference_person
                  WHERE conference_id = cur_conference_id
             ) AS conference_person USING (person_id)
       WHERE abstract IS NULL AND
             EXISTS (SELECT 1
                       FROM event_person
                            INNER JOIN event USING (event_id)
                            INNER JOIN event_state USING (event_state_id)
                            INNER JOIN event_role USING (event_role_id)
                            INNER JOIN event_role_state USING (event_role_state_id)
                      WHERE event.conference_id = cur_conference_id AND
                            event_person.person_id = person.person_id AND
                            event_state.tag = 'accepted' AND
                            event_role.tag IN ('speaker', 'moderator') AND
                            event_role_state.tag = 'confirmed'
             )
    LOOP
      RETURN NEXT cur_person;
    END LOOP;

    RETURN;
  END;
$$ LANGUAGE 'plpgsql' RETURNS NULL ON NULL INPUT;

CREATE OR REPLACE FUNCTION conflict_person_no_description(INTEGER) RETURNS SETOF conflict_person AS $$
  DECLARE
    cur_conference_id ALIAS FOR $1;
    cur_person conflict_person%ROWTYPE;
  BEGIN
    FOR cur_person IN 
      SELECT person_id
        FROM person
             LEFT OUTER JOIN (
                 SELECT person_id,
                        description
                   FROM conference_person
                  WHERE conference_id = cur_conference_id
             ) AS conference_person USING (person_id)
       WHERE description IS NULL AND
             EXISTS (SELECT 1
                       FROM event_person
                            INNER JOIN event USING (event_id)
                            INNER JOIN event_state USING (event_state_id)
                            INNER JOIN event_role USING (event_role_id)
                            INNER JOIN event_role_state USING (event_role_state_id)
                      WHERE event.conference_id = cur_conference_id AND
                            event_person.person_id = person.person_id AND
                            event_state.tag = 'accepted' AND
                            event_role.tag IN ('speaker', 'moderator') AND
                            event_role_state.tag = 'confirmed'
             )
    LOOP
      RETURN NEXT cur_person;
    END LOOP;

    RETURN;
  END;
$$ LANGUAGE 'plpgsql' RETURNS NULL ON NULL INPUT;

CREATE OR REPLACE FUNCTION conflict_person_abstract_length(INTEGER) RETURNS SETOF conflict_person AS $$
  DECLARE
    cur_conference_id ALIAS FOR $1;
    cur_conference RECORD;
    cur_person RECORD;
  BEGIN
    SELECT INTO cur_conference abstract_length, description_length FROM conference WHERE conference_id = cur_conference_id;
    FOR cur_person IN
      SELECT DISTINCT person_id
        FROM conference_person
             INNER JOIN event_person USING (person_id)
             INNER JOIN event_role ON (
               event_role.event_role_id = event_person.event_role_id AND
               event_role.tag IN ('speaker', 'moderator')
             )
             INNER JOIN event USING (event_id, conference_id)
       WHERE conference_id = cur_conference_id AND
             length(conference_person.abstract) > cur_conference.abstract_length
    LOOP
      RETURN NEXT cur_person;
    END LOOP;
  END;
$$ LANGUAGE 'plpgsql' RETURNS NULL ON NULL INPUT;

CREATE OR REPLACE FUNCTION conflict_person_description_length(INTEGER) RETURNS SETOF conflict_person AS $$
  DECLARE
    cur_conference_id ALIAS FOR $1;
    cur_conference RECORD;
    cur_person RECORD;
  BEGIN
    SELECT INTO cur_conference abstract_length, description_length FROM conference WHERE conference_id = cur_conference_id;
    FOR cur_person IN
      SELECT DISTINCT person_id
        FROM conference_person
             INNER JOIN event_person USING (person_id)
             INNER JOIN event_role ON (
               event_role.event_role_id = event_person.event_role_id AND
               event_role.tag IN ('speaker', 'moderator')
             )
             INNER JOIN event USING (event_id, conference_id)
       WHERE conference_id = cur_conference_id AND
             length(conference_person.description) > cur_conference.description_length
    LOOP
      RETURN NEXT cur_person;
    END LOOP;
  END;
$$ LANGUAGE 'plpgsql' RETURNS NULL ON NULL INPUT;

