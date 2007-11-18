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

INSERT INTO event_state (event_state, rank) VALUES ('undecided', 1);
INSERT INTO event_state (event_state, rank) VALUES ('accepted', 2);
INSERT INTO event_state (event_state, rank) VALUES ('rejected', 3);


--
-- PostgreSQL database dump complete
--

