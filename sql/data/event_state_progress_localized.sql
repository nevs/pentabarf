--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Data for Name: event_state_progress_localized; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO event_state_progress_localized (language_id, name, event_state, event_state_progress) VALUES (144, 'In Rezension', 'undecided', 'review');
INSERT INTO event_state_progress_localized (language_id, name, event_state, event_state_progress) VALUES (120, 'Incomplete', 'undecided', 'new');
INSERT INTO event_state_progress_localized (language_id, name, event_state, event_state_progress) VALUES (144, 'Unvollständig', 'undecided', 'new');
INSERT INTO event_state_progress_localized (language_id, name, event_state, event_state_progress) VALUES (144, 'Kandidat', 'undecided', 'candidate');
INSERT INTO event_state_progress_localized (language_id, name, event_state, event_state_progress) VALUES (144, 'Ablehnungskandidat', 'undecided', 'rejection-candidate');
INSERT INTO event_state_progress_localized (language_id, name, event_state, event_state_progress) VALUES (120, 'Confirmed', 'accepted', 'confirmed');
INSERT INTO event_state_progress_localized (language_id, name, event_state, event_state_progress) VALUES (144, 'Bestätigt', 'accepted', 'confirmed');
INSERT INTO event_state_progress_localized (language_id, name, event_state, event_state_progress) VALUES (120, 'Canceled', 'accepted', 'canceled');
INSERT INTO event_state_progress_localized (language_id, name, event_state, event_state_progress) VALUES (144, 'Abgesagt', 'accepted', 'canceled');
INSERT INTO event_state_progress_localized (language_id, name, event_state, event_state_progress) VALUES (120, 'Unconfirmed', 'rejected', 'unconfirmed');
INSERT INTO event_state_progress_localized (language_id, name, event_state, event_state_progress) VALUES (144, 'Unbestätigt', 'rejected', 'unconfirmed');
INSERT INTO event_state_progress_localized (language_id, name, event_state, event_state_progress) VALUES (120, 'Confirmed', 'rejected', 'confirmed');
INSERT INTO event_state_progress_localized (language_id, name, event_state, event_state_progress) VALUES (144, 'Bestätigt', 'rejected', 'confirmed');
INSERT INTO event_state_progress_localized (language_id, name, event_state, event_state_progress) VALUES (120, 'In review', 'undecided', 'review');
INSERT INTO event_state_progress_localized (language_id, name, event_state, event_state_progress) VALUES (120, 'Candidate', 'undecided', 'candidate');
INSERT INTO event_state_progress_localized (language_id, name, event_state, event_state_progress) VALUES (120, 'Rejection candidate', 'undecided', 'rejection-candidate');
INSERT INTO event_state_progress_localized (language_id, name, event_state, event_state_progress) VALUES (120, 'Withdrawn', 'undecided', 'withdrawn');
INSERT INTO event_state_progress_localized (language_id, name, event_state, event_state_progress) VALUES (144, 'Zurückgezogen', 'undecided', 'withdrawn');
INSERT INTO event_state_progress_localized (language_id, name, event_state, event_state_progress) VALUES (120, 'Unconfirmed', 'accepted', 'unconfirmed');
INSERT INTO event_state_progress_localized (language_id, name, event_state, event_state_progress) VALUES (144, 'Unbestätigt', 'accepted', 'unconfirmed');


--
-- PostgreSQL database dump complete
--

