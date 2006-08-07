
CREATE TABLE master.link_type_localized(
  link_type TEXT,
  translated TEXT,
  name TEXT
) WITHOUT OIDS;

CREATE TABLE link_type_localized() INHERITS(master.link_type_localized);
CREATE TABLE logging.link_type_localized() INHERITS(master.link_type_localized);

