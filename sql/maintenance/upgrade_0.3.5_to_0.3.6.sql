
BEGIN;

ALTER TABLE conference RENAME TO old_conference;

CREATE TABLE base.conference (
  conference_id SERIAL NOT NULL,
  acronym TEXT NOT NULL UNIQUE,
  title TEXT NOT NULL,
  subtitle TEXT,
  conference_phase TEXT NOT NULL,
  start_date DATE NOT NULL,
  days SMALLINT NOT NULL DEFAULT 1,
  venue TEXT,
  city TEXT,
  country_id INTEGER,
  time_zone_id INTEGER,
  currency_id INTEGER,
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

CREATE TABLE public.conference (
  FOREIGN KEY (conference_phase) REFERENCES conference_phase (conference_phase) ON UPDATE CASCADE ON DELETE RESTRICT,
  FOREIGN KEY (country_id) REFERENCES country (country_id) ON UPDATE CASCADE ON DELETE SET NULL,
  FOREIGN KEY (time_zone_id) REFERENCES time_zone (time_zone_id) ON UPDATE CASCADE ON DELETE SET NULL,
  FOREIGN KEY (currency_id) REFERENCES currency (currency_id) ON UPDATE CASCADE ON DELETE SET NULL,
  PRIMARY KEY (conference_id)
) INHERITS( base.conference );

CREATE TABLE log.conference() INHERITS( base.logging, base.conference );

INSERT INTO public.conference( conference_id, acronym, title, subtitle, conference_phase, start_date, days, venue, city, country_id, time_zone_id, currency_id, timeslot_duration, default_timeslots, max_timeslot_duration, day_change, remark, release, homepage, abstract_length, description_length, export_base_url, export_css_file, feedback_base_url, css, email, f_feedback_enabled, f_submission_enabled, f_visitor_enabled, f_reconfirmation_enabled ) SELECT conference_id, acronym, title, subtitle, conference_phase, start_date, days, venue, city, country_id, time_zone_id, currency_id, timeslot_duration, default_timeslots, max_timeslot_duration, day_change, remark, release, homepage, abstract_length, description_length, export_base_url, export_css_file, feedback_base_url, css, email, f_feedback_enabled, f_submission_enabled, f_visitor_enabled, f_reconfirmation_enabled FROM public.old_conference;

COMMIT;

