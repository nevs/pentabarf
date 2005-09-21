--
-- PostgreSQL database dump
--

SET client_encoding = 'UNICODE';
SET check_function_bodies = false;

SET search_path = public, pg_catalog;

--
-- Data for TOC entry 3 (OID 66800)
-- Name: event_state; Type: TABLE DATA; Schema: public; Owner: pentabarf
--

INSERT INTO event_state (event_state_id, tag, rank) VALUES (1, 'undecided', 1);
INSERT INTO event_state (event_state_id, tag, rank) VALUES (2, 'accepted', 2);
INSERT INTO event_state (event_state_id, tag, rank) VALUES (3, 'rejected', 3);


--
-- TOC entry 2 (OID 66798)
-- Name: event_state_event_state_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pentabarf
--

SELECT pg_catalog.setval('event_state_event_state_id_seq', 10, true);


