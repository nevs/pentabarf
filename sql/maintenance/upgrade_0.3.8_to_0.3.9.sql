
BEGIN;

INSERT INTO auth.object_domain(object,domain) VALUES ('attachment_type_localized','localization');
INSERT INTO auth.object_domain(object,domain) VALUES ('transport_localized','localization');

COMMIT;

