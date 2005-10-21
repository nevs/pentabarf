--
-- PostgreSQL database dump
--

SET client_encoding = 'UNICODE';
SET check_function_bodies = false;

SET search_path = public, pg_catalog;

--
-- Data for TOC entry 3 (OID 89152)
-- Name: conflict; Type: TABLE DATA; Schema: public; Owner: pentabarf
--

INSERT INTO conflict (conflict_id, conflict_type_id, tag) VALUES (1, 1, 'person_no_email');
INSERT INTO conflict (conflict_id, conflict_type_id, tag) VALUES (2, 2, 'event_person_language');
INSERT INTO conflict (conflict_id, conflict_type_id, tag) VALUES (3, 3, 'event_person_event_time');
INSERT INTO conflict (conflict_id, conflict_type_id, tag) VALUES (4, 4, 'event_no_speaker');
INSERT INTO conflict (conflict_id, conflict_type_id, tag) VALUES (5, 4, 'event_no_coordinator');
INSERT INTO conflict (conflict_id, conflict_type_id, tag) VALUES (6, 4, 'event_incomplete');
INSERT INTO conflict (conflict_id, conflict_type_id, tag) VALUES (7, 5, 'event_event_time');
INSERT INTO conflict (conflict_id, conflict_type_id, tag) VALUES (8, 4, 'event_missing_tag');
INSERT INTO conflict (conflict_id, conflict_type_id, tag) VALUES (11, 4, 'event_no_paper');
INSERT INTO conflict (conflict_id, conflict_type_id, tag) VALUES (12, 4, 'event_inconsistent_public_link');
INSERT INTO conflict (conflict_id, conflict_type_id, tag) VALUES (9, 5, 'event_event_duplicate_tag');
INSERT INTO conflict (conflict_id, conflict_type_id, tag) VALUES (10, 4, 'event_inconsistent_tag');
INSERT INTO conflict (conflict_id, conflict_type_id, tag) VALUES (13, 1, 'person_inconsistent_public_link');


--
-- TOC entry 2 (OID 89150)
-- Name: conflict_conflict_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pentabarf
--

SELECT pg_catalog.setval('conflict_conflict_id_seq', 13, true);


