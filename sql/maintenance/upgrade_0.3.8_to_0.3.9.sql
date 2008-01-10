
BEGIN;

INSERT INTO auth.object_domain(object,domain) VALUES ('attachment_type_localized','localization');
INSERT INTO auth.object_domain(object,domain) VALUES ('transport_localized','localization');
INSERT INTO auth.object_domain(object,domain) VALUES ('phone_type_localized','localization');
INSERT INTO auth.object_domain(object,domain) VALUES ('mime_type_localized','localization');
INSERT INTO auth.object_domain(object,domain) VALUES ('conference_phase_localized','localization');
INSERT INTO auth.object_domain(object,domain) VALUES ('event_origin_localized','localization');
INSERT INTO auth.object_domain(object,domain) VALUES ('event_role_localized','localization');

COMMIT;

