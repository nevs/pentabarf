
CREATE TABLE base.event_person (
  event_person_id SERIAL NOT NULL,
  event_id INTEGER NOT NULL,
  person_id INTEGER NOT NULL,
  event_role TEXT NOT NULL,
  event_role_state TEXT,
  remark TEXT,
  rank INTEGER
);

CREATE TABLE event_person (
  FOREIGN KEY (event_id) REFERENCES event (event_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (person_id) REFERENCES person (person_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (event_role) REFERENCES event_role (event_role) ON UPDATE CASCADE ON DELETE RESTRICT,
  FOREIGN KEY (event_role,event_role_state) REFERENCES event_role_state (event_role,event_role_state) ON UPDATE CASCADE ON DELETE RESTRICT,
  UNIQUE (event_id, person_id, event_role),
  PRIMARY KEY (event_person_id)
) INHERITS( base.event_person );

CREATE TABLE log.event_person (
) INHERITS( base.logging, base.event_person );

