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

INSERT INTO conference_phase_localized (conference_phase, translated, name) VALUES ('bureaucracy', 'de', '[4] Konferenzphase');
INSERT INTO conference_phase_localized (conference_phase, translated, name) VALUES ('chaos', 'en', '[1] Submission Phase');
INSERT INTO conference_phase_localized (conference_phase, translated, name) VALUES ('chaos', 'de', '[1] Abgabephase');
INSERT INTO conference_phase_localized (conference_phase, translated, name) VALUES ('discord', 'en', '[2] Review Phase');
INSERT INTO conference_phase_localized (conference_phase, translated, name) VALUES ('discord', 'de', '[2] Reviewphase');
INSERT INTO conference_phase_localized (conference_phase, translated, name) VALUES ('confusion', 'en', '[3] Scheduling Phase');
INSERT INTO conference_phase_localized (conference_phase, translated, name) VALUES ('confusion', 'de', '[3] Zeitplanungsphase');
INSERT INTO conference_phase_localized (conference_phase, translated, name) VALUES ('bureaucracy', 'en', '[4] Conference Phase');
INSERT INTO conference_phase_localized (conference_phase, translated, name) VALUES ('aftermath', 'en', '[5] Postprocessing Phase');
INSERT INTO conference_phase_localized (conference_phase, translated, name) VALUES ('aftermath', 'de', '[5] Nachbearbeitungsphase');


--
-- PostgreSQL database dump complete
--

