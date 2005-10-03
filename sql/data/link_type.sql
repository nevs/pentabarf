--
-- PostgreSQL database dump
--

SET client_encoding = 'UNICODE';
SET check_function_bodies = false;

SET search_path = public, pg_catalog;

--
-- Data for TOC entry 3 (OID 66405)
-- Name: link_type; Type: TABLE DATA; Schema: public; Owner: pentabarf
--

INSERT INTO link_type (link_type_id, tag, "template", rank) VALUES (3, 'request tracker', 'https://rt.cccv.de/Ticket/Display.html?id=', NULL);
INSERT INTO link_type (link_type_id, tag, "template", rank) VALUES (4, 'orga wiki', 'https://22c3.cccv.de/wiki/', NULL);
INSERT INTO link_type (link_type_id, tag, "template", rank) VALUES (1, 'url', NULL, 1);


--
-- TOC entry 2 (OID 66403)
-- Name: link_type_link_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pentabarf
--

SELECT pg_catalog.setval('link_type_link_type_id_seq', 6, true);


