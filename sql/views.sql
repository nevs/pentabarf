
-- view for ui_messages with fallback to tag
CREATE OR REPLACE VIEW view_ui_message AS SELECT ui_message_id, language_id, tag, coalesce(name,tag) AS name FROM (SELECT language_id, ui_message_id, ui_message.tag FROM language CROSS JOIN ui_message) AS all_lang LEFT OUTER JOIN ui_message_localized USING (language_id, ui_message_id);

-- view for event_state with fallback to tag
CREATE OR REPLACE VIEW view_event_state AS SELECT event_state_id, language_id, tag, coalesce(name,tag) AS name FROM (SELECT language_id, event_state_id, event_state.tag FROM language CROSS JOIN event_state) AS all_lang LEFT OUTER JOIN event_state_localized USING (language_id, event_state_id);

-- view for event_role with fallback to tag
CREATE OR REPLACE VIEW view_event_role AS SELECT event_role_id, language_id, tag, coalesce(name,tag) AS name FROM (SELECT language_id, event_role_id, event_role.tag FROM language CROSS JOIN event_role) AS all_lang LEFT OUTER JOIN event_role_localized USING (language_id, event_role_id);

-- view for event_role_state with fallback to tag
CREATE OR REPLACE VIEW view_event_role_state AS SELECT event_role_state_id, language_id, tag, coalesce(name,tag) AS name FROM (SELECT language_id, event_role_state_id, event_role_state.tag FROM language CROSS JOIN event_role_state) AS all_lang LEFT OUTER JOIN event_role_state_localized USING (language_id, event_role_state_id);

-- view for persons with name
CREATE OR REPLACE VIEW view_person AS SELECT person_id, login_name, coalesce(person.public_name, coalesce(person.first_name || ' ', '') || person.last_name, person.nickname, person.login_name) AS name, password, title, gender, first_name, middle_name, last_name, public_name, nickname, address, street, street_postcode, po_box, po_box_postcode, city, country_id, email_contact, email_public, iban, bank_name, account_owner, abstract, description, gpg_key, remark, preferences, f_conflict, f_deleted, last_login FROM person;


-- view for persons with name
CREATE OR REPLACE VIEW view_last_active AS SELECT person_id, login_name, name, last_login, now() - last_login AS login_diff FROM view_person WHERE last_login > now() + '-1 hour'::interval ORDER BY last_login DESC; 

-- view for recent changes
CREATE OR REPLACE VIEW view_recent_changes AS SELECT 'conference' AS type, conference_transaction.conference_id AS id, conference.title AS title, conference_transaction.changed_when, conference_transaction.changed_by, view_person.name , conference_transaction.f_create 
FROM conference_transaction, conference, view_person 
WHERE conference_transaction.changed_by = view_person.person_id AND conference_transaction.conference_id = conference.conference_id 
UNION 
SELECT 'event' AS type, event_transaction.event_id AS id, event.title AS title, event_transaction.changed_when, event_transaction.changed_by, view_person.name , event_transaction.f_create 
FROM event_transaction, view_person, event
WHERE event_transaction.changed_by = view_person.person_id AND event_transaction.event_id = event.event_id 
UNION 
SELECT 'person' AS type, person_transaction.person_id AS id, person.name AS title , person_transaction.changed_when, person_transaction.changed_by, view_person.name , person_transaction.f_create 
FROM person_transaction, view_person, view_person as person 
WHERE person_transaction.changed_by = view_person.person_id AND person_transaction.person_id = person.person_id ORDER BY changed_when DESC;

-- view for event_persons
CREATE OR REPLACE VIEW view_event_person AS SELECT event_person.event_person_id, event_person.event_id, event_person.person_id, event_person.event_role_id, event_person.event_role_state_id, event_person.remark, event_person.rank, event.conference_id, event.title, event.subtitle, event.event_state_id, view_person.name, view_event_state.language_id, view_event_state.tag AS event_state_tag, view_event_state.name as event_state, view_event_role.tag AS event_role_tag, view_event_role.name AS event_role, view_event_role_state.tag as event_role_state_tag, view_event_role_state.name AS event_role_state
FROM event_person INNER JOIN event USING (event_id) 
     INNER JOIN view_person USING (person_id) 
     INNER JOIN view_event_state USING (event_state_id)
     INNER JOIN view_event_role ON (view_event_role.event_role_id = event_person.event_role_id AND view_event_state.language_id = view_event_role.language_id)
     LEFT OUTER JOIN view_event_role_state ON (event_person.event_role_state_id = view_event_role_state.event_role_state_id AND view_event_state.language_id = view_event_role_state.language_id);

