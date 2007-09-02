
CREATE TABLE attachment_type_localized (
  attachment_type_id INTEGER NOT NULL,
  language_id INTEGER NOT NULL,
  name VARCHAR(64) NOT NULL,
  FOREIGN KEY (attachment_type_id) REFERENCES attachment_type (attachment_type_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (language_id) REFERENCES language (language_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (attachment_type_id, language_id)
) WITHOUT OIDS;

