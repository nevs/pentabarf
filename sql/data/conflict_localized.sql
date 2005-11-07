--
-- PostgreSQL database dump
--

SET client_encoding = 'UNICODE';
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Data for Name: conflict_localized; Type: TABLE DATA; Schema: public; Owner: pentabarf
--

INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (4, 120, 'Accepted and confirmed event without confirmed speaker');
INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (4, 144, 'Akzeptierte und bestätigte Veranstaltung ohne bestätigten Referenten');
INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (11, 120, 'Accepted Event without paper');
INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (11, 144, 'Akzeptierte Veranstaltung ohne Paper');
INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (2, 144, 'Referent oder Moderator spricht nicht die Sprache der Veranstaltung');
INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (2, 120, 'Speaker or Moderator does not speak the language of the event');
INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (5, 120, 'Event without coordinator');
INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (5, 144, 'Veranstaltung ohne Koordinator');
INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (12, 120, 'Event with inconsistent public link');
INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (12, 144, 'Veranstaltung mit inkonsistentem öffentlichen Verweis');
INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (13, 120, 'Person with inconsistent public link');
INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (13, 144, 'Person mit inkonsistentem öffentlichen Verweis');
INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (14, 120, 'Accepted event with no language selected');
INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (14, 144, 'Akzeptierte Veranstaltung ohne eingetragene Sprache');
INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (15, 120, 'Accepted event without conference track');
INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (15, 144, 'Akzeptierte Veranstaltung ohne Track');
INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (6, 144, 'Akzeptierte Veranstaltung mit unvollständigen Angaben zu Tag, Raum oder Zeit');
INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (6, 120, 'Accepted event with data on incomplete day, room or time');
INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (7, 120, 'Two events at the same timeslot');
INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (7, 144, 'Zwei Events belegen den selben Zeitraum');
INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (8, 120, 'Event with missing unique tag');
INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (8, 144, 'Veranstaltung mit fehlender eindeutiger Kennung');
INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (9, 120, 'Events with duplicate tag');
INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (9, 144, 'Veranstaltungen mit doppelter Kennung');
INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (1, 120, 'Speaker or moderator without contact email address');
INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (1, 144, 'Referent oder Moderator ohne Kontakt-E-Mail-Adresse');
INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (3, 120, 'Speaker or moderator added to two simultaneously scheduled events');
INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (3, 144, 'Referent oder Moderator für zwei parallel stattfindende Veranstaltungen eingetragen');
INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (10, 120, 'Event with incorrectly named tag');
INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (10, 144, 'Veranstaltung mit fehlerhafter Kennung');
INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (16, 120, 'Speaker or moderator is visitor of another event at the same time');
INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (16, 144, 'Referent oder Moderator ist gleichzeitig bei einer anderen Veranstaltung Besucher');


--
-- PostgreSQL database dump complete
--

