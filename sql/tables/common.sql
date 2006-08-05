
CREATE TABLE event() INHERITS(master.event);

CREATE SEQUENCE event_id_sequence;

ALTER TABLE event ADD CONSTRAINT event_pk PRIMARY KEY(event_id);

ALTER TABLE event ADD CONSTRAINT event_fk_conference_id FOREIGN KEY conference_id REFERENCES conference(conference_id);
ALTER TABLE event ADD CONSTRAINT event_fk_country FOREIGN KEY country REFERENCES country(country);
ALTER TABLE event ADD CONSTRAINT event_fk_currency FOREIGN KEY currency REFERENCES currency(currency);

ALTER TABLE event ALTER COLUMN event_id SET DEFAULT nextval('event_id_sequence');

