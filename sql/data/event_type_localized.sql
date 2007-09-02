--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Data for Name: event_type_localized; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO event_type_localized (event_type_id, language_id, name) VALUES (1, 120, 'Lecture');
INSERT INTO event_type_localized (event_type_id, language_id, name) VALUES (3, 120, 'Workshop');
INSERT INTO event_type_localized (event_type_id, language_id, name) VALUES (4, 120, 'Movie');
INSERT INTO event_type_localized (event_type_id, language_id, name) VALUES (6, 120, 'Podium');
INSERT INTO event_type_localized (event_type_id, language_id, name) VALUES (7, 120, 'Meeting');
INSERT INTO event_type_localized (event_type_id, language_id, name) VALUES (8, 120, 'Other');
INSERT INTO event_type_localized (event_type_id, language_id, name) VALUES (6, 144, 'Podium');
INSERT INTO event_type_localized (event_type_id, language_id, name) VALUES (7, 144, 'Treffen');
INSERT INTO event_type_localized (event_type_id, language_id, name) VALUES (8, 144, 'Sonstiges');
INSERT INTO event_type_localized (event_type_id, language_id, name) VALUES (1, 144, 'Vortrag');
INSERT INTO event_type_localized (event_type_id, language_id, name) VALUES (3, 144, 'Workshop');
INSERT INTO event_type_localized (event_type_id, language_id, name) VALUES (4, 144, 'Film');
INSERT INTO event_type_localized (event_type_id, language_id, name) VALUES (9, 120, 'Lightning-Talk');
INSERT INTO event_type_localized (event_type_id, language_id, name) VALUES (9, 144, 'Lightning-Talk');
INSERT INTO event_type_localized (event_type_id, language_id, name) VALUES (10, 120, 'Contest');
INSERT INTO event_type_localized (event_type_id, language_id, name) VALUES (10, 144, 'Wettkampf');


--
-- PostgreSQL database dump complete
--

