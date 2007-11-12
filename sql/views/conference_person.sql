
CREATE OR REPLACE VIEW view_conference_person AS
  SELECT conference_person_id,
         person_id,
         conference_id,
         name,
         abstract,
         description,
         remark,
         conference_person.email
    FROM conference_person
         INNER JOIN view_person USING (person_id)
;

