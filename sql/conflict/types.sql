
/*
 * These types are used for the conflict functions.
 *
*/

CREATE TYPE conflict.person AS (
  person_id   INTEGER  
);

CREATE TYPE conflict.person_conflict AS (
  conflict    TEXT,
  person_id   INTEGER  
);

CREATE TYPE conflict.event_person AS (
  event_id    INTEGER,
  person_id   INTEGER
);

CREATE TYPE conflict.event_person_conflict AS (
  conflict    TEXT,
  event_id    INTEGER,
  person_id   INTEGER
);

CREATE TYPE conflict.event_person_event AS (
  event_id1   INTEGER,
  event_id2   INTEGER,
  person_id   INTEGER
);

CREATE TYPE conflict.event_person_event_conflict AS (
  conflict    TEXT,
  event_id1   INTEGER,
  event_id2   INTEGER,
  person_id   INTEGER
);

CREATE TYPE conflict.event AS (
  event_id    INTEGER
);

CREATE TYPE conflict.event_conflict AS (
  conflict    TEXT,
  event_id    INTEGER
);

CREATE TYPE conflict.event_event AS (
  event_id1   INTEGER,
  event_id2   INTEGER
);

CREATE TYPE conflict.event_event_conflict AS (
  conflict    TEXT,
  event_id1   INTEGER,
  event_id2   INTEGER
);

