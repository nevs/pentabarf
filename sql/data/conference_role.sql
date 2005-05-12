--
-- PostgreSQL database dump
--

SET client_encoding = 'UNICODE';

SET search_path = public, pg_catalog;

--
-- Data for TOC entry 3 (OID 67085)
-- Name: conference_role; Type: TABLE DATA; Schema: public; Owner: pentabarf
--

INSERT INTO conference_role (conference_role_id, tag, rank) VALUES (1, 'coordinator', NULL);


--
-- TOC entry 2 (OID 67083)
-- Name: conference_role_conference_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pentabarf
--

SELECT pg_catalog.setval('conference_role_conference_role_id_seq', 1, true);


