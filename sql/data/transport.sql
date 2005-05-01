--
-- PostgreSQL database dump
--

BEGIN TRANSACTION;

SET client_encoding = 'UNICODE';

SET search_path = public, pg_catalog;

--
-- Data for TOC entry 3 (OID 66189)
-- Name: transport; Type: TABLE DATA; Schema: public; Owner: pentabarf
--

INSERT INTO transport (transport_id, tag, rank) VALUES (1, 'train', NULL);
INSERT INTO transport (transport_id, tag, rank) VALUES (2, 'plane', NULL);
INSERT INTO transport (transport_id, tag, rank) VALUES (3, 'car', NULL);
INSERT INTO transport (transport_id, tag, rank) VALUES (4, 'ufo', NULL);
INSERT INTO transport (transport_id, tag, rank) VALUES (5, 'submarine', NULL);


--
-- TOC entry 2 (OID 66187)
-- Name: transport_transport_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pentabarf
--

SELECT pg_catalog.setval('transport_transport_id_seq', 1, false);

COMMIT TRANSACTION;

