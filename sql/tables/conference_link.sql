
CREATE TABLE conference_link (
  conference_link_id SERIAL NOT NULL,
  conference_id INTEGER NOT NULL,
  url VARCHAR(1024) NOT NULL,
  title VARCHAR(256),
  rank INTEGER,
  FOREIGN KEY (conference_id) REFERENCES conference (conference_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (conference_link_id)
) WITHOUT OIDS;

