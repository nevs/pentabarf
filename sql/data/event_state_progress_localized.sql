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

INSERT INTO event_state_progress_localized (event_state, event_state_progress, translated, name) VALUES ('undecided', 'review', 'de', 'In Rezension');
INSERT INTO event_state_progress_localized (event_state, event_state_progress, translated, name) VALUES ('undecided', 'new', 'en', 'Incomplete');
INSERT INTO event_state_progress_localized (event_state, event_state_progress, translated, name) VALUES ('undecided', 'new', 'de', 'Unvollständig');
INSERT INTO event_state_progress_localized (event_state, event_state_progress, translated, name) VALUES ('undecided', 'candidate', 'de', 'Kandidat');
INSERT INTO event_state_progress_localized (event_state, event_state_progress, translated, name) VALUES ('undecided', 'rejection-candidate', 'de', 'Ablehnungskandidat');
INSERT INTO event_state_progress_localized (event_state, event_state_progress, translated, name) VALUES ('accepted', 'confirmed', 'en', 'Confirmed');
INSERT INTO event_state_progress_localized (event_state, event_state_progress, translated, name) VALUES ('accepted', 'confirmed', 'de', 'Bestätigt');
INSERT INTO event_state_progress_localized (event_state, event_state_progress, translated, name) VALUES ('accepted', 'canceled', 'en', 'Canceled');
INSERT INTO event_state_progress_localized (event_state, event_state_progress, translated, name) VALUES ('accepted', 'canceled', 'de', 'Abgesagt');
INSERT INTO event_state_progress_localized (event_state, event_state_progress, translated, name) VALUES ('rejected', 'unconfirmed', 'en', 'Unconfirmed');
INSERT INTO event_state_progress_localized (event_state, event_state_progress, translated, name) VALUES ('rejected', 'unconfirmed', 'de', 'Unbestätigt');
INSERT INTO event_state_progress_localized (event_state, event_state_progress, translated, name) VALUES ('rejected', 'confirmed', 'en', 'Confirmed');
INSERT INTO event_state_progress_localized (event_state, event_state_progress, translated, name) VALUES ('rejected', 'confirmed', 'de', 'Bestätigt');
INSERT INTO event_state_progress_localized (event_state, event_state_progress, translated, name) VALUES ('undecided', 'review', 'en', 'In review');
INSERT INTO event_state_progress_localized (event_state, event_state_progress, translated, name) VALUES ('undecided', 'candidate', 'en', 'Candidate');
INSERT INTO event_state_progress_localized (event_state, event_state_progress, translated, name) VALUES ('undecided', 'rejection-candidate', 'en', 'Rejection candidate');
INSERT INTO event_state_progress_localized (event_state, event_state_progress, translated, name) VALUES ('undecided', 'withdrawn', 'en', 'Withdrawn');
INSERT INTO event_state_progress_localized (event_state, event_state_progress, translated, name) VALUES ('undecided', 'withdrawn', 'de', 'Zurückgezogen');
INSERT INTO event_state_progress_localized (event_state, event_state_progress, translated, name) VALUES ('accepted', 'unconfirmed', 'en', 'Unconfirmed');
INSERT INTO event_state_progress_localized (event_state, event_state_progress, translated, name) VALUES ('accepted', 'unconfirmed', 'de', 'Unbestätigt');


--
-- PostgreSQL database dump complete
--

