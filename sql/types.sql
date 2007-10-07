
/*
 * These types are used for the conflict functions.
 *
*/

CREATE TYPE conflict_person AS (
  person_id   INTEGER
);

CREATE TYPE conflict_person_conflict AS (
  conflict_id INTEGER,
  person_id   INTEGER
);

CREATE TYPE conflict_event_person AS (
  event_id    INTEGER,
  person_id   INTEGER
);

CREATE TYPE conflict_event_person_conflict AS (
  conflict_id INTEGER,
  event_id    INTEGER,
  person_id   INTEGER
);

CREATE TYPE conflict_event_person_event AS (
  event_id1   INTEGER,
  event_id2   INTEGER,
  person_id   INTEGER
);

CREATE TYPE conflict_event_person_event_conflict AS (
  conflict_id INTEGER,
  event_id1   INTEGER,
  event_id2   INTEGER,
  person_id   INTEGER
);

CREATE TYPE conflict_event AS (
  event_id    INTEGER
);

CREATE TYPE conflict_event_conflict AS (
  conflict_id INTEGER,
  event_id    INTEGER
);

CREATE TYPE conflict_event_event AS (
  event_id1   INTEGER,
  event_id2   INTEGER
);

CREATE TYPE conflict_event_event_conflict AS (
  conflict_id INTEGER,
  event_id1   INTEGER,
  event_id2   INTEGER
);

CREATE TYPE view_conflict_event AS (
  conflict_id INTEGER,
  event_id INTEGER,
  conflict_level_id INTEGER,
  level_name TEXT,
  level_tag TEXT,
  language_id INTEGER,
  conflict_tag TEXT,
  conflict_name TEXT,
  title TEXT
);

CREATE TYPE view_conflict_event_event AS (
  conflict_id INTEGER,
  event_id1 INTEGER,
  event_id2 INTEGER,
  conflict_level_id INTEGER,
  level_name TEXT,
  level_tag TEXT,
  language_id INTEGER,
  conflict_tag TEXT,
  conflict_name TEXT,
  title1 TEXT,
  title2 TEXT
);

CREATE TYPE view_conflict_event_person AS (
  conflict_id INTEGER,
  event_id INTEGER,
  person_id INTEGER,
  conflict_level_id INTEGER,
  level_name TEXT,
  level_tag TEXT,
  language_id INTEGER,
  conflict_tag TEXT,
  conflict_name TEXT,
  title TEXT,
  name TEXT
);

CREATE TYPE view_conflict_event_person_event AS (
  conflict_id INTEGER,
  person_id INTEGER,
  event_id1 INTEGER,
  event_id2 INTEGER,
  conflict_level_id INTEGER,
  level_name TEXT,
  level_tag TEXT,
  language_id INTEGER,
  conflict_tag TEXT,
  conflict_name TEXT,
  name TEXT,
  title1 TEXT,
  title2 TEXT
);

CREATE TYPE view_conflict_person AS (
  conflict_id INTEGER,
  person_id INTEGER,
  conflict_level_id INTEGER,
  level_name TEXT,
  level_tag TEXT,
  language_id INTEGER,
  conflict_tag TEXT,
  conflict_name TEXT,
  name TEXT
);

