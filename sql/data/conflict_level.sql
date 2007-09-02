--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Name: conflict_level_conflict_level_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('conflict_level_conflict_level_id_seq', 5, true);


--
-- Data for Name: conflict_level; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO conflict_level (conflict_level_id, tag, rank) VALUES (1, 'silent', 1);
INSERT INTO conflict_level (conflict_level_id, tag, rank) VALUES (3, 'warning', 3);
INSERT INTO conflict_level (conflict_level_id, tag, rank) VALUES (5, 'fatal', 5);
INSERT INTO conflict_level (conflict_level_id, tag, rank) VALUES (2, 'note', 2);
INSERT INTO conflict_level (conflict_level_id, tag, rank) VALUES (4, 'error', 4);


--
-- PostgreSQL database dump complete
--

