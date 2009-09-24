
BEGIN;

INSERT INTO conference_role_permission (conference_role, permission) VALUES ('reviewer', 'review::modify');

COMMIT;

