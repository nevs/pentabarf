
CREATE OR REPLACE VIEW view_find_person_role_state AS
  SELECT
    view_event_role_state.event_role_state_id,
    view_event_role_state.event_role_id,
    view_event_role_state.language_id,
    view_event_role_state.tag,
    view_event_role_state.name,
    view_event_role_state.rank,
    view_event_role_state.language_tag,
    event_role_localized.name AS event_role
  FROM view_event_role_state
    INNER JOIN event_role_localized USING (event_role_id,language_id)
;

