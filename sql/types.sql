
/*
 * These types are used for the conflict functions.
 *
*/


-- type for conflicts regarding one person
CREATE TYPE conflict_person AS (
  person_id INTEGER,
  name      TEXT
);


-- type for conflicting events
CREATE TYPE conflict_event_time AS (
  event_id1 INTEGER,
  title1    VARCHAR(128),
  subtitle1 VARCHAR(128),
  event_id2 INTEGER,
  title2    VARCHAR(128),
  subtitle2 VARCHAR(128)
);


-- type for persons with overlapping events 
CREATE TYPE conflict_person_time AS (
  person_id INTEGER,
  name      TEXT,
  event_id1 INTEGER,
  title1    VARCHAR(128),
  subtitle1 VARCHAR(128),
  event_id2 INTEGER,
  title2    VARCHAR(128),
  subtitle2 VARCHAR(128)
);


-- type for persons who do not speak the language of an event
CREATE TYPE conflict_person_event_language AS (
  person_id INTEGER,
  name      TEXT,
  event_id  INTEGER,
  title     VARCHAR(128),
  subtitle  VARCHAR(128)
);

CREATE TYPE event_localized AS (
  event_id INTEGER,
  conference_id INTEGER,
  tag VARCHAR(32),
  title VARCHAR(128),
  subtitle VARCHAR(128),
  conference_track_id INTEGER,
  conference_track VARCHAR(64),
  conference_track_tag VARCHAR(32),
  team_id INTEGER,
  team VARCHAR(64),
  team_tag VARCHAR(32),
  event_type_id INTEGER,
  event_type VARCHAR(64),
  event_type_tag VARCHAR(32),
  duration INTERVAL,
  event_state_id INTEGER,
  event_state VARCHAR(64),
  event_state_tag VARCHAR(32),
  language_id INTEGER,
  language VARCHAR(64),
  room_id INTEGER,
  room VARCHAR(64),
  room_tag VARCHAR(32),
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
  remark TEXT
);

