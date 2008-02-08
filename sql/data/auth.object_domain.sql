--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = auth, pg_catalog;

--
-- Data for Name: object_domain; Type: TABLE DATA; Schema: auth; Owner: -
--

INSERT INTO object_domain ("object", "domain") VALUES ('conference', 'conference');
INSERT INTO object_domain ("object", "domain") VALUES ('conference_language', 'conference');
INSERT INTO object_domain ("object", "domain") VALUES ('conference_person', 'person');
INSERT INTO object_domain ("object", "domain") VALUES ('conference_person_link', 'person');
INSERT INTO object_domain ("object", "domain") VALUES ('conference_person_link_internal', 'person');
INSERT INTO object_domain ("object", "domain") VALUES ('conference_phase_conflict', 'config');
INSERT INTO object_domain ("object", "domain") VALUES ('conference_track', 'conference');
INSERT INTO object_domain ("object", "domain") VALUES ('event', 'event');
INSERT INTO object_domain ("object", "domain") VALUES ('event_attachment', 'event');
INSERT INTO object_domain ("object", "domain") VALUES ('event_link', 'event');
INSERT INTO object_domain ("object", "domain") VALUES ('event_link_internal', 'event');
INSERT INTO object_domain ("object", "domain") VALUES ('event_person', 'event');
INSERT INTO object_domain ("object", "domain") VALUES ('event_rating', 'review');
INSERT INTO object_domain ("object", "domain") VALUES ('person', 'person');
INSERT INTO object_domain ("object", "domain") VALUES ('person_im', 'person');
INSERT INTO object_domain ("object", "domain") VALUES ('person_language', 'person');
INSERT INTO object_domain ("object", "domain") VALUES ('person_phone', 'person');
INSERT INTO object_domain ("object", "domain") VALUES ('person_rating', 'review');
INSERT INTO object_domain ("object", "domain") VALUES ('ui_message_localized', 'localization');
INSERT INTO object_domain ("object", "domain") VALUES ('event_transaction', 'public');
INSERT INTO object_domain ("object", "domain") VALUES ('person_transaction', 'public');
INSERT INTO object_domain ("object", "domain") VALUES ('conference_transaction', 'public');
INSERT INTO object_domain ("object", "domain") VALUES ('event_image', 'event');
INSERT INTO object_domain ("object", "domain") VALUES ('conference_image', 'conference');
INSERT INTO object_domain ("object", "domain") VALUES ('person_image', 'person');
INSERT INTO object_domain ("object", "domain") VALUES ('person_availability', 'person');
INSERT INTO object_domain ("object", "domain") VALUES ('account', 'account');
INSERT INTO object_domain ("object", "domain") VALUES ('conference_person_travel', 'person');
INSERT INTO object_domain ("object", "domain") VALUES ('conference_room', 'conference');
INSERT INTO object_domain ("object", "domain") VALUES ('conference_team', 'conference');
INSERT INTO object_domain ("object", "domain") VALUES ('account_role', 'account');
INSERT INTO object_domain ("object", "domain") VALUES ('conference_day', 'conference');
INSERT INTO object_domain ("object", "domain") VALUES ('event_feedback', 'public');
INSERT INTO object_domain ("object", "domain") VALUES ('attachment_type_localized', 'localization');
INSERT INTO object_domain ("object", "domain") VALUES ('transport_localized', 'localization');
INSERT INTO object_domain ("object", "domain") VALUES ('phone_type_localized', 'localization');
INSERT INTO object_domain ("object", "domain") VALUES ('mime_type_localized', 'localization');
INSERT INTO object_domain ("object", "domain") VALUES ('conference_phase_localized', 'localization');
INSERT INTO object_domain ("object", "domain") VALUES ('event_origin_localized', 'localization');
INSERT INTO object_domain ("object", "domain") VALUES ('event_role_localized', 'localization');
INSERT INTO object_domain ("object", "domain") VALUES ('country_localized', 'localization');
INSERT INTO object_domain ("object", "domain") VALUES ('currency_localized', 'localization');
INSERT INTO object_domain ("object", "domain") VALUES ('event_state_localized', 'localization');
INSERT INTO object_domain ("object", "domain") VALUES ('event_type_localized', 'localization');
INSERT INTO object_domain ("object", "domain") VALUES ('im_type_localized', 'localization');
INSERT INTO object_domain ("object", "domain") VALUES ('language_localized', 'localization');
INSERT INTO object_domain ("object", "domain") VALUES ('link_type_localized', 'localization');
INSERT INTO object_domain ("object", "domain") VALUES ('event_role_state_localized', 'localization');
INSERT INTO object_domain ("object", "domain") VALUES ('event_state_progress_localized', 'localization');
INSERT INTO object_domain ("object", "domain") VALUES ('custom_fields', 'custom');
INSERT INTO object_domain ("object", "domain") VALUES ('custom_conference_person', 'person');
INSERT INTO object_domain ("object", "domain") VALUES ('ui_message', 'localization');
INSERT INTO object_domain ("object", "domain") VALUES ('custom_conference', 'conference');
INSERT INTO object_domain ("object", "domain") VALUES ('custom_event', 'event');
INSERT INTO object_domain ("object", "domain") VALUES ('custom_person', 'person');


--
-- PostgreSQL database dump complete
--

