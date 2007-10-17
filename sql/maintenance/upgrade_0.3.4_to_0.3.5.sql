
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

CREATE TABLE base.logging (
  log_transaction_id BIGSERIAL,
  log_operation   char(1),
  log_timestamp   TIMESTAMP NOT NULL,
  log_person_id   INTEGER
);

CREATE SEQUENCE log.log_transaction_id_seq;

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
DROP TABLE auth.person_role_old;


COMMIT;

