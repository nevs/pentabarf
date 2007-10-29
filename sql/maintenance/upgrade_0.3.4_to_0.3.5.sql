
BEGIN;

-- attachment type surrogate key removal

ALTER TABLE attachment_type ADD COLUMN attachment_type TEXT;
UPDATE attachment_type SET attachment_type = tag;
ALTER TABLE attachment_type DROP COLUMN tag CASCADE;
ALTER TABLE attachment_type DROP CONSTRAINT attachment_type_pkey CASCADE;
ALTER TABLE attachment_type ADD CONSTRAINT attachment_type_pkey PRIMARY KEY( attachment_type );

ALTER TABLE attachment_type_localized ADD COLUMN attachment_type TEXT REFERENCES attachment_type(attachment_type) ON UPDATE CASCADE ON DELETE CASCADE;
UPDATE attachment_type_localized SET attachment_type = ( SELECT attachment_type FROM attachment_type WHERE attachment_type.attachment_type_id = attachment_type_localized.attachment_type_id );
ALTER TABLE attachment_type_localized ALTER attachment_type SET NOT NULL;
ALTER TABLE attachment_type_localized DROP COLUMN attachment_type_id;
ALTER TABLE attachment_type_localized ADD CONSTRAINT attachment_type_localized_pkey PRIMARY KEY( attachment_type, language_id );
ALTER TABLE attachment_type_localized ALTER name TYPE TEXT;

ALTER TABLE event_attachment ADD COLUMN attachment_type TEXT;
UPDATE event_attachment SET attachment_type = (SELECT attachment_type FROM attachment_type WHERE attachment_type.attachment_type_id = event_attachment.attachment_type_id);
ALTER TABLE event_attachment ALTER attachment_type SET NOT NULL;
ALTER TABLE event_attachment DROP COLUMN attachment_type_id;

ALTER TABLE attachment_type DROP COLUMN attachment_type_id;

-- link_type surrogate key removal

ALTER TABLE link_type ADD COLUMN link_type TEXT;
UPDATE link_type SET link_type = tag;
ALTER TABLE link_type DROP COLUMN tag CASCADE;
ALTER TABLE link_type DROP CONSTRAINT link_type_pkey CASCADE;
ALTER TABLE link_type ADD CONSTRAINT link_type_pkey PRIMARY KEY( link_type );

ALTER TABLE link_type_localized ADD COLUMN link_type TEXT REFERENCES link_type(link_type) ON UPDATE CASCADE ON DELETE CASCADE;
UPDATE link_type_localized SET link_type = ( SELECT link_type FROM link_type WHERE link_type.link_type_id = link_type_localized.link_type_id );
ALTER TABLE link_type_localized ALTER link_type SET NOT NULL;
ALTER TABLE link_type_localized DROP COLUMN link_type_id;
ALTER TABLE link_type_localized ADD CONSTRAINT link_type_localized_pkey PRIMARY KEY( link_type, language_id );
ALTER TABLE link_type_localized ALTER name TYPE TEXT;

ALTER TABLE event_link_internal ADD COLUMN link_type TEXT REFERENCES link_type(link_type) ON UPDATE CASCADE ON DELETE CASCADE;
UPDATE event_link_internal SET link_type = ( SELECT link_type FROM link_type WHERE link_type.link_type_id = event_link_internal.link_type_id );
ALTER TABLE event_link_internal ALTER link_type SET NOT NULL;
ALTER TABLE event_link_internal DROP COLUMN link_type_id;
ALTER TABLE event_link_internal ALTER description TYPE TEXT;
ALTER TABLE event_link_internal ALTER url TYPE TEXT;

ALTER TABLE conference_person_link_internal ADD COLUMN link_type TEXT REFERENCES link_type(link_type) ON UPDATE CASCADE ON DELETE CASCADE;
UPDATE conference_person_link_internal SET link_type = ( SELECT link_type FROM link_type WHERE link_type.link_type_id = conference_person_link_internal.link_type_id );
ALTER TABLE conference_person_link_internal ALTER link_type SET NOT NULL;
ALTER TABLE conference_person_link_internal DROP COLUMN link_type_id;
ALTER TABLE conference_person_link_internal ALTER description TYPE TEXT;

ALTER TABLE link_type DROP COLUMN link_type_id;

-- event origin surrogate key removal

ALTER TABLE event_origin ADD COLUMN event_origin TEXT;
UPDATE event_origin SET event_origin = tag;
ALTER TABLE event_origin DROP COLUMN tag CASCADE;
ALTER TABLE event_origin DROP CONSTRAINT event_origin_pkey CASCADE;
ALTER TABLE event_origin ADD CONSTRAINT event_origin_pkey PRIMARY KEY( event_origin );

