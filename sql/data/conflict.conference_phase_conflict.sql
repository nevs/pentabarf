--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = conflict, pg_catalog;

--
-- Name: conference_phase_conflict_conference_phase_conflict_id_seq; Type: SEQUENCE SET; Schema: conflict; Owner: -
--

SELECT pg_catalog.setval('conference_phase_conflict_conference_phase_conflict_id_seq', 180, true);


--
-- Data for Name: conference_phase_conflict; Type: TABLE DATA; Schema: conflict; Owner: -
--

INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (57, 'discord', 'event_no_paper', 'note');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (10, 'discord', 'person_no_email', 'error');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (37, 'discord', 'event_missing_tag', 'note');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (38, 'confusion', 'event_missing_tag', 'warning');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (39, 'bureaucracy', 'event_missing_tag', 'fatal');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (40, 'aftermath', 'event_missing_tag', 'fatal');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (36, 'chaos', 'event_missing_tag', 'note');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (17, 'confusion', 'person_no_email', 'error');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (24, 'bureaucracy', 'person_no_email', 'error');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (31, 'aftermath', 'person_no_email', 'error');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (35, 'aftermath', 'event_no_coordinator', 'silent');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (3, 'chaos', 'event_incomplete', 'note');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (61, 'chaos', 'event_inconsistent_public_link', 'error');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (46, 'chaos', 'event_event_duplicate_tag', 'note');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (47, 'discord', 'event_event_duplicate_tag', 'warning');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (48, 'confusion', 'event_event_duplicate_tag', 'error');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (49, 'bureaucracy', 'event_event_duplicate_tag', 'error');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (50, 'aftermath', 'event_event_duplicate_tag', 'error');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (51, 'chaos', 'event_inconsistent_tag', 'note');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (52, 'discord', 'event_inconsistent_tag', 'warning');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (4, 'chaos', 'event_event_time', 'fatal');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (53, 'confusion', 'event_inconsistent_tag', 'error');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (54, 'bureaucracy', 'event_inconsistent_tag', 'fatal');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (2, 'chaos', 'event_person_language', 'fatal');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (55, 'aftermath', 'event_inconsistent_tag', 'fatal');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (16, 'confusion', 'event_event_time', 'fatal');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (8, 'discord', 'event_incomplete', 'warning');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (30, 'aftermath', 'event_event_time', 'fatal');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (5, 'chaos', 'event_person_event_time_speaker_speaker', 'fatal');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (15, 'confusion', 'event_incomplete', 'error');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (62, 'discord', 'event_inconsistent_public_link', 'error');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (63, 'confusion', 'event_inconsistent_public_link', 'error');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (166, 'chaos', 'event_paper_unknown', 'warning');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (131, 'chaos', 'event_person_event_time_attendee', 'silent');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (56, 'chaos', 'event_no_paper', 'silent');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (6, 'chaos', 'event_no_speaker', 'fatal');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (168, 'discord', 'event_paper_unknown', 'error');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (64, 'bureaucracy', 'event_inconsistent_public_link', 'error');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (65, 'aftermath', 'event_inconsistent_public_link', 'error');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (66, 'chaos', 'person_inconsistent_public_link', 'error');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (67, 'discord', 'person_inconsistent_public_link', 'error');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (7, 'chaos', 'event_no_coordinator', 'fatal');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (68, 'confusion', 'person_inconsistent_public_link', 'error');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (9, 'discord', 'event_event_time', 'fatal');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (69, 'bureaucracy', 'person_inconsistent_public_link', 'error');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (12, 'discord', 'event_person_event_time_speaker_speaker', 'fatal');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (13, 'discord', 'event_no_speaker', 'fatal');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (14, 'discord', 'event_no_coordinator', 'fatal');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (70, 'aftermath', 'person_inconsistent_public_link', 'error');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (71, 'chaos', 'event_no_language', 'silent');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (72, 'discord', 'event_no_language', 'note');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (18, 'confusion', 'event_person_language', 'fatal');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (20, 'confusion', 'event_no_speaker', 'fatal');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (21, 'confusion', 'event_no_coordinator', 'fatal');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (23, 'bureaucracy', 'event_event_time', 'fatal');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (73, 'confusion', 'event_no_language', 'warning');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (25, 'bureaucracy', 'event_person_language', 'fatal');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (26, 'bureaucracy', 'event_person_event_time_speaker_speaker', 'fatal');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (28, 'bureaucracy', 'event_no_coordinator', 'fatal');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (29, 'aftermath', 'event_incomplete', 'fatal');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (74, 'bureaucracy', 'event_no_language', 'error');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (75, 'aftermath', 'event_no_language', 'error');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (32, 'aftermath', 'event_person_language', 'fatal');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (33, 'aftermath', 'event_person_event_time_speaker_speaker', 'fatal');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (34, 'aftermath', 'event_no_speaker', 'fatal');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (11, 'discord', 'event_person_language', 'fatal');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (19, 'confusion', 'event_person_event_time_speaker_speaker', 'fatal');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (27, 'bureaucracy', 'event_no_speaker', 'fatal');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (76, 'chaos', 'event_no_track', 'silent');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (22, 'bureaucracy', 'event_incomplete', 'fatal');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (1, 'chaos', 'person_no_email', 'error');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (77, 'discord', 'event_no_track', 'note');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (78, 'confusion', 'event_no_track', 'warning');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (79, 'bureaucracy', 'event_no_track', 'error');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (80, 'aftermath', 'event_no_track', 'error');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (81, 'chaos', 'event_person_event_time_speaker_visitor', 'warning');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (82, 'discord', 'event_person_event_time_speaker_visitor', 'warning');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (83, 'confusion', 'event_person_event_time_speaker_visitor', 'warning');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (84, 'bureaucracy', 'event_person_event_time_speaker_visitor', 'warning');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (85, 'aftermath', 'event_person_event_time_speaker_visitor', 'warning');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (86, 'chaos', 'event_conference_language', 'fatal');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (87, 'discord', 'event_conference_language', 'fatal');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (88, 'confusion', 'event_conference_language', 'fatal');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (89, 'bureaucracy', 'event_conference_language', 'fatal');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (90, 'aftermath', 'event_conference_language', 'fatal');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (91, 'chaos', 'event_person_event_time_visitor_visitor', 'warning');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (92, 'discord', 'event_person_event_time_visitor_visitor', 'warning');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (93, 'confusion', 'event_person_event_time_visitor_visitor', 'warning');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (94, 'bureaucracy', 'event_person_event_time_visitor_visitor', 'warning');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (95, 'aftermath', 'event_person_event_time_visitor_visitor', 'warning');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (96, 'chaos', 'person_no_description', 'note');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (97, 'chaos', 'event_no_description', 'note');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (169, 'discord', 'event_slides_unknown', 'warning');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (99, 'chaos', 'person_no_abstract', 'note');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (100, 'discord', 'person_no_description', 'note');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (58, 'confusion', 'event_no_paper', 'error');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (170, 'confusion', 'event_paper_unknown', 'fatal');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (103, 'discord', 'person_no_abstract', 'note');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (108, 'bureaucracy', 'person_no_description', 'error');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (171, 'confusion', 'event_slides_unknown', 'error');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (110, 'bureaucracy', 'event_no_abstract', 'error');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (111, 'bureaucracy', 'person_no_abstract', 'error');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (112, 'aftermath', 'person_no_description', 'note');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (113, 'aftermath', 'event_no_description', 'note');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (114, 'aftermath', 'event_no_abstract', 'note');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (115, 'aftermath', 'person_no_abstract', 'note');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (104, 'confusion', 'person_no_description', 'error');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (172, 'bureaucracy', 'event_paper_unknown', 'fatal');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (106, 'confusion', 'event_no_abstract', 'error');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (107, 'confusion', 'person_no_abstract', 'error');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (116, 'chaos', 'event_person_event_before_arrival', 'note');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (117, 'chaos', 'event_person_event_after_departure', 'note');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (118, 'discord', 'event_person_event_before_arrival', 'note');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (119, 'discord', 'event_person_event_after_departure', 'note');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (120, 'confusion', 'event_person_event_before_arrival', 'error');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (121, 'confusion', 'event_person_event_after_departure', 'error');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (122, 'bureaucracy', 'event_person_event_before_arrival', 'fatal');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (123, 'bureaucracy', 'event_person_event_after_departure', 'fatal');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (124, 'aftermath', 'event_person_event_before_arrival', 'silent');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (125, 'aftermath', 'event_person_event_after_departure', 'silent');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (60, 'aftermath', 'event_no_paper', 'fatal');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (126, 'chaos', 'event_no_slides', 'note');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (127, 'discord', 'event_no_slides', 'note');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (128, 'confusion', 'event_no_slides', 'note');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (129, 'bureaucracy', 'event_no_slides', 'fatal');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (130, 'aftermath', 'event_no_slides', 'fatal');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (132, 'chaos', 'event_abstract_length', 'note');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (133, 'chaos', 'event_description_length', 'note');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (134, 'chaos', 'person_abstract_length', 'note');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (135, 'chaos', 'person_description_length', 'note');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (136, 'discord', 'event_person_event_time_attendee', 'silent');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (137, 'discord', 'event_abstract_length', 'warning');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (138, 'discord', 'event_description_length', 'warning');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (139, 'discord', 'person_description_length', 'warning');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (140, 'discord', 'person_abstract_length', 'warning');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (141, 'confusion', 'event_person_event_time_attendee', 'silent');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (142, 'confusion', 'event_abstract_length', 'error');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (143, 'confusion', 'event_description_length', 'error');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (144, 'confusion', 'person_abstract_length', 'error');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (145, 'confusion', 'person_description_length', 'error');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (146, 'bureaucracy', 'event_person_event_time_attendee', 'silent');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (147, 'bureaucracy', 'event_abstract_length', 'error');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (148, 'bureaucracy', 'event_description_length', 'error');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (149, 'bureaucracy', 'person_abstract_length', 'error');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (150, 'bureaucracy', 'person_description_length', 'error');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (151, 'aftermath', 'event_person_event_time_attendee', 'silent');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (152, 'aftermath', 'event_abstract_length', 'silent');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (153, 'aftermath', 'event_description_length', 'silent');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (154, 'aftermath', 'person_abstract_length', 'silent');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (155, 'aftermath', 'person_description_length', 'silent');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (98, 'chaos', 'event_no_abstract', 'warning');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (102, 'discord', 'event_no_abstract', 'warning');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (101, 'discord', 'event_no_description', 'warning');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (105, 'confusion', 'event_no_description', 'warning');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (109, 'bureaucracy', 'event_no_description', 'warning');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (156, 'chaos', 'event_accepted_without_timeslot', 'silent');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (157, 'chaos', 'event_unconfirmed_with_timeslot', 'silent');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (59, 'bureaucracy', 'event_no_paper', 'fatal');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (173, 'bureaucracy', 'event_slides_unknown', 'fatal');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (160, 'confusion', 'event_accepted_without_timeslot', 'error');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (161, 'confusion', 'event_unconfirmed_with_timeslot', 'error');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (162, 'bureaucracy', 'event_accepted_without_timeslot', 'fatal');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (163, 'bureaucracy', 'event_unconfirmed_with_timeslot', 'fatal');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (164, 'aftermath', 'event_accepted_without_timeslot', 'silent');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (165, 'aftermath', 'event_unconfirmed_with_timeslot', 'silent');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (158, 'discord', 'event_accepted_without_timeslot', 'warning');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (159, 'discord', 'event_unconfirmed_with_timeslot', 'warning');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (174, 'aftermath', 'event_paper_unknown', 'fatal');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (175, 'aftermath', 'event_slides_unknown', 'fatal');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (176, 'chaos', 'event_person_person_availability', 'note');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (177, 'discord', 'event_person_person_availability', 'fatal');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (178, 'confusion', 'event_person_person_availability', 'fatal');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (179, 'bureaucracy', 'event_person_person_availability', 'fatal');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (180, 'aftermath', 'event_person_person_availability', 'silent');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (167, 'chaos', 'event_slides_unknown', 'warning');


--
-- PostgreSQL database dump complete
--

