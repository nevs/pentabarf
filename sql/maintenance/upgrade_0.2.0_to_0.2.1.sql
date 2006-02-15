-- script to upgrade database from pentabarf 0.2.0 to 0.2.1

BEGIN TRANSACTION;

ALTER TABLE conference ADD COLUMN f_visitor_enabled BOOL;
UPDATE conference SET f_visitor_enabled = FALSE;
ALTER TABLE conference ALTER f_visitor_enabled SET DEFAULT FALSE;
ALTER TABLE conference ALTER f_visitor_enabled SET NOT NULL;

ALTER TABLE conference_logging ADD COLUMN f_visitor_enabled BOOL;
UPDATE conference_logging SET f_visitor_enabled = FALSE;

COMMIT TRANSACTION;

