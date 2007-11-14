--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Data for Name: event_role; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO event_role (event_role, rank) VALUES ('speaker', 1);
INSERT INTO event_role (event_role, rank) VALUES ('visitor', 4);
INSERT INTO event_role (event_role, rank) VALUES ('reporter', NULL);
INSERT INTO event_role (event_role, rank) VALUES ('reviewer', NULL);
INSERT INTO event_role (event_role, rank) VALUES ('attendee', NULL);
INSERT INTO event_role (event_role, rank) VALUES ('submitter', NULL);
INSERT INTO event_role (event_role, rank) VALUES ('moderator', 2);
INSERT INTO event_role (event_role, rank) VALUES ('coordinator', 3);


--
-- PostgreSQL database dump complete
--

