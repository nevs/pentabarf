
CREATE TABLE master.room(
  room TEXT NOT NULL,
  conference_id INTEGER NOT NULL,
  public BOOL NOT NULL DEFAULT TRUE
) WITHOUT OIDS;

CREATE TABLE room(
  PRIMARY KEY(conference_id, room),
  FOREIGN KEY(conference_id) REFERENCES conference(conference_id) ON UPDATE CASCADE
) INHERITS(master.room);

CREATE TABLE logging.room() INHERITS(master.room);

