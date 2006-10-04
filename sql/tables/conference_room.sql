
CREATE TABLE master.room(
  conference_room_id INTEGER NOT NULL,
  conference_room TEXT NOT NULL,
  conference_id INTEGER NOT NULL,
  public BOOL NOT NULL DEFAULT TRUE
);

CREATE TABLE room(
  PRIMARY KEY(conference_id, room),
  FOREIGN KEY(conference_id) REFERENCES conference(conference_id) ON UPDATE CASCADE
) INHERITS(master.room);

CREATE SEQUENCE conference_room_id_sequence;
ALTER TABLE conference_room ALTER COLUMN conference_room_id SET DEFAULT nextval('conference_room_id_sequence');

CREATE TABLE logging.room() INHERITS(master.logging, master.room);

