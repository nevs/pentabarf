--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Name: transport_transport_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('transport_transport_id_seq', 1, false);


--
-- Data for Name: transport; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO transport (transport_id, tag, rank) VALUES (1, 'train', NULL);
INSERT INTO transport (transport_id, tag, rank) VALUES (2, 'plane', NULL);
INSERT INTO transport (transport_id, tag, rank) VALUES (3, 'car', NULL);
INSERT INTO transport (transport_id, tag, rank) VALUES (4, 'ufo', NULL);
INSERT INTO transport (transport_id, tag, rank) VALUES (5, 'submarine', NULL);


--
-- PostgreSQL database dump complete
--

