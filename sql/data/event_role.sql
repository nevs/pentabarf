
SET client_encoding = 'UTF8';
SET search_path = public, pg_catalog;

INSERT INTO event_role (event_role, rank, participant) VALUES ('attendee', NULL, true);
INSERT INTO event_role (event_role, rank, participant) VALUES ('coordinator', 3, false);
INSERT INTO event_role (event_role, rank, participant) VALUES ('moderator', 2, false);
INSERT INTO event_role (event_role, rank, participant) VALUES ('reporter', NULL, true);
INSERT INTO event_role (event_role, rank, participant) VALUES ('reviewer', NULL, false);
INSERT INTO event_role (event_role, rank, participant) VALUES ('speaker', 1, true);
INSERT INTO event_role (event_role, rank, participant) VALUES ('submitter', NULL, false);
INSERT INTO event_role (event_role, rank, participant) VALUES ('visitor', 4, true);
