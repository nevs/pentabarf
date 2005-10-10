--
-- PostgreSQL database dump
--

SET client_encoding = 'UNICODE';
SET check_function_bodies = false;

SET search_path = public, pg_catalog;

--
-- Data for TOC entry 3 (OID 66382)
-- Name: time_zone; Type: TABLE DATA; Schema: public; Owner: pentabarf
--

INSERT INTO time_zone (time_zone_id, tag, f_visible, f_preferred) VALUES (1, 'utc', false, false);
INSERT INTO time_zone (time_zone_id, tag, f_visible, f_preferred) VALUES (2, 'utc+1', false, false);
INSERT INTO time_zone (time_zone_id, tag, f_visible, f_preferred) VALUES (3, 'utc+2', false, false);


--
-- TOC entry 2 (OID 66380)
-- Name: time_zone_time_zone_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pentabarf
--

SELECT pg_catalog.setval('time_zone_time_zone_id_seq', 3, true);


