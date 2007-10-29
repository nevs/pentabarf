
/*
 * These types are used for the conflict functions.
 *
*/

CREATE TYPE conflict.conflict_person AS (
  person_id   INTEGER
);

CREATE TYPE conflict.conflict_person_conflict AS (
  conflict    TEXT,
  person_id   INTEGER
);

CREATE TYPE conflict.conflict_event_person AS (
  event_id    INTEGER,
  person_id   INTEGER
);

CREATE TYPE conflict.conflict_event_person_conflict AS (
  conflict    TEXT,
  event_id    INTEGER,
  person_id   INTEGER
);

CREATE TYPE conflict.conflict_event_person_event AS (
  event_id1   INTEGER,
  event_id2   INTEGER,
  person_id   INTEGER
);

CREATE TYPE conflict.conflict_event_person_event_conflict AS (
  conflict    TEXT,
  event_id1   INTEGER,
  event_id2   INTEGER,
  person_id   INTEGER
);

CREATE TYPE conflict.conflict_event AS (
  event_id    INTEGER
);

CREATE TYPE conflict.conflict_event_conflict AS (
  conflict    TEXT,
  event_id    INTEGER
);

CREATE TYPE conflict.conflict_event_event AS (
  event_id1   INTEGER,
  event_id2   INTEGER
);

CREATE TYPE conflict.conflict_event_event_conflict AS (
  conflict    TEXT,
  event_id1   INTEGER,
  event_id2   INTEGER
);

CREATE TYPE conflict.view_conflict_event AS (
  conflict    TEXT,
  conflict_name TEXT,
  conflict_level TEXT,
  conflict_level_name TEXT,
  language_id INTEGER,
  event_id    INTEGER,
  title TEXT
);

CREATE TYPE conflict.view_conflict_event_event AS (
  conflict    TEXT,
  conflict_name TEXT,
  conflict_level TEXT,
  conflict_level_name TEXT,
  language_id INTEGER,
  event_id1 INTEGER,
  event_id2 INTEGER,
  title1 TEXT,
  title2 TEXT
);

CREATE TYPE conflict.view_conflict_event_person AS (
  conflict    TEXT,
  conflict_name TEXT,
  conflict_level TEXT,
  conflict_level_name TEXT,
  language_id INTEGER,
  event_id INTEGER,
  person_id INTEGER,
  title TEXT,
  name TEXT
);

CREATE TYPE conflict.view_conflict_event_person_event AS (
  conflict    TEXT,
  conflict_name TEXT,
  conflict_level TEXT,
  conflict_level_name TEXT,
  language_id INTEGER,
  person_id INTEGER,
  event_id1 INTEGER,
  event_id2 INTEGER,
  name TEXT,
  title1 TEXT,
  title2 TEXT
);

CREATE TYPE conflict.view_conflict_person AS (
  conflict    TEXT,
  conflict_name TEXT,
  conflict_level TEXT,
  conflict_level_name TEXT,
  language_id INTEGER,
  person_id INTEGER,
  name TEXT
);

