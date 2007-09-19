
ALTER TABLE conference_person ADD CONSTRAINT conference_person_unique UNIQUE(conference_id,person_id);

ALTER TABLE conference ALTER timeslot_duration SET DEFAULT '1:00:00'::interval;

