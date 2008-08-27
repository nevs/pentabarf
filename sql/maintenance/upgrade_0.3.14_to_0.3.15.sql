
BEGIN;

-- add conference_track_id back to table conference_track

ALTER TABLE base.conference_track ADD COLUMN conference_track_id SERIAL NOT NULL;
DELETE FROM log.conference_track;
ALTER TABLE base.event ADD COLUMN conference_track_id INTEGER;

UPDATE event SET conference_track_id = ( SELECT conference_track_id FROM conference_track WHERE conference_track.conference_track = event.conference_track AND conference_track.conference_id = event.conference_id) WHERE conference_track IS NOT NULL;

ALTER TABLE public.event DROP CONSTRAINT event_conference_track_fkey;

ALTER TABLE public.conference_track DROP CONSTRAINT conference_track_pkey1;

ALTER TABLE public.conference_track ADD CONSTRAINT conference_track_pkey PRIMARY KEY( conference_track_id );
ALTER TABLE public.conference_track ADD CONSTRAINT conference_track_uniq UNIQUE( conference_id, conference_track );
ALTER TABLE public.event ADD CONSTRAINT event_conference_track_id_fkey FOREIGN KEY (conference_track_id) REFERENCES conference_track (conference_track_id) ON UPDATE CASCADE ON DELETE SET NULL;

ALTER TABLE base.event DROP COLUMN conference_track CASCADE;

-- add conference_room_id back to table conference_room

ALTER TABLE base.conference_room ADD COLUMN conference_room_id SERIAL NOT NULL;
DELETE FROM log.conference_room;

ALTER TABLE base.event ADD COLUMN conference_room_id INTEGER;
ALTER TABLE base.conference_room_role ADD COLUMN conference_room_id INTEGER;

UPDATE event SET conference_room_id = ( SELECT conference_room_id FROM conference_room WHERE conference_room.conference_room = event.conference_room AND conference_room.conference_id = event.conference_id) WHERE conference_room IS NOT NULL;
UPDATE conference_room_role SET conference_room_id = ( SELECT conference_room_id FROM conference_room WHERE conference_room.conference_room = conference_room_role.conference_room AND conference_room.conference_id = conference_room_role.conference_id) WHERE conference_room IS NOT NULL;

ALTER TABLE public.event DROP CONSTRAINT event_conference_room_fkey;
ALTER TABLE public.conference_room_role DROP CONSTRAINT conference_room_role_conference_id_fkey;
ALTER TABLE public.conference_room_role DROP CONSTRAINT conference_room_role_pkey;

ALTER TABLE public.conference_room DROP CONSTRAINT conference_room_pkey;

ALTER TABLE public.conference_room ADD CONSTRAINT conference_room_pkey PRIMARY KEY( conference_room_id );
ALTER TABLE public.conference_room ADD CONSTRAINT conference_room_uniq UNIQUE( conference_id, conference_room );
ALTER TABLE public.event ADD CONSTRAINT event_conference_room_id_fkey FOREIGN KEY (conference_room_id) REFERENCES conference_room (conference_room_id) ON UPDATE CASCADE ON DELETE SET NULL;
ALTER TABLE public.conference_room_role ADD CONSTRAINT conference_room_role_pkey PRIMARY KEY( conference_room_id );
ALTER TABLE public.conference_room_role ADD CONSTRAINT conference_room_role_conference_room_id_fkey FOREIGN KEY (conference_room_id) REFERENCES conference_room (conference_room_id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE base.event DROP COLUMN conference_room CASCADE;
ALTER TABLE base.conference_room_role DROP COLUMN conference_id;
ALTER TABLE base.conference_room_role DROP COLUMN conference_room;


SELECT log.activate_logging();

COMMIT;

