
CREATE TABLE event_role_state_localized (
  event_role_state_id INTEGER NOT NULL,
  language_id INTEGER NOT NULL,
  name VARCHAR(64) NOT NULL,
  FOREIGN KEY (event_role_state_id) REFERENCES event_role_state (event_role_state_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (language_id) REFERENCES language (language_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (event_role_state_id, language_id)
) WITHOUT OIDS;

