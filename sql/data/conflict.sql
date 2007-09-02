--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Name: conflict_conflict_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('conflict_conflict_id_seq', 35, true);


--
-- Data for Name: conflict; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO conflict (conflict_id, conflict_type_id, tag) VALUES (2, 2, 'event_person_language');
INSERT INTO conflict (conflict_id, conflict_type_id, tag) VALUES (4, 4, 'event_no_speaker');
INSERT INTO conflict (conflict_id, conflict_type_id, tag) VALUES (5, 4, 'event_no_coordinator');
INSERT INTO conflict (conflict_id, conflict_type_id, tag) VALUES (6, 4, 'event_incomplete');
INSERT INTO conflict (conflict_id, conflict_type_id, tag) VALUES (7, 5, 'event_event_time');
INSERT INTO conflict (conflict_id, conflict_type_id, tag) VALUES (8, 4, 'event_missing_tag');
INSERT INTO conflict (conflict_id, conflict_type_id, tag) VALUES (11, 4, 'event_no_paper');
INSERT INTO conflict (conflict_id, conflict_type_id, tag) VALUES (12, 4, 'event_inconsistent_public_link');
INSERT INTO conflict (conflict_id, conflict_type_id, tag) VALUES (9, 5, 'event_event_duplicate_tag');
INSERT INTO conflict (conflict_id, conflict_type_id, tag) VALUES (10, 4, 'event_inconsistent_tag');
INSERT INTO conflict (conflict_id, conflict_type_id, tag) VALUES (13, 1, 'person_inconsistent_public_link');
INSERT INTO conflict (conflict_id, conflict_type_id, tag) VALUES (14, 4, 'event_no_language');
INSERT INTO conflict (conflict_id, conflict_type_id, tag) VALUES (15, 4, 'event_no_track');
INSERT INTO conflict (conflict_id, conflict_type_id, tag) VALUES (17, 4, 'event_conference_language');
INSERT INTO conflict (conflict_id, conflict_type_id, tag) VALUES (3, 3, 'event_person_event_time_speaker_speaker');
INSERT INTO conflict (conflict_id, conflict_type_id, tag) VALUES (16, 3, 'event_person_event_time_speaker_visitor');
INSERT INTO conflict (conflict_id, conflict_type_id, tag) VALUES (18, 3, 'event_person_event_time_visitor_visitor');
INSERT INTO conflict (conflict_id, conflict_type_id, tag) VALUES (19, 4, 'event_no_abstract');
INSERT INTO conflict (conflict_id, conflict_type_id, tag) VALUES (20, 4, 'event_no_description');
INSERT INTO conflict (conflict_id, conflict_type_id, tag) VALUES (21, 1, 'person_no_abstract');
INSERT INTO conflict (conflict_id, conflict_type_id, tag) VALUES (22, 1, 'person_no_description');
INSERT INTO conflict (conflict_id, conflict_type_id, tag) VALUES (1, 1, 'person_no_email');
INSERT INTO conflict (conflict_id, conflict_type_id, tag) VALUES (26, 3, 'event_person_event_time_attendee');
INSERT INTO conflict (conflict_id, conflict_type_id, tag) VALUES (27, 4, 'event_abstract_length');
INSERT INTO conflict (conflict_id, conflict_type_id, tag) VALUES (23, 2, 'event_person_event_before_arrival');
INSERT INTO conflict (conflict_id, conflict_type_id, tag) VALUES (24, 2, 'event_person_event_after_departure');
INSERT INTO conflict (conflict_id, conflict_type_id, tag) VALUES (25, 4, 'event_no_slides');
INSERT INTO conflict (conflict_id, conflict_type_id, tag) VALUES (28, 4, 'event_description_length');
INSERT INTO conflict (conflict_id, conflict_type_id, tag) VALUES (29, 1, 'person_abstract_length');
INSERT INTO conflict (conflict_id, conflict_type_id, tag) VALUES (30, 1, 'person_description_length');
INSERT INTO conflict (conflict_id, conflict_type_id, tag) VALUES (31, 4, 'event_accepted_without_timeslot');
INSERT INTO conflict (conflict_id, conflict_type_id, tag) VALUES (32, 4, 'event_unconfirmed_with_timeslot');
INSERT INTO conflict (conflict_id, conflict_type_id, tag) VALUES (33, 4, 'event_paper_unknown');
INSERT INTO conflict (conflict_id, conflict_type_id, tag) VALUES (34, 4, 'event_slides_unknown');
INSERT INTO conflict (conflict_id, conflict_type_id, tag) VALUES (35, 2, 'event_person_person_availability');


--
-- PostgreSQL database dump complete
--

