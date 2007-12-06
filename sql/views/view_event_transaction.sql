
CREATE OR REPLACE VIEW view_event_transaction AS
  SELECT
    event_transaction.event_transaction_id,
    event_transaction.event_id,
    event_transaction.changed_when,
    event_transaction.changed_by,
    event_transaction.f_create,
    view_person.name
  FROM
    event_transaction
    INNER JOIN view_person ON ( event_transaction.changed_by = view_person.person_id )
;

