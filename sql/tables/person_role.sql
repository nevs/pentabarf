
CREATE TABLE person_role (
  person_id INTEGER NOT NULL,
  role_id INTEGER NOT NULL,
  FOREIGN KEY (person_id) REFERENCES person (person_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (role_id) REFERENCES role (role_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (person_id, role_id)
);

