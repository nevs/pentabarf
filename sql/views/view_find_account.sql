CREATE OR REPLACE VIEW view_find_account AS
  SELECT
    account.account_id,
    account.login_name,
    account.email AS account_email,
    account.person_id,
    view_person.first_name,
    view_person.last_name,
    view_person.public_name,
    view_person.nickname,
    view_person.email AS person_email,
    view_person.name
  FROM
    auth.account
    LEFT OUTER JOIN view_person USING(person_id)
;
