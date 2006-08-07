
CREATE TABLE master.ui_message(
  ui_message TEXT NOT NULL
) WITHOUT OIDS;

CREATE TABLE ui_message(
  PRIMARY KEY(ui_message)
) INHERITS(master.ui_message);

CREATE TABLE logging.ui_message() INHERITS(master.ui_message);

