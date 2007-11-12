
CREATE TABLE base.account_password_reset (
  account_id INTEGER UNIQUE NOT NULL,
  activation_string CHAR(64) NOT NULL UNIQUE,
  reset_time TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

CREATE TABLE auth.account_password_reset (
  PRIMARY KEY (account_id),
  FOREIGN KEY (account_id) REFERENCES auth.account (account_id) ON UPDATE CASCADE ON DELETE CASCADE
) INHERITS( base.account_password_reset );

CREATE TABLE log.account_password_reset (
) INHERITS( base.logging, base.account_password_reset );

