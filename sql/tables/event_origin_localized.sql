
CREATE TABLE event_origin_localized (
  event_origin TEXT NOT NULL,
  language_id INTEGER NOT NULL,
  name TEXT NOT NULL,
  FOREIGN KEY (event_origin) REFERENCES event_origin (event_origin) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (language_id) REFERENCES language (language_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (event_origin, language_id)
);

