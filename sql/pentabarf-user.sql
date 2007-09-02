
-- create a first user for logging into pentabarf password pentabarf

INSERT INTO person( person_id, login_name, password) VALUES ( 1, 'pentabarf', 'dc0e832c2240352019ab65831813936c9cea5800bb7e3ccc' );

SELECT nextval('person_person_id_seq');

-- give this user admin privileges

INSERT INTO person_role VALUES ( 1, 2);


