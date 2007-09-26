--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Data for Name: event_state; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO event_state (rank, event_state) VALUES (1, 'undecided');
INSERT INTO event_state (rank, event_state) VALUES (2, 'accepted');
INSERT INTO event_state (rank, event_state) VALUES (3, 'rejected');


--
-- PostgreSQL database dump complete
--

