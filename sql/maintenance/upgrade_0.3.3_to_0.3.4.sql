

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

