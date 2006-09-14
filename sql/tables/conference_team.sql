
CREATE TABLE master.conference_team(
  conference_id INTEGER NOT NULL,
  conference_team TEXT NOT NULL
);

CREATE TABLE conference_team(
  PRIMARY KEY(conference_id, conference_team),
  FOREIGN KEY(conference_id) REFERENCES conference(conference_id) ON UPDATE CASCADE
) INHERITS(master.conference_team);

CREATE TABLE logging.conference_team() INHERITS(master.logging, master.conference_team);

