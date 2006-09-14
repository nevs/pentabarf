
CREATE TABLE master.conference_phase(
  conference_phase TEXT NOT NULL,
  rank INTEGER
);

CREATE TABLE conference_phase(
  PRIMARY KEY(conference_phase)
) INHERITS(master.conference_phase);

CREATE TABLE logging.conference_phase() INHERITS(master.logging, master.conference_phase);

