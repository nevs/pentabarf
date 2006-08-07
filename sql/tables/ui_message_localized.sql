
CREATE TABLE master.ui_message_localized(
  ui_message TEXT NOT NULL,
  translated TEXT NOT NULL,
  name TEXT NOT NULL
) WITHOUT OIDS;

CREATE TABLE ui_message_localized(
  PRIMARY KEY(ui_message, translated),
  FOREIGN KEY(ui_message) REFERENCES ui_message(ui_message),
  FOREIGN KEY(translated) REFERENCES language(language)
) INHERITS(master.ui_message_localized);

CREATE TABLE logging.ui_message_localized() INHERITS(master.ui_message_localized);

