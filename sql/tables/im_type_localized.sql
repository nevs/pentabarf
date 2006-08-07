
CREATE TABLE master.im_type_localized(
  im_type TEXT,
  translated TEXT,
  name TEXT
) WITHOUT OIDS;

CREATE TABLE im_type_localized() INHERITS(master.im_type_localized);
CREATE TABLE logging.im_type_localized() INHERITS(master.im_type_localized);
