
CREATE TABLE base.event_type_localized (
  event_type TEXT NOT NULL,
  translated TEXT NOT NULL,
  name TEXT NOT NULL
);

CREATE TABLE event_type_localized (
  FOREIGN KEY (event_type) REFERENCES event_type(event_type) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (translated) REFERENCES language (language) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (event_type, translated)
) INHERITS( base.event_type_localized );

CREATE TABLE log.event_type_localized (
) INHERITS( base.logging, base.event_type_localized );

