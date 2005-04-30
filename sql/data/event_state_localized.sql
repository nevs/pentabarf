--
-- PostgreSQL database dump
--

BEGIN TRANSACTION;

SET client_encoding = 'UNICODE';

SET search_path = public, pg_catalog;

--
-- Data for TOC entry 2 (OID 66807)
-- Name: event_state_localized; Type: TABLE DATA; Schema: public; Owner: pentabarf
--

INSERT INTO event_state_localized (event_state_id, language_id, name) VALUES (1, 144, 'Idee');
INSERT INTO event_state_localized (event_state_id, language_id, name) VALUES (2, 144, 'Eingabe');
INSERT INTO event_state_localized (event_state_id, language_id, name) VALUES (3, 144, 'Abgesagt');
INSERT INTO event_state_localized (event_state_id, language_id, name) VALUES (4, 144, 'Abgelehnt');
INSERT INTO event_state_localized (event_state_id, language_id, name) VALUES (5, 144, 'Akzeptiert (bestätigt)');
INSERT INTO event_state_localized (event_state_id, language_id, name) VALUES (6, 144, 'Unklar');
INSERT INTO event_state_localized (event_state_id, language_id, name) VALUES (7, 144, 'Akzeptiert');
INSERT INTO event_state_localized (event_state_id, language_id, name) VALUES (8, 144, 'Abgelehnt (bestätigt)');
INSERT INTO event_state_localized (event_state_id, language_id, name) VALUES (9, 144, 'Zurückgestellt');
INSERT INTO event_state_localized (event_state_id, language_id, name) VALUES (1, 120, 'Idea');
INSERT INTO event_state_localized (event_state_id, language_id, name) VALUES (2, 120, 'Offering');
INSERT INTO event_state_localized (event_state_id, language_id, name) VALUES (3, 120, 'Canceled');
INSERT INTO event_state_localized (event_state_id, language_id, name) VALUES (4, 120, 'Decline');
INSERT INTO event_state_localized (event_state_id, language_id, name) VALUES (5, 120, 'Accepted (confirmed)');
INSERT INTO event_state_localized (event_state_id, language_id, name) VALUES (6, 120, 'Uncleared');
INSERT INTO event_state_localized (event_state_id, language_id, name) VALUES (7, 120, 'Accepted');
INSERT INTO event_state_localized (event_state_id, language_id, name) VALUES (8, 120, 'Declined (confirmed)');
INSERT INTO event_state_localized (event_state_id, language_id, name) VALUES (9, 120, 'On Hold');

COMMIT TRANSACTION;

