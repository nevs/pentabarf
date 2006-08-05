
ALTER TABLE person_transaction ADD COLUMN person_transaction_id SERIAL;
ALTER TABLE person_transaction DROP CONSTRAINT person_transaction_pkey;
ALTER TABLE person_transaction ADD CONSTRAINT person_transaction_pkey PRIMARY KEY(person_transaction_id);

ALTER TABLE event_transaction ADD COLUMN event_transaction_id SERIAL;
ALTER TABLE event_transaction DROP CONSTRAINT event_transaction_pkey;
ALTER TABLE event_transaction ADD CONSTRAINT event_transaction_pkey PRIMARY KEY(event_transaction_id);

ALTER TABLE conference_transaction ADD COLUMN conference_transaction_id SERIAL;
ALTER TABLE conference_transaction DROP CONSTRAINT conference_transaction_pkey;
ALTER TABLE conference_transaction ADD CONSTRAINT conference_transaction_pkey PRIMARY KEY(conference_transaction_id);

