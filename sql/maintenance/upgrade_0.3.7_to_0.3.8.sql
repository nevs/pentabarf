
BEGIN;

ALTER TABLE conference_day DROP CONSTRAINT conference_day_conference_id_fkey;
ALTER TABLE conference_day ADD CONSTRAINT conference_day_conference_id_fkey FOREIGN KEY( conference_id ) REFERENCES conference( conference_id ) ON UPDATE CASCADE ON DELETE CASCADE;

INSERT INTO currency (currency, exchange_rate) VALUES ('VEF', NULL);

UPDATE ui_message SET ui_message = replace( ui_message, ':event_rating_public:', ':event_feedback:');

INSERT INTO conflict.conflict_localized VALUES ('event_paper_unknown','en','Event with unknown paper state.');
INSERT INTO conflict.conflict_localized VALUES ('event_paper_unknown','de','Veranstaltung mit unklarem Paper-Status.');
INSERT INTO conflict.conflict_localized VALUES ('event_person_event_time_attendee','en','Attendee with two events at the same time.');
INSERT INTO conflict.conflict_localized VALUES ('event_person_event_time_attendee','de','Besucher mit zwei gleichzeitigen Veranstaltungen.');
INSERT INTO conflict.conflict_localized VALUES ('event_slides_unknown','en','Event with unknown slides state.');
INSERT INTO conflict.conflict_localized VALUES ('event_slides_unknown','de','Veranstaltung mit unklarem Folien-Status.');

COMMIT;

