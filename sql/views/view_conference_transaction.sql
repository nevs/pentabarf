
CREATE OR REPLACE VIEW view_conference_transaction AS
  SELECT
    conference_transaction.conference_transaction_id,
    conference_transaction.conference_id,
    conference_transaction.changed_when,
    conference_transaction.changed_by,
    conference_transaction.f_create,
    view_person.name
  FROM
    conference_transaction
    INNER JOIN view_person ON ( conference_transaction.changed_by = view_person.person_id )
;

