--
-- PostgreSQL database dump
--

SET client_encoding = 'UNICODE';
SET check_function_bodies = false;

SET search_path = public, pg_catalog;

--
-- Data for TOC entry 3 (OID 66821)
-- Name: event_type; Type: TABLE DATA; Schema: public; Owner: pentabarf
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
-- TOC entry 2 (OID 66819)
-- Name: event_type_event_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pentabarf
--

SELECT pg_catalog.setval('event_type_event_type_id_seq', 10, true);


