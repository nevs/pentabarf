
CREATE TABLE master.im_type_localized(
  im_type TEXT NOT NULL,
  translated TEXT NOT NULL,
  name TEXT NOT NULL
) WITHOUT OIDS;

CREATE TABLE im_type_localized(
  PRIMARY KEY(im_type, translated),
  FOREIGN KEY(im_type) REFERENCES im_type(im_type),
  FOREIGN KEY(translated) REFERENCES language(language)
) INHERITS(master.im_type_localized);

CREATE TABLE logging.im_type_localized() INHERITS(master.im_type_localized);

