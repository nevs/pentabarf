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
INSERT INTO event_type (event_type, rank) VALUES ('workshop', 3);
INSERT INTO event_type (event_type, rank) VALUES ('movie', 4);
INSERT INTO event_type (event_type, rank) VALUES ('podium', 6);
INSERT INTO event_type (event_type, rank) VALUES ('meeting', 7);
INSERT INTO event_type (event_type, rank) VALUES ('other', 8);
INSERT INTO event_type (event_type, rank) VALUES ('lightning', 9);
INSERT INTO event_type (event_type, rank) VALUES ('contest', 10);


--
-- PostgreSQL database dump complete
--

