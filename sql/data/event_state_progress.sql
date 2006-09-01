--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Data for Name: event_state_progress; Type: TABLE DATA; Schema: public; Owner: sven
--

INSERT INTO event_state_progress (event_state, event_state_progress, rank) VALUES ('undecided', 'new', 1);
INSERT INTO event_state_progress (event_state, event_state_progress, rank) VALUES ('undecided', 'review', 2);
INSERT INTO event_state_progress (event_state, event_state_progress, rank) VALUES ('undecided', 'candidate', 3);
INSERT INTO event_state_progress (event_state, event_state_progress, rank) VALUES ('undecided', 'rejection-candidate', 4);
INSERT INTO event_state_progress (event_state, event_state_progress, rank) VALUES ('undecided', 'withdrawn', 5);
INSERT INTO event_state_progress (event_state, event_state_progress, rank) VALUES ('accepted', 'unconfirmed', 6);
INSERT INTO event_state_progress (event_state, event_state_progress, rank) VALUES ('accepted', 'confirmed', 7);
INSERT INTO event_state_progress (event_state, event_state_progress, rank) VALUES ('accepted', 'canceled', 8);
INSERT INTO event_state_progress (event_state, event_state_progress, rank) VALUES ('rejected', 'unconfirmed', 9);
INSERT INTO event_state_progress (event_state, event_state_progress, rank) VALUES ('rejected', 'confirmed', 10);


--
-- PostgreSQL database dump complete
--

