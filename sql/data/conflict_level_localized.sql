--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Data for Name: conflict_level_localized; Type: TABLE DATA; Schema: public; Owner: pentabarf
--

INSERT INTO conflict_level_localized (conflict_level_id, language_id, name) VALUES (2, 120, 'Other notes');
INSERT INTO conflict_level_localized (conflict_level_id, language_id, name) VALUES (2, 144, 'Weitere Hinweise');
INSERT INTO conflict_level_localized (conflict_level_id, language_id, name) VALUES (3, 120, 'Please observe');
INSERT INTO conflict_level_localized (conflict_level_id, language_id, name) VALUES (4, 120, 'Should be fixed');
INSERT INTO conflict_level_localized (conflict_level_id, language_id, name) VALUES (4, 144, 'Sollte behoben werden');
INSERT INTO conflict_level_localized (conflict_level_id, language_id, name) VALUES (5, 120, 'Must be fixed');
INSERT INTO conflict_level_localized (conflict_level_id, language_id, name) VALUES (5, 144, 'Muss behoben werden');
INSERT INTO conflict_level_localized (conflict_level_id, language_id, name) VALUES (3, 144, 'Bitte beachten');
INSERT INTO conflict_level_localized (conflict_level_id, language_id, name) VALUES (1, 120, 'silent');
INSERT INTO conflict_level_localized (conflict_level_id, language_id, name) VALUES (1, 144, 'still');


--
-- PostgreSQL database dump complete
--

