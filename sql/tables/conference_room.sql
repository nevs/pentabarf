
CREATE TABLE base.conference_room (
  conference_id INTEGER NOT NULL,
  conference_room TEXT NOT NULL,
  public BOOL NOT NULL DEFAULT FALSE,
  size INTEGER,
  remark TEXT,
  rank INTEGER
);

CREATE TABLE conference_room(
  FOREIGN KEY (conference_id) REFERENCES conference (conference_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (conference_room, conference_id)
) INHERITS( base.conference_room );

CREATE TABLE log.conference_room(
) INHERITS( base.logging, base.conference_room );

