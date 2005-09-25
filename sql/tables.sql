
BEGIN;

CREATE TABLE language (
  language_id SERIAL NOT NULL,
  iso_639_code CHAR(3) NOT NULL UNIQUE,
  tag VARCHAR(32) NOT NULL UNIQUE,
  f_default BOOL NOT NULL DEFAULT FALSE,
  f_localized BOOL NOT NULL DEFAULT FALSE,
  f_visible BOOL NOT NULL DEFAULT FALSE,
  f_preferred BOOL NOT NULL DEFAULT FALSE,
  PRIMARY KEY (language_id)
) WITHOUT OIDS;

CREATE TABLE language_localized (
  translated_id INTEGER NOT NULL,
  language_id INTEGER NOT NULL,
  name VARCHAR(64) NOT NULL,
  FOREIGN KEY (translated_id) REFERENCES language (language_id),
  FOREIGN KEY (language_id) REFERENCES language (language_id),
  PRIMARY KEY (translated_id, language_id)
) WITHOUT OIDS;

CREATE TABLE country (
  country_id SERIAL NOT NULL,
  iso_3166_code CHAR(2) NOT NULL UNIQUE,
  phone_prefix VARCHAR(8),
  f_visible BOOL NOT NULL DEFAULT FALSE,
  f_preferred BOOL NOT NULL DEFAULT FALSE,
  PRIMARY KEY (country_id)
) WITHOUT OIDS;

CREATE TABLE country_localized (
  country_id INTEGER NOT NULL,
  language_id INTEGER NOT NULL,
  name VARCHAR(64) NOT NULL,
  FOREIGN KEY (country_id) REFERENCES country (country_id),
  FOREIGN KEY (language_id) REFERENCES language (language_id),
  PRIMARY KEY (country_id, language_id)
) WITHOUT OIDS;

CREATE TABLE currency (
  currency_id SERIAL NOT NULL,
  iso_4217_code CHAR(3) NOT NULL UNIQUE,
  f_default BOOL NOT NULL DEFAULT FALSE,
  f_visible BOOL NOT NULL DEFAULT FALSE,
  f_preferred BOOL NOT NULL DEFAULT FALSE,
  exchange_rate DECIMAL(15,5),
  PRIMARY KEY (currency_id)
) WITHOUT OIDS;

CREATE TABLE currency_localized (
  currency_id INTEGER NOT NULL,
  language_id INTEGER NOT NULL,
  name VARCHAR(64) NOT NULL,
  FOREIGN KEY (currency_id) REFERENCES currency (currency_id),
  FOREIGN KEY (language_id) REFERENCES language (language_id),
  PRIMARY KEY (currency_id, language_id)
) WITHOUT OIDS;

CREATE TABLE transport (
  transport_id SERIAL NOT NULL,
  tag VARCHAR(32) NOT NULL UNIQUE,
  rank INTEGER,
  PRIMARY KEY (transport_id)
) WITHOUT OIDS;

CREATE TABLE transport_localized (
  transport_id INTEGER NOT NULL,
  language_id INTEGER NOT NULL,
  name VARCHAR(64) NOT NULL,
  FOREIGN KEY (transport_id) REFERENCES transport (transport_id),
  FOREIGN KEY (language_id) REFERENCES language (language_id),
  PRIMARY KEY (transport_id, language_id)
) WITHOUT OIDS;

CREATE TABLE ui_message (
  ui_message_id SERIAL NOT NULL,
  tag VARCHAR(128) NOT NULL UNIQUE,
  PRIMARY KEY (ui_message_id)
) WITHOUT OIDS;

CREATE TABLE ui_message_localized (
  ui_message_id INTEGER NOT NULL,
  language_id INTEGER NOT NULL,
  name TEXT NOT NULL,
  FOREIGN KEY (ui_message_id) REFERENCES ui_message (ui_message_id),
  FOREIGN KEY (language_id) REFERENCES language (language_id),
  PRIMARY KEY (ui_message_id, language_id)
) WITHOUT OIDS;

CREATE TABLE role (
  role_id SERIAL NOT NULL,
  tag VARCHAR(32) NOT NULL UNIQUE,
  rank INTEGER,
  PRIMARY KEY (role_id)
) WITHOUT OIDS;

CREATE TABLE role_localized (
  role_id INTEGER NOT NULL,
  language_id INTEGER NOT NULL,
  name VARCHAR(64) NOT NULL,
  FOREIGN KEY (role_id) REFERENCES role (role_id),
  FOREIGN KEY (language_id) REFERENCES language (language_id),
  PRIMARY KEY (role_id, language_id)
) WITHOUT OIDS;

CREATE TABLE authorisation (
  authorisation_id SERIAL NOT NULL,
  tag VARCHAR(32) NOT NULL UNIQUE,
  rank INTEGER,
  PRIMARY KEY (authorisation_id)
) WITHOUT OIDS;

