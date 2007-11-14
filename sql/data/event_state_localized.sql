--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Data for Name: event_state_localized; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO event_state_localized (event_state, translated, name) VALUES ('undecided', 'en', 'Undecided');
INSERT INTO event_state_localized (event_state, translated, name) VALUES ('undecided', 'de', 'Unentschieden');
INSERT INTO event_state_localized (event_state, translated, name) VALUES ('accepted', 'en', 'Accepted');
INSERT INTO event_state_localized (event_state, translated, name) VALUES ('accepted', 'de', 'Akzeptiert');
INSERT INTO event_state_localized (event_state, translated, name) VALUES ('rejected', 'en', 'Rejected');
INSERT INTO event_state_localized (event_state, translated, name) VALUES ('rejected', 'de', 'Abgelehnt');


--
-- PostgreSQL database dump complete
--

