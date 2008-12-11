
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

-- add per conference event rating categories

CREATE TABLE base.event_rating_remark (
  person_id INTEGER NOT NULL,
  event_id INTEGER NOT NULL,
  remark TEXT NOT NULL,
  eval_time TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

CREATE TABLE event_rating_remark (
  FOREIGN KEY (person_id) REFERENCES person (person_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (event_id) REFERENCES event (event_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (person_id, event_id)
) INHERITS( base.event_rating_remark );

CREATE TABLE log.event_rating_remark () INHERITS( base.logging, base.event_rating_remark );

INSERT INTO event_rating_remark(person_id,event_id,remark,eval_time) SELECT person_id,event_id,remark,eval_time FROM event_rating WHERE remark IS NOT NULL;

ALTER TABLE base.event_rating RENAME TO old_event_rating;
ALTER TABLE public.event_rating RENAME TO old_event_rating;
ALTER TABLE log.event_rating RENAME TO old_event_rating;

CREATE TABLE base.event_rating_category (
  event_rating_category_id SERIAL NOT NULL,
  conference_id INTEGER NOT NULL,
  event_rating_category TEXT NOT NULL,
  rank INTEGER
);

CREATE TABLE event_rating_category (
  FOREIGN KEY (conference_id) REFERENCES conference(conference_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (event_rating_category_id),
  UNIQUE (conference_id,event_rating_category)
) INHERITS( base.event_rating_category );

CREATE TABLE log.event_rating_category () INHERITS( base.logging, base.event_rating_category );

CREATE TABLE base.event_rating (
  person_id INTEGER NOT NULL,
  event_id INTEGER NOT NULL,
  event_rating_category_id INTEGER NOT NULL,
  rating SMALLINT CHECK( rating > 0 AND rating < 6 ) NOT NULL,
  eval_time TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

CREATE TABLE event_rating (
  FOREIGN KEY (person_id) REFERENCES person (person_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (event_id) REFERENCES event (event_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (event_rating_category_id) REFERENCES event_rating_category(event_rating_category_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (person_id, event_id, event_rating_category_id)
) INHERITS( base.event_rating );

CREATE TABLE log.event_rating () INHERITS( base.logging, base.event_rating );

INSERT INTO event_rating_category(conference_id,event_rating_category) SELECT conference_id,'relevance' FROM conference;
INSERT INTO event_rating_category(conference_id,event_rating_category) SELECT conference_id,'actuality' FROM conference;
INSERT INTO event_rating_category(conference_id,event_rating_category) SELECT conference_id,'acceptance' FROM conference;

INSERT INTO event_rating(person_id,event_id,event_rating_category_id,rating,eval_time) SELECT person_id,event_id,event_rating_category_id,relevance,eval_time FROM old_event_rating INNER JOIN event USING(event_id) INNER JOIN event_rating_category ON (event_rating_category='relevance' AND event_rating_category.conference_id=event.conference_id) WHERE relevance IS NOT NULL;
INSERT INTO event_rating(person_id,event_id,event_rating_category_id,rating,eval_time) SELECT person_id,event_id,event_rating_category_id,actuality,eval_time FROM old_event_rating INNER JOIN event USING(event_id) INNER JOIN event_rating_category ON (event_rating_category='actuality' AND event_rating_category.conference_id=event.conference_id) WHERE actuality IS NOT NULL;
INSERT INTO event_rating(person_id,event_id,event_rating_category_id,rating,eval_time) SELECT person_id,event_id,event_rating_category_id,acceptance,eval_time FROM old_event_rating INNER JOIN event USING(event_id) INNER JOIN event_rating_category ON (event_rating_category='acceptance' AND event_rating_category.conference_id=event.conference_id) WHERE acceptance IS NOT NULL;

DROP TABLE base.old_event_rating CASCADE;

SELECT log.activate_logging();

INSERT INTO auth.object_domain VALUES ('conference_link','conference');

COMMIT;