CREATE TABLE authorisation_localized (
  authorisation_id INTEGER NOT NULL,
  language_id INTEGER NOT NULL,
  name VARCHAR(64) NOT NULL,
  FOREIGN KEY (authorisation_id) REFERENCES authorisation (authorisation_id),
  FOREIGN KEY (language_id) REFERENCES language (language_id),
  PRIMARY KEY (authorisation_id, language_id)
) WITHOUT OIDS;

CREATE TABLE audience (
  audience_id SERIAL NOT NULL,
  tag VARCHAR(32) NOT NULL UNIQUE,
  rank INTEGER,
  PRIMARY KEY (audience_id)
) WITHOUT OIDS;

CREATE TABLE audience_localized (
  audience_id INTEGER NOT NULL,
  language_id INTEGER NOT NULL,
  name VARCHAR(64) NOT NULL,
  FOREIGN KEY (audience_id) REFERENCES audience (audience_id),
  FOREIGN KEY (language_id) REFERENCES language (language_id),
  PRIMARY KEY (audience_id, language_id)
) WITHOUT OIDS;

CREATE TABLE keyword (
  keyword_id SERIAL NOT NULL,
  tag VARCHAR(32) NOT NULL UNIQUE,
  PRIMARY KEY (keyword_id)
) WITHOUT OIDS;

CREATE TABLE keyword_localized (
  keyword_id INTEGER NOT NULL,
  language_id INTEGER NOT NULL,
  name VARCHAR(64) NOT NULL,
  FOREIGN KEY (keyword_id) REFERENCES keyword (keyword_id),
  FOREIGN KEY (language_id) REFERENCES language (language_id),
  PRIMARY KEY (keyword_id, language_id)
) WITHOUT OIDS;

CREATE TABLE phone_type (
  phone_type_id SERIAL NOT NULL,
  tag VARCHAR(32) NOT NULL UNIQUE,
  scheme VARCHAR(32),
  rank INTEGER,
  PRIMARY KEY (phone_type_id)
) WITHOUT OIDS;

CREATE TABLE phone_type_localized (
  phone_type_id INTEGER NOT NULL,
  language_id INTEGER NOT NULL,
  name VARCHAR(64) NOT NULL,
  FOREIGN KEY (phone_type_id) REFERENCES phone_type (phone_type_id),
  FOREIGN KEY (language_id) REFERENCES language (language_id),
  PRIMARY KEY (phone_type_id, language_id)
) WITHOUT OIDS;

CREATE TABLE mime_type (
  mime_type_id SERIAL NOT NULL,
  mime_type VARCHAR(128) NOT NULL UNIQUE,
  file_extension VARCHAR(16),
  f_image BOOL NOT NULL DEFAULT FALSE,
  PRIMARY KEY (mime_type_id)
) WITHOUT OIDS;

CREATE TABLE mime_type_localized (
  mime_type_id INTEGER NOT NULL,
  language_id INTEGER NOT NULL,
  name VARCHAR(128) NOT NULL,
  FOREIGN KEY (mime_type_id) REFERENCES mime_type (mime_type_id),
  FOREIGN KEY (language_id) REFERENCES language (language_id),
  PRIMARY KEY (mime_type_id, language_id)
) WITHOUT OIDS;

CREATE TABLE im_type (
  im_type_id SERIAL NOT NULL,
  tag VARCHAR(32) NOT NULL UNIQUE,
  scheme VARCHAR(32),
  rank INTEGER,
  PRIMARY KEY (im_type_id)
) WITHOUT OIDS;

CREATE TABLE im_type_localized (
  im_type_id INTEGER NOT NULL,
  language_id INTEGER NOT NULL,
  name VARCHAR(64) NOT NULL,
  FOREIGN KEY (im_type_id) REFERENCES im_type (im_type_id),
  FOREIGN KEY (language_id) REFERENCES language (language_id),
  PRIMARY KEY (im_type_id, language_id)
) WITHOUT OIDS;

CREATE TABLE time_zone (
  time_zone_id SERIAL NOT NULL,
  tag VARCHAR(32) NOT NULL UNIQUE,
  f_visible BOOL NOT NULL DEFAULT FALSE,
  f_preferred BOOL NOT NULL DEFAULT FALSE,
  PRIMARY KEY (time_zone_id)
) WITHOUT OIDS;

CREATE TABLE time_zone_localized (
  time_zone_id INTEGER NOT NULL,
  language_id INTEGER NOT NULL,
  name VARCHAR(64) NOT NULL,
  FOREIGN KEY (time_zone_id) REFERENCES time_zone (time_zone_id),
  FOREIGN KEY (language_id) REFERENCES language (language_id),
  PRIMARY KEY (time_zone_id, language_id)
) WITHOUT OIDS;

CREATE TABLE link_type (
  link_type_id SERIAL NOT NULL,
  tag VARCHAR(32) NOT NULL,
  url_prefix VARCHAR(1024),
  f_public BOOL NOT NULL DEFAULT FALSE,
  rank INTEGER,
  PRIMARY KEY (link_type_id)
) WITHOUT OIDS;

