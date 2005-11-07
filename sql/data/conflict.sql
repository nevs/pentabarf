--
-- PostgreSQL database dump
--

SET client_encoding = 'UNICODE';
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Name: conflict_conflict_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pentabarf
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('conflict', 'conflict_id'), 16, true);


--
-- Data for Name: conflict; Type: TABLE DATA; Schema: public; Owner: pentabarf
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
INSERT INTO conflict (conflict_id, conflict_type_id, tag) VALUES (14, 4, 'event_no_language');
INSERT INTO conflict (conflict_id, conflict_type_id, tag) VALUES (15, 4, 'event_no_track');
INSERT INTO conflict (conflict_id, conflict_type_id, tag) VALUES (16, 3, 'event_person_event_time_visitor');


--
-- PostgreSQL database dump complete
--

