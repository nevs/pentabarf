
CREATE TABLE base.account_activation (
  account_id INTEGER UNIQUE NOT NULL,
  conference_id INTEGER,
  activation_string CHAR(64) NOT NULL UNIQUE,
  account_creation TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

CREATE TABLE auth.account_activation (
  FOREIGN KEY (account_id) REFERENCES auth.account(account_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (conference_id) REFERENCES conference(conference_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (account_id)
) INHERITS( base.account_activation );

CREATE TABLE log.account_activation (
) INHERITS( base.logging, base.account_activation );

