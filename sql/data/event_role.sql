
SET client_encoding = 'UTF8';
SET search_path = public, pg_catalog;

INSERT INTO event_role (event_role, rank) VALUES ('attendee', NULL);
INSERT INTO event_role (event_role, rank) VALUES ('coordinator', 3);
INSERT INTO event_role (event_role, rank) VALUES ('moderator', 2);
INSERT INTO event_role (event_role, rank) VALUES ('reporter', NULL);
INSERT INTO event_role (event_role, rank) VALUES ('reviewer', NULL);
INSERT INTO event_role (event_role, rank) VALUES ('speaker', 1);
INSERT INTO event_role (event_role, rank) VALUES ('submitter', NULL);
INSERT INTO event_role (event_role, rank) VALUES ('visitor', 4);
