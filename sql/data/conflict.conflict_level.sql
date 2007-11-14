--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = conflict, pg_catalog;

--
-- Data for Name: conflict_level; Type: TABLE DATA; Schema: conflict; Owner: -
--

INSERT INTO conflict_level (conflict_level, rank) VALUES ('silent', 1);
INSERT INTO conflict_level (conflict_level, rank) VALUES ('warning', 3);
INSERT INTO conflict_level (conflict_level, rank) VALUES ('fatal', 5);
INSERT INTO conflict_level (conflict_level, rank) VALUES ('note', 2);
INSERT INTO conflict_level (conflict_level, rank) VALUES ('error', 4);


--
-- PostgreSQL database dump complete
--

