--
-- PostgreSQL database dump
--

BEGIN TRANSACTION;

SET client_encoding = 'UNICODE';

SET search_path = public, pg_catalog;

--
-- Data for TOC entry 3 (OID 66405)
-- Name: link_type; Type: TABLE DATA; Schema: public; Owner: pentabarf
--

INSERT INTO link_type (link_type_id, tag, url_prefix, f_public, rank) VALUES (1, 'public link', NULL, true, NULL);
INSERT INTO link_type (link_type_id, tag, url_prefix, f_public, rank) VALUES (2, 'weblog', NULL, true, NULL);
INSERT INTO link_type (link_type_id, tag, url_prefix, f_public, rank) VALUES (3, 'request tracker', NULL, false, NULL);
INSERT INTO link_type (link_type_id, tag, url_prefix, f_public, rank) VALUES (4, 'orga wiki', NULL, false, NULL);
INSERT INTO link_type (link_type_id, tag, url_prefix, f_public, rank) VALUES (5, 'documentation', NULL, false, NULL);
INSERT INTO link_type (link_type_id, tag, url_prefix, f_public, rank) VALUES (6, 'document', NULL, false, NULL);


--
-- TOC entry 2 (OID 66403)
-- Name: link_type_link_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pentabarf
--

SELECT pg_catalog.setval('link_type_link_type_id_seq', 6, true);

COMMIT TRANSACTION;

