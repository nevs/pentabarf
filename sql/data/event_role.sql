--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Data for Name: event_role; Type: TABLE DATA; Schema: public; Owner: sven
--

INSERT INTO event_role (event_role, public, rank) VALUES ('speaker', true, NULL);
INSERT INTO event_role (event_role, public, rank) VALUES ('moderator', true, NULL);
INSERT INTO event_role (event_role, public, rank) VALUES ('coordinator', false, NULL);
INSERT INTO event_role (event_role, public, rank) VALUES ('visitor', false, NULL);


--
-- PostgreSQL database dump complete
--

