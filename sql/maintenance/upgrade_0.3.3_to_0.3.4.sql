
BEGIN;

CREATE SCHEMA base;
CREATE SCHEMA log;

-- im_type surrogate key removal
ALTER TABLE im_type ADD COLUMN im_type TEXT;
UPDATE im_type SET im_type = tag;
ALTER TABLE im_type DROP COLUMN tag CASCADE;
ALTER TABLE im_type DROP CONSTRAINT im_type_pkey CASCADE;
ALTER TABLE im_type ADD CONSTRAINT im_type_pkey PRIMARY KEY( im_type );
ALTER TABLE im_type ALTER scheme TYPE TEXT;

ALTER TABLE im_type_localized ADD COLUMN im_type TEXT REFERENCES im_type(im_type) ON UPDATE CASCADE ON DELETE CASCADE;
UPDATE im_type_localized SET im_type = ( SELECT im_type FROM im_type WHERE im_type.im_type_id = im_type_localized.im_type_id );
ALTER TABLE im_type_localized DROP COLUMN im_type_id;
ALTER TABLE im_type_localized ADD CONSTRAINT im_type_localized_pkey PRIMARY KEY( im_type, language_id );
ALTER TABLE im_type_localized ALTER name TYPE TEXT;

ALTER TABLE person_im ADD COLUMN im_type TEXT REFERENCES im_type(im_type) ON UPDATE CASCADE ON DELETE CASCADE;
UPDATE person_im SET im_type = ( SELECT im_type FROM im_type WHERE im_type.im_type_id = person_im.im_type_id );
ALTER TABLE person_im ALTER im_type SET NOT NULL;
ALTER TABLE person_im DROP COLUMN im_type_id;
ALTER TABLE person_im ALTER im_address TYPE TEXT;

ALTER TABLE im_type DROP COLUMN im_type_id;

-- phone_type surrogate key removal

ALTER TABLE phone_type ADD COLUMN phone_type TEXT;
UPDATE phone_type SET phone_type = tag;
ALTER TABLE phone_type DROP COLUMN tag CASCADE;
ALTER TABLE phone_type DROP CONSTRAINT phone_type_pkey CASCADE;
ALTER TABLE phone_type ADD CONSTRAINT phone_type_pkey PRIMARY KEY( phone_type );
ALTER TABLE phone_type ALTER scheme TYPE TEXT;

ALTER TABLE phone_type_localized ADD COLUMN phone_type TEXT REFERENCES phone_type(phone_type) ON UPDATE CASCADE ON DELETE CASCADE;
UPDATE phone_type_localized SET phone_type = ( SELECT phone_type FROM phone_type WHERE phone_type.phone_type_id = phone_type_localized.phone_type_id );
ALTER TABLE phone_type_localized DROP COLUMN phone_type_id;
ALTER TABLE phone_type_localized ADD CONSTRAINT phone_type_localized_pkey PRIMARY KEY( phone_type, language_id );
ALTER TABLE phone_type_localized ALTER name TYPE TEXT;

ALTER TABLE person_phone ADD COLUMN phone_type TEXT REFERENCES phone_type(phone_type) ON UPDATE CASCADE ON DELETE CASCADE;
UPDATE person_phone SET phone_type = ( SELECT phone_type FROM phone_type WHERE phone_type.phone_type_id = person_phone.phone_type_id );
ALTER TABLE person_phone ALTER phone_type SET NOT NULL;
ALTER TABLE person_phone DROP COLUMN phone_type_id;
ALTER TABLE person_phone ALTER phone_number TYPE TEXT;

ALTER TABLE phone_type DROP COLUMN phone_type_id;

-- mime_type surrogate key removal

DROP VIEW view_mime_type CASCADE;
DROP VIEW view_conference_image;
DROP VIEW view_event_image;
DROP VIEW view_person_image;
DROP VIEW view_find_person;
DROP VIEW view_find_event;
DROP VIEW view_find_conference;
DROP VIEW view_event;
ALTER TABLE mime_type ALTER mime_type TYPE TEXT;
ALTER TABLE mime_type DROP CONSTRAINT mime_type_pkey CASCADE;
ALTER TABLE mime_type ADD CONSTRAINT mime_type_pkey PRIMARY KEY( mime_type );

ALTER TABLE mime_type_localized ADD COLUMN mime_type TEXT REFERENCES mime_type(mime_type) ON UPDATE CASCADE ON DELETE CASCADE;
UPDATE mime_type_localized SET mime_type = ( SELECT mime_type FROM mime_type WHERE mime_type.mime_type_id = mime_type_localized.mime_type_id );
ALTER TABLE mime_type_localized ALTER mime_type SET NOT NULL;
ALTER TABLE mime_type_localized DROP COLUMN mime_type_id;
ALTER TABLE mime_type_localized ADD CONSTRAINT mime_type_localized_pkey PRIMARY KEY( mime_type, language_id );
ALTER TABLE mime_type_localized ALTER name TYPE TEXT;

ALTER TABLE conference_image ADD COLUMN mime_type TEXT REFERENCES mime_type(mime_type) ON UPDATE CASCADE ON DELETE CASCADE;
UPDATE conference_image SET mime_type = ( SELECT mime_type FROM mime_type WHERE mime_type.mime_type_id = conference_image.mime_type_id );
ALTER TABLE conference_image ALTER mime_type SET NOT NULL;
ALTER TABLE conference_image DROP COLUMN mime_type_id;

ALTER TABLE event_image ADD COLUMN mime_type TEXT REFERENCES mime_type(mime_type) ON UPDATE CASCADE ON DELETE CASCADE;
UPDATE event_image SET mime_type = ( SELECT mime_type FROM mime_type WHERE mime_type.mime_type_id = event_image.mime_type_id );
ALTER TABLE event_image ALTER mime_type SET NOT NULL;
ALTER TABLE event_image DROP COLUMN mime_type_id CASCADE;

ALTER TABLE person_image ADD COLUMN mime_type TEXT REFERENCES mime_type(mime_type) ON UPDATE CASCADE ON DELETE CASCADE;
UPDATE person_image SET mime_type = ( SELECT mime_type FROM mime_type WHERE mime_type.mime_type_id = person_image.mime_type_id );
ALTER TABLE person_image ALTER mime_type SET NOT NULL;
ALTER TABLE person_image DROP COLUMN mime_type_id CASCADE;

ALTER TABLE event_attachment ADD COLUMN mime_type TEXT REFERENCES mime_type(mime_type) ON UPDATE CASCADE ON DELETE CASCADE;
UPDATE event_attachment SET mime_type = ( SELECT mime_type FROM mime_type WHERE mime_type.mime_type_id = event_attachment.mime_type_id );
ALTER TABLE event_attachment ALTER mime_type SET NOT NULL;
ALTER TABLE event_attachment DROP COLUMN mime_type_id;

ALTER TABLE mime_type DROP COLUMN mime_type_id;

COMMIT;

