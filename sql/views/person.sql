
-- view for persons with name
CREATE OR REPLACE VIEW view_person AS
  SELECT person_id,
         login_name,
         coalesce(person.public_name, coalesce(person.first_name || ' ', '') || person.last_name, person.nickname, person.login_name) AS name,
         password,
         title,
         gender,
         first_name,
         middle_name,
         last_name,
         public_name,
         nickname,
         address,
         street,
         street_postcode,
         po_box,
         po_box_postcode,
         city,
         country_id,
         email_contact,
         iban,
         bic,
         bank_name,
         account_owner,
         gpg_key,
         preferences,
         f_conflict,
         f_deleted,
         f_spam,
         last_login
    FROM person;

