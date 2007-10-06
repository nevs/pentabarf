
CREATE TABLE event_role_state_localized (
  event_role TEXT NOT NULL,
  event_role_state TEXT NOT NULL,
  language_id INTEGER NOT NULL,
  name VARCHAR(64) NOT NULL,
  FOREIGN KEY (event_role,event_role_state) REFERENCES event_role_state (event_role,event_role_state) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (language_id) REFERENCES language (language_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (event_role, event_role_state, language_id)
);

