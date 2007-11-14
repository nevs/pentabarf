--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = conflict, pg_catalog;

--
-- Data for Name: conflict_level_localized; Type: TABLE DATA; Schema: conflict; Owner: -
--

INSERT INTO conflict_level_localized (conflict_level, translated, name) VALUES ('note', 'en', 'Other notes');
INSERT INTO conflict_level_localized (conflict_level, translated, name) VALUES ('note', 'de', 'Weitere Hinweise');
INSERT INTO conflict_level_localized (conflict_level, translated, name) VALUES ('warning', 'en', 'Please observe');
INSERT INTO conflict_level_localized (conflict_level, translated, name) VALUES ('error', 'en', 'Should be fixed');
INSERT INTO conflict_level_localized (conflict_level, translated, name) VALUES ('error', 'de', 'Sollte behoben werden');
INSERT INTO conflict_level_localized (conflict_level, translated, name) VALUES ('fatal', 'en', 'Must be fixed');
INSERT INTO conflict_level_localized (conflict_level, translated, name) VALUES ('fatal', 'de', 'Muss behoben werden');
INSERT INTO conflict_level_localized (conflict_level, translated, name) VALUES ('warning', 'de', 'Bitte beachten');
INSERT INTO conflict_level_localized (conflict_level, translated, name) VALUES ('silent', 'en', 'silent');
INSERT INTO conflict_level_localized (conflict_level, translated, name) VALUES ('silent', 'de', 'still');


--
-- PostgreSQL database dump complete
--

