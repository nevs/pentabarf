
CREATE TABLE base.ui_message (
  ui_message TEXT NOT NULL
);

CREATE TABLE ui_message (
  PRIMARY KEY (ui_message)
) INHERITS( base.ui_message );

CREATE TABLE log.ui_message (
) INHERITS( base.logging, base.ui_message );

