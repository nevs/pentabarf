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

INSERT INTO event_role (rank, event_role) VALUES (1, 'speaker');
INSERT INTO event_role (rank, event_role) VALUES (4, 'visitor');
INSERT INTO event_role (rank, event_role) VALUES (NULL, 'reporter');
INSERT INTO event_role (rank, event_role) VALUES (NULL, 'reviewer');
INSERT INTO event_role (rank, event_role) VALUES (NULL, 'attendee');
INSERT INTO event_role (rank, event_role) VALUES (NULL, 'submitter');
INSERT INTO event_role (rank, event_role) VALUES (2, 'moderator');
INSERT INTO event_role (rank, event_role) VALUES (3, 'coordinator');


--
-- PostgreSQL database dump complete
--

