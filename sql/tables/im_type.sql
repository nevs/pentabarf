
CREATE TABLE master.im_type(
  im_type TEXT
) WITHOUT OIDS;

CREATE TABLE im_type() INHERITS(master.im_type);
CREATE TABLE logging.im_type() INHERITS(master.im_type);
