
CREATE TABLE master.conference_language(
  conference_language_id INTEGER NOT NULL,
  conference_id INTEGER NOT NULL,
  language TEXT NOT NULL
);

CREATE TABLE conference_language(
  PRIMARY KEY(conference_language_id),
  UNIQUE(conference_id, language),
  FOREIGN KEY(conference_id) REFERENCES conference(conference_id) ON UPDATE CASCADE,
  FOREIGN KEY(language) REFERENCES language(language) ON UPDATE CASCADE
) INHERITS(master.conference_language);

CREATE TABLE logging.conference_language() INHERITS(master.conference_language);

CREATE SEQUENCE conference_language_id_sequence;
ALTER TABLE conference_language ALTER COLUMN conference_language_id SET DEFAULT nextval('conference_language_id_sequence');

