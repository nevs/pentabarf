
CREATE TABLE master.conference(
  conference_id INTEGER NOT NULL,
  conference_phase TEXT NOT NULL,
  acronym TEXT NOT NULL,
  title TEXT NOT NULL,
  subtitle TEXT,
  start_date DATE NOT NULL,
  days SMALLINT NOT NULL DEFAULT 1,
  venue TEXT,
  city TEXT,
  country TEXT,
  currency TEXT,
  timeslot_duration INTERVAL NOT NULL DEFAULT '0:30:00',
  default_timeslots INTEGER NOT NULL DEFAULT 1,
  max_timeslot_duration INTEGER NOT NULL DEFAULT 10,
  day_change TIME WITHOUT TIME ZONE NOT NULL DEFAULT '0:00:00',
  remark TEXT,
  release TEXT,
  homepage TEXT,
  abstract_length INTEGER DEFAULT 150,
  description_length INTEGER DEFAULT 150,
  export_base_url TEXT,
  export_css_file TEXT,
  feedback_base_url TEXT,
  css TEXT,
  feedback_enabled BOOL NOT NULL DEFAULT FALSE,
  submission_enabled BOOL NOT NULL DEFAULT FALSE,
  visitor_enabled BOOL NOT NULL DEFAULT FALSE
);

CREATE TABLE conference(
  PRIMARY KEY(conference_id),
  FOREIGN KEY(conference_phase) REFERENCES conference_phase(conference_phase) ON UPDATE CASCADE,
  FOREIGN KEY(country) REFERENCES country(country) ON UPDATE CASCADE,
  FOREIGN KEY(currency) REFERENCES currency(currency) ON UPDATE CASCADE
) INHERITS(master.conference);

CREATE SEQUENCE conference_id_sequence;
ALTER TABLE conference ALTER COLUMN conference_id SET DEFAULT nextval('conference_id_sequence');

CREATE TABLE logging.conference() INHERITS(master.conference);

