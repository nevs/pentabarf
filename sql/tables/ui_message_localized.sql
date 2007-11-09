
CREATE TABLE base.ui_message_localized (
  ui_message TEXT NOT NULL,
  translated TEXT NOT NULL,
  name TEXT NOT NULL
);

CREATE TABLE ui_message_localized (
  FOREIGN KEY (ui_message) REFERENCES ui_message (ui_message) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (translated) REFERENCES language (language) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (ui_message, translated)
) INHERITS( base.ui_message_localized );

CREATE TABLE log.ui_message_localized (
) INHERITS( base.logging, base.ui_message_localized );

