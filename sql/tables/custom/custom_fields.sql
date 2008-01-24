
CREATE TABLE base.custom_fields (
  table_name TEXT NOT NULL,
  field_name TEXT NOT NULL,
  field_type TEXT NOT NULL,
  CHECK( table_name IN ('conference_person') ),
  CHECK( field_name ~* '^[a-z_0-9]+$' ),
  CHECK( field_type IN ('bool','text') )
);

CREATE TABLE custom.custom_fields (
  PRIMARY KEY( table_name, field_name )
) INHERITS( base.custom_fields );

CREATE TABLE log.custom_fields (
) INHERITS( base.logging, base.custom_fields );

