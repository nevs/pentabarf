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

INSERT INTO ui_message (ui_message_id, tag) VALUES (49, 'link::conflict_setup');
INSERT INTO ui_message (ui_message_id, tag) VALUES (50, 'link::admin');
INSERT INTO ui_message (ui_message_id, tag) VALUES (51, 'link::localization');
INSERT INTO ui_message (ui_message_id, tag) VALUES (52, 'view_event::persons');
INSERT INTO ui_message (ui_message_id, tag) VALUES (53, 'view_event::event_person::person');
INSERT INTO ui_message (ui_message_id, tag) VALUES (54, 'view_event::event_person::role');
INSERT INTO ui_message (ui_message_id, tag) VALUES (55, 'view_event::event_person::role_state');
INSERT INTO ui_message (ui_message_id, tag) VALUES (56, 'view_event::event_person::comment');
INSERT INTO ui_message (ui_message_id, tag) VALUES (57, 'form::remove');
INSERT INTO ui_message (ui_message_id, tag) VALUES (58, 'view_event::notes');
INSERT INTO ui_message (ui_message_id, tag) VALUES (59, 'view_event::title');
INSERT INTO ui_message (ui_message_id, tag) VALUES (60, 'view_event::subtitle');
INSERT INTO ui_message (ui_message_id, tag) VALUES (61, 'view_event::tag');
INSERT INTO ui_message (ui_message_id, tag) VALUES (62, 'link::schedule');
INSERT INTO ui_message (ui_message_id, tag) VALUES (63, 'tabs::show_all');
INSERT INTO ui_message (ui_message_id, tag) VALUES (64, 'view_event::acronym');
INSERT INTO ui_message (ui_message_id, tag) VALUES (65, 'view_event::conference_phase');
INSERT INTO ui_message (ui_message_id, tag) VALUES (66, 'view_event::venue');
INSERT INTO ui_message (ui_message_id, tag) VALUES (67, 'view_event::city');
INSERT INTO ui_message (ui_message_id, tag) VALUES (68, 'view_event::country');
INSERT INTO ui_message (ui_message_id, tag) VALUES (69, 'view_event::start_date');
INSERT INTO ui_message (ui_message_id, tag) VALUES (70, 'view_event::duration');
INSERT INTO ui_message (ui_message_id, tag) VALUES (71, 'view_event::time_zone');
INSERT INTO ui_message (ui_message_id, tag) VALUES (72, 'view_event::currency');
INSERT INTO ui_message (ui_message_id, tag) VALUES (73, 'view_event::timeslot_duration');
INSERT INTO ui_message (ui_message_id, tag) VALUES (74, 'view_event::max_timeslots_per_event');
INSERT INTO ui_message (ui_message_id, tag) VALUES (75, 'view_event::day_change');
INSERT INTO ui_message (ui_message_id, tag) VALUES (76, 'view_event::logo');
INSERT INTO ui_message (ui_message_id, tag) VALUES (77, 'view_conference::notes');
INSERT INTO ui_message (ui_message_id, tag) VALUES (78, 'view_conference::acronym');
INSERT INTO ui_message (ui_message_id, tag) VALUES (79, 'view_conference::title');
INSERT INTO ui_message (ui_message_id, tag) VALUES (80, 'view_conference::subtitle');
INSERT INTO ui_message (ui_message_id, tag) VALUES (81, 'view_conference::conference_phase');
INSERT INTO ui_message (ui_message_id, tag) VALUES (82, 'view_conference::venue');
INSERT INTO ui_message (ui_message_id, tag) VALUES (83, 'view_conference::city');
INSERT INTO ui_message (ui_message_id, tag) VALUES (84, 'view_conference::country');
INSERT INTO ui_message (ui_message_id, tag) VALUES (85, 'view_conference::start_date');
INSERT INTO ui_message (ui_message_id, tag) VALUES (86, 'view_conference::duration');
INSERT INTO ui_message (ui_message_id, tag) VALUES (87, 'view_conference::time_zone');
INSERT INTO ui_message (ui_message_id, tag) VALUES (88, 'view_conference::currency');
INSERT INTO ui_message (ui_message_id, tag) VALUES (89, 'view_conference::timeslot_duration');
INSERT INTO ui_message (ui_message_id, tag) VALUES (90, 'view_conference::max_timeslots_per_event');
INSERT INTO ui_message (ui_message_id, tag) VALUES (91, 'view_conference::day_change');
INSERT INTO ui_message (ui_message_id, tag) VALUES (92, 'view_conference::logo');
INSERT INTO ui_message (ui_message_id, tag) VALUES (93, 'view_conference::section_general');
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
INSERT INTO ui_message (ui_message_id, tag) VALUES (94, 'view_conference::remove_logo');
INSERT INTO ui_message (ui_message_id, tag) VALUES (95, 'view_conference::teams');
INSERT INTO ui_message (ui_message_id, tag) VALUES (96, 'view_conference::team');
INSERT INTO ui_message (ui_message_id, tag) VALUES (97, 'view_conference::persons');
INSERT INTO ui_message (ui_message_id, tag) VALUES (98, 'view_conference::tracks');
INSERT INTO ui_message (ui_message_id, tag) VALUES (99, 'view_conference::track');
INSERT INTO ui_message (ui_message_id, tag) VALUES (100, 'view_event::event_state');
INSERT INTO ui_message (ui_message_id, tag) VALUES (101, 'view_event::role');
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
INSERT INTO ui_message (ui_message_id, tag) VALUES (102, 'view_event::role_state');
INSERT INTO ui_message (ui_message_id, tag) VALUES (41, 'view_event::tab_general');
INSERT INTO ui_message (ui_message_id, tag) VALUES (42, 'view_event::tab_persons');
INSERT INTO ui_message (ui_message_id, tag) VALUES (43, 'view_event::tab_description');
INSERT INTO ui_message (ui_message_id, tag) VALUES (44, 'view_event::tab_links');
INSERT INTO ui_message (ui_message_id, tag) VALUES (45, 'view_event::tab_rating');
INSERT INTO ui_message (ui_message_id, tag) VALUES (46, 'view_event::tab_resources');
INSERT INTO ui_message (ui_message_id, tag) VALUES (47, 'view_event::tab_related');
INSERT INTO ui_message (ui_message_id, tag) VALUES (48, 'view_event::tab_feedback');
INSERT INTO ui_message (ui_message_id, tag) VALUES (103, 'view_event::comment');
INSERT INTO ui_message (ui_message_id, tag) VALUES (104, 'view_person::other_events');
INSERT INTO ui_message (ui_message_id, tag) VALUES (105, 'view_conference::conference');
INSERT INTO ui_message (ui_message_id, tag) VALUES (106, 'view_conference::event_state');
INSERT INTO ui_message (ui_message_id, tag) VALUES (107, 'view_conference::role');
INSERT INTO ui_message (ui_message_id, tag) VALUES (108, 'view_conference::role_state');
INSERT INTO ui_message (ui_message_id, tag) VALUES (109, 'view_conference::im::add_im_address');
INSERT INTO ui_message (ui_message_id, tag) VALUES (110, 'view_event::event_origin');
INSERT INTO ui_message (ui_message_id, tag) VALUES (111, 'view_event::event_state_progress');
INSERT INTO ui_message (ui_message_id, tag) VALUES (112, 'view_event::team');
INSERT INTO ui_message (ui_message_id, tag) VALUES (113, 'view_event::schedule');
INSERT INTO ui_message (ui_message_id, tag) VALUES (114, 'view_event::day');
INSERT INTO ui_message (ui_message_id, tag) VALUES (115, 'view_conference::im::add_im_address_title');
INSERT INTO ui_message (ui_message_id, tag) VALUES (116, 'table::event::title');
INSERT INTO ui_message (ui_message_id, tag) VALUES (117, 'table::event::subtitle');
INSERT INTO ui_message (ui_message_id, tag) VALUES (118, 'table::event::tag');
INSERT INTO ui_message (ui_message_id, tag) VALUES (119, 'table::event::event_origin');
INSERT INTO ui_message (ui_message_id, tag) VALUES (120, 'table::event::event_state');
INSERT INTO ui_message (ui_message_id, tag) VALUES (121, 'table::event::event_state_progress');
INSERT INTO ui_message (ui_message_id, tag) VALUES (122, 'table::event::team');
INSERT INTO ui_message (ui_message_id, tag) VALUES (123, 'table::event::f_public');
INSERT INTO ui_message (ui_message_id, tag) VALUES (124, 'table::event::f_paper');
INSERT INTO ui_message (ui_message_id, tag) VALUES (125, 'table::event::f_slides');
INSERT INTO ui_message (ui_message_id, tag) VALUES (126, 'table::event::language');
INSERT INTO ui_message (ui_message_id, tag) VALUES (127, 'table::event::track');
INSERT INTO ui_message (ui_message_id, tag) VALUES (128, 'table::event::type');
INSERT INTO ui_message (ui_message_id, tag) VALUES (129, 'table::event::conference');
INSERT INTO ui_message (ui_message_id, tag) VALUES (130, 'table::event_person::person');
INSERT INTO ui_message (ui_message_id, tag) VALUES (131, 'table::event_person::event_role');
INSERT INTO ui_message (ui_message_id, tag) VALUES (132, 'table::event_person::event_role_state');
INSERT INTO ui_message (ui_message_id, tag) VALUES (133, 'table::event_person::remark');
INSERT INTO ui_message (ui_message_id, tag) VALUES (134, 'table::event::abstract');
INSERT INTO ui_message (ui_message_id, tag) VALUES (135, 'table::event::description');
INSERT INTO ui_message (ui_message_id, tag) VALUES (136, 'day');


--
-- TOC entry 2 (OID 66208)
-- Name: ui_message_ui_message_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pentabarf
--

SELECT pg_catalog.setval('ui_message_ui_message_id_seq', 136, true);


