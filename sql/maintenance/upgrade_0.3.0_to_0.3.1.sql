
BEGIN;

-- ui_message migration

ALTER TABLE ui_message ADD COLUMN ui_message TEXT;
UPDATE ui_message SET ui_message = tag;
ALTER TABLE ui_message DROP COLUMN tag CASCADE;
ALTER TABLE ui_message_localized ADD COLUMN ui_message TEXT;
UPDATE ui_message_localized SET ui_message = ( SELECT ui_message FROM ui_message WHERE ui_message.ui_message_id = ui_message_localized.ui_message_id );

ALTER TABLE ui_message_localized DROP CONSTRAINT ui_message_localized_pkey;
ALTER TABLE ui_message_localized DROP CONSTRAINT ui_message_localized_ui_message_id_fkey;
ALTER TABLE ui_message DROP CONSTRAINT ui_message_pkey;
ALTER TABLE ui_message DROP COLUMN ui_message_id;
ALTER TABLE ui_message_localized DROP COLUMN ui_message_id ;

ALTER TABLE ui_message ADD CONSTRAINT ui_message_pkey PRIMARY KEY( ui_message );
ALTER TABLE ui_message_localized ADD CONSTRAINT ui_message_localized_pkey PRIMARY KEY ( ui_message, language_id );
ALTER TABLE ui_message_localized ADD CONSTRAINT ui_message_localized_ui_message_fkey FOREIGN KEY( ui_message ) REFERENCES ui_message(ui_message) ON UPDATE CASCADE ON DELETE CASCADE;

-- event state migration

ALTER TABLE event_state ADD COLUMN event_state TEXT;
UPDATE event_state SET event_state = tag;
ALTER TABLE event_state DROP COLUMN tag CASCADE;

ALTER TABLE event_state_localized ALTER name TYPE TEXT;
ALTER TABLE event_state_localized ADD COLUMN event_state TEXT;
UPDATE event_state_localized SET event_state = ( SELECT event_state FROM event_state WHERE event_state.event_state_id = event_state_localized.event_state_id );
ALTER TABLE event_state_localized DROP CONSTRAINT event_state_localized_event_state_id_fkey;
ALTER TABLE event_state_localized DROP CONSTRAINT event_state_localized_pkey;

ALTER TABLE event_state_progress ADD COLUMN event_state TEXT;
UPDATE event_state_progress SET event_state = ( SELECT event_state FROM event_state WHERE event_state.event_state_id = event_state_progress.event_state_id );
ALTER TABLE event_state_progress DROP CONSTRAINT event_state_progress_event_state_id_fkey;

ALTER TABLE event ADD COLUMN event_state TEXT;
UPDATE event SET event_state = ( SELECT event_state FROM event_state WHERE event_state.event_state_id = event.event_state_id );
ALTER TABLE event DROP CONSTRAINT event_event_state_id_fkey;

ALTER TABLE event_state DROP CONSTRAINT event_state_pkey CASCADE;
ALTER TABLE event_state ADD CONSTRAINT event_state_pkey PRIMARY KEY( event_state );
ALTER TABLE event_state DROP COLUMN event_state_id;

ALTER TABLE event_state_localized ADD CONSTRAINT event_state_localized_pkey PRIMARY KEY( event_state, language_id );
ALTER TABLE event_state_localized ADD CONSTRAINT event_state_localized_event_state_fkey FOREIGN KEY( event_state ) REFERENCES event_state( event_state ) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE event_state_localized DROP COLUMN event_state_id;

ALTER TABLE event DROP COLUMN event_state_id;
ALTER TABLE event_state_progress DROP COLUMN event_state_id CASCADE;
ALTER TABLE event_state_progress ADD CONSTRAINT event_state_progress_event_state_fkey FOREIGN KEY( event_state ) REFERENCES event_state( event_state ) ON UPDATE CASCADE ON DELETE CASCADE;

CREATE INDEX event_event_state_index ON event(event_state);

-- event state progress migration

ALTER TABLE event_state_progress ADD COLUMN event_state_progress TEXT;
UPDATE event_state_progress SET event_state_progress = tag;
ALTER TABLE event_state_progress DROP COLUMN tag;

ALTER TABLE event_state_progress_localized ADD COLUMN event_state TEXT;
ALTER TABLE event_state_progress_localized ADD COLUMN event_state_progress TEXT;
ALTER TABLE event_state_progress_localized ALTER name TYPE TEXT;
UPDATE event_state_progress_localized SET event_state = ( SELECT event_state FROM event_state_progress WHERE event_state_progress.event_state_progress_id = event_state_progress_localized.event_state_progress_id );
UPDATE event_state_progress_localized SET event_state_progress = ( SELECT event_state_progress FROM event_state_progress WHERE event_state_progress.event_state_progress_id = event_state_progress_localized.event_state_progress_id );

ALTER TABLE event ADD COLUMN event_state_progress TEXT;
UPDATE event SET event_state_progress = ( SELECT event_state_progress FROM event_state_progress WHERE event_state_progress.event_state_progress_id = event.event_state_progress_id );

ALTER TABLE event_state_progress DROP COLUMN event_state_progress_id CASCADE;
ALTER TABLE event_state_progress ADD CONSTRAINT event_state_progress_pkey PRIMARY KEY (event_state, event_state_progress);

ALTER TABLE event_state_progress_localized DROP COLUMN event_state_progress_id CASCADE;
ALTER TABLE event_state_progress_localized ADD CONSTRAINT event_state_progress_localized_pkey PRIMARY KEY ( event_state, event_state_progress, language_id );
ALTER TABLE event_state_progress_localized ADD CONSTRAINT event_state_progress_localized_event_state_fkey FOREIGN KEY ( event_state, event_state_progress ) REFERENCES event_state_progress( event_state, event_state_progress ) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE event DROP COLUMN event_state_progress_id CASCADE;
ALTER TABLE event ADD CONSTRAINT event_event_state_fkey FOREIGN KEY ( event_state, event_state_progress ) REFERENCES event_state_progress( event_state,event_state_progress);
ALTER TABLE event ALTER event_state SET NOT NULL;
ALTER TABLE event ALTER event_state_progress SET NOT NULL;

-- drop unused columns from event

ALTER TABLE event DROP COLUMN f_conflict;
ALTER TABLE event DROP COLUMN f_deleted;
ALTER TABLE event DROP COLUMN f_unmoderated;

COMMIT;

