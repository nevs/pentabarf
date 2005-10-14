/*
 * Conflicts concerning persons
*/


-- returns all conclicts related to persons
CREATE OR REPLACE FUNCTION conflict_person(integer) RETURNS SETOF conflict_person_conflict AS '
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
       WHERE conflict_type.tag = ''person''
    LOOP
      FOR cur_conflict_person IN
        EXECUTE ''SELECT conflict_id, person_id FROM conflict_'' || cur_conflict.tag || ''('' || cur_conference_id || ''), ( SELECT '' || cur_conflict.conflict_id || '' AS conflict_id) AS conflict_id; ''
      LOOP
        RETURN NEXT cur_conflict_person;
      END LOOP;
    END LOOP;

    RETURN;
  END;
' LANGUAGE 'plpgsql' RETURNS NULL ON NULL INPUT;

-- returns all speaker/moderator without email
CREATE OR REPLACE FUNCTION conflict_person_no_email(integer) RETURNS SETOF conflict_person AS '
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
' LANGUAGE 'plpgsql' RETURNS NULL ON NULL INPUT;

