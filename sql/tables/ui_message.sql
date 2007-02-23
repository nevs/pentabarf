
CREATE TABLE ui_message (
  ui_message_id SERIAL NOT NULL,
  tag VARCHAR(128) NOT NULL UNIQUE,
  PRIMARY KEY (ui_message_id)
) WITHOUT OIDS;

