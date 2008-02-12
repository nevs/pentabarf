
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



COMMIT;