CREATE TABLE link_type_localized (
  link_type_id INTEGER NOT NULL,
  language_id INTEGER NOT NULL,
  name VARCHAR(64) NOT NULL,
  FOREIGN KEY (link_type_id) REFERENCES link_type (link_type_id),
  FOREIGN KEY (language_id) REFERENCES language (language_id),
  PRIMARY KEY (link_type_id, language_id)
) WITHOUT OIDS;

CREATE TABLE role_authorisation (
  role_id INTEGER NOT NULL,
  authorisation_id INTEGER NOT NULL,
  FOREIGN KEY (role_id) REFERENCES role (role_id),
  FOREIGN KEY (authorisation_id) REFERENCES authorisation (authorisation_id),
  PRIMARY KEY (role_id, authorisation_id)
) WITHOUT OIDS;
  

CREATE TABLE conference (
  conference_id SERIAL NOT NULL,
  acronym VARCHAR(16) NOT NULL UNIQUE,
  title VARCHAR(128) NOT NULL,
  subtitle VARCHAR(128),
  start_date DATE NOT NULL,
  days SMALLINT NOT NULL DEFAULT 1,
  venue VARCHAR(64),
  city VARCHAR(64),
  country_id INTEGER,
  time_zone_id INTEGER,
  currency_id INTEGER,
  timeslot_duration INTERVAL,
  max_timeslot_duration INTEGER NOT NULL,
  day_change TIME WITHOUT TIME ZONE NOT NULL DEFAULT '0:00:00',
  remark TEXT,
  f_deleted BOOL NOT NULL DEFAULT FALSE,
  release VARCHAR(32),
  export_base_url VARCHAR(256),
  export_css_file VARCHAR(256),
  feedback_base_url VARCHAR(256),
  css TEXT,
  FOREIGN KEY (country_id) REFERENCES country (country_id),
  FOREIGN KEY (time_zone_id) REFERENCES time_zone (time_zone_id),
  FOREIGN KEY (currency_id) REFERENCES currency (currency_id),
  PRIMARY KEY (conference_id)
) WITHOUT OIDS;

CREATE TABLE conference_language (
  conference_language_id SERIAL NOT NULL,
  conference_id INTEGER NOT NULL,
  language_id INTEGER NOT NULL,
  rank INTEGER,
  FOREIGN KEY (conference_id) REFERENCES conference (conference_id),
  FOREIGN KEY (language_id) REFERENCES language (language_id),
  PRIMARY KEY (conference_language_id)
) WITHOUT OIDS;

CREATE TABLE conference_person (
  conference_person_id SERIAL NOT NULL,
  conference_id INTEGER NOT NULL,
  person_id INTEGER NOT NULL,
  abstract TEXT,
  description TEXT,
  remark TEXT,
  email_public VARCHAR(64),
  FOREIGN KEY (conference_id) REFERENCES conference (conference_id),
  FOREIGN KEY (person_id) REFERENCES person (person_id),
  PRIMARY KEY (conference_person_id)
) WITHOUT OIDS;

CREATE TABLE conference_link (
  conference_link_id SERIAL NOT NULL,
  conference_id INTEGER NOT NULL,
  url VARCHAR(1024) NOT NULL,
  title VARCHAR(128),
  description VARCHAR(128),
  rank INTEGER,
  FOREIGN KEY (conference_id) REFERENCES conference (conference_id),
  PRIMARY KEY (conference_link_id)
) WITHOUT OIDS;

CREATE TABLE conference_localized (
  conference_id INTEGER NOT NULL,
  language_id INTEGER NOT NULL,
  description TEXT NOT NULL,
  FOREIGN KEY (conference_id) REFERENCES conference (conference_id),
  FOREIGN KEY (language_id) REFERENCES language (language_id),
  PRIMARY KEY (conference_id, language_id)
) WITHOUT OIDS;

CREATE TABLE conference_image (
  conference_id INTEGER NOT NULL,
  mime_type_id INTEGER NOT NULL,
  image BYTEA NOT NULL,
  last_changed TIMESTAMP NOT NULL DEFAULT 'now()',
  FOREIGN KEY (conference_id) REFERENCES conference (conference_id),
  FOREIGN KEY (mime_type_id) REFERENCES mime_type (mime_type_id),
  PRIMARY KEY (conference_id)
) WITHOUT OIDS;

CREATE TABLE conference_track (
  conference_track_id SERIAL NOT NULL,
  conference_id INTEGER NOT NULL,
  tag VARCHAR(32) NOT NULL,
  rank INTEGER,
  FOREIGN KEY (conference_id) REFERENCES conference (conference_id),
  PRIMARY KEY (conference_track_id)
) WITHOUT OIDS;

CREATE TABLE conference_track_localized (
  conference_track_id INTEGER NOT NULL,
  language_id INTEGER NOT NULL,
  name VARCHAR(64) NOT NULL,
  FOREIGN KEY (conference_track_id) REFERENCES conference_track (conference_track_id),
  FOREIGN KEY (language_id) REFERENCES language (language_id),
  PRIMARY KEY (conference_track_id, language_id)
) WITHOUT OIDS;

