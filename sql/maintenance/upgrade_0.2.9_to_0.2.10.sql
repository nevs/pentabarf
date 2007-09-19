
BEGIN;

DROP VIEW view_review;

ALTER TABLE conference_track ADD CONSTRAINT no_slashes CHECK (tag NOT SIMILAR TO '%[\\\\/]%');

ALTER TABLE person ADD CONSTRAINT no_colon CHECK ( strpos( login_name, ':' ) = 0 );

INSERT INTO authorisation( tag ) VALUES ( 'view_ratings' );
INSERT INTO role_authorisation VALUES ( (SELECT role_id FROM role WHERE tag = 'developer'), currval('authorisation_authorisation_id_seq') );
INSERT INTO role_authorisation VALUES ( (SELECT role_id FROM role WHERE tag = 'admin'), currval('authorisation_authorisation_id_seq') );
INSERT INTO role_authorisation VALUES ( (SELECT role_id FROM role WHERE tag = 'committee'), currval('authorisation_authorisation_id_seq') );

DROP TABLE person_availability;

CREATE TABLE person_availability (
  person_availability_id SERIAL,
  person_id INTEGER NOT NULL,
  conference_id INTEGER NOT NULL,
  start_date TIMESTAMP WITH TIME ZONE NOT NULL,
  duration INTERVAL NOT NULL,
  FOREIGN KEY (person_id) REFERENCES person (person_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (conference_id) REFERENCES conference (conference_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (person_availability_id),
  UNIQUE (person_id, conference_id, start_date)
);

INSERT INTO ui_message(tag) VALUES ('view::pentabarf::conference::tab::teams');
INSERT INTO ui_message_localized VALUES ( currval('ui_message_ui_message_id_seq'), 120, 'Teams');
INSERT INTO ui_message_localized VALUES ( currval('ui_message_ui_message_id_seq'), 144, 'Teams');
INSERT INTO ui_message(tag) VALUES ('view::pentabarf::person::tab::availability');
INSERT INTO ui_message_localized VALUES ( currval('ui_message_ui_message_id_seq'), 120, 'Availability');
INSERT INTO ui_message_localized VALUES ( currval('ui_message_ui_message_id_seq'), 144, 'Verfügbarkeit');

INSERT INTO conflict( conflict_type_id, tag) VALUES (2,'event_person_person_availability');
INSERT INTO conflict_localized( conflict_id, language_id, name ) VALUES( currval('conflict_conflict_id_seq'), 120, 'Speaker or moderator not available for an event');
INSERT INTO conflict_localized( conflict_id, language_id, name ) VALUES( currval('conflict_conflict_id_seq'), 144, 'Referent oder Moderator für einen Event nicht verfügbar');

INSERT INTO conference_phase_conflict( conference_phase_id, conflict_id, conflict_level_id ) VALUES ( 1, currval('conflict_conflict_id_seq'), 2 );
INSERT INTO conference_phase_conflict( conference_phase_id, conflict_id, conflict_level_id ) VALUES ( 2, currval('conflict_conflict_id_seq'), 5 );
INSERT INTO conference_phase_conflict( conference_phase_id, conflict_id, conflict_level_id ) VALUES ( 3, currval('conflict_conflict_id_seq'), 5 );
INSERT INTO conference_phase_conflict( conference_phase_id, conflict_id, conflict_level_id ) VALUES ( 4, currval('conflict_conflict_id_seq'), 5 );
INSERT INTO conference_phase_conflict( conference_phase_id, conflict_id, conflict_level_id ) VALUES ( 5, currval('conflict_conflict_id_seq'), 1 );

COMMIT;

