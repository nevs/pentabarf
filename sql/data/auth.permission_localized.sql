--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = auth, pg_catalog;

--
-- Data for Name: permission_localized; Type: TABLE DATA; Schema: auth; Owner: -
--

INSERT INTO permission_localized (permission, translated, name) VALUES ('create_person', 'de', 'Anlegen einer Person');
INSERT INTO permission_localized (permission, translated, name) VALUES ('modify_person', 'de', 'Modifizieren einer Person');
INSERT INTO permission_localized (permission, translated, name) VALUES ('delete_person', 'de', 'Löschen einer Person');
INSERT INTO permission_localized (permission, translated, name) VALUES ('create_event', 'de', 'Anlegen einer Veranstaltung');
INSERT INTO permission_localized (permission, translated, name) VALUES ('modify_event', 'de', 'Modifizieren einer Veranstaltung');
INSERT INTO permission_localized (permission, translated, name) VALUES ('delete_event', 'de', 'Löschen einer Verantstaltung');
INSERT INTO permission_localized (permission, translated, name) VALUES ('create_conference', 'de', 'Anlegen einer Konferenz');
INSERT INTO permission_localized (permission, translated, name) VALUES ('modify_conference', 'de', 'Modifizieren einer Konferenz');
INSERT INTO permission_localized (permission, translated, name) VALUES ('delete_conference', 'de', 'Löschen einer Konferenz');
INSERT INTO permission_localized (permission, translated, name) VALUES ('modify_localization', 'de', 'Modifizieren von Lokalisierungen');
INSERT INTO permission_localized (permission, translated, name) VALUES ('modify_valuelist', 'de', 'Modifizieren von Werten in Wertelisten');
INSERT INTO permission_localized (permission, translated, name) VALUES ('create_roles', 'de', 'Anlegen von Rollen');
INSERT INTO permission_localized (permission, translated, name) VALUES ('modify_roles', 'de', 'Bearbeiten von Rollen');
INSERT INTO permission_localized (permission, translated, name) VALUES ('delete_roles', 'de', 'Löschen von Rollen');
INSERT INTO permission_localized (permission, translated, name) VALUES ('modify_own_person', 'de', 'Modifizierung der Daten zur eigenen Person');
INSERT INTO permission_localized (permission, translated, name) VALUES ('modify_own_event', 'de', 'Modifizierung der Daten an der die Person beteiligt ist');
INSERT INTO permission_localized (permission, translated, name) VALUES ('modify_account', 'de', 'Zuordnung von Personen zu Gruppen');
INSERT INTO permission_localized (permission, translated, name) VALUES ('create_account', 'de', 'Zuordnung von Personen zu Gruppen');
INSERT INTO permission_localized (permission, translated, name) VALUES ('delete_account', 'de', 'Zuordnung von Personen zu Gruppen');


--
-- PostgreSQL database dump complete
--

