
CREATE TABLE master.im_type(
  im_type TEXT NOT NULL
);

CREATE TABLE im_type(
  PRIMARY KEY(im_type)
) INHERITS(master.im_type);

CREATE TABLE logging.im_type() INHERITS(master.logging, master.im_type);

