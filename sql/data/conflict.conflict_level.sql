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

INSERT INTO conflict_level (rank, conflict_level) VALUES (1, 'silent');
INSERT INTO conflict_level (rank, conflict_level) VALUES (3, 'warning');
INSERT INTO conflict_level (rank, conflict_level) VALUES (5, 'fatal');
INSERT INTO conflict_level (rank, conflict_level) VALUES (2, 'note');
INSERT INTO conflict_level (rank, conflict_level) VALUES (4, 'error');


--
-- PostgreSQL database dump complete
--

