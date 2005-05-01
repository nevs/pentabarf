
-- view for ui_messages with fallback to tag
CREATE OR REPLACE VIEW view_ui_message AS SELECT ui_message_id, language_id, tag, coalesce(name,tag) AS name FROM (SELECT language_id, ui_message_id, ui_message.tag FROM language CROSS JOIN ui_message) AS all_lang LEFT OUTER JOIN ui_message_localized USING (language_id, ui_message_id);

-- view for persons with name
CREATE OR REPLACE VIEW view_person AS SELECT person_id, login_name, coalesce(person.public_name, coalesce(person.first_name || ' ', '') || person.last_name, person.nickname, person.login_name) AS name, password, title, gender, first_name, middle_name, last_name, public_name, nickname, address, street, street_postcode, po_box, po_box_postcode, city, country_id, email_contact, email_public, iban, bank_name, account_owner, abstract, description, gpg_key, remark, preferences, f_conflict, f_deleted, last_login FROM person;

