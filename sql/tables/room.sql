
CREATE TABLE room (
  room_id SERIAL NOT NULL,
  conference_id INTEGER NOT NULL,
  short_name VARCHAR(32) NOT NULL,
  f_public BOOL NOT NULL DEFAULT FALSE,
  size INTEGER,
  remark TEXT,
  rank INTEGER,
  FOREIGN KEY (conference_id) REFERENCES conference (conference_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (room_id)
) WITHOUT OIDS;

