
CREATE TABLE master.language(
  language TEXT,
  localized BOOL,
  visible BOOL
) WITHOUT OIDS;

CREATE TABLE master.language_localized(
  language TEXT,
  translated TEXT,
  name     TEXT
) WITHOUT OIDS;

CREATE TABLE master.ui_message(
  ui_message TEXT
) WITHOUT OIDS;

CREATE TABLE master.ui_message_localized(
  ui_message TEXT,
  translated TEXT,
  name TEXT
) WITHOUT OIDS;

CREATE TABLE master.country(
  country TEXT,
  visible BOOL
) WITHOUT OIDS;

CREATE TABLE master.country_localized(
  country TEXT,
  translated TEXT,
  name TEXT
) WITHOUT OIDS;

CREATE TABLE master.currency(
  currency TEXT
) WITHOUT OIDS;

CREATE TABLE master.currency_localized(
  currency TEXT,
  translated TEXT,
  name TEXT
) WITHOUT OIDS;

CREATE TABLE master.transport(
  transport TEXT
) WITHOUT OIDS;

CREATE TABLE master.transport_localized(
  transport TEXT,
  translated TEXT,
  name TEXT
) WITHOUT OIDS;

CREATE TABLE master.im_type(
  im_type TEXT
) WITHOUT OIDS;

CREATE TABLE master.im_type_localized(
  im_type TEXT,
  translated TEXT,
  name TEXT
) WITHOUT OIDS;

CREATE TABLE master.link_type(
  link_type TEXT
) WITHOUT OIDS;

CREATE TABLE master.link_type_localized(
  link_type TEXT,
  translated TEXT,
  name TEXT
) WITHOUT OIDS;

CREATE TABLE master.person(
  person_id INTEGER,
  first_name TEXT,
  last_name TEXT
) WITHOUT OIDS;

CREATE TABLE conference_phase(
  conference_phase TEXT
) WITHOUT OIDS;

CREATE TABLE conference_phase_localized(
  conference_phase TEXT,
  translated TEXT,
  name TEXT
) WITHOUT OIDS;

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

CREATE TABLE master.conference_language(
  conference_id INTEGER,
  language TEXT
) WITHOUT OIDS;

CREATE TABLE master.phone_type(
  phone_type TEXT
) WITHOUT OIDS;

CREATE TABLE master.phone_type_localized(
  phone_type TEXT,
  translated TEXT,
  name TEXT
) WITHOUT OIDS;

CREATE TABLE master.mime_type(
  mime_type TEXT
) WITHOUT OIDS;

CREATE TABLE master.mime_type_localized(
  mime_type TEXT,
  translated TEXT,
  name TEXT
) WITHOUT OIDS;

CREATE TABLE master.conference_image(
  conference_id TEXT,
  mime_type TEXT,
  image BYTEA
) WITHOUT OIDS;

CREATE TABLE master.conference_track(
  conference_id INTEGER,
  conference_track TEXT,

) WITHOUT OIDS;

CREATE TABLE master.room(
  room TEXT,
  conference_id INTEGER,
  public BOOL
) WITHOUT OIDS;

CREATE TABLE master.event(
  event_id INTEGER,
  conference_id INTEGER,
  tag TEXT,
  title TEXT,
  subtitle TEXT
) WITHOUT OIDS;

