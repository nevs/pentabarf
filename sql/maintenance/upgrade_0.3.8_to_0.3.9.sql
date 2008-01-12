
BEGIN;

INSERT INTO auth.object_domain(object,domain) VALUES ('attachment_type_localized','localization');
INSERT INTO auth.object_domain(object,domain) VALUES ('transport_localized','localization');
INSERT INTO auth.object_domain(object,domain) VALUES ('phone_type_localized','localization');
INSERT INTO auth.object_domain(object,domain) VALUES ('mime_type_localized','localization');
INSERT INTO auth.object_domain(object,domain) VALUES ('conference_phase_localized','localization');
INSERT INTO auth.object_domain(object,domain) VALUES ('event_origin_localized','localization');
INSERT INTO auth.object_domain(object,domain) VALUES ('event_role_localized','localization');
INSERT INTO auth.object_domain(object,domain) VALUES ('country_localized','localization');
INSERT INTO auth.object_domain(object,domain) VALUES ('currency_localized','localization');
INSERT INTO auth.object_domain(object,domain) VALUES ('event_state_localized','localization');
INSERT INTO auth.object_domain(object,domain) VALUES ('event_type_localized','localization');
INSERT INTO auth.object_domain(object,domain) VALUES ('im_type_localized','localization');
INSERT INTO auth.object_domain(object,domain) VALUES ('language_localized','localization');
INSERT INTO auth.object_domain(object,domain) VALUES ('link_type_localized','localization');

DROP VIEW view_review;
DROP VIEW view_find_event;
DROP VIEW view_report_feedback;
DROP VIEW view_report_paper;
DROP VIEW view_report_slides;
DROP VIEW view_report_resources;
DROP VIEW view_report_review;
DROP VIEW view_schedule;;
DROP VIEW view_own_events_coordinator;
DROP VIEW view_own_events_participant;


COMMIT;

