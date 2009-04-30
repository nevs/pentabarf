
BEGIN;

DELETE FROM auth.permission WHERE permission = 'move_event';

COMMIT;

