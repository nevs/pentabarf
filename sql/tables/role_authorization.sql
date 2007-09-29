
CREATE TABLE role_authorisation (
  role_id INTEGER NOT NULL,
  authorisation_id INTEGER NOT NULL,
  FOREIGN KEY (role_id) REFERENCES role (role_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (authorisation_id) REFERENCES authorisation (authorisation_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (role_id, authorisation_id)
);

