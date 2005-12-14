--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Name: event_state_event_state_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pentabarf
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('event_state', 'event_state_id'), 10, true);


--
-- Data for Name: event_state; Type: TABLE DATA; Schema: public; Owner: pentabarf
--

INSERT INTO event_state (event_state_id, tag, rank) VALUES (1, 'undecided', 1);
INSERT INTO event_state (event_state_id, tag, rank) VALUES (2, 'accepted', 2);
INSERT INTO event_state (event_state_id, tag, rank) VALUES (3, 'rejected', 3);


--
-- PostgreSQL database dump complete
--

