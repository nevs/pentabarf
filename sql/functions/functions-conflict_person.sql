/*
 * Conflicts concerning persons
*/


-- returns all conclicts related to persons
CREATE OR REPLACE FUNCTION conflict_person(integer) RETURNS SETOF conflict_person_conflict AS $$
  DECLARE
    cur_conference_id ALIAS FOR $1;
    cur_conflict_person RECORD;
    cur_conflict RECORD;

  BEGIN

    FOR cur_conflict IN
      SELECT conflict.conflict_id,
             conflict.conflict_type_id,
             conflict.tag
        FROM conflict
             INNER JOIN conflict_type USING (conflict_type_id)
             INNER JOIN conference_phase_conflict USING (conflict_id)
             INNER JOIN conference USING (conference_phase_id)
             INNER JOIN conflict_level USING (conflict_level_id)
       WHERE conflict_type.tag = 'person' AND
             conflict_level.tag <> 'silent' AND
             conference.conference_id = cur_conference_id
    LOOP
      FOR cur_conflict_person IN
        EXECUTE 'SELECT conflict_id, person_id FROM conflict_' || cur_conflict.tag || '(' || cur_conference_id || '), ( SELECT ' || cur_conflict.conflict_id || ' AS conflict_id) AS conflict_id; '
      LOOP
        RETURN NEXT cur_conflict_person;
      END LOOP;
    END LOOP;

    RETURN;
  END;
$$ LANGUAGE 'plpgsql' RETURNS NULL ON NULL INPUT;

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

