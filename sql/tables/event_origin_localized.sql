
CREATE TABLE base.event_origin_localized (
  event_origin TEXT NOT NULL,
  translated TEXT NOT NULL,
  name TEXT NOT NULL
);

CREATE TABLE event_origin_localized (
  FOREIGN KEY (event_origin) REFERENCES event_origin (event_origin) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (translated) REFERENCES language (language) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (event_origin, translated)
) INHERITS( base.event_origin_localized );

CREATE TABLE log.event_origin_localized (
) INHERITS( base.logging, base.event_origin_localized );

