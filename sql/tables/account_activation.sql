
CREATE TABLE account_activation(
  account_activation_id SERIAL NOT NULL,
  person_id INTEGER UNIQUE NOT NULL,
  conference_id INTEGER,
  activation_string CHAR(64) NOT NULL UNIQUE,
  account_creation TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  FOREIGN KEY (person_id) REFERENCES person(person_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (conference_id) REFERENCES conference(conference_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (account_activation_id)
) WITHOUT OIDS;

