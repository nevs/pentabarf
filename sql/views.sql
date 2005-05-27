
-- view for ui_messages with fallback to tag
CREATE OR REPLACE VIEW view_ui_message AS SELECT ui_message_id, language_id, tag, coalesce(name,tag) AS name FROM (SELECT language_id, ui_message_id, ui_message.tag FROM language CROSS JOIN ui_message) AS all_lang LEFT OUTER JOIN ui_message_localized USING (language_id, ui_message_id);

-- view for persons with name
CREATE OR REPLACE VIEW view_person AS SELECT person_id, login_name, coalesce(person.public_name, coalesce(person.first_name || ' ', '') || person.last_name, person.nickname, person.login_name) AS name, password, title, gender, first_name, middle_name, last_name, public_name, nickname, address, street, street_postcode, po_box, po_box_postcode, city, country_id, email_contact, email_public, iban, bank_name, account_owner, abstract, description, gpg_key, remark, preferences, f_conflict, f_deleted, last_login FROM person;


-- view for persons with name
CREATE OR REPLACE VIEW view_last_active AS SELECT person_id, login_name, name, last_login, now() - last_login AS login_diff FROM view_person WHERE last_login > now() + '-1 hour'::interval ORDER BY last_login DESC; 

-- view for recent changes
CREATE OR REPLACE VIEW view_recent_changes AS SELECT 'conference' AS type, conference_transaction.conference_id AS id, conference.title AS title, conference_transaction.changed_when, conference_transaction.changed_by, coalesce(p.public_name, coalesce(p.first_name || ' ', '') || p.last_name, p.nickname, p.login_name) AS name , conference_transaction.f_create 
FROM conference_transaction, conference, person AS p
WHERE conference_transaction.changed_by = p.person_id AND conference_transaction.conference_id = conference.conference_id 
UNION 
SELECT 'event' AS type, event_transaction.event_id AS id, event.title AS title, event_transaction.changed_when, event_transaction.changed_by, coalesce(p.public_name, coalesce(p.first_name || ' ', '') || p.last_name, p.nickname, p.login_name) AS name , event_transaction.f_create 
FROM event_transaction, person AS p, event
WHERE event_transaction.changed_by = p.person_id AND event_transaction.event_id = event.event_id 
UNION 
SELECT 'person' AS type, person_transaction.person_id AS id, coalesce(person.public_name, coalesce(person.first_name || ' ', '') || person.last_name, person.nickname, person.login_name) AS title , person_transaction.changed_when, person_transaction.changed_by, coalesce(p.public_name, coalesce(p.first_name || ' ', '') || p.last_name, p.nickname, p.login_name) AS name , person_transaction.f_create 
FROM person_transaction, person AS p, person
WHERE person_transaction.changed_by = p.person_id AND person_transaction.person_id = person.person_id ORDER BY changed_when DESC;

