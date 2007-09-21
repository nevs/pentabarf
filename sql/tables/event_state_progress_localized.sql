
CREATE TABLE event_state_progress_localized (
  event_state TEXT NOT NULL,
  event_state_progress TEXT NOT NULL,
  language_id INTEGER NOT NULL,
  name TEXT NOT NULL,
  FOREIGN KEY (event_state,event_state_progress) REFERENCES event_state_progress (event_state,event_state_progress) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (language_id) REFERENCES language (language_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (event_state, event_state_progress, language_id)
);

