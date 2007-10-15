
CREATE TABLE attachment_type_localized (
  attachment_type TEXT NOT NULL,
  language_id INTEGER NOT NULL,
  name TEXT NOT NULL,
  FOREIGN KEY (attachment_type) REFERENCES attachment_type (attachment_type) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (language_id) REFERENCES language (language_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (attachment_type, language_id)
);

