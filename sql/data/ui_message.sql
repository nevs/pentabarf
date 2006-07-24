--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Name: ui_message_ui_message_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pentabarf
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('ui_message', 'ui_message_id'), 226, true);


--
-- Data for Name: ui_message; Type: TABLE DATA; Schema: public; Owner: pentabarf
--

INSERT INTO ui_message (ui_message_id, tag) VALUES (49, 'link::conflict_setup');
INSERT INTO ui_message (ui_message_id, tag) VALUES (50, 'link::admin');
INSERT INTO ui_message (ui_message_id, tag) VALUES (51, 'link::localization');
INSERT INTO ui_message (ui_message_id, tag) VALUES (57, 'form::remove');
INSERT INTO ui_message (ui_message_id, tag) VALUES (62, 'link::schedule');
INSERT INTO ui_message (ui_message_id, tag) VALUES (63, 'tabs::show_all');
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
INSERT INTO ui_message (ui_message_id, tag) VALUES (137, 'table::event::day');
INSERT INTO ui_message (ui_message_id, tag) VALUES (138, 'table::event::room');
INSERT INTO ui_message (ui_message_id, tag) VALUES (142, 'link::review');
INSERT INTO ui_message (ui_message_id, tag) VALUES (140, 'table::event::duration');
INSERT INTO ui_message (ui_message_id, tag) VALUES (141, 'table::event::start_time');
INSERT INTO ui_message (ui_message_id, tag) VALUES (143, 'table::person::nickname');
INSERT INTO ui_message (ui_message_id, tag) VALUES (144, 'table::person::public_name');
INSERT INTO ui_message (ui_message_id, tag) VALUES (145, 'table::person::last_name');
INSERT INTO ui_message (ui_message_id, tag) VALUES (146, 'table::person::first_name');
INSERT INTO ui_message (ui_message_id, tag) VALUES (147, 'table::person::title');
INSERT INTO ui_message (ui_message_id, tag) VALUES (149, 'table::person::gender');
INSERT INTO ui_message (ui_message_id, tag) VALUES (150, 'table::conference_person_link::title');
INSERT INTO ui_message (ui_message_id, tag) VALUES (151, 'table::conference::default_timeslots');
INSERT INTO ui_message (ui_message_id, tag) VALUES (152, 'table::event_link::url');
INSERT INTO ui_message (ui_message_id, tag) VALUES (153, 'table::event_link::title');
INSERT INTO ui_message (ui_message_id, tag) VALUES (154, 'table::person_travel::f_arrived');
INSERT INTO ui_message (ui_message_id, tag) VALUES (155, 'view::pentabarf::event::tab::general');
INSERT INTO ui_message (ui_message_id, tag) VALUES (156, 'view::pentabarf::event::tab::persons');
INSERT INTO ui_message (ui_message_id, tag) VALUES (157, 'view::pentabarf::event::tab::description');
INSERT INTO ui_message (ui_message_id, tag) VALUES (158, 'view::pentabarf::event::tab::links');
INSERT INTO ui_message (ui_message_id, tag) VALUES (159, 'view::pentabarf::event::tab::schedule');
INSERT INTO ui_message (ui_message_id, tag) VALUES (160, 'view::pentabarf::event::tab::rating');
INSERT INTO ui_message (ui_message_id, tag) VALUES (161, 'view::pentabarf::event::tab::resources');
INSERT INTO ui_message (ui_message_id, tag) VALUES (162, 'view::pentabarf::event::tab::related');
INSERT INTO ui_message (ui_message_id, tag) VALUES (163, 'view::pentabarf::event::tab::feedback');
INSERT INTO ui_message (ui_message_id, tag) VALUES (164, 'table::event::remark');
INSERT INTO ui_message (ui_message_id, tag) VALUES (77, 'table::conference::remark');
INSERT INTO ui_message (ui_message_id, tag) VALUES (78, 'table::conference::acronym');
INSERT INTO ui_message (ui_message_id, tag) VALUES (79, 'table::conference::title');
INSERT INTO ui_message (ui_message_id, tag) VALUES (80, 'table::conference::subtitle');
INSERT INTO ui_message (ui_message_id, tag) VALUES (81, 'table::conference::conference_phase');
INSERT INTO ui_message (ui_message_id, tag) VALUES (82, 'table::conference::venue');
INSERT INTO ui_message (ui_message_id, tag) VALUES (83, 'table::conference::city');
INSERT INTO ui_message (ui_message_id, tag) VALUES (84, 'table::conference::country');
INSERT INTO ui_message (ui_message_id, tag) VALUES (85, 'table::conference::start_date');
INSERT INTO ui_message (ui_message_id, tag) VALUES (86, 'table::conference::duration');
INSERT INTO ui_message (ui_message_id, tag) VALUES (87, 'table::conference::time_zone');
INSERT INTO ui_message (ui_message_id, tag) VALUES (88, 'table::conference::currency');
INSERT INTO ui_message (ui_message_id, tag) VALUES (89, 'table::conference::timeslot_duration');
INSERT INTO ui_message (ui_message_id, tag) VALUES (90, 'table::conference::max_timeslots_per_event');
INSERT INTO ui_message (ui_message_id, tag) VALUES (91, 'table::conference::day_change');
INSERT INTO ui_message (ui_message_id, tag) VALUES (34, 'view::pentabarf::conference::tab::general');
INSERT INTO ui_message (ui_message_id, tag) VALUES (35, 'view::pentabarf::conference::tab::persons');
INSERT INTO ui_message (ui_message_id, tag) VALUES (36, 'view::pentabarf::conference::tab::tracks');
INSERT INTO ui_message (ui_message_id, tag) VALUES (37, 'view::pentabarf::conference::tab::rooms');
INSERT INTO ui_message (ui_message_id, tag) VALUES (38, 'view::pentabarf::conference::tab::events');
INSERT INTO ui_message (ui_message_id, tag) VALUES (39, 'view::pentabarf::conference::tab::export');
INSERT INTO ui_message (ui_message_id, tag) VALUES (40, 'view::pentabarf::conference::tab::feedback');
INSERT INTO ui_message (ui_message_id, tag) VALUES (165, 'table::team::tag');
INSERT INTO ui_message (ui_message_id, tag) VALUES (166, 'table::conference_track::tag');
INSERT INTO ui_message (ui_message_id, tag) VALUES (167, 'table::conference_track::color');
INSERT INTO ui_message (ui_message_id, tag) VALUES (18, 'view::pentabarf::person::tab::general');
INSERT INTO ui_message (ui_message_id, tag) VALUES (19, 'view::pentabarf::person::tab::events');
INSERT INTO ui_message (ui_message_id, tag) VALUES (20, 'view::pentabarf::person::tab::contact');
INSERT INTO ui_message (ui_message_id, tag) VALUES (21, 'view::pentabarf::person::tab::description');
INSERT INTO ui_message (ui_message_id, tag) VALUES (22, 'view::pentabarf::person::tab::links');
INSERT INTO ui_message (ui_message_id, tag) VALUES (23, 'view::pentabarf::person::tab::rating');
INSERT INTO ui_message (ui_message_id, tag) VALUES (24, 'view::pentabarf::person::tab::travel');
INSERT INTO ui_message (ui_message_id, tag) VALUES (25, 'view::pentabarf::person::tab::account');
INSERT INTO ui_message (ui_message_id, tag) VALUES (27, 'view::pentabarf::index::tab::coordinator');
INSERT INTO ui_message (ui_message_id, tag) VALUES (26, 'view::pentabarf::index::tab::participant');
INSERT INTO ui_message (ui_message_id, tag) VALUES (168, 'view::pentabarf::person::other_events');
INSERT INTO ui_message (ui_message_id, tag) VALUES (169, 'table::person::remark');
INSERT INTO ui_message (ui_message_id, tag) VALUES (170, 'view::pentabarf::person::spoken_languages');
INSERT INTO ui_message (ui_message_id, tag) VALUES (171, 'view::pentabarf::person::add_language');
INSERT INTO ui_message (ui_message_id, tag) VALUES (172, 'table::person_language::language');
INSERT INTO ui_message (ui_message_id, tag) VALUES (173, 'view::pentabarf::person::add_event');
INSERT INTO ui_message (ui_message_id, tag) VALUES (174, 'view::pentabarf::person::email');
INSERT INTO ui_message (ui_message_id, tag) VALUES (175, 'view::pentabarf::person::add_phone_number');
INSERT INTO ui_message (ui_message_id, tag) VALUES (176, 'view::pentabarf::person::phone');
INSERT INTO ui_message (ui_message_id, tag) VALUES (177, 'view::pentabarf::person::add_im_address');
INSERT INTO ui_message (ui_message_id, tag) VALUES (178, 'view::pentabarf::person::instant_messaging');
INSERT INTO ui_message (ui_message_id, tag) VALUES (179, 'table::person::email_contact');
INSERT INTO ui_message (ui_message_id, tag) VALUES (180, 'table::person::f_spam');
INSERT INTO ui_message (ui_message_id, tag) VALUES (181, 'table::conference_person::email_public');
INSERT INTO ui_message (ui_message_id, tag) VALUES (182, 'table::person_im::im_type');
INSERT INTO ui_message (ui_message_id, tag) VALUES (183, 'table::person_im::im_address');
INSERT INTO ui_message (ui_message_id, tag) VALUES (184, 'table::person_phone::phone_type');
INSERT INTO ui_message (ui_message_id, tag) VALUES (185, 'table::person_phone::phone_number');
INSERT INTO ui_message (ui_message_id, tag) VALUES (186, 'table::person::address');
INSERT INTO ui_message (ui_message_id, tag) VALUES (187, 'table::person::street');
INSERT INTO ui_message (ui_message_id, tag) VALUES (188, 'table::person::street_postcode');
INSERT INTO ui_message (ui_message_id, tag) VALUES (189, 'table::person::po_box');
INSERT INTO ui_message (ui_message_id, tag) VALUES (190, 'table::person::po_box_postcode');
INSERT INTO ui_message (ui_message_id, tag) VALUES (191, 'table::person::city');
INSERT INTO ui_message (ui_message_id, tag) VALUES (192, 'table::person::country');
INSERT INTO ui_message (ui_message_id, tag) VALUES (193, 'view::pentabarf::person::address');
INSERT INTO ui_message (ui_message_id, tag) VALUES (28, 'view::pentabarf::find_person::tab::simple');
INSERT INTO ui_message (ui_message_id, tag) VALUES (29, 'view::pentabarf::find_person::tab::advanced');
INSERT INTO ui_message (ui_message_id, tag) VALUES (30, 'view::pentabarf::find_event::tab::simple');
INSERT INTO ui_message (ui_message_id, tag) VALUES (31, 'view::pentabarf::find_event::tab::advanced');
INSERT INTO ui_message (ui_message_id, tag) VALUES (32, 'view::pentabarf::find_conference::tab::simple');
INSERT INTO ui_message (ui_message_id, tag) VALUES (33, 'view::pentabarf::find_conference::tab::advanced');
INSERT INTO ui_message (ui_message_id, tag) VALUES (195, 'schedule::speakers');
INSERT INTO ui_message (ui_message_id, tag) VALUES (196, 'schedule::speaker');
INSERT INTO ui_message (ui_message_id, tag) VALUES (197, 'schedule::event');
INSERT INTO ui_message (ui_message_id, tag) VALUES (198, 'schedule::events');
INSERT INTO ui_message (ui_message_id, tag) VALUES (199, 'schedule::day');
INSERT INTO ui_message (ui_message_id, tag) VALUES (200, 'schedule::schedule');
INSERT INTO ui_message (ui_message_id, tag) VALUES (201, 'schedule::room');
INSERT INTO ui_message (ui_message_id, tag) VALUES (202, 'schedule::start_time');
INSERT INTO ui_message (ui_message_id, tag) VALUES (203, 'schedule::language');
INSERT INTO ui_message (ui_message_id, tag) VALUES (204, 'schedule::conference_track');
INSERT INTO ui_message (ui_message_id, tag) VALUES (205, 'schedule::event_type');
INSERT INTO ui_message (ui_message_id, tag) VALUES (206, 'schedule::event_duration');
INSERT INTO ui_message (ui_message_id, tag) VALUES (207, 'schedule::did_you_attend_this_event');
INSERT INTO ui_message (ui_message_id, tag) VALUES (208, 'schedule::give_feedback');
INSERT INTO ui_message (ui_message_id, tag) VALUES (209, 'schedule::attachments');
INSERT INTO ui_message (ui_message_id, tag) VALUES (210, 'schedule::links');
INSERT INTO ui_message (ui_message_id, tag) VALUES (211, 'feedback::welcome_to_the_feedback_system');
INSERT INTO ui_message (ui_message_id, tag) VALUES (212, 'feedback::my_rating');
INSERT INTO ui_message (ui_message_id, tag) VALUES (213, 'feedback::my_opinion');
INSERT INTO ui_message (ui_message_id, tag) VALUES (214, 'feedback::please_answer_these_questions');
INSERT INTO ui_message (ui_message_id, tag) VALUES (215, 'feedback::rating_category');
INSERT INTO ui_message (ui_message_id, tag) VALUES (216, 'feedback::no_rating');
INSERT INTO ui_message (ui_message_id, tag) VALUES (217, 'feedback::question_participant_knowledge');
INSERT INTO ui_message (ui_message_id, tag) VALUES (218, 'feedback::question_topic_importance');
INSERT INTO ui_message (ui_message_id, tag) VALUES (219, 'feedback::question_content_quality');
INSERT INTO ui_message (ui_message_id, tag) VALUES (220, 'feedback::question_presentation_quality');
INSERT INTO ui_message (ui_message_id, tag) VALUES (221, 'feedback::question_audience_involvement');
INSERT INTO ui_message (ui_message_id, tag) VALUES (222, 'feedback::submit');
INSERT INTO ui_message (ui_message_id, tag) VALUES (223, 'feedback::criticism');
INSERT INTO ui_message (ui_message_id, tag) VALUES (224, 'schedule::all_days');
INSERT INTO ui_message (ui_message_id, tag) VALUES (225, 'table::conference::abstract_length');
INSERT INTO ui_message (ui_message_id, tag) VALUES (226, 'table::conference::description_length');


--
-- PostgreSQL database dump complete
--

