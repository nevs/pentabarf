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

INSERT INTO link_type (link_type_id, "template", rank, link_type) VALUES (4, 'https://22c3.cccv.de/wiki/', NULL, 'orga wiki');
INSERT INTO link_type (link_type_id, "template", rank, link_type) VALUES (1, NULL, 1, 'url');
INSERT INTO link_type (link_type_id, "template", rank, link_type) VALUES (7, 'https://rt.entheovision.de/Ticket/Display.html?id=', NULL, 'rt entheovision');
INSERT INTO link_type (link_type_id, "template", rank, link_type) VALUES (3, 'https://rt.cccv.de/Ticket/Display.html?id=', NULL, 'rt cccv');


--
-- PostgreSQL database dump complete
--

