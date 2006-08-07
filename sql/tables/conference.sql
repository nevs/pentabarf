
CREATE TABLE master.conference(
  conference_id INTEGER,
  conference_phase TEXT,
  acronym TEXT,
  title TEXT,
  subtitle TEXT,
  start_date DATE,
  days SMALLINT,
  venue TEXT,
  city TEXT,
  country TEXT,
  currency TEXT,
  timeslot_duration INTERVAL,
  default_timeslots INTEGER,
  daychange TIME WITHOUT TIME ZONE,
  remark TEXT,
  release TEXT,
  homepage TEXT,
  abstract_length INTEGER,
  description_length INTEGER,
  export_base_url TEXT,
  export_css_file TEXT,
  feedback_base_url TEXT,
  css TEXT,
  feedback_enabled BOOL,
  submission_enabled BOOL,
  visitor_enabled BOOL
) WITHOUT OIDS;

CREATE TABLE conference() INHERITS(master.conference);
CREATE TABLE logging.conference() INHERITS(master.conference);


