--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Data for Name: conference_phase_localized; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO conference_phase_localized (language_id, name, conference_phase) VALUES (144, '[4] Konferenzphase', 'bureaucracy');
INSERT INTO conference_phase_localized (language_id, name, conference_phase) VALUES (120, '[1] Submission Phase', 'chaos');
INSERT INTO conference_phase_localized (language_id, name, conference_phase) VALUES (144, '[1] Abgabephase', 'chaos');
INSERT INTO conference_phase_localized (language_id, name, conference_phase) VALUES (120, '[2] Review Phase', 'discord');
INSERT INTO conference_phase_localized (language_id, name, conference_phase) VALUES (144, '[2] Reviewphase', 'discord');
INSERT INTO conference_phase_localized (language_id, name, conference_phase) VALUES (120, '[3] Scheduling Phase', 'confusion');
INSERT INTO conference_phase_localized (language_id, name, conference_phase) VALUES (144, '[3] Zeitplanungsphase', 'confusion');
INSERT INTO conference_phase_localized (language_id, name, conference_phase) VALUES (120, '[4] Conference Phase', 'bureaucracy');
INSERT INTO conference_phase_localized (language_id, name, conference_phase) VALUES (120, '[5] Postprocessing Phase', 'aftermath');
INSERT INTO conference_phase_localized (language_id, name, conference_phase) VALUES (144, '[5] Nachbearbeitungsphase', 'aftermath');


--
-- PostgreSQL database dump complete
--

