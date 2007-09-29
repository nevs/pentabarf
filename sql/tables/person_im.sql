
CREATE TABLE person_im (
  person_im_id SERIAL NOT NULL,
  person_id INTEGER NOT NULL,
  im_type_id INTEGER NOT NULL,
  im_address VARCHAR(128) NOT NULL,
  rank INTEGER,
  FOREIGN KEY (person_id) REFERENCES person (person_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (im_type_id) REFERENCES im_type (im_type_id) ON UPDATE CASCADE ON DELETE RESTRICT,
  PRIMARY KEY (person_im_id)
);

