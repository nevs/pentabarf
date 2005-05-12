--
-- PostgreSQL database dump
--


SET client_encoding = 'UNICODE';

SET search_path = public, pg_catalog;

--
-- Data for TOC entry 3 (OID 66800)
-- Name: event_state; Type: TABLE DATA; Schema: public; Owner: pentabarf
--

INSERT INTO event_state (event_state_id, tag, rank) VALUES (1, 'idea', 1);
INSERT INTO event_state (event_state_id, tag, rank) VALUES (2, 'offering', 2);
INSERT INTO event_state (event_state_id, tag, rank) VALUES (3, 'canceled', 8);
INSERT INTO event_state (event_state_id, tag, rank) VALUES (4, 'declined', 6);
INSERT INTO event_state (event_state_id, tag, rank) VALUES (5, 'confirmed', 4);
INSERT INTO event_state (event_state_id, tag, rank) VALUES (6, 'unclear', 5);
INSERT INTO event_state (event_state_id, tag, rank) VALUES (7, 'accepted', 3);
INSERT INTO event_state (event_state_id, tag, rank) VALUES (8, 'rejected', 7);
INSERT INTO event_state (event_state_id, tag, rank) VALUES (9, 'onhold', NULL);


--
-- TOC entry 2 (OID 66798)
-- Name: event_state_event_state_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pentabarf
--

SELECT pg_catalog.setval('event_state_event_state_id_seq', 9, true);


