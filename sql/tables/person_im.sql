
CREATE TABLE base.person_im (
  person_im_id SERIAL NOT NULL,
  person_id INTEGER NOT NULL,
  im_type TEXT NOT NULL,
  im_address TEXT NOT NULL,
  rank INTEGER
);

CREATE TABLE person_im (
  FOREIGN KEY (person_id) REFERENCES person (person_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (im_type) REFERENCES im_type (im_type) ON UPDATE CASCADE ON DELETE RESTRICT,
  PRIMARY KEY (person_im_id)
) INHERITS( base.person_im );

CREATE TABLE log.person_im (
) INHERITS( base.logging, base.person_im );

