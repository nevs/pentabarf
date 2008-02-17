
SET client_encoding = 'UTF8';
SET search_path = public, pg_catalog;

INSERT INTO event_state (event_state, rank) VALUES ('accepted', 2);
INSERT INTO event_state (event_state, rank) VALUES ('rejected', 3);
INSERT INTO event_state (event_state, rank) VALUES ('undecided', 1);
