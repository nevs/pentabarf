
CREATE TABLE master.conference_room(
  conference_room_id INTEGER NOT NULL,
  conference_room TEXT NOT NULL,
  conference_id INTEGER NOT NULL,
  public BOOL NOT NULL DEFAULT TRUE
);

CREATE TABLE conference_room(
  PRIMARY KEY(conference_id, conference_room),
  FOREIGN KEY(conference_id) REFERENCES conference(conference_id) ON UPDATE CASCADE ON DELETE CASCADE
) INHERITS(master.conference_room);

CREATE SEQUENCE conference_room_id_sequence;
ALTER TABLE conference_room ALTER COLUMN conference_room_id SET DEFAULT nextval('conference_room_id_sequence');

CREATE TABLE logging.conference_room() INHERITS(master.logging, master.conference_room);

