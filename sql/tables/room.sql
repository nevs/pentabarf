
CREATE TABLE master.room(
  room TEXT,
  conference_id INTEGER,
  public BOOL
) WITHOUT OIDS;

CREATE TABLE room() INHERITS(master.room);
CREATE TABLE logging.room() INHERITS(master.room);

