
CREATE OR REPLACE VIEW view_event_link_internal AS
  SELECT event_link_internal_id,
         event_id,
         link_type,
         url,
         description,
         event_link_internal.rank,
         language_id,
         template,
         link_type_localized.name AS link_type_name
  FROM event_link_internal
       INNER JOIN link_type USING (link_type)
       INNER JOIN link_type_localized USING (link_type);

