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

INSERT INTO event_state_progress (event_state, event_state_progress) VALUES ('undecided', 'new');
INSERT INTO event_state_progress (event_state, event_state_progress) VALUES ('undecided', 'review');
INSERT INTO event_state_progress (event_state, event_state_progress) VALUES ('undecided', 'candidate');
INSERT INTO event_state_progress (event_state, event_state_progress) VALUES ('undecided', 'withdrawn');
INSERT INTO event_state_progress (event_state, event_state_progress) VALUES ('accepted', 'unconfirmed');
INSERT INTO event_state_progress (event_state, event_state_progress) VALUES ('accepted', 'confirmed');
INSERT INTO event_state_progress (event_state, event_state_progress) VALUES ('accepted', 'canceled');
INSERT INTO event_state_progress (event_state, event_state_progress) VALUES ('rejected', 'confirmed');
INSERT INTO event_state_progress (event_state, event_state_progress) VALUES ('rejected', 'unconfirmed');
INSERT INTO event_state_progress (event_state, event_state_progress) VALUES ('undecided', 'rejection-candidate');


--
-- PostgreSQL database dump complete
--