CREATE TABLE conference_release (
  release_id SERIAL NOT NULL,
  conference_id INTEGER NOT NULL,
  release_tag VARCHAR(32) NOT NULL,
  description VARCHAR(128),
  release_date TIMESTAMP(0) WITH TIME ZONE NOT NULL DEFAULT now(),
  FOREIGN KEY (conference_id) REFERENCES conference (conference_id),
  PRIMARY KEY (release_id)
) WITHOUT OIDS;

CREATE TABLE room (
  room_id SERIAL NOT NULL,
  conference_id INTEGER NOT NULL,
  short_name VARCHAR(32) NOT NULL,
  f_public BOOL NOT NULL DEFAULT FALSE,
  size INTEGER,
  remark TEXT,
  rank INTEGER,
  FOREIGN KEY (conference_id) REFERENCES conference (conference_id),
  PRIMARY KEY (room_id)
) WITHOUT OIDS;

CREATE TABLE room_localized (
  room_id INTEGER NOT NULL,
  language_id INTEGER NOT NULL,
  public_name VARCHAR(64) NOT NULL,
  description TEXT,
  FOREIGN KEY (room_id) REFERENCES room (room_id),
  FOREIGN KEY (language_id) REFERENCES language (language_id),
  PRIMARY KEY (room_id, language_id)
) WITHOUT OIDS;

CREATE TABLE room_availability (
  room_id INTEGER NOT NULL,
  start_time INTERVAL NOT NULL,
  duration INTERVAL NOT NULL,
  FOREIGN KEY (room_id) REFERENCES room (room_id),
  PRIMARY KEY (room_id, start_time)
) WITHOUT OIDS;

CREATE TABLE room_image (
  room_id INTEGER NOT NULL,
  mime_type_id INTEGER NOT NULL,
  image BYTEA NOT NULL,
  FOREIGN KEY (room_id) REFERENCES room (room_id),
  FOREIGN KEY (mime_type_id) REFERENCES mime_type (mime_type_id),
  PRIMARY KEY (room_id)
) WITHOUT OIDS;

CREATE TABLE person (
  person_id SERIAL NOT NULL,
  login_name VARCHAR(32) UNIQUE,
  password CHAR(48),
  title VARCHAR(32),
  gender BOOL,
  first_name VARCHAR(64),
  middle_name VARCHAR(64),
  last_name VARCHAR(64),
  public_name VARCHAR(64),
  nickname VARCHAR(64),
  address VARCHAR(64),
  street VARCHAR(64),
  street_postcode VARCHAR(10),
  po_box VARCHAR(10),
  po_box_postcode VARCHAR(10),
  city VARCHAR(64),
  country_id INTEGER,
  email_contact VARCHAR(64),
  iban VARCHAR(128),
  bic VARCHAR(11),
  bank_name VARCHAR(128),
  account_owner VARCHAR(128),
  gpg_key TEXT,
  preferences TEXT,
  f_conflict BOOL NOT NULL DEFAULT FALSE,
  f_deleted BOOL NOT NULL DEFAULT FALSE,
  f_spam BOOL NOT NULL DEFAULT FALSE,
  last_login TIMESTAMP WITH TIME ZONE,
  FOREIGN KEY (country_id) REFERENCES country (country_id),
  PRIMARY KEY (person_id)
) WITHOUT OIDS;

CREATE TABLE person_link (
  person_link_id SERIAL NOT NULL,
  person_id INTEGER NOT NULL,
  url VARCHAR(1024) NOT NULL,
  title VARCHAR(128),
  description VARCHAR(128),
  rank INTEGER,
  FOREIGN KEY (person_id) REFERENCES person (person_id),
  FOREIGN KEY (link_type_id) REFERENCES link_type (link_type_id),
  PRIMARY KEY (person_link_id)
) WITHOUT OIDS;

CREATE TABLE person_link_internal (
  person_link_internal_id SERIAL NOT NULL,
  person_id INTEGER NOT NULL,
  link_type_id INTEGER NOT NULL,
  url TEXT NOT NULL,
  title VARCHAR(128),
  description VARCHAR(128),
  rank INTEGER,
  FOREIGN KEY (person_id) REFERENCES person (person_id),
  FOREIGN KEY (link_type_id) REFERENCES link_type (link_type_id),
  PRIMARY KEY (person_link_internal_id)
) WITHOUT OIDS;

CREATE TABLE person_phone (
  person_phone_id SERIAL NOT NULL,
  person_id INTEGER NOT NULL,
  phone_type_id INTEGER NOT NULL,
  phone_number VARCHAR(32) NOT NULL,
  rank INTEGER,
  FOREIGN KEY (person_id) REFERENCES person (person_id),
  FOREIGN KEY (phone_type_id) REFERENCES phone_type (phone_type_id),
  PRIMARY KEY (person_phone_id)
) WITHOUT OIDS;

