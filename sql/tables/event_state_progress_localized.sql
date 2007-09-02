
CREATE TABLE event_state_progress_localized (
  event_state_progress_id INTEGER NOT NULL,
  language_id INTEGER NOT NULL,
  name VARCHAR(64) NOT NULL,
  FOREIGN KEY (event_state_progress_id) REFERENCES event_state_progress (event_state_progress_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (language_id) REFERENCES language (language_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (event_state_progress_id, language_id)
) WITHOUT OIDS;

