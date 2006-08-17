
CREATE TABLE master.language(
  language TEXT NOT NULL,
  localized BOOL NOT NULL,
  visible BOOL NOT NULL DEFAULT FALSE
);

CREATE TABLE language(
  PRIMARY KEY(language)
) INHERITS(master.language);

CREATE TABLE logging.language() INHERITS(master.language);

