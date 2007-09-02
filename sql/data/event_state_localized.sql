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

INSERT INTO event_state_localized (event_state_id, language_id, name) VALUES (1, 120, 'Undecided');
INSERT INTO event_state_localized (event_state_id, language_id, name) VALUES (1, 144, 'Unentschieden');
INSERT INTO event_state_localized (event_state_id, language_id, name) VALUES (2, 120, 'Accepted');
INSERT INTO event_state_localized (event_state_id, language_id, name) VALUES (2, 144, 'Akzeptiert');
INSERT INTO event_state_localized (event_state_id, language_id, name) VALUES (3, 120, 'Rejected');
INSERT INTO event_state_localized (event_state_id, language_id, name) VALUES (3, 144, 'Abgelehnt');


--
-- PostgreSQL database dump complete
--

