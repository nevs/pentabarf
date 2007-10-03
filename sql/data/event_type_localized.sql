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

INSERT INTO event_type_localized (language_id, name, event_type) VALUES (120, 'Lecture', 'lecture');
INSERT INTO event_type_localized (language_id, name, event_type) VALUES (120, 'Workshop', 'workshop');
INSERT INTO event_type_localized (language_id, name, event_type) VALUES (120, 'Movie', 'movie');
INSERT INTO event_type_localized (language_id, name, event_type) VALUES (120, 'Podium', 'podium');
INSERT INTO event_type_localized (language_id, name, event_type) VALUES (120, 'Meeting', 'meeting');
INSERT INTO event_type_localized (language_id, name, event_type) VALUES (120, 'Other', 'other');
INSERT INTO event_type_localized (language_id, name, event_type) VALUES (144, 'Podium', 'podium');
INSERT INTO event_type_localized (language_id, name, event_type) VALUES (144, 'Treffen', 'meeting');
INSERT INTO event_type_localized (language_id, name, event_type) VALUES (144, 'Sonstiges', 'other');
INSERT INTO event_type_localized (language_id, name, event_type) VALUES (144, 'Vortrag', 'lecture');
INSERT INTO event_type_localized (language_id, name, event_type) VALUES (144, 'Workshop', 'workshop');
INSERT INTO event_type_localized (language_id, name, event_type) VALUES (144, 'Film', 'movie');
INSERT INTO event_type_localized (language_id, name, event_type) VALUES (120, 'Lightning-Talk', 'lightning');
INSERT INTO event_type_localized (language_id, name, event_type) VALUES (144, 'Lightning-Talk', 'lightning');
INSERT INTO event_type_localized (language_id, name, event_type) VALUES (120, 'Contest', 'contest');
INSERT INTO event_type_localized (language_id, name, event_type) VALUES (144, 'Wettkampf', 'contest');


--
-- PostgreSQL database dump complete
--

