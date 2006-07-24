--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Name: conflict_type_conflict_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pentabarf
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('conflict_type', 'conflict_type_id'), 5, true);


--
-- Data for Name: conflict_type; Type: TABLE DATA; Schema: public; Owner: pentabarf
--

INSERT INTO conflict_type (conflict_type_id, tag) VALUES (1, 'person');
INSERT INTO conflict_type (conflict_type_id, tag) VALUES (2, 'event_person');
INSERT INTO conflict_type (conflict_type_id, tag) VALUES (3, 'event_person_event');
INSERT INTO conflict_type (conflict_type_id, tag) VALUES (4, 'event');
INSERT INTO conflict_type (conflict_type_id, tag) VALUES (5, 'event_event');


--
-- PostgreSQL database dump complete
--

