
CREATE INDEX conference_person_conference_id_index ON conference_person(conference_id);
CREATE INDEX conference_person_person_id_index ON conference_person(person_id);

CREATE INDEX event_conference_id_index ON event(conference_id);
CREATE INDEX event_event_state_index ON event(event_state,event_state_progress);

CREATE INDEX event_person_event_id_index ON event_person(event_id);
CREATE INDEX event_person_person_id_index ON event_person(person_id);
CREATE INDEX event_person_event_role_index ON event_person(event_role);
CREATE INDEX event_person_event_role_state_index ON event_person(event_role,event_role_state);

