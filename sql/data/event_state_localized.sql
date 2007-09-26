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

INSERT INTO event_state_localized (language_id, name, event_state) VALUES (120, 'Undecided', 'undecided');
INSERT INTO event_state_localized (language_id, name, event_state) VALUES (144, 'Unentschieden', 'undecided');
INSERT INTO event_state_localized (language_id, name, event_state) VALUES (120, 'Accepted', 'accepted');
INSERT INTO event_state_localized (language_id, name, event_state) VALUES (144, 'Akzeptiert', 'accepted');
INSERT INTO event_state_localized (language_id, name, event_state) VALUES (120, 'Rejected', 'rejected');
INSERT INTO event_state_localized (language_id, name, event_state) VALUES (144, 'Abgelehnt', 'rejected');


--
-- PostgreSQL database dump complete
--

