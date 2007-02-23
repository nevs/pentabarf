--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Name: event_type_event_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('event_type_event_type_id_seq', 10, true);


--
-- Data for Name: event_type; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO event_type (event_type_id, tag, rank) VALUES (6, 'podium', NULL);
INSERT INTO event_type (event_type_id, tag, rank) VALUES (7, 'meeting', NULL);
INSERT INTO event_type (event_type_id, tag, rank) VALUES (8, 'other', NULL);
INSERT INTO event_type (event_type_id, tag, rank) VALUES (1, 'lecture', NULL);
INSERT INTO event_type (event_type_id, tag, rank) VALUES (3, 'workshop', NULL);
INSERT INTO event_type (event_type_id, tag, rank) VALUES (4, 'movie', NULL);
INSERT INTO event_type (event_type_id, tag, rank) VALUES (9, 'lightning', NULL);
INSERT INTO event_type (event_type_id, tag, rank) VALUES (10, 'contest', NULL);


--
-- PostgreSQL database dump complete
--

