
DROP FUNCTION own_events(integer);
DROP FUNCTION own_events(integer,integer);

ALTER TABLE person ADD COLUMN current_conference_id INTEGER REFERENCES conference( conference_id ) ON UPDATE CASCADE ON DELETE SET NULL;
ALTER TABLE person_logging ADD COLUMN current_conference_id INTEGER;

ALTER TABLE person ADD COLUMN current_language_id INTEGER REFERENCES language( language_id ) ON UPDATE CASCADE ON DELETE SET NULL;
ALTER TABLE person_logging ADD COLUMN current_language_id INTEGER;

-- add new permission for config stuff and give it to developers and admin
INSERT INTO authorisation(tag) VALUES ('modify_config');
INSERT INTO role_authorisation VALUES (1, lastval());
INSERT INTO role_authorisation VALUES (2, lastval());

