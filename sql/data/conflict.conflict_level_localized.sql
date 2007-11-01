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

INSERT INTO conflict_level_localized (language_id, name, conflict_level) VALUES (120, 'Other notes', 'note');
INSERT INTO conflict_level_localized (language_id, name, conflict_level) VALUES (144, 'Weitere Hinweise', 'note');
INSERT INTO conflict_level_localized (language_id, name, conflict_level) VALUES (120, 'Please observe', 'warning');
INSERT INTO conflict_level_localized (language_id, name, conflict_level) VALUES (120, 'Should be fixed', 'error');
INSERT INTO conflict_level_localized (language_id, name, conflict_level) VALUES (144, 'Sollte behoben werden', 'error');
INSERT INTO conflict_level_localized (language_id, name, conflict_level) VALUES (120, 'Must be fixed', 'fatal');
INSERT INTO conflict_level_localized (language_id, name, conflict_level) VALUES (144, 'Muss behoben werden', 'fatal');
INSERT INTO conflict_level_localized (language_id, name, conflict_level) VALUES (144, 'Bitte beachten', 'warning');
INSERT INTO conflict_level_localized (language_id, name, conflict_level) VALUES (120, 'silent', 'silent');
INSERT INTO conflict_level_localized (language_id, name, conflict_level) VALUES (144, 'still', 'silent');


--
-- PostgreSQL database dump complete
--

