
-- view for recent changes
CREATE OR REPLACE VIEW view_recent_changes AS
  SELECT 'conference' AS type,
         conference_transaction.conference_id AS id,
         conference.acronym,
         conference.title AS title,
         conference_transaction.changed_when,
         conference_transaction.changed_by,
         view_person.name,
         conference_transaction.f_create
    FROM conference_transaction
         INNER JOIN conference USING (conference_id)
         INNER JOIN view_person ON (conference_transaction.changed_by = view_person.person_id)
UNION
  SELECT 'event' AS type,
         event_transaction.event_id AS id,
         conference.acronym,
         event.title AS title,
         event_transaction.changed_when,
         event_transaction.changed_by,
         view_person.name,
         event_transaction.f_create
    FROM event_transaction
         INNER JOIN event USING (event_id)
         INNER JOIN conference USING (conference_id)
         INNER JOIN view_person ON (event_transaction.changed_by = view_person.person_id)
UNION
  SELECT 'person' AS type,
         person_transaction.person_id AS id,
         '' AS acronym,
         person.name AS title ,
         person_transaction.changed_when,
         person_transaction.changed_by,
         view_person.name,
         person_transaction.f_create
    FROM person_transaction
         INNER JOIN view_person AS person USING (person_id)
         INNER JOIN view_person ON (person_transaction.changed_by = view_person.person_id)
ORDER BY changed_when DESC;

