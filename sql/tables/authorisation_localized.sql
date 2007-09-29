
CREATE TABLE authorisation_localized (
  authorisation_id INTEGER NOT NULL,
  language_id INTEGER NOT NULL,
  name VARCHAR(64) NOT NULL,
  FOREIGN KEY (authorisation_id) REFERENCES authorisation (authorisation_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (language_id) REFERENCES language (language_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (authorisation_id, language_id)
);

