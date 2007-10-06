
CREATE TABLE event_role_localized (
  event_role TEXT NOT NULL,
  language_id INTEGER NOT NULL,
  name VARCHAR(64),
  FOREIGN KEY (event_role) REFERENCES event_role (event_role) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (language_id) REFERENCES language (language_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (event_role, language_id)
);

