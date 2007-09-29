
CREATE TABLE event_person (
  event_person_id SERIAL NOT NULL,
  event_id INTEGER NOT NULL,
  person_id INTEGER NOT NULL,
  event_role_id INTEGER NOT NULL,
  event_role_state_id INTEGER,
  remark TEXT,
  rank INTEGER,
  last_modified TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  last_modified_by INTEGER,
  FOREIGN KEY (event_id) REFERENCES event (event_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (person_id) REFERENCES person (person_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (event_role_id) REFERENCES event_role (event_role_id) ON UPDATE CASCADE ON DELETE RESTRICT,
  FOREIGN KEY (event_role_state_id) REFERENCES event_role_state (event_role_state_id) ON UPDATE CASCADE ON DELETE RESTRICT,
  FOREIGN KEY (last_modified_by) REFERENCES person (person_id) ON UPDATE CASCADE ON DELETE SET NULL,
  UNIQUE (event_id, person_id, event_role_id),
  PRIMARY KEY (event_person_id)
);

CREATE INDEX event_person_event_id_index ON event_person(event_id);
CREATE INDEX event_person_person_id_index ON event_person(person_id);
CREATE INDEX event_person_event_role_id_index ON event_person(event_role_id);
CREATE INDEX event_person_event_role_state_id_index ON event_person(event_role_state_id);

