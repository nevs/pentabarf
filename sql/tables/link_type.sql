
CREATE TABLE master.link_type(
  link_type TEXT
) WITHOUT OIDS;

CREATE TABLE link_type() INHERITS(master.link_type);
CREATE TABLE logging.link_type() INHERITS(master.link_type);

