
-- create a first user for logging into pentabarf password pentabarf

INSERT INTO person( nickname ) VALUES ( 'pentabarf' );
INSERT INTO auth.account( login_name, email, salt, password, person_id ) VALUES ( 'pentabarf', 'pentabarf@localhost', 'dc0e832c22403520','19ab65831813936c9cea5800bb7e3ccc', currval( pg_get_serial_sequence('base.person','person_id')));


-- give this user admin privileges

INSERT INTO auth.account_role VALUES ( currval( pg_get_serial_sequence( 'base.account', 'account_id' ) ), 'admin' );


