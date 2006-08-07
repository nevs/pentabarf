
CREATE TABLE master.language(
  language TEXT,
  localized BOOL,
  visible BOOL
) WITHOUT OIDS;

CREATE TABLE language() INHERITS(master.language);
CREATE TABLE logging.language() INHERITS(master.language);