ALTER TABLE event_origin_localized ADD COLUMN event_origin TEXT REFERENCES event_origin(event_origin) ON UPDATE CASCADE ON DELETE CASCADE;
UPDATE event_origin_localized SET event_origin = ( SELECT event_origin FROM event_origin WHERE event_origin.event_origin_id = event_origin_localized.event_origin_id );
ALTER TABLE event_origin_localized ALTER event_origin SET NOT NULL;
ALTER TABLE event_origin_localized DROP COLUMN event_origin_id;
ALTER TABLE event_origin_localized ADD CONSTRAINT event_origin_localized_pkey PRIMARY KEY( event_origin, language_id );
ALTER TABLE event_origin_localized ALTER name TYPE TEXT;

ALTER TABLE event ADD COLUMN event_origin TEXT REFERENCES event_origin(event_origin) ON UPDATE CASCADE ON DELETE CASCADE;
UPDATE event SET event_origin = ( SELECT event_origin FROM event_origin WHERE event_origin.event_origin_id = event.event_origin_id );
ALTER TABLE event ALTER event_origin SET NOT NULL;
ALTER TABLE event DROP COLUMN event_origin_id CASCADE;

ALTER TABLE event_origin DROP COLUMN event_origin_id;

-- conference phase migration

ALTER TABLE conference_phase ADD COLUMN conference_phase TEXT;
UPDATE conference_phase SET conference_phase = tag;
ALTER TABLE conference_phase DROP COLUMN tag CASCADE;
ALTER TABLE conference_phase DROP CONSTRAINT conference_phase_pkey CASCADE;
ALTER TABLE conference_phase ADD CONSTRAINT conference_phase_pkey PRIMARY KEY( conference_phase );

ALTER TABLE conference_phase_localized ADD COLUMN conference_phase TEXT REFERENCES conference_phase(conference_phase) ON UPDATE CASCADE ON DELETE CASCADE;
UPDATE conference_phase_localized SET conference_phase = ( SELECT conference_phase FROM conference_phase WHERE conference_phase.conference_phase_id = conference_phase_localized.conference_phase_id );
ALTER TABLE conference_phase_localized ALTER conference_phase SET NOT NULL;
ALTER TABLE conference_phase_localized DROP COLUMN conference_phase_id;
ALTER TABLE conference_phase_localized ADD CONSTRAINT conference_phase_localized_pkey PRIMARY KEY( conference_phase, language_id );
ALTER TABLE conference_phase_localized ALTER name TYPE TEXT;

ALTER TABLE conference_phase_conflict ADD COLUMN conference_phase TEXT REFERENCES conference_phase(conference_phase) ON UPDATE CASCADE ON DELETE CASCADE;
UPDATE conference_phase_conflict SET conference_phase = ( SELECT conference_phase FROM conference_phase WHERE conference_phase.conference_phase_id = conference_phase_conflict.conference_phase_id );
ALTER TABLE conference_phase_conflict ALTER conference_phase SET NOT NULL;
ALTER TABLE conference_phase_conflict DROP COLUMN conference_phase_id;

ALTER TABLE conference ADD COLUMN conference_phase TEXT REFERENCES conference_phase(conference_phase) ON UPDATE CASCADE ON DELETE RESTRICT;
UPDATE conference SET conference_phase = ( SELECT conference_phase FROM conference_phase WHERE conference_phase.conference_phase_id = conference.conference_phase_id );
ALTER TABLE conference ALTER conference_phase SET NOT NULL;
ALTER TABLE conference DROP COLUMN conference_phase_id;

ALTER TABLE conference_phase DROP COLUMN conference_phase_id;

-- conflict migration

CREATE SCHEMA conflict;

-- conflict_id removal

ALTER TABLE conflict ADD COLUMN conflict TEXT;
UPDATE conflict SET conflict = tag;
ALTER TABLE conflict DROP COLUMN tag CASCADE;
ALTER TABLE conflict DROP CONSTRAINT conflict_pkey CASCADE;
ALTER TABLE conflict ADD CONSTRAINT conflict_pkey PRIMARY KEY( conflict );
ALTER TABLE conflict SET SCHEMA conflict;

