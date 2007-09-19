
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
ALTER TABLE ui_message_localized ADD CONSTRAINT ui_message_localized_ui_message_fkey FOREIGN KEY( ui_message ) REFERENCES ui_message(ui_message);

