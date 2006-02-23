-- script to upgrade database from pentabarf 0.2.0 to 0.2.1

BEGIN TRANSACTION;

ALTER TABLE conference ADD COLUMN f_visitor_enabled BOOL;
UPDATE conference SET f_visitor_enabled = FALSE;
ALTER TABLE conference ALTER f_visitor_enabled SET DEFAULT FALSE;
ALTER TABLE conference ALTER f_visitor_enabled SET NOT NULL;

ALTER TABLE conference_logging ADD COLUMN f_visitor_enabled BOOL;
UPDATE conference_logging SET f_visitor_enabled = FALSE;


-- attendee conflict
SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('conflict', 'conflict_id'), 26, true);
INSERT INTO conflict (conflict_id, conflict_type_id, tag) VALUES (26, 3, 'event_person_event_time_attendee');

-- add attendee event role
SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('event_role', 'event_role_id'), 7, true);
INSERT INTO event_role (event_role_id, tag, rank) VALUES (7, 'attendee', NULL);

COMMIT TRANSACTION;