ALTER TABLE conflict_localized ADD COLUMN conflict TEXT REFERENCES conflict.conflict(conflict) ON UPDATE CASCADE ON DELETE CASCADE;
UPDATE conflict_localized SET conflict = ( SELECT conflict FROM conflict.conflict WHERE conflict.conflict_id = conflict_localized.conflict_id );
ALTER TABLE conflict_localized ALTER conflict SET NOT NULL;
ALTER TABLE conflict_localized DROP COLUMN conflict_id;
ALTER TABLE conflict_localized ADD CONSTRAINT conflict_localized_pkey PRIMARY KEY( conflict, language_id );
ALTER TABLE conflict_localized ALTER name TYPE TEXT;
ALTER TABLE conflict_localized SET SCHEMA conflict;

ALTER TABLE conference_phase_conflict ADD COLUMN conflict TEXT REFERENCES conflict.conflict(conflict) ON UPDATE CASCADE ON DELETE CASCADE;
UPDATE conference_phase_conflict SET conflict = ( SELECT conflict FROM conflict.conflict WHERE conflict.conflict_id = conference_phase_conflict.conflict_id );
ALTER TABLE conference_phase_conflict ALTER conflict SET NOT NULL;
ALTER TABLE conference_phase_conflict DROP COLUMN conflict_id;
ALTER TABLE conference_phase_conflict SET SCHEMA conflict;

ALTER TABLE conflict.conflict DROP COLUMN conflict_id;

-- conflict_type_id removal

ALTER TABLE conflict_type ADD COLUMN conflict_type TEXT;
UPDATE conflict_type SET conflict_type = tag;
ALTER TABLE conflict_type DROP COLUMN tag CASCADE;
ALTER TABLE conflict_type DROP CONSTRAINT conflict_type_pkey CASCADE;
ALTER TABLE conflict_type ADD CONSTRAINT conflict_type_pkey PRIMARY KEY( conflict_type );
ALTER TABLE conflict_type SET SCHEMA conflict;

ALTER TABLE conflict.conflict ADD COLUMN conflict_type TEXT REFERENCES conflict.conflict_type(conflict_type) ON UPDATE CASCADE ON DELETE CASCADE;
UPDATE conflict.conflict SET conflict_type = ( SELECT conflict_type FROM conflict.conflict_type WHERE conflict_type.conflict_type_id = conflict.conflict_type_id );
ALTER TABLE conflict.conflict ALTER conflict_type SET NOT NULL;
ALTER TABLE conflict.conflict DROP COLUMN conflict_type_id;

ALTER TABLE conflict.conflict_type DROP COLUMN conflict_type_id;

-- conflict_level_id removal

ALTER TABLE conflict_level ADD COLUMN conflict_level TEXT;
UPDATE conflict_level SET conflict_level = tag;
ALTER TABLE conflict_level DROP COLUMN tag CASCADE;
ALTER TABLE conflict_level DROP CONSTRAINT conflict_level_pkey CASCADE;
ALTER TABLE conflict_level ADD CONSTRAINT conflict_level_pkey PRIMARY KEY( conflict_level );
ALTER TABLE conflict_level SET SCHEMA conflict;

ALTER TABLE conflict_level_localized ADD COLUMN conflict_level TEXT REFERENCES conflict.conflict_level(conflict_level) ON UPDATE CASCADE ON DELETE CASCADE;
UPDATE conflict_level_localized SET conflict_level = ( SELECT conflict_level FROM conflict.conflict_level WHERE conflict_level.conflict_level_id = conflict_level_localized.conflict_level_id );
ALTER TABLE conflict_level_localized ALTER conflict_level SET NOT NULL;
ALTER TABLE conflict_level_localized DROP COLUMN conflict_level_id;
ALTER TABLE conflict_level_localized ADD CONSTRAINT conflict_level_localized_pkey PRIMARY KEY( conflict_level, language_id );
ALTER TABLE conflict_level_localized ALTER name TYPE TEXT;
ALTER TABLE conflict_level_localized SET SCHEMA conflict;

ALTER TABLE conflict.conference_phase_conflict ADD COLUMN conflict_level TEXT REFERENCES conflict.conflict_level(conflict_level) ON UPDATE CASCADE ON DELETE CASCADE;
UPDATE conflict.conference_phase_conflict SET conflict_level = ( SELECT conflict_level FROM conflict.conflict_level WHERE conflict_level.conflict_level_id = conference_phase_conflict.conflict_level_id );
ALTER TABLE conflict.conference_phase_conflict ALTER conflict_level SET NOT NULL;
ALTER TABLE conflict.conference_phase_conflict DROP COLUMN conflict_level_id;

ALTER TABLE conflict.conflict_level DROP COLUMN conflict_level_id;