CREATE TABLE person_rating (
  person_id INTEGER NOT NULL,
  evaluator_id INTEGER NOT NULL,
  speaker_quality SMALLINT,
  competence SMALLINT,
  remark TEXT,
  eval_time TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  FOREIGN KEY (person_id) REFERENCES person (person_id),
  FOREIGN KEY (evaluator_id) REFERENCES person (person_id),
  PRIMARY KEY (person_id, evaluator_id)
) WITHOUT OIDS;

CREATE TABLE person_watchlist_person (
  person_id INTEGER NOT NULL,
  watched_person_id INTEGER NOT NULL,
  FOREIGN KEY (person_id) REFERENCES person (person_id),
  FOREIGN KEY (watched_person_id) REFERENCES person (person_id),
  PRIMARY KEY (person_id, watched_person_id)
) WITHOUT OIDS;

CREATE TABLE person_watchlist_conference (
  person_id INTEGER NOT NULL,
  conference_id INTEGER NOT NULL,
  FOREIGN KEY (person_id) REFERENCES person (person_id),
  FOREIGN KEY (conference_id) REFERENCES conference (conference_id),
  PRIMARY KEY (person_id, conference_id)
) WITHOUT OIDS;

CREATE TABLE person_travel (
  person_id INTEGER NOT NULL,
  conference_id INTEGER NOT NULL,
  arrival_transport_id INTEGER,
  arrival_from VARCHAR(64),
  arrival_to VARCHAR(64),
  arrival_number VARCHAR(32),
  arrival_date DATE,
  arrival_time TIME(0) WITH TIME ZONE,
  f_arrival_pickup BOOL NOT NULL DEFAULT FALSE,
  f_departure_pickup BOOL NOT NULL DEFAULT FALSE,
  departure_transport_id INTEGER,
  departure_from VARCHAR(64),
  departure_to VARCHAR(64),
  departure_number VARCHAR(32),
  departure_date DATE,
  departure_time TIME(0) WITH TIME ZONE,
  travel_cost DECIMAL(16,2),
  travel_currency_id INTEGER NOT NULL,
  accommodation_cost DECIMAL(16,2),
  accommodation_currency_id INTEGER NOT NULL,
  accommodation_name VARCHAR(64),
  accommodation_street VARCHAR(64),
  accommodation_postcode VARCHAR(10),
  accommodation_city VARCHAR(64),
  accommodation_phone VARCHAR(32),
  accommodation_phone_room VARCHAR(32),
  f_arrived BOOL NOT NULL DEFAULT FALSE,
  fee DECIMAL(16,2),
  fee_currency_id INTEGER NOT NULL,
  FOREIGN KEY (person_id) REFERENCES person (person_id),
  FOREIGN KEY (conference_id) REFERENCES conference (conference_id),
  FOREIGN KEY (arrival_transport_id) REFERENCES transport (transport_id),
  FOREIGN KEY (departure_transport_id) REFERENCES transport (transport_id),
  FOREIGN KEY (travel_currency_id) REFERENCES currency (currency_id),
  FOREIGN KEY (accommodation_currency_id) REFERENCES currency (currency_id),
  FOREIGN KEY (fee_currency_id) REFERENCES currency (currency_id),
  PRIMARY KEY (person_id, conference_id)
) WITHOUT OIDS;

CREATE TABLE person_im (
  person_im_id SERIAL NOT NULL,
  person_id INTEGER NOT NULL,
  im_type_id INTEGER NOT NULL,
  im_address VARCHAR(128) NOT NULL,
  rank INTEGER,
  FOREIGN KEY (person_id) REFERENCES person (person_id),
  FOREIGN KEY (im_type_id) REFERENCES im_type (im_type_id),
  PRIMARY KEY (person_im_id)
) WITHOUT OIDS;

CREATE TABLE person_role (
  person_id INTEGER NOT NULL,
  role_id INTEGER NOT NULL,
  FOREIGN KEY (person_id) REFERENCES person (person_id),
  FOREIGN KEY (role_id) REFERENCES role (role_id),
  PRIMARY KEY (person_id, role_id)
) WITHOUT OIDS;

CREATE TABLE person_availability (
  person_id INTEGER NOT NULL,
  conference_id INTEGER NOT NULL,
  start_time INTERVAL NOT NULL,
  duration INTERVAL NOT NULL,
  FOREIGN KEY (person_id) REFERENCES person (person_id),
  FOREIGN KEY (conference_id) REFERENCES conference (conference_id),
  PRIMARY KEY (person_id, conference_id, start_time)
) WITHOUT OIDS;

CREATE TABLE person_image (
  person_id INTEGER NOT NULL,
  mime_type_id INTEGER NOT NULL,
  f_public BOOL NOT NULL DEFAULT FALSE,
  image BYTEA NOT NULL,
  last_changed TIMESTAMP NOT NULL DEFAULT 'now()',
  FOREIGN KEY (person_id) REFERENCES person (person_id),
  FOREIGN KEY (mime_type_id) REFERENCES mime_type (mime_type_id),
  PRIMARY KEY (person_id)
) WITHOUT OIDS;

