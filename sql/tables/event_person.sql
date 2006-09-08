
CREATE TABLE master.event_person(
  event_person_id INTEGER NOT NULL,
  person_id INTEGER NOT NULL,
  event_id INTEGER NOT NULL,
  event_role TEXT NOT NULL,
  event_role_state TEXT,
  remark TEXT
);

CREATE TABLE event_person(
  PRIMARY KEY(event_person_id),
  FOREIGN KEY(person_id) REFERENCES person(person_id),
  FOREIGN KEY(event_id) REFERENCES event(event_id),
  FOREIGN KEY(event_role) REFERENCES event_role(event_role),
  FOREIGN KEY(event_role, event_role_state) REFERENCES event_role_state(event_role, event_role_state)
) INHERITS(master.event_person);

CREATE SEQUENCE event_person_id_sequence;
ALTER TABLE event_person ALTER COLUMN event_person_id SET DEFAULT nextval('event_person_id_sequence');

CREATE TABLE logging.event_person() INHERITS(master.event_person);


