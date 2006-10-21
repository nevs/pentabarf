
CREATE TABLE master.conference_team(
  conference_team_id INTEGER NOT NULL,
  conference_id INTEGER NOT NULL,
  conference_team TEXT NOT NULL
);

CREATE TABLE public.conference_team(
  PRIMARY KEY(conference_team_id),
  FOREIGN KEY(conference_id) REFERENCES conference(conference_id) ON UPDATE CASCADE
  UNIQUE( conference_id, conference_team),
) INHERITS(master.conference_team);

CREATE SEQUENCE conference_team_sequence;
ALTER TABLE public.conference_team ALTER COLUMN conference_team_id SET DEFAULT nextval('conference_team_sequence');

CREATE TABLE logging.conference_team() INHERITS(master.logging, master.conference_team);