CREATE TABLE person_language (
  person_id INTEGER NOT NULL,
  language_id INTEGER NOT NULL,
  rank INTEGER,
  FOREIGN KEY (person_id) REFERENCES person (person_id),
  FOREIGN KEY (language_id) REFERENCES language (language_id),
  PRIMARY KEY (person_id, language_id)
) WITHOUT OIDS;

CREATE TABLE event_state (
  event_state_id SERIAL NOT NULL,
  tag VARCHAR(32) NOT NULL UNIQUE,
  rank INTEGER,
  PRIMARY KEY (event_state_id)
) WITHOUT OIDS;

CREATE TABLE event_state_localized (
  event_state_id INTEGER NOT NULL,
  language_id INTEGER NOT NULL,
  name VARCHAR(64) NOT NULL,
  FOREIGN KEY (event_state_id) REFERENCES event_state (event_state_id),
  FOREIGN KEY (language_id) REFERENCES language (language_id),
  PRIMARY KEY (event_state_id, language_id)
) WITHOUT OIDS;

CREATE TABLE event_state_progress (
  event_state_progress_id SERIAL NOT NULL,
  event_state_id INTEGER NOT NULL,
  tag VARCHAR(32) NOT NULL,
  rank INTEGER,
  FOREIGN KEY (event_state_id) REFERENCES event_state (event_state_id),
  PRIMARY KEY (event_state_progress_id)
) WITHOUT OIDS;

CREATE TABLE event_state_progress_localized (
  event_state_progress_id INTEGER NOT NULL,
  language_id INTEGER NOT NULL,
  name VARCHAR(64) NOT NULL,
  FOREIGN KEY (event_state_progress_id) REFERENCES event_state_progress (event_state_progress_id),
  FOREIGN KEY (language_id) REFERENCES language (language_id),
  PRIMARY KEY (event_state_progress_id, language_id)
) WITHOUT OIDS;

CREATE TABLE event_type (
  event_type_id SERIAL NOT NULL,
  tag VARCHAR(32) NOT NULL UNIQUE,
  rank INTEGER,
  PRIMARY KEY (event_type_id)
) WITHOUT OIDS;

CREATE TABLE event_type_localized (
  event_type_id INTEGER NOT NULL,
  language_id INTEGER NOT NULL,
  name VARCHAR(64) NOT NULL,
  FOREIGN KEY (event_type_id) REFERENCES event_type (event_type_id),
  FOREIGN KEY (language_id) REFERENCES language (language_id),
  PRIMARY KEY (event_type_id, language_id)
) WITHOUT OIDS;

CREATE TABLE event_origin (
  event_origin_id SERIAL NOT NULL,
  tag VARCHAR(32) NOT NULL UNIQUE,
  rank INTEGER,
  PRIMARY KEY (event_origin_id)
) WITHOUT OIDS;

CREATE TABLE event_origin_localized (
  event_origin_id INTEGER NOT NULL,
  language_id INTEGER NOT NULL,
  name VARCHAR(64) NOT NULL,
  FOREIGN KEY (event_origin_id) REFERENCES event_origin (event_origin_id),
  FOREIGN KEY (language_id) REFERENCES language (language_id),
  PRIMARY KEY (event_origin_id, language_id)
) WITHOUT OIDS;

CREATE TABLE team (
  team_id SERIAL NOT NULL,
  tag VARCHAR(32) NOT NULL,
  conference_id INTEGER NOT NULL,
  rank INTEGER,
  FOREIGN KEY (conference_id) REFERENCES conference(conference_id),
  PRIMARY KEY (team_id)
) WITHOUT OIDS;

CREATE TABLE team_localized (
  team_id INTEGER NOT NULL,
  language_id INTEGER NOT NULL,
  name VARCHAR(64) NOT NULL,
  FOREIGN KEY (team_id) REFERENCES team (team_id),
  FOREIGN KEY (language_id) REFERENCES language (language_id),
  PRIMARY KEY (team_id, language_id)
) WITHOUT OIDS;

CREATE TABLE event (
  event_id SERIAL NOT NULL,
  conference_id INTEGER NOT NULL,
  tag VARCHAR(32),
  title VARCHAR(128) NOT NULL,
  subtitle VARCHAR(128),
  conference_track_id INTEGER,
  team_id INTEGER,
  event_type_id INTEGER,
  duration INTERVAL,
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
  f_public BOOL NOT NULL DEFAULT FALSE,
  f_paper BOOL NOT NULL DEFAULT TRUE,
  f_slides BOOL NOT NULL DEFAULT TRUE,
  f_conflict BOOL NOT NULL DEFAULT FALSE,
  f_deleted BOOL NOT NULL DEFAULT FALSE,
  f_unmoderated BOOL NOT NULL DEFAULT FALSE,
  remark TEXT,
  FOREIGN KEY (conference_id) REFERENCES conference (conference_id),
  FOREIGN KEY (conference_track_id) REFERENCES conference_track (conference_track_id),
  FOREIGN KEY (team_id) REFERENCES team(team_id),
  FOREIGN KEY (event_type_id) REFERENCES event_type (event_type_id),
  FOREIGN KEY (event_origin_id) REFERENCES event_origin (event_origin_id),
  FOREIGN KEY (event_state_id) REFERENCES event_state (event_state_id),
  FOREIGN KEY (event_state_progress_id) REFERENCES event_state_progress (event_state_progress_id),
  FOREIGN KEY (language_id) REFERENCES language (language_id),
  FOREIGN KEY (room_id) REFERENCES room (room_id),
  PRIMARY KEY (event_id)
) WITHOUT OIDS;

