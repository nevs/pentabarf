
CREATE TABLE base.event (
  event_id SERIAL NOT NULL,
  conference_id INTEGER NOT NULL,
  tag TEXT,
  title TEXT NOT NULL,
  subtitle TEXT,
  conference_track TEXT,
  conference_team TEXT,
  event_type TEXT,
  duration INTERVAL NOT NULL DEFAULT '1:00:00',
  event_origin TEXT NOT NULL DEFAULT 'idea',
  event_state TEXT NOT NULL DEFAULT 'undecided',
  event_state_progress TEXT NOT NULL DEFAULT 'new',
  language TEXT,
  conference_room TEXT,
  day SMALLINT,
  start_time INTERVAL,
  abstract TEXT,
  description TEXT,
  resources TEXT,
  public BOOL NOT NULL DEFAULT FALSE,
  paper BOOL,
  slides BOOL,
  remark TEXT,
  submission_notes TEXT
);

CREATE TABLE event (
  FOREIGN KEY (conference_id) REFERENCES conference (conference_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (conference_track,conference_id) REFERENCES conference_track (conference_track,conference_id) ON UPDATE CASCADE ON DELETE RESTRICT,
  FOREIGN KEY (conference_team,conference_id) REFERENCES conference_team(conference_team,conference_id) ON UPDATE CASCADE ON DELETE RESTRICT,
  FOREIGN KEY (event_type) REFERENCES event_type(event_type) ON UPDATE CASCADE ON DELETE SET NULL,
  FOREIGN KEY (event_origin) REFERENCES event_origin (event_origin) ON UPDATE CASCADE ON DELETE RESTRICT,
  FOREIGN KEY (event_state,event_state_progress) REFERENCES event_state_progress (event_state,event_state_progress) ON UPDATE CASCADE ON DELETE RESTRICT,
  FOREIGN KEY (language) REFERENCES language (language) ON UPDATE CASCADE ON DELETE SET NULL,
  FOREIGN KEY (conference_room,conference_id) REFERENCES conference_room (conference_room,conference_id) ON UPDATE CASCADE ON DELETE RESTRICT,
  PRIMARY KEY (event_id)
) INHERITS( base.event );

CREATE TABLE log.event (
) INHERITS( base.logging, base.event );

