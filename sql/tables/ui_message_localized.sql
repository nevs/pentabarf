
CREATE TABLE ui_message_localized (
  ui_message_id INTEGER NOT NULL,
  language_id INTEGER NOT NULL,
  name TEXT NOT NULL CHECK (name NOT LIKE '%`%' AND name NOT LIKE '%#{%' AND name NOT LIKE '%<\\%%'),
  FOREIGN KEY (ui_message_id) REFERENCES ui_message (ui_message_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (language_id) REFERENCES language (language_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (ui_message_id, language_id)
) WITHOUT OIDS;

