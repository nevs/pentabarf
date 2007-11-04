
CREATE TABLE timezone (
  name TEXT NOT NULL,
  abbreviation TEXT NOT NULL,
  utf_offset INTERVAL NOT NULL,
  PRIMARY KEY( name )
);