DROP TYPE conflict_person CASCADE;
DROP TYPE conflict_person_conflict CASCADE;
DROP TYPE conflict_event_person CASCADE;
DROP TYPE conflict_event_person_conflict CASCADE;
DROP TYPE conflict_event_person_event CASCADE;
DROP TYPE conflict_event_person_event_conflict CASCADE;
DROP TYPE conflict_event CASCADE;
DROP TYPE conflict_event_conflict CASCADE;
DROP TYPE conflict_event_event CASCADE;
DROP TYPE conflict_event_event_conflict CASCADE;
DROP TYPE view_conflict_event CASCADE;
DROP TYPE view_conflict_event_event CASCADE;
DROP TYPE view_conflict_event_person CASCADE;
DROP TYPE view_conflict_event_person_event CASCADE;
DROP TYPE view_conflict_person CASCADE;

CREATE TYPE conflict.conflict_person AS (
  person_id   INTEGER
);

CREATE TYPE conflict.conflict_person_conflict AS (
  conflict    TEXT,
  person_id   INTEGER
);

CREATE TYPE conflict.conflict_event_person AS (
  event_id    INTEGER,
  person_id   INTEGER
);

CREATE TYPE conflict.conflict_event_person_conflict AS (
  conflict    TEXT,
  event_id    INTEGER,
  person_id   INTEGER
);

CREATE TYPE conflict.conflict_event_person_event AS (
  event_id1   INTEGER,
  event_id2   INTEGER,
  person_id   INTEGER
);

CREATE TYPE conflict.conflict_event_person_event_conflict AS (
  conflict    TEXT,
  event_id1   INTEGER,
  event_id2   INTEGER,
  person_id   INTEGER
);

CREATE TYPE conflict.conflict_event AS (
  event_id    INTEGER
);

CREATE TYPE conflict.conflict_event_conflict AS (
  conflict    TEXT,
  event_id    INTEGER
);

CREATE TYPE conflict.conflict_event_event AS (
  event_id1   INTEGER,
  event_id2   INTEGER
);

CREATE TYPE conflict.conflict_event_event_conflict AS (
  conflict    TEXT,
  event_id1   INTEGER,
  event_id2   INTEGER
);

CREATE TYPE conflict.view_conflict_event AS (
  conflict    TEXT,
  conflict_name TEXT,
  conflict_level TEXT,
  conflict_level_name TEXT,
  language_id INTEGER,
  event_id    INTEGER,
  title TEXT
);

CREATE TYPE conflict.view_conflict_event_event AS (
  conflict    TEXT,
  conflict_name TEXT,
  conflict_level TEXT,
  conflict_level_name TEXT,
  language_id INTEGER,
  event_id1 INTEGER,
  event_id2 INTEGER,
  title1 TEXT,
  title2 TEXT
);

CREATE TYPE conflict.view_conflict_event_person AS (
  conflict    TEXT,
  conflict_name TEXT,
  conflict_level TEXT,
  conflict_level_name TEXT,
  language_id INTEGER,
  event_id INTEGER,
  person_id INTEGER,
  title TEXT,
  name TEXT
);

CREATE TYPE conflict.view_conflict_event_person_event AS (
  conflict    TEXT,
  conflict_name TEXT,
  conflict_level TEXT,
  conflict_level_name TEXT,
  language_id INTEGER,
  person_id INTEGER,
  event_id1 INTEGER,
  event_id2 INTEGER,
  name TEXT,
  title1 TEXT,
  title2 TEXT
);

CREATE TYPE conflict.view_conflict_person AS (
  conflict    TEXT,
  conflict_name TEXT,
  conflict_level TEXT,
  conflict_level_name TEXT,
  language_id INTEGER,
  person_id INTEGER,
  name TEXT
);

-- inheritance based logging stuff

CREATE TABLE base.logging (
  log_transaction_id BIGSERIAL,
  log_operation CHAR(1)
);

CREATE TABLE log.log_transaction(
  log_transaction_id SERIAL,
  log_timestamp TIMESTAMP DEFAULT now(),
  person_id INTEGER REFERENCES person(person_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY( log_transaction_id )
);

CREATE TABLE base.person_role (
  person_id INTEGER NOT NULL,
  role TEXT NOT NULL
);

CREATE TABLE log.person_role() INHERITS( base.logging, base.person_role );

ALTER TABLE auth.person_role RENAME TO person_role_old;

CREATE TABLE auth.person_role (
  PRIMARY KEY( person_id, role ),
  FOREIGN KEY( person_id) REFERENCES person( person_id ) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY( role ) REFERENCES auth.role( role ) ON UPDATE CASCADE ON DELETE CASCADE
) INHERITS( base.person_role );

INSERT INTO auth.person_role( person_id, role ) SELECT person_id, role FROM auth.person_role_old;
DROP TABLE auth.person_role_old CASCADE;


COMMIT;

