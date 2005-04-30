--
-- PostgreSQL database dump
--

BEGIN TRANSACTION;

SET client_encoding = 'UNICODE';

SET search_path = public, pg_catalog;

--
-- Data for TOC entry 3 (OID 66234)
-- Name: role; Type: TABLE DATA; Schema: public; Owner: pentabarf
--

INSERT INTO role (role_id, tag, rank) VALUES (1, 'developer', 1);
INSERT INTO role (role_id, tag, rank) VALUES (2, 'admin', 2);
INSERT INTO role (role_id, tag, rank) VALUES (4, 'committee', 3);
INSERT INTO role (role_id, tag, rank) VALUES (3, 'reviewer', 4);
INSERT INTO role (role_id, tag, rank) VALUES (5, 'speaker', 5);
INSERT INTO role (role_id, tag, rank) VALUES (6, 'visitor', 6);


--
-- TOC entry 2 (OID 66232)
-- Name: role_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pentabarf
--

SELECT pg_catalog.setval('role_role_id_seq', 6, true);

COMMIT TRANSACTION;

