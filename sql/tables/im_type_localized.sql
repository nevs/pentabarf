
CREATE TABLE base.im_type_localized (
  im_type TEXT NOT NULL,
  translated TEXT NOT NULL,
  name TEXT NOT NULL
);

CREATE TABLE im_type_localized (
  FOREIGN KEY (im_type) REFERENCES im_type (im_type) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (translated) REFERENCES language (language) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (im_type, translated)
) INHERITS( base.im_type_localized );

CREATE TABLE log.im_type_localized (
) INHERITS( base.logging, base.im_type_localized );

