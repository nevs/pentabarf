
CREATE TABLE master.conference_language(
  conference_id INTEGER,
  language TEXT
) WITHOUT OIDS;

CREATE TABLE conference_language INHERITS(master.conference_language);

CREATE TABLE logging.conference_language INHERITS(master.conference_language);

