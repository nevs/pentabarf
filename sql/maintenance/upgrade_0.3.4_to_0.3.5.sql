
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


COMMIT;

