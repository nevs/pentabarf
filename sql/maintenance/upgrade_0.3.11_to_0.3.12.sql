
BEGIN;

DROP TABLE log.ui_message;
DROP TRIGGER ui_message_log_trigger ON ui_message;
DELETE FROM log.log_transaction_involved_tables where table_name = 'ui_message';

CREATE INDEX account_person_id_index ON auth.account(person_id);

ALTER TABLE base.conference ADD COLUMN f_submission_writable BOOL NOT NULL DEFAULT FALSE;
UPDATE conference SET f_submission_writable = TRUE WHERE f_submission_enabled = TRUE;

ALTER TABLE base.person ADD CONSTRAINT person_email_check CHECK(email ~ E'^[\\w=_.+-]+@([\\w.+_-]+\.)+\\w{2,}$');
ALTER TABLE base.conference_person ADD CONSTRAINT conference_person_email_check CHECK(email ~ E'^[\\w=_.+-]+@([\\w.+_-]+\.)+\\w{2,}$');
ALTER TABLE base.account ADD CONSTRAINT account_email_check CHECK(email ~ E'^[\\w=_.+-]+@([\\w.+_-]+\.)+\\w{2,}$');

DROP VIEW view_own_events_coordinator;
DROP VIEW view_own_events_participant;

SELECT log.activate_logging();

CREATE OR REPLACE FUNCTION momomoto.fetch_procedure_columns( procedure_name TEXT ) RETURNS SETOF momomoto.procedure_column AS $$
DECLARE
  proc RECORD;
  typ RECORD;
  att RECORD;
  i INTEGER;
  col momomoto.procedure_column%rowtype;
BEGIN
  SELECT INTO proc * FROM pg_proc WHERE proname = procedure_name;
  IF FOUND THEN
    SELECT INTO typ * FROM pg_type WHERE oid = proc.prorettype;

    IF typ.typtype = 'b' THEN
      -- base type
      IF proc.proallargtypes IS NULL THEN
        -- we only got IN arguments
        col.column_name = procedure_name;
        SELECT INTO col.data_type format_type( proc.prorettype, NULL::integer );
        RETURN NEXT col;
      ELSE
        -- we got a named out arguments
        FOR i IN array_lower(proc.proallargtypes, 1) .. array_upper(proc.proallargtypes, 1)
        LOOP
          CONTINUE WHEN proc.proargmodes[ i ] = 'i';
          IF COALESCE( proc.proargnames[ i ], '' ) = '' THEN
            col.column_name = procedure_name;
          ELSE
            col.column_name = proc.proargnames[ i ];
          END IF;
          col.data_type = format_type( proc.proallargtypes[ i ], NULL );
          RETURN NEXT col;
        END LOOP;
      END IF;
    ELSIF typ.typtype = 'c' THEN
      -- composite type
      FOR col IN
        SELECT attname AS column_name, format_type(atttypid, NULL) FROM pg_attribute WHERE attrelid = typ.typrelid AND attnum > 0 ORDER BY attnum
      LOOP
        RETURN NEXT col;
      END LOOP;
    ELSIF typ.typtype = 'p' THEN
      -- pseudo type
      IF typ.typname <> 'void' THEN
        FOR i IN array_lower(proc.proallargtypes, 1) .. array_upper(proc.proallargtypes, 1)
        LOOP
          CONTINUE WHEN proc.proargmodes[ i ] = 'i';
          col.column_name = proc.proargnames[ i ];
          col.data_type = format_type( proc.proallargtypes[ i ], NULL );
          RETURN NEXT col;
        END LOOP;
      END IF;
    ELSE
      RAISE EXCEPTION 'Not yet implemented';
    END IF;
  END IF;
  RETURN;
END;
$$ LANGUAGE plpgsql;

COMMIT;

