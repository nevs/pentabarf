
BEGIN;

-- remove unused columns from event
ALTER TABLE event DROP COLUMN actual_start;
ALTER TABLE event DROP COLUMN actual_end;

-- remove surrogate primary key from event type 
ALTER TABLE event_type ADD COLUMN event_type TEXT;
UPDATE event_type SET event_type = tag;
ALTER TABLE event_type DROP COLUMN tag CASCADE;
ALTER TABLE event_type_localized ADD COLUMN event_type TEXT;
UPDATE event_type_localized SET event_type = ( SELECT event_type FROM event_type WHERE event_type.event_type_id = event_type_localized.event_type_id );
ALTER TABLE event ADD COLUMN event_type TEXT;
UPDATE event SET event_type = ( SELECT event_type FROM event_type WHERE event_type.event_type_id = event.event_type_id );

ALTER TABLE event_type_localized DROP CONSTRAINT event_type_localized_pkey;
ALTER TABLE event_type DROP CONSTRAINT event_type_pkey CASCADE;
ALTER TABLE event_type DROP COLUMN event_type_id;
ALTER TABLE event_type_localized DROP COLUMN event_type_id ;
ALTER TABLE event DROP COLUMN event_type_id CASCADE;

ALTER TABLE event_type ADD CONSTRAINT event_type_pkey PRIMARY KEY( event_type );
ALTER TABLE event_type_localized ADD CONSTRAINT event_type_localized_pkey PRIMARY KEY ( event_type, language_id );
ALTER TABLE event_type_localized ADD CONSTRAINT event_type_localized_event_type_fkey FOREIGN KEY( event_type ) REFERENCES event_type(event_type) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE event ADD CONSTRAINT event_event_type_fkey FOREIGN KEY( event_type ) REFERENCES event_type(event_type) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE event_type_localized ALTER name TYPE TEXT;

COMMIT;

