--
-- PostgreSQL database dump
--

SET client_encoding = 'UNICODE';


SET search_path = public, pg_catalog;

--
-- Data for TOC entry 3 (OID 67036)
-- Name: event_role_state; Type: TABLE DATA; Schema: public; Owner: pentabarf
--

INSERT INTO event_role_state (event_role_state_id, event_role_id, tag, rank) VALUES (9, 3, 'idea', 1);
INSERT INTO event_role_state (event_role_state_id, event_role_id, tag, rank) VALUES (10, 3, 'enquired', 2);
INSERT INTO event_role_state (event_role_state_id, event_role_id, tag, rank) VALUES (11, 3, 'canceled', 3);
INSERT INTO event_role_state (event_role_state_id, event_role_id, tag, rank) VALUES (12, 3, 'declined', 4);
INSERT INTO event_role_state (event_role_state_id, event_role_id, tag, rank) VALUES (13, 3, 'confirmed', 5);
INSERT INTO event_role_state (event_role_state_id, event_role_id, tag, rank) VALUES (5, 1, 'confirmed', 5);
INSERT INTO event_role_state (event_role_state_id, event_role_id, tag, rank) VALUES (14, 3, 'unclear', 6);
INSERT INTO event_role_state (event_role_state_id, event_role_id, tag, rank) VALUES (15, 3, 'offer', 7);
INSERT INTO event_role_state (event_role_state_id, event_role_id, tag, rank) VALUES (1, 1, 'idea', 1);
INSERT INTO event_role_state (event_role_state_id, event_role_id, tag, rank) VALUES (2, 1, 'enquired', 2);
INSERT INTO event_role_state (event_role_state_id, event_role_id, tag, rank) VALUES (3, 1, 'canceled', 3);
INSERT INTO event_role_state (event_role_state_id, event_role_id, tag, rank) VALUES (4, 1, 'declined', 4);
INSERT INTO event_role_state (event_role_state_id, event_role_id, tag, rank) VALUES (6, 1, 'unclear', 6);
INSERT INTO event_role_state (event_role_state_id, event_role_id, tag, rank) VALUES (7, 1, 'offer', 7);


--
-- TOC entry 2 (OID 67034)
-- Name: event_role_state_event_role_state_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pentabarf
--

SELECT pg_catalog.setval('event_role_state_event_role_state_id_seq', 15, true);


