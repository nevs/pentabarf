
CREATE TABLE base.conference (
  conference_id SERIAL NOT NULL,
  acronym TEXT NOT NULL UNIQUE,
  title TEXT NOT NULL,
  subtitle TEXT,
  conference_phase TEXT NOT NULL DEFAULT 'chaos',
  venue TEXT,
  city TEXT,
  country TEXT,
  timezone TEXT NOT NULL DEFAULT 'Europe/Berlin',
  currency TEXT,
  timeslot_duration INTERVAL NOT NULL DEFAULT '1:00:00',
  default_timeslots INTEGER NOT NULL DEFAULT 1,
  max_timeslot_duration INTEGER NOT NULL DEFAULT 10,
  day_change TIME WITHOUT TIME ZONE NOT NULL DEFAULT '0:00:00',
  remark TEXT,
  release TEXT,
  homepage TEXT,
  abstract_length INTEGER,
  description_length INTEGER,
  export_base_url TEXT,
  export_css_file TEXT,
  feedback_base_url TEXT,
  css TEXT,
  email TEXT,
  f_feedback_enabled BOOL NOT NULL DEFAULT FALSE,
  f_submission_enabled BOOL NOT NULL DEFAULT FALSE,
  f_visitor_enabled BOOL NOT NULL DEFAULT FALSE,
  f_reconfirmation_enabled BOOL NOT NULL DEFAULT FALSE
);

CREATE TABLE conference (
  FOREIGN KEY (conference_phase) REFERENCES conference_phase (conference_phase) ON UPDATE CASCADE ON DELETE RESTRICT,
  FOREIGN KEY (country) REFERENCES country (country) ON UPDATE CASCADE ON DELETE SET NULL,
  FOREIGN KEY (timezone) REFERENCES timezone (timezone) ON UPDATE CASCADE ON DELETE SET NULL,
  FOREIGN KEY (currency) REFERENCES currency (currency) ON UPDATE CASCADE ON DELETE SET NULL,
  PRIMARY KEY (conference_id)
) INHERITS( base.conference );

CREATE TABLE log.conference() INHERITS( base.logging, base.conference );

