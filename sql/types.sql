
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

