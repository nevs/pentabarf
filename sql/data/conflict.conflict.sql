--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = conflict, pg_catalog;

--
-- Data for Name: conflict; Type: TABLE DATA; Schema: conflict; Owner: -
--

INSERT INTO conflict (conflict, conflict_type) VALUES ('event_person_language', 'event_person');
INSERT INTO conflict (conflict, conflict_type) VALUES ('event_no_speaker', 'event');
INSERT INTO conflict (conflict, conflict_type) VALUES ('event_no_coordinator', 'event');
INSERT INTO conflict (conflict, conflict_type) VALUES ('event_incomplete', 'event');
INSERT INTO conflict (conflict, conflict_type) VALUES ('event_event_time', 'event_event');
INSERT INTO conflict (conflict, conflict_type) VALUES ('event_missing_tag', 'event');
INSERT INTO conflict (conflict, conflict_type) VALUES ('event_no_paper', 'event');
INSERT INTO conflict (conflict, conflict_type) VALUES ('event_inconsistent_public_link', 'event');
INSERT INTO conflict (conflict, conflict_type) VALUES ('event_event_duplicate_tag', 'event_event');
INSERT INTO conflict (conflict, conflict_type) VALUES ('event_inconsistent_tag', 'event');
INSERT INTO conflict (conflict, conflict_type) VALUES ('person_inconsistent_public_link', 'person');
INSERT INTO conflict (conflict, conflict_type) VALUES ('event_no_language', 'event');
INSERT INTO conflict (conflict, conflict_type) VALUES ('event_no_track', 'event');
INSERT INTO conflict (conflict, conflict_type) VALUES ('event_conference_language', 'event');
INSERT INTO conflict (conflict, conflict_type) VALUES ('event_person_event_time_speaker_speaker', 'event_person_event');
INSERT INTO conflict (conflict, conflict_type) VALUES ('event_person_event_time_speaker_visitor', 'event_person_event');
INSERT INTO conflict (conflict, conflict_type) VALUES ('event_person_event_time_visitor_visitor', 'event_person_event');
INSERT INTO conflict (conflict, conflict_type) VALUES ('event_no_abstract', 'event');
INSERT INTO conflict (conflict, conflict_type) VALUES ('event_no_description', 'event');
INSERT INTO conflict (conflict, conflict_type) VALUES ('person_no_abstract', 'person');
INSERT INTO conflict (conflict, conflict_type) VALUES ('person_no_description', 'person');
INSERT INTO conflict (conflict, conflict_type) VALUES ('person_no_email', 'person');
INSERT INTO conflict (conflict, conflict_type) VALUES ('event_person_event_time_attendee', 'event_person_event');
INSERT INTO conflict (conflict, conflict_type) VALUES ('event_abstract_length', 'event');
INSERT INTO conflict (conflict, conflict_type) VALUES ('event_person_event_before_arrival', 'event_person');
INSERT INTO conflict (conflict, conflict_type) VALUES ('event_person_event_after_departure', 'event_person');
INSERT INTO conflict (conflict, conflict_type) VALUES ('event_no_slides', 'event');
INSERT INTO conflict (conflict, conflict_type) VALUES ('event_description_length', 'event');
INSERT INTO conflict (conflict, conflict_type) VALUES ('person_abstract_length', 'person');
INSERT INTO conflict (conflict, conflict_type) VALUES ('person_description_length', 'person');
INSERT INTO conflict (conflict, conflict_type) VALUES ('event_accepted_without_timeslot', 'event');
INSERT INTO conflict (conflict, conflict_type) VALUES ('event_unconfirmed_with_timeslot', 'event');
INSERT INTO conflict (conflict, conflict_type) VALUES ('event_paper_unknown', 'event');
INSERT INTO conflict (conflict, conflict_type) VALUES ('event_slides_unknown', 'event');
INSERT INTO conflict (conflict, conflict_type) VALUES ('event_person_person_availability', 'event_person');


--
-- PostgreSQL database dump complete
--