CREATE TABLE person_watchlist_event (
  person_id INTEGER NOT NULL,
  event_id INTEGER NOT NULL,
  FOREIGN KEY (person_id) REFERENCES person (person_id),
  FOREIGN KEY (event_id) REFERENCES event (event_id),
  PRIMARY KEY (person_id, event_id)
) WITHOUT OIDS;

CREATE TABLE event_audience (
  event_id INTEGER NOT NULL,
  audience_id INTEGER NOT NULL,
  FOREIGN KEY (event_id) REFERENCES event (event_id),
  FOREIGN KEY (audience_id) REFERENCES audience (audience_id),
  PRIMARY KEY (event_id, audience_id)
) WITHOUT OIDS;

CREATE TABLE event_keyword (
  event_id INTEGER NOT NULL,
  keyword_id INTEGER NOT NULL,
  FOREIGN KEY (event_id) REFERENCES event (event_id),
  FOREIGN KEY (keyword_id) REFERENCES keyword (keyword_id),
  PRIMARY KEY (event_id, keyword_id)
) WITHOUT OIDS;

CREATE TABLE person_keyword (
  person_id INTEGER NOT NULL,
  keyword_id INTEGER NOT NULL,
  FOREIGN KEY (person_id) REFERENCES person (person_id),
  FOREIGN KEY (keyword_id) REFERENCES keyword (keyword_id),
  PRIMARY KEY (person_id, keyword_id)
) WITHOUT OIDS;

CREATE TABLE event_image (
  event_id INTEGER NOT NULL,
  mime_type_id INTEGER NOT NULL,
  image BYTEA NOT NULL,
  last_changed TIMESTAMP NOT NULL DEFAULT 'now()',
  FOREIGN KEY (event_id) REFERENCES event (event_id),
  FOREIGN KEY (mime_type_id) REFERENCES mime_type (mime_type_id),
  PRIMARY KEY (event_id)
) WITHOUT OIDS;

CREATE TABLE event_rating_public (
  event_id INTEGER NOT NULL,
  participant_knowledge SMALLINT,
  topic_importance SMALLINT,
  content_quality SMALLINT,
  presentation_quality SMALLINT,
  audience_involvement SMALLINT,
  remark TEXT,
  eval_time TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  rater_ip INET,
  FOREIGN KEY (event_id) REFERENCES event (event_id),
  PRIMARY KEY (event_id, eval_time)
) WITHOUT OIDS;

CREATE TABLE event_rating (
  person_id INTEGER NOT NULL,
  event_id INTEGER NOT NULL,
  relevance SMALLINT,
  actuality SMALLINT,
  acceptance SMALLINT,
  remark TEXT,
  eval_time TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  FOREIGN KEY (person_id) REFERENCES person (person_id),
  FOREIGN KEY (event_id) REFERENCES event (event_id),
  PRIMARY KEY (person_id, event_id)
) WITHOUT OIDS;

CREATE TABLE event_link (
  event_link_id SERIAL NOT NULL,
  event_id INTEGER NOT NULL,
  url VARCHAR(1024) NOT NULL,
  title VARCHAR(128),
  description VARCHAR(128),
  rank INTEGER,
  FOREIGN KEY (event_id) REFERENCES event (event_id),
  PRIMARY KEY (event_link_id)
) WITHOUT OIDS;

CREATE TABLE event_link_internal (
  event_link_internal_id SERIAL NOT NULL,
  event_id INTEGER NOT NULL,
  link_type_id INTEGER NOT NULL,
  url VARCHAR(1024) NOT NULL,
  title VARCHAR(128),
  description VARCHAR(128),
  rank INTEGER,
  FOREIGN KEY (event_id) REFERENCES event (event_id),
  FOREIGN KEY (link_type_id) REFERENCES link_type (link_type_id),
  PRIMARY KEY (event_link_internal_id)
) WITHOUT OIDS;

CREATE TABLE event_role (
  event_role_id SERIAL NOT NULL,
  tag VARCHAR(32),
  rank INTEGER,
  PRIMARY KEY (event_role_id)
) WITHOUT OIDS;

