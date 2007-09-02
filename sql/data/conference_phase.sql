--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Name: conference_phase_conference_phase_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('conference_phase_conference_phase_id_seq', 5, true);


--
-- Data for Name: conference_phase; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO conference_phase (conference_phase_id, tag, rank) VALUES (1, 'chaos', 1);
INSERT INTO conference_phase (conference_phase_id, tag, rank) VALUES (2, 'discord', 2);
INSERT INTO conference_phase (conference_phase_id, tag, rank) VALUES (3, 'confusion', 3);
INSERT INTO conference_phase (conference_phase_id, tag, rank) VALUES (4, 'bureaucracy', 4);
INSERT INTO conference_phase (conference_phase_id, tag, rank) VALUES (5, 'aftermath', 5);


--
-- PostgreSQL database dump complete
--

