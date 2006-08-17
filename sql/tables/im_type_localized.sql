
CREATE TABLE master.im_type_localized(
  im_type TEXT NOT NULL,
  translated TEXT NOT NULL,
  name TEXT NOT NULL
);

CREATE TABLE im_type_localized(
  PRIMARY KEY(im_type, translated),
  FOREIGN KEY(im_type) REFERENCES im_type(im_type) ON UPDATE CASCADE,
  FOREIGN KEY(translated) REFERENCES language(language) ON UPDATE CASCADE
) INHERITS(master.im_type_localized);

CREATE TABLE logging.im_type_localized() INHERITS(master.im_type_localized);

