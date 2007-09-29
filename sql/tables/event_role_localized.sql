
CREATE TABLE event_role_localized (
  event_role_id INTEGER NOT NULL,
  language_id INTEGER NOT NULL,
  name VARCHAR(64),
  FOREIGN KEY (event_role_id) REFERENCES event_role (event_role_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (language_id) REFERENCES language (language_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (event_role_id, language_id)
);

