--
-- PostgreSQL database dump
--

SET client_encoding = 'UNICODE';
SET check_function_bodies = false;

SET SESSION AUTHORIZATION 'pentabarf';

SET search_path = public, pg_catalog;

--
-- Data for TOC entry 3 (OID 67017)
-- Name: event_role; Type: TABLE DATA; Schema: public; Owner: pentabarf
--

INSERT INTO event_role (event_role_id, tag, rank) VALUES (1, 'speaker', 1);
INSERT INTO event_role (event_role_id, tag, rank) VALUES (2, 'coordinator', 2);
INSERT INTO event_role (event_role_id, tag, rank) VALUES (3, 'moderator', 3);
INSERT INTO event_role (event_role_id, tag, rank) VALUES (4, 'visitor', 4);
INSERT INTO event_role (event_role_id, tag, rank) VALUES (5, 'reporter', NULL);


--
-- TOC entry 2 (OID 67015)
-- Name: event_role_event_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pentabarf
--

SELECT pg_catalog.setval('event_role_event_role_id_seq', 5, true);


