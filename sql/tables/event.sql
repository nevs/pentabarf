
CREATE TABLE master.event(
  event_id INTEGER NOT NULL,
  conference_id INTEGER NOT NULL,
  tag TEXT,
  title TEXT NOT NULL,
  subtitle TEXT,
  conference_track TEXT,
  conference_team TEXT,
  event_type TEXT NOT NULL DEFAULT 'lecture',
  duration INTERVAL NOT NULL DEFAULT '01:00:00',
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

CREATE TABLE event(
  PRIMARY KEY(event_id),
  FOREIGN KEY(conference_id) REFERENCES conference(conference_id) ON UPDATE CASCADE,
  FOREIGN KEY(conference_id, conference_track) REFERENCES conference_track(conference_id, conference_track) ON UPDATE CASCADE,
  FOREIGN KEY(conference_id, conference_team) REFERENCES conference_team(conference_id, conference_team) ON UPDATE CASCADE,
  FOREIGN KEY(event_type) REFERENCES event_type(event_type) ON UPDATE CASCADE,
  FOREIGN KEY(event_origin) REFERENCES event_origin(event_origin) ON UPDATE CASCADE,
  FOREIGN KEY(event_state) REFERENCES event_state(event_state) ON UPDATE CASCADE,
  FOREIGN KEY(event_state, event_state_progress) REFERENCES event_state_progress(event_state, event_state_progress) ON UPDATE CASCADE,
  FOREIGN KEY(language) REFERENCES language(language) ON UPDATE CASCADE,
  FOREIGN KEY(conference_id, conference_room) REFERENCES conference_room(conference_id,conference_room) ON UPDATE CASCADE
) INHERITS(master.event);

CREATE SEQUENCE event_id_sequence;
ALTER TABLE event ALTER COLUMN event_id SET DEFAULT nextval('event_id_sequence');

CREATE INDEX event_conference_id ON public.event( conference_id );
CREATE INDEX event_event_state ON public.event( event_state );
CREATE INDEX event_event_state_progress ON public.event( event_state_progress );

CREATE TABLE logging.event() INHERITS(master.logging, master.event);


