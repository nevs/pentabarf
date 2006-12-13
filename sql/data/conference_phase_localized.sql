--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Data for Name: conference_phase_localized; Type: TABLE DATA; Schema: public; Owner: sven
--

INSERT INTO conference_phase_localized (conference_phase, translated, name) VALUES ('chaos', 'eng', '[1] Submission Phase');
INSERT INTO conference_phase_localized (conference_phase, translated, name) VALUES ('discord', 'eng', '[2] Review Phase');
INSERT INTO conference_phase_localized (conference_phase, translated, name) VALUES ('confusion', 'eng', '[3] Scheduling Phase');
INSERT INTO conference_phase_localized (conference_phase, translated, name) VALUES ('bureaucracy', 'eng', '[4] Conference Phase');
INSERT INTO conference_phase_localized (conference_phase, translated, name) VALUES ('aftermath', 'eng', '[5] Postprocessing Phase');
INSERT INTO conference_phase_localized (conference_phase, translated, name) VALUES ('chaos', 'ger', '[1] Abgabephase');
INSERT INTO conference_phase_localized (conference_phase, translated, name) VALUES ('discord', 'ger', '[2] Reviewphase');
INSERT INTO conference_phase_localized (conference_phase, translated, name) VALUES ('confusion', 'ger', '[3] Zeitplanungsphase');
INSERT INTO conference_phase_localized (conference_phase, translated, name) VALUES ('bureaucracy', 'ger', '[4] Konferenzphase');
INSERT INTO conference_phase_localized (conference_phase, translated, name) VALUES ('aftermath', 'ger', '[5] Nachbearbeitungsphase');


--
-- PostgreSQL database dump complete
--

