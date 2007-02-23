
CREATE TABLE im_type_localized (
  im_type_id INTEGER NOT NULL,
  language_id INTEGER NOT NULL,
  name VARCHAR(64) NOT NULL,
  FOREIGN KEY (im_type_id) REFERENCES im_type (im_type_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (language_id) REFERENCES language (language_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (im_type_id, language_id)
) WITHOUT OIDS;

