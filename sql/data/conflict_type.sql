--
-- PostgreSQL database dump
--

SET client_encoding = 'UNICODE';
SET check_function_bodies = false;

SET search_path = public, pg_catalog;

--
-- Data for TOC entry 3 (OID 89143)
-- Name: conflict_type; Type: TABLE DATA; Schema: public; Owner: pentabarf
--

INSERT INTO conflict_type (conflict_type_id, tag) VALUES (1, 'person');
INSERT INTO conflict_type (conflict_type_id, tag) VALUES (2, 'event_person');
INSERT INTO conflict_type (conflict_type_id, tag) VALUES (3, 'event_person_event');
INSERT INTO conflict_type (conflict_type_id, tag) VALUES (4, 'event');
INSERT INTO conflict_type (conflict_type_id, tag) VALUES (5, 'event_event');


--
-- TOC entry 2 (OID 89141)
-- Name: conflict_type_conflict_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pentabarf
--

SELECT pg_catalog.setval('conflict_type_conflict_type_id_seq', 5, true);


