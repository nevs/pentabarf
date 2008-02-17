
SET client_encoding = 'UTF8';
SET search_path = conflict, pg_catalog;

INSERT INTO conflict_level (conflict_level, rank) VALUES ('error', 4);
INSERT INTO conflict_level (conflict_level, rank) VALUES ('fatal', 5);
INSERT INTO conflict_level (conflict_level, rank) VALUES ('note', 2);
INSERT INTO conflict_level (conflict_level, rank) VALUES ('silent', 1);
INSERT INTO conflict_level (conflict_level, rank) VALUES ('warning', 3);
