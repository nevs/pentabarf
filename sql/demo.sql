
INSERT INTO conference(title, acronym, start_date) VALUES ('Pentabarf', 'Pentabarf', '2007-01-01');

INSERT INTO event(conference_id, title) VALUES  (currval('conference_id_sequence'), 'First Event');
INSERT INTO event(conference_id, title) VALUES  (currval('conference_id_sequence'), 'Second Event');
INSERT INTO event(conference_id, title) VALUES  (currval('conference_id_sequence'), 'Third Event');
INSERT INTO event(conference_id, title) VALUES  (currval('conference_id_sequence'), 'Fourth Event');

INSERT INTO person( first_name, login_name ) VALUES ( 'Sven', 'sven' );
INSERT INTO person( first_name, login_name ) VALUES ( 'Astro', 'astro' );
INSERT INTO person( first_name, login_name ) VALUES ( 'Toidinamai', 'toidinamai' );
INSERT INTO person( first_name, login_name ) VALUES ( 'blitz', 'blitz' );
INSERT INTO person( first_name, login_name ) VALUES ( 'riot', 'riot' );
INSERT INTO person( first_name, login_name ) VALUES ( 'knulli', 'knulli' );

