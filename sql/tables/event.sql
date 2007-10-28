
CREATE TABLE event (
  event_id SERIAL NOT NULL,
  conference_id INTEGER NOT NULL,
  tag TEXT,
  title TEXT NOT NULL,
  subtitle TEXT,
  conference_track_id INTEGER,
  team_id INTEGER,
  event_type TEXT,
  duration INTERVAL NOT NULL,
  event_origin TEXT NOT NULL,
  event_state TEXT NOT NULL DEFAULT 'undecided',
  event_state_progress TEXT NOT NULL DEFAULT 'new',
  language_id INTEGER,
  room_id INTEGER,
  day SMALLINT,
  start_time INTERVAL,
  abstract TEXT,
  description TEXT,
  resources TEXT,
  f_public BOOL NOT NULL DEFAULT FALSE,
  f_paper BOOL,
  f_slides BOOL,
  remark TEXT,
  submission_notes TEXT,
  last_modified TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  last_modified_by INTEGER,
  FOREIGN KEY (conference_id) REFERENCES conference (conference_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (conference_track_id) REFERENCES conference_track (conference_track_id) ON UPDATE CASCADE ON DELETE SET NULL,
  FOREIGN KEY (team_id) REFERENCES team(team_id) ON UPDATE CASCADE ON DELETE SET NULL,
  FOREIGN KEY (event_type) REFERENCES event_type(event_type) ON UPDATE CASCADE ON DELETE SET NULL,
  FOREIGN KEY (event_origin) REFERENCES event_origin (event_origin) ON UPDATE CASCADE ON DELETE RESTRICT,
  FOREIGN KEY (event_state,event_state_progress) REFERENCES event_state_progress (event_state,event_state_progress) ON UPDATE CASCADE ON DELETE RESTRICT,
  FOREIGN KEY (language_id) REFERENCES language (language_id) ON UPDATE CASCADE ON DELETE SET NULL,
  FOREIGN KEY (room_id) REFERENCES room (room_id) ON UPDATE CASCADE ON DELETE SET NULL,
  FOREIGN KEY (last_modified_by) REFERENCES person (person_id) ON UPDATE CASCADE ON DELETE SET NULL,
  PRIMARY KEY (event_id)
);

CREATE INDEX event_conference_id_index ON event(conference_id);
CREATE INDEX event_event_state_index ON event(event_state,event_state_progress);

