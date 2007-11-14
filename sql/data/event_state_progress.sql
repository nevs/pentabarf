--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Data for Name: event_state_progress; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO event_state_progress (event_state_progress, event_state, rank) VALUES ('new', 'undecided', 1);
INSERT INTO event_state_progress (event_state_progress, event_state, rank) VALUES ('review', 'undecided', 2);
INSERT INTO event_state_progress (event_state_progress, event_state, rank) VALUES ('candidate', 'undecided', 3);
INSERT INTO event_state_progress (event_state_progress, event_state, rank) VALUES ('withdrawn', 'undecided', 4);
INSERT INTO event_state_progress (event_state_progress, event_state, rank) VALUES ('unconfirmed', 'accepted', 1);
INSERT INTO event_state_progress (event_state_progress, event_state, rank) VALUES ('confirmed', 'accepted', 2);
INSERT INTO event_state_progress (event_state_progress, event_state, rank) VALUES ('canceled', 'accepted', 3);
INSERT INTO event_state_progress (event_state_progress, event_state, rank) VALUES ('unconfirmed', 'rejected', 1);
INSERT INTO event_state_progress (event_state_progress, event_state, rank) VALUES ('confirmed', 'rejected', 2);
INSERT INTO event_state_progress (event_state_progress, event_state, rank) VALUES ('rejection-candidate', 'undecided', 5);


--
-- PostgreSQL database dump complete
--

