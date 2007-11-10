
CREATE TABLE base.conference_link (
  conference_link_id SERIAL NOT NULL,
  conference_id INTEGER NOT NULL,
  url TEXT NOT NULL,
  title TEXT,
  rank INTEGER
);

CREATE TABLE conference_link (
  FOREIGN KEY (conference_id) REFERENCES conference (conference_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (conference_link_id)
) INHERITS( base.conference_link );

CREATE TABLE log.conference_link (
) INHERITS( base.logging,base.conference_link );

