
CREATE TABLE base.ui_message (
  ui_message TEXT NOT NULL
);

CREATE TABLE ui_message (
  PRIMARY KEY (ui_message)
) INHERITS( base.ui_message );

CREATE INDEX log_ui_message_ui_message_idx ON log.ui_message( ui_message );
CREATE INDEX log_ui_message_log_transaction_id_idx ON log.ui_message( log_transaction_id );

