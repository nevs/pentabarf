--
-- PostgreSQL database dump
--

SET client_encoding = 'UNICODE';
SET check_function_bodies = false;

SET search_path = public, pg_catalog;

--
-- Data for TOC entry 3 (OID 66210)
-- Name: ui_message; Type: TABLE DATA; Schema: public; Owner: pentabarf
--

INSERT INTO ui_message (ui_message_id, tag) VALUES (1, 'link::startpage');
INSERT INTO ui_message (ui_message_id, tag) VALUES (2, 'link::recent_changes');
INSERT INTO ui_message (ui_message_id, tag) VALUES (3, 'link::reports');
INSERT INTO ui_message (ui_message_id, tag) VALUES (4, 'link::conflicts');
INSERT INTO ui_message (ui_message_id, tag) VALUES (5, 'link::preferences');
INSERT INTO ui_message (ui_message_id, tag) VALUES (6, 'link::find_person');
INSERT INTO ui_message (ui_message_id, tag) VALUES (7, 'link::find_event');
INSERT INTO ui_message (ui_message_id, tag) VALUES (8, 'link::find_conference');
INSERT INTO ui_message (ui_message_id, tag) VALUES (9, 'link::new_person');
INSERT INTO ui_message (ui_message_id, tag) VALUES (10, 'link::new_event');
INSERT INTO ui_message (ui_message_id, tag) VALUES (11, 'link::new_conference');
INSERT INTO ui_message (ui_message_id, tag) VALUES (12, 'link::pentabarf_wiki');
INSERT INTO ui_message (ui_message_id, tag) VALUES (13, 'link::pentabarf_bugtracker');
INSERT INTO ui_message (ui_message_id, tag) VALUES (14, 'sidebar::find');
INSERT INTO ui_message (ui_message_id, tag) VALUES (15, 'sidebar::new');
INSERT INTO ui_message (ui_message_id, tag) VALUES (16, 'form::cancel');
INSERT INTO ui_message (ui_message_id, tag) VALUES (17, 'form::save');
INSERT INTO ui_message (ui_message_id, tag) VALUES (18, 'view_person::tab_general');
INSERT INTO ui_message (ui_message_id, tag) VALUES (19, 'view_person::tab_events');
INSERT INTO ui_message (ui_message_id, tag) VALUES (20, 'view_person::tab_contact');
INSERT INTO ui_message (ui_message_id, tag) VALUES (21, 'view_person::tab_description');
INSERT INTO ui_message (ui_message_id, tag) VALUES (22, 'view_person::tab_links');
INSERT INTO ui_message (ui_message_id, tag) VALUES (23, 'view_person::tab_rating');
INSERT INTO ui_message (ui_message_id, tag) VALUES (24, 'view_person::tab_travel');
INSERT INTO ui_message (ui_message_id, tag) VALUES (25, 'view_person::tab_account');
INSERT INTO ui_message (ui_message_id, tag) VALUES (26, 'view_home::tab_participant');
INSERT INTO ui_message (ui_message_id, tag) VALUES (27, 'view_home::tab_coordinator');
INSERT INTO ui_message (ui_message_id, tag) VALUES (28, 'view_find_person::tab_simple');
INSERT INTO ui_message (ui_message_id, tag) VALUES (29, 'view_find_person::tab_advanced');
INSERT INTO ui_message (ui_message_id, tag) VALUES (30, 'view_find_event::tab_simple');
INSERT INTO ui_message (ui_message_id, tag) VALUES (31, 'view_find_event::tab_advanced');
INSERT INTO ui_message (ui_message_id, tag) VALUES (32, 'view_find_conference::tab_simple');
INSERT INTO ui_message (ui_message_id, tag) VALUES (33, 'view_find_conference::tab_advanced');
INSERT INTO ui_message (ui_message_id, tag) VALUES (34, 'view_conference::tab_general');
INSERT INTO ui_message (ui_message_id, tag) VALUES (35, 'view_conference::tab_persons');
INSERT INTO ui_message (ui_message_id, tag) VALUES (36, 'view_conference::tab_tracks');
INSERT INTO ui_message (ui_message_id, tag) VALUES (37, 'view_conference::tab_rooms');
INSERT INTO ui_message (ui_message_id, tag) VALUES (38, 'view_conference::tab_events');
INSERT INTO ui_message (ui_message_id, tag) VALUES (39, 'view_conference::tab_export');
INSERT INTO ui_message (ui_message_id, tag) VALUES (40, 'view_conference::tab_feedback');
INSERT INTO ui_message (ui_message_id, tag) VALUES (41, 'view_event::tab_general');
INSERT INTO ui_message (ui_message_id, tag) VALUES (42, 'view_event::tab_persons');
INSERT INTO ui_message (ui_message_id, tag) VALUES (43, 'view_event::tab_description');
INSERT INTO ui_message (ui_message_id, tag) VALUES (44, 'view_event::tab_links');
INSERT INTO ui_message (ui_message_id, tag) VALUES (45, 'view_event::tab_rating');
INSERT INTO ui_message (ui_message_id, tag) VALUES (46, 'view_event::tab_resources');
INSERT INTO ui_message (ui_message_id, tag) VALUES (47, 'view_event::tab_related');
INSERT INTO ui_message (ui_message_id, tag) VALUES (48, 'view_event::tab_feedback');


--
-- TOC entry 2 (OID 66208)
-- Name: ui_message_ui_message_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pentabarf
--

SELECT pg_catalog.setval('ui_message_ui_message_id_seq', 48, true);


