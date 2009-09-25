
SET client_encoding = 'UTF8';
SET search_path = public, pg_catalog;

INSERT INTO event_role (event_role, rank, participant, public) VALUES ('attendee', NULL, true, false);
INSERT INTO event_role (event_role, rank, participant, public) VALUES ('coordinator', 3, false, false);
INSERT INTO event_role (event_role, rank, participant, public) VALUES ('moderator', 2, false, true);
INSERT INTO event_role (event_role, rank, participant, public) VALUES ('reporter', NULL, true, false);
INSERT INTO event_role (event_role, rank, participant, public) VALUES ('reviewer', NULL, false, false);
INSERT INTO event_role (event_role, rank, participant, public) VALUES ('speaker', 1, true, true);
INSERT INTO event_role (event_role, rank, participant, public) VALUES ('submitter', NULL, false, false);
INSERT INTO event_role (event_role, rank, participant, public) VALUES ('visitor', 4, true, false);
