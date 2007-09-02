--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Name: link_type_link_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('link_type_link_type_id_seq', 7, true);


--
-- Data for Name: link_type; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO link_type (link_type_id, tag, "template", rank) VALUES (4, 'orga wiki', 'https://22c3.cccv.de/wiki/', NULL);
INSERT INTO link_type (link_type_id, tag, "template", rank) VALUES (1, 'url', NULL, 1);
INSERT INTO link_type (link_type_id, tag, "template", rank) VALUES (7, 'rt entheovision', 'https://rt.entheovision.de/Ticket/Display.html?id=', NULL);
INSERT INTO link_type (link_type_id, tag, "template", rank) VALUES (3, 'rt cccv', 'https://rt.cccv.de/Ticket/Display.html?id=', NULL);


--
-- PostgreSQL database dump complete
--

