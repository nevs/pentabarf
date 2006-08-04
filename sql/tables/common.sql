
CREATE TABLE event() INHERITS(master.event);

CREATE SEQUENCE event_id_sequence;

ALTER TABLE event ALTER COLUMN event_id SET DEFAULT nextval('event_id_sequence');

