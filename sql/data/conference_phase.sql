--
-- PostgreSQL database dump
--

SET client_encoding = 'UNICODE';
SET check_function_bodies = false;

SET search_path = public, pg_catalog;

--
-- Data for TOC entry 3 (OID 88964)
-- Name: conference_phase; Type: TABLE DATA; Schema: public; Owner: pentabarf
--

INSERT INTO conference_phase (conference_phase_id, tag, rank) VALUES (1, 'chaos', 1);
INSERT INTO conference_phase (conference_phase_id, tag, rank) VALUES (2, 'discord', 2);
INSERT INTO conference_phase (conference_phase_id, tag, rank) VALUES (3, 'confusion', 3);
INSERT INTO conference_phase (conference_phase_id, tag, rank) VALUES (4, 'bureaucracy', 4);
INSERT INTO conference_phase (conference_phase_id, tag, rank) VALUES (5, 'aftermath', 5);


--
-- TOC entry 2 (OID 88962)
-- Name: conference_phase_conference_phase_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pentabarf
--

SELECT pg_catalog.setval('conference_phase_conference_phase_id_seq', 5, true);


