
-- test data

-- test conference
INSERT INTO conference(title,subtitle,acronym,remark) VALUES ('Octi loves you','Welcome to Townsville','TEST','Really cool conference with Blossom, Buttercup, Bubbles and MojoJojo');

INSERT INTO conference_day(conference_id,conference_day) VALUES ((SELECT conference_id FROM conference WHERE acronym='TEST'),'2007-06-01');
INSERT INTO conference_day(conference_id,conference_day) VALUES ((SELECT conference_id FROM conference WHERE acronym='TEST'),'2007-06-02');
INSERT INTO conference_day(conference_id,conference_day) VALUES ((SELECT conference_id FROM conference WHERE acronym='TEST'),'2007-06-03');
INSERT INTO conference_day(conference_id,conference_day) VALUES ((SELECT conference_id FROM conference WHERE acronym='TEST'),'2007-06-04');
INSERT INTO conference_day(conference_id,conference_day) VALUES ((SELECT conference_id FROM conference WHERE acronym='TEST'),'2007-06-05');

INSERT INTO conference_track(conference_id,conference_track) VALUES ((SELECT conference_id FROM conference WHERE acronym='TEST'),'Hacking');
INSERT INTO conference_track(conference_id,conference_track) VALUES ((SELECT conference_id FROM conference WHERE acronym='TEST'),'Society');
INSERT INTO conference_track(conference_id,conference_track) VALUES ((SELECT conference_id FROM conference WHERE acronym='TEST'),'Community');
INSERT INTO conference_track(conference_id,conference_track) VALUES ((SELECT conference_id FROM conference WHERE acronym='TEST'),'Culture');
INSERT INTO conference_track(conference_id,conference_track) VALUES ((SELECT conference_id FROM conference WHERE acronym='TEST'),'Science');

INSERT INTO conference_room(conference_id,conference_room) VALUES ((SELECT conference_id FROM conference WHERE acronym='TEST'),'Room A');
INSERT INTO conference_room(conference_id,conference_room) VALUES ((SELECT conference_id FROM conference WHERE acronym='TEST'),'Room B');
INSERT INTO conference_room(conference_id,conference_room) VALUES ((SELECT conference_id FROM conference WHERE acronym='TEST'),'Room C');
INSERT INTO conference_room(conference_id,conference_room) VALUES ((SELECT conference_id FROM conference WHERE acronym='TEST'),'Room D');
INSERT INTO conference_room(conference_id,conference_room) VALUES ((SELECT conference_id FROM conference WHERE acronym='TEST'),'Room E');

-- create some persons
INSERT INTO person(first_name,last_name,public_name) VALUES('Blossom',NULL,'Blossom');
INSERT INTO person(first_name,last_name,public_name) VALUES('Bubbles',NULL,'Bubbles');
INSERT INTO person(first_name,last_name,public_name) VALUES('Buttercup',NULL,'Buttercup');
INSERT INTO person(first_name,last_name,public_name) VALUES('MojoJojo',NULL,'MojoJojo');

-- create some accounts
INSERT INTO person(public_name) VALUES('Submitter');
INSERT INTO auth.account(login_name,email,current_conference_id,person_id) VALUES('submitter','pentabarf@localhost',(SELECT conference_id FROM conference WHERE acronym='TEST'),currval('base.person_person_id_seq'));
INSERT INTO auth.account_role(account_id,role) VALUES(currval('base.account_account_id_seq'),'submitter');

INSERT INTO person(public_name) VALUES('Reviewer');
INSERT INTO auth.account(login_name,email,current_conference_id,person_id) VALUES('reviewer','pentabarf@localhost',(SELECT conference_id FROM conference WHERE acronym='TEST'),currval('base.person_person_id_seq'));
INSERT INTO auth.account_role(account_id,role) VALUES(currval('base.account_account_id_seq'),'submitter');
INSERT INTO auth.account_role(account_id,role) VALUES(currval('base.account_account_id_seq'),'reviewer');

INSERT INTO person(public_name) VALUES('Committee');
INSERT INTO auth.account(login_name,email,current_conference_id,person_id) VALUES('committee','pentabarf@localhost',(SELECT conference_id FROM conference WHERE acronym='TEST'),currval('base.person_person_id_seq'));
INSERT INTO auth.account_role(account_id,role) VALUES(currval('base.account_account_id_seq'),'submitter');
INSERT INTO auth.account_role(account_id,role) VALUES(currval('base.account_account_id_seq'),'reviewer');
INSERT INTO auth.account_role(account_id,role) VALUES(currval('base.account_account_id_seq'),'committee');

INSERT INTO person(public_name) VALUES('Administrator');
INSERT INTO auth.account(login_name,email,current_conference_id,person_id) VALUES('admin','pentabarf@localhost',(SELECT conference_id FROM conference WHERE acronym='TEST'),currval('base.person_person_id_seq'));
INSERT INTO auth.account_role(account_id,role) VALUES(currval('base.account_account_id_seq'),'submitter');
INSERT INTO auth.account_role(account_id,role) VALUES(currval('base.account_account_id_seq'),'reviewer');
INSERT INTO auth.account_role(account_id,role) VALUES(currval('base.account_account_id_seq'),'committee');
INSERT INTO auth.account_role(account_id,role) VALUES(currval('base.account_account_id_seq'),'admin');

-- create some events
INSERT INTO event(title,conference_id) VALUES('Welcome',(SELECT conference_id FROM conference WHERE acronym='TEST'));

