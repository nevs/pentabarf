
BEGIN;

ALTER TABLE base.custom_fields DROP CONSTRAINT custom_fields_field_type_check;
ALTER TABLE base.custom_fields ADD CONSTRAINT custom_fields_field_type_check CHECK(field_type IN('boolean','text','valuelist'));


COMMIT;

