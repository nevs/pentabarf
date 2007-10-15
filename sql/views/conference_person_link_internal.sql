
CREATE OR REPLACE VIEW view_conference_person_link_internal AS
  SELECT conference_person_link_internal_id,
         conference_person_id,
         link_type,
         url,
         description,
         conference_person_link_internal.rank,
         language_id,
         template,
         link_type_localized.name AS link_type_name
    FROM conference_person_link_internal
         INNER JOIN link_type USING (link_type)
         INNER JOIN link_type_localized USING (link_type);

