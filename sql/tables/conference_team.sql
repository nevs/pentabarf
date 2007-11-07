
CREATE TABLE base.conference_team (
  conference_id INTEGER NOT NULL,
  conference_team TEXT NOT NULL,
  rank INTEGER
);

CREATE TABLE conference_team (
  FOREIGN KEY (conference_id) REFERENCES conference(conference_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (conference_id,conference_team)
) INHERITS (base.conference_team);

CREATE TABLE log.conference_team (
) INHERITS( base.logging, base.conference_team );

