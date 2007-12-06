
CREATE OR REPLACE VIEW view_person_transaction AS
  SELECT
    person_transaction.person_transaction_id,
    person_transaction.person_id,
    person_transaction.changed_when,
    person_transaction.changed_by,
    person_transaction.f_create,
    view_person.name
  FROM
    person_transaction
    INNER JOIN view_person ON ( person_transaction.changed_by = view_person.person_id )
;

