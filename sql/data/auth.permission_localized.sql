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

INSERT INTO permission_localized (permission, translated_id, name) VALUES ('create_person', 144, 'Anlegen einer Person');
INSERT INTO permission_localized (permission, translated_id, name) VALUES ('modify_person', 144, 'Modifizieren einer Person');
INSERT INTO permission_localized (permission, translated_id, name) VALUES ('delete_person', 144, 'Löschen einer Person');
INSERT INTO permission_localized (permission, translated_id, name) VALUES ('create_event', 144, 'Anlegen einer Veranstaltung');
INSERT INTO permission_localized (permission, translated_id, name) VALUES ('modify_event', 144, 'Modifizieren einer Veranstaltung');
INSERT INTO permission_localized (permission, translated_id, name) VALUES ('delete_event', 144, 'Löschen einer Verantstaltung');
INSERT INTO permission_localized (permission, translated_id, name) VALUES ('create_conference', 144, 'Anlegen einer Konferenz');
INSERT INTO permission_localized (permission, translated_id, name) VALUES ('modify_conference', 144, 'Modifizieren einer Konferenz');
INSERT INTO permission_localized (permission, translated_id, name) VALUES ('delete_conference', 144, 'Löschen einer Konferenz');
INSERT INTO permission_localized (permission, translated_id, name) VALUES ('modify_localization', 144, 'Modifizieren von Lokalisierungen');
INSERT INTO permission_localized (permission, translated_id, name) VALUES ('modify_valuelist', 144, 'Modifizieren von Werten in Wertelisten');
INSERT INTO permission_localized (permission, translated_id, name) VALUES ('create_roles', 144, 'Anlegen von Rollen');
INSERT INTO permission_localized (permission, translated_id, name) VALUES ('modify_roles', 144, 'Bearbeiten von Rollen');
INSERT INTO permission_localized (permission, translated_id, name) VALUES ('delete_roles', 144, 'Löschen von Rollen');
INSERT INTO permission_localized (permission, translated_id, name) VALUES ('create_login', 144, 'Zuordnung von Personen zu Gruppen');
INSERT INTO permission_localized (permission, translated_id, name) VALUES ('modify_login', 144, 'Zuordnung von Personen zu Gruppen');
INSERT INTO permission_localized (permission, translated_id, name) VALUES ('delete_login', 144, 'Zuordnung von Personen zu Gruppen');
INSERT INTO permission_localized (permission, translated_id, name) VALUES ('modify_own_person', 144, 'Modifizierung der Daten zur eigenen Person');
INSERT INTO permission_localized (permission, translated_id, name) VALUES ('modify_own_event', 144, 'Modifizierung der Daten an der die Person beteiligt ist');


--
-- PostgreSQL database dump complete
--

