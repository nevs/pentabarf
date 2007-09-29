
CREATE TABLE mime_type_localized (
  mime_type_id INTEGER NOT NULL,
  language_id INTEGER NOT NULL,
  name VARCHAR(128) NOT NULL,
  FOREIGN KEY (mime_type_id) REFERENCES mime_type (mime_type_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (language_id) REFERENCES language (language_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (mime_type_id, language_id)
);

