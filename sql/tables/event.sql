
CREATE TABLE master.event(
  event_id INTEGER NOT NULL,
  conference_id INTEGER NOT NULL,
  tag TEXT,
  title TEXT NOT NULL,
  subtitle TEXT
) WITHOUT OIDS;

-- this is the real event table
CREATE TABLE event(
  PRIMARY KEY(event_id),
  FOREIGN KEY(conference_id) REFERENCES conference(conference_id)
) INHERITS(master.event);

CREATE SEQUENCE event_id_sequence;
ALTER TABLE event ALTER COLUMN event_id SET DEFAULT nextval('event_id_sequence');

CREATE TABLE logging.event(
) INHERITS(master.event);