CREATE TABLE event_role_localized (
  event_role_id INTEGER NOT NULL,
  language_id INTEGER NOT NULL,
  name VARCHAR(64),
  FOREIGN KEY (event_role_id) REFERENCES event_role (event_role_id),
  FOREIGN KEY (language_id) REFERENCES language (language_id),
  PRIMARY KEY (event_role_id, language_id)
) WITHOUT OIDS;
  
CREATE TABLE event_role_state (
  event_role_state_id SERIAL NOT NULL,
  event_role_id INTEGER NOT NULL,
  tag VARCHAR(32) NOT NULL,
  rank INTEGER,
  FOREIGN KEY (event_role_id) REFERENCES event_role (event_role_id),
  PRIMARY KEY (event_role_state_id)
) WITHOUT OIDS;

CREATE TABLE event_role_state_localized (
  event_role_state_id INTEGER NOT NULL,
  language_id INTEGER NOT NULL,
  name VARCHAR(64) NOT NULL,
  FOREIGN KEY (event_role_state_id) REFERENCES event_role_state (event_role_state_id),
  FOREIGN KEY (language_id) REFERENCES language (language_id),
  PRIMARY KEY (event_role_state_id, language_id)
) WITHOUT OIDS;

CREATE TABLE event_person (
  event_person_id SERIAL NOT NULL,
  event_id INTEGER NOT NULL,
  person_id INTEGER NOT NULL,
  event_role_id INTEGER NOT NULL,
  event_role_state_id INTEGER,
  remark TEXT,
  rank INTEGER,
  FOREIGN KEY (event_id) REFERENCES event (event_id),
  FOREIGN KEY (person_id) REFERENCES person (person_id),
  FOREIGN KEY (event_role_id) REFERENCES event_role (event_role_id),
  FOREIGN KEY (event_role_state_id) REFERENCES event_role_state (event_role_state_id),
  PRIMARY KEY (event_person_id)
) WITHOUT OIDS;

CREATE TABLE conference_transaction (
  conference_id INTEGER NOT NULL,
  changed_when TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  changed_by INTEGER NOT NULL,
  f_create BOOL NOT NULL DEFAULT FALSE,
  FOREIGN KEY (conference_id) REFERENCES conference (conference_id),
  FOREIGN KEY (changed_by) REFERENCES person (person_id),
  PRIMARY KEY (conference_id, changed_when)
) WITHOUT OIDS;

CREATE TABLE event_transaction (
  event_id INTEGER NOT NULL,
  changed_when TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  changed_by INTEGER NOT NULL,
  f_create BOOL NOT NULL DEFAULT FALSE,
  FOREIGN KEY (event_id) REFERENCES event (event_id),
  FOREIGN KEY (changed_by) REFERENCES person (person_id),
  PRIMARY KEY (event_id, changed_when)
) WITHOUT OIDS;

CREATE TABLE person_transaction (
  person_id INTEGER NOT NULL,
  changed_when TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  changed_by INTEGER NOT NULL,
  f_create BOOL NOT NULL DEFAULT FALSE,
  FOREIGN KEY (person_id) REFERENCES person (person_id),
  FOREIGN KEY (changed_by) REFERENCES person (person_id),
  PRIMARY KEY (person_id, changed_when)
) WITHOUT OIDS;

CREATE TABLE attachment_type (
  attachment_type_id SERIAL NOT NULL,
  tag VARCHAR(32) NOT NULL,
  rank INTEGER,
  PRIMARY KEY (attachment_type_id)
) WITHOUT OIDS;

CREATE TABLE attachment_type_localized (
  attachment_type_id INTEGER NOT NULL,
  language_id INTEGER NOT NULL,
  name VARCHAR(64) NOT NULL,
  FOREIGN KEY (attachment_type_id) REFERENCES attachment_type (attachment_type_id),
  FOREIGN KEY (language_id) REFERENCES language (language_id),
  PRIMARY KEY (attachment_type_id, language_id)
) WITHOUT OIDS;

CREATE TABLE event_attachment (
  event_attachment_id SERIAL NOT NULL,
  attachment_type_id INTEGER NOT NULL,
  event_id INTEGER NOT NULL,
  mime_type_id INTEGER NOT NULL,
  filename VARCHAR(256),
  title VARCHAR(64),
  data BYTEA NOT NULL,
  f_public BOOL NOT NULL DEFAULT FALSE,
  last_changed TIMESTAMP NOT NULL DEFAULT 'now()',
  FOREIGN KEY (attachment_type_id) REFERENCES attachment_type (attachment_type_id),
  FOREIGN KEY (event_id) REFERENCES event (event_id),
  FOREIGN KEY (mime_type_id) REFERENCES mime_type (mime_type_id),
  PRIMARY KEY (event_attachment_id)
) WITHOUT OIDS;

CREATE TABLE event_related (
  event_id1 INTEGER NOT NULL,
  event_id2 INTEGER NOT NULL,
  FOREIGN KEY (event_id1) REFERENCES event (event_id),
  FOREIGN KEY (event_id2) REFERENCES event (event_id),
  PRIMARY KEY (event_id1, event_id2)
) WITHOUT OIDS;

COMMIT;

