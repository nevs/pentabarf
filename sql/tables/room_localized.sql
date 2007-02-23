
CREATE TABLE room_localized (
  room_id INTEGER NOT NULL,
  language_id INTEGER NOT NULL,
  public_name VARCHAR(64) NOT NULL,
  description TEXT,
  FOREIGN KEY (room_id) REFERENCES room (room_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (language_id) REFERENCES language (language_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (room_id, language_id)
) WITHOUT OIDS;

