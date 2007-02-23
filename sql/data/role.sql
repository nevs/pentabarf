--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Name: role_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('role_role_id_seq', 7, true);


--
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO "role" (role_id, tag, rank) VALUES (1, 'developer', 1);
INSERT INTO "role" (role_id, tag, rank) VALUES (2, 'admin', 2);
INSERT INTO "role" (role_id, tag, rank) VALUES (4, 'committee', 3);
INSERT INTO "role" (role_id, tag, rank) VALUES (3, 'reviewer', 4);
INSERT INTO "role" (role_id, tag, rank) VALUES (7, 'submitter', 7);


--
-- PostgreSQL database dump complete
--

