
CREATE TABLE person_logging (
  person_logging_id SERIAL NOT NULL,
  person_id INTEGER NOT NULL,
  login_name VARCHAR(32),
  password CHAR(48),
  title VARCHAR(32),
  gender BOOL,
  first_name VARCHAR(64),
  middle_name VARCHAR(64),
  last_name VARCHAR(64),
  public_name VARCHAR(64),
  nickname VARCHAR(64),
  address VARCHAR(256),
  street VARCHAR(64),
  street_postcode VARCHAR(10),
  po_box VARCHAR(10),
  po_box_postcode VARCHAR(10),
  city VARCHAR(64),
  country_id INTEGER,
  email_contact VARCHAR(64),
  iban VARCHAR(128),
  bic VARCHAR(32),
  bank_name VARCHAR(128),
  account_owner VARCHAR(128),
  gpg_key TEXT,
  preferences TEXT,
  f_conflict BOOL,
  f_deleted BOOL,
  f_spam BOOL,
  last_login TIMESTAMP WITH TIME ZONE,
  last_modified TIMESTAMP WITH TIME ZONE,
  last_modified_by INTEGER,
  PRIMARY KEY (person_logging_id)
) WITHOUT OIDS;

CREATE TABLE conference_person_logging (
  conference_person_logging_id SERIAL,
  conference_person_id INTEGER NOT NULL,
  conference_id INTEGER NOT NULL,
  person_id INTEGER NOT NULL,
  abstract TEXT,
  description TEXT,
  remark TEXT,
  email_public VARCHAR(64),
  f_reconfirmed BOOL,
  last_modified TIMESTAMP WITH TIME ZONE,
  last_modified_by INTEGER,
  PRIMARY KEY (conference_person_logging_id)
) WITHOUT OIDS;

CREATE TABLE event_logging (
  event_logging_id SERIAL NOT NULL,
  event_id INTEGER NOT NULL,
  conference_id INTEGER NOT NULL,
  tag TEXT,
  title TEXT NOT NULL,
  subtitle TEXT,
  conference_track_id INTEGER,
  team_id INTEGER,
  event_type_id INTEGER,
  duration INTERVAL NOT NULL,
  event_origin_id INTEGER NOT NULL,
  event_state_id INTEGER NOT NULL,
  event_state_progress_id INTEGER NOT NULL,
  language_id INTEGER,
  room_id INTEGER,
  day SMALLINT,
  start_time INTERVAL,
  abstract TEXT,
  description TEXT,
  resources TEXT,
  f_public BOOL,
  f_paper BOOL,
  f_slides BOOL,
  f_conflict BOOL,
  f_deleted BOOL,
  f_unmoderated BOOL,
  remark TEXT,
  submission_notes TEXT,
  actual_start TIMESTAMP WITH TIME ZONE,
  actual_end TIMESTAMP WITH TIME ZONE,
  last_modified TIMESTAMP WITH TIME ZONE,
  last_modified_by INTEGER,
  PRIMARY KEY (event_logging_id)
) WITHOUT OIDS;

CREATE TABLE person_image_logging (
  person_image_logging_id SERIAL NOT NULL,
  person_id INTEGER NOT NULL,
  mime_type_id INTEGER NOT NULL,
  f_public BOOL,
  image BYTEA NOT NULL,
  last_modified TIMESTAMP WITH TIME ZONE,
  last_modified_by INTEGER,
  PRIMARY KEY (person_image_logging_id)
) WITHOUT OIDS;

CREATE TABLE event_image_logging (
  event_image_logging_id SERIAL NOT NULL,
  event_id INTEGER NOT NULL,
  mime_type_id INTEGER NOT NULL,
  image BYTEA NOT NULL,
  last_modified TIMESTAMP WITH TIME ZONE,
  last_modified_by INTEGER,
  PRIMARY KEY (event_image_logging_id)
) WITHOUT OIDS;

CREATE TABLE conference_image_logging (
  conference_image_logging_id SERIAL NOT NULL,
  conference_id INTEGER NOT NULL,
  mime_type_id INTEGER NOT NULL,
  image BYTEA NOT NULL,
  last_modified TIMESTAMP WITH TIME ZONE,
  last_modified_by INTEGER,
  PRIMARY KEY (conference_image_logging_id)
) WITHOUT OIDS;

CREATE TABLE event_attachment_logging (
  event_attachment_logging_id SERIAL NOT NULL,
  event_attachment_id INTEGER NOT NULL,
  attachment_type_id INTEGER NOT NULL,
  event_id INTEGER NOT NULL,
  mime_type_id INTEGER NOT NULL,
  filename VARCHAR(256),
  title VARCHAR(256),
  pages INTEGER,
  data BYTEA NOT NULL,
  f_public BOOL,
  last_modified TIMESTAMP WITH TIME ZONE,
  last_modified_by INTEGER,
  PRIMARY KEY (event_attachment_logging_id)
) WITHOUT OIDS;

CREATE TABLE conference_logging (
  conference_logging_id SERIAL NOT NULL,
  conference_id INTEGER NOT NULL,
  acronym TEXT NOT NULL,
  title TEXT NOT NULL,
  subtitle TEXT,
  conference_phase_id INTEGER NOT NULL,
  start_date DATE NOT NULL,
  days SMALLINT,
  venue TEXT,
  city TEXT,
  country_id INTEGER,
  time_zone_id INTEGER,
  currency_id INTEGER,
  timeslot_duration INTERVAL NOT NULL,
  default_timeslots INTEGER,
  max_timeslot_duration INTEGER NOT NULL,
  day_change TIME WITHOUT TIME ZONE NOT NULL,
  remark TEXT,
  f_deleted BOOL,
  release VARCHAR(32),
  homepage TEXT,
  abstract_length INTEGER,
  description_length INTEGER,
  export_base_url VARCHAR(256),
  export_css_file VARCHAR(256),
  feedback_base_url VARCHAR(256),
  css TEXT,
  email TEXT,
  f_feedback_enabled BOOL,
  f_submission_enabled BOOL,
  f_visitor_enabled BOOL,
  f_reconfirmation_enabled BOOL,
  last_modified TIMESTAMP WITH TIME ZONE,
  last_modified_by INTEGER,
  PRIMARY KEY (conference_logging_id)
) WITHOUT OIDS;

CREATE TABLE event_person_logging (
  event_person_logging_id SERIAL NOT NULL,
  event_person_id INTEGER NOT NULL,
  event_id INTEGER NOT NULL,
  person_id INTEGER NOT NULL,
  event_role_id INTEGER NOT NULL,
  event_role_state_id INTEGER,
  remark TEXT,
  rank INTEGER,
  last_modified TIMESTAMP WITH TIME ZONE NOT NULL,
  last_modified_by INTEGER,
  PRIMARY KEY (event_person_logging_id)
) WITHOUT OIDS;

CREATE TABLE event_link_logging (
  event_link_logging_id SERIAL NOT NULL,
  event_link_id INTEGER NOT NULL,
  event_id INTEGER NOT NULL,
  url VARCHAR(1024) NOT NULL,
  title VARCHAR(256),
  rank INTEGER,
  last_modified TIMESTAMP WITH TIME ZONE NOT NULL,
  last_modified_by INTEGER,
  PRIMARY KEY (event_link_logging_id)
) WITHOUT OIDS;

