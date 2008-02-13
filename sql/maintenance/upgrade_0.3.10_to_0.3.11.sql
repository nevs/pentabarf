
BEGIN;

ALTER TABLE base.custom_fields DROP CONSTRAINT custom_fields_field_type_check;
ALTER TABLE base.custom_fields ADD CONSTRAINT custom_fields_field_type_check CHECK(field_type IN('boolean','text','valuelist','conference-valuelist'));

DROP TABLE base.custom_conference_person CASCADE;

CREATE TABLE base.custom_conference_person (
  conference_id INTEGER NOT NULL,
  person_id INTEGER NOT NULL
);

CREATE TABLE custom.custom_conference_person (
  PRIMARY KEY( conference_id, person_id ),
  FOREIGN KEY( conference_id, person_id ) REFERENCES conference_person( conference_id, person_id ) ON UPDATE CASCADE ON DELETE CASCADE
) INHERITS( base.custom_conference_person );

CREATE TABLE log.custom_conference_person (
) INHERITS( base.logging, base.custom_conference_person );

CREATE TABLE log.account() INHERITS( base.logging, base.account );

CREATE TABLE base.account_settings (
  account_id INTEGER NOT NULL,
  current_language TEXT NOT NULL DEFAULT 'en',
  current_conference_id INTEGER,
  preferences TEXT,
  last_login TIMESTAMP
);

CREATE TABLE auth.account_settings (
  FOREIGN KEY( account_id ) REFERENCES auth.account( account_id ) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY( account_id )
) INHERITS( base.account_settings );

INSERT INTO auth.account_settings(account_id,current_language,current_conference_id,preferences,last_login) SELECT account_id,current_language,current_conference_id,preferences,last_login FROM auth.account;

ALTER TABLE base.account DROP COLUMN current_language;
ALTER TABLE base.account DROP COLUMN current_conference_id;
ALTER TABLE base.account DROP COLUMN preferences;
ALTER TABLE base.account DROP COLUMN last_login CASCADE;

INSERT INTO auth.object_domain VALUES('account_settings','account');

COMMIT;

