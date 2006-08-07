
CREATE TABLE master.ui_message_localized(
  ui_message TEXT,
  translated TEXT,
  name TEXT
) WITHOUT OIDS;

CREATE TABLE ui_message_localized() INHERITS(master.ui_message_localized);
CREATE TABLE logging.ui_message_localized() INHERITS(master.ui_message_localized);

