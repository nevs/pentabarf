
CREATE TABLE master.event_person(
  event_person_id INTEGER NOT NULL,
  event_id INTEGER NOT NULL,
  person_id INTEGER NOT NULL,
  event_role TEXT NOT NULL,
  event_role_state TEXT,
  remark TEXT
);

CREATE TABLE event_person(
  PRIMARY KEY(event_person_id),
  FOREIGN KEY(event_id) REFERENCES event(event_id),
  FOREIGN KEY(person_id) REFERENCES person(person_id),
  FOREIGN KEY(event_role) REFERENCES event_role(event_role),
  FOREIGN KEY(event_role, event_role_state) REFERENCES event_role_state(event_role, event_role_state),
  UNIQUE( event_id, person_id, event_role )
) INHERITS(master.event_person);

CREATE SEQUENCE event_person_id_sequence;
ALTER TABLE event_person ALTER COLUMN event_person_id SET DEFAULT nextval('event_person_id_sequence');

CREATE INDEX event_person_event_id ON event_person( event_id );
CREATE INDEX event_person_person_id ON event_person( person_id );
CREATE INDEX event_person_event_role ON event_person( event_role );

CREATE TABLE logging.event_person() INHERITS(master.logging, master.event_person);


