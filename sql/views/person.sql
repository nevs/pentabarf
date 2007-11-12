
-- view for persons with name
CREATE OR REPLACE VIEW view_person AS
  SELECT person_id,
         coalesce(person.public_name, coalesce(person.first_name || ' ', '') || person.last_name, person.nickname) AS name,
         title,
         gender,
         first_name,
         last_name,
         public_name,
         nickname,
         address,
         street,
         street_postcode,
         po_box,
         po_box_postcode,
         city,
         country,
         email,
         spam,
         iban,
         bic,
         bank_name,
         account_owner
    FROM person;

