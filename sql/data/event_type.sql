--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Data for Name: event_type; Type: TABLE DATA; Schema: public; Owner: sven
--

INSERT INTO event_type (event_type, rank) VALUES ('lecture', 1);
INSERT INTO event_type (event_type, rank) VALUES ('workshop', 2);
INSERT INTO event_type (event_type, rank) VALUES ('movie', 3);
INSERT INTO event_type (event_type, rank) VALUES ('podium', 4);
INSERT INTO event_type (event_type, rank) VALUES ('meeting', 5);
INSERT INTO event_type (event_type, rank) VALUES ('other', 6);
INSERT INTO event_type (event_type, rank) VALUES ('lightning', 7);
INSERT INTO event_type (event_type, rank) VALUES ('contest', 8);


--
-- PostgreSQL database dump complete
--

