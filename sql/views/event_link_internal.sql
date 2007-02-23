
CREATE OR REPLACE VIEW view_event_link_internal AS
  SELECT event_link_internal_id,
         event_id,
         link_type_id,
         url,
         description,
         event_link_internal.rank,
         language_id,
         template,
         tag,
         name
  FROM event_link_internal
       INNER JOIN view_link_type USING (link_type_id);

