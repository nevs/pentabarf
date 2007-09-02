
CREATE OR REPLACE VIEW view_conference_person_link_internal AS
  SELECT conference_person_link_internal_id,
         conference_person_id,
         link_type_id,
         url,
         description,
         conference_person_link_internal.rank,
         language_id,
         template,
         tag,
         name
    FROM conference_person_link_internal
         INNER JOIN view_link_type USING (link_type_id);

