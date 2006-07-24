--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Name: event_state_progress_event_state_progress_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pentabarf
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('event_state_progress', 'event_state_progress_id'), 10, true);


--
-- Data for Name: event_state_progress; Type: TABLE DATA; Schema: public; Owner: pentabarf
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
INSERT INTO event_state_progress (event_state_progress_id, event_state_id, tag, rank) VALUES (10, 1, 'rejection-candidate', 5);


--
-- PostgreSQL database dump complete
--

