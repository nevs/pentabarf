--
-- PostgreSQL database dump
--

SET client_encoding = 'UNICODE';
SET check_function_bodies = false;

SET search_path = public, pg_catalog;

--
-- Data for TOC entry 3 (OID 86870)
-- Name: event_state_progress; Type: TABLE DATA; Schema: public; Owner: pentabarf
--

INSERT INTO event_state_progress (event_state_progress_id, event_state_id, tag, rank) VALUES (1, 1, 'new', 1);
INSERT INTO event_state_progress (event_state_progress_id, event_state_id, tag, rank) VALUES (2, 1, 'review', 2);
INSERT INTO event_state_progress (event_state_progress_id, event_state_id, tag, rank) VALUES (3, 1, 'candidate', 3);
INSERT INTO event_state_progress (event_state_progress_id, event_state_id, tag, rank) VALUES (4, 1, 'withdrawn', 4);
INSERT INTO event_state_progress (event_state_progress_id, event_state_id, tag, rank) VALUES (5, 2, 'unconfirmed', 1);
INSERT INTO event_state_progress (event_state_progress_id, event_state_id, tag, rank) VALUES (6, 2, 'confirmed', 2);
INSERT INTO event_state_progress (event_state_progress_id, event_state_id, tag, rank) VALUES (7, 2, 'canceled', 3);
INSERT INTO event_state_progress (event_state_progress_id, event_state_id, tag, rank) VALUES (8, 3, 'unconfirmed', 1);
INSERT INTO event_state_progress (event_state_progress_id, event_state_id, tag, rank) VALUES (9, 3, 'confirmed', 2);


--
-- TOC entry 2 (OID 86868)
-- Name: event_state_progress_event_state_progress_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pentabarf
--

SELECT pg_catalog.setval('event_state_progress_event_state_progress_id_seq', 9, true);


