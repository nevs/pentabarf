--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Data for Name: conflict_localized; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (4, 120, 'Accepted and confirmed event without confirmed speaker');
INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (4, 144, 'Akzeptierte und bestätigte Veranstaltung ohne bestätigten Referenten');
INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (11, 120, 'Accepted Event without paper');
INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (11, 144, 'Akzeptierte Veranstaltung ohne Paper');
INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (2, 144, 'Referent oder Moderator spricht nicht die Sprache der Veranstaltung');
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
INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (17, 120, 'Event has a language set which is not a conference language');
INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (17, 144, 'Eine Veranstaltung ist in einer Sprache die keine Konferenzsprache ist');
INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (18, 120, 'A person is visitor of two simultaneous events');
INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (18, 144, 'Eine Person ist bei 2 parallelen Veranstaltungen als Besucher eingetragen');
INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (22, 120, 'Accepted speaker or moderator without description');
INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (22, 144, 'Akzeptierter Referent oder Moderator ohne Langbeschreibung');
INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (21, 120, 'Accepted speaker or moderator without abstract');
INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (21, 144, 'Akzeptierter Referent oder Moderator ohne Kurzbeschreibung');
INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (20, 120, 'event without description');
INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (20, 144, 'Veranstaltung ohne Langbeschreibung');
INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (19, 120, 'event without abstract');
INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (19, 144, 'Veranstaltung ohne Kurzbeschreibung');
INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (23, 120, 'Accepted event before arrival of speaker');
INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (23, 144, 'Akzeptierter Event vor der Ankunft des Referenten');
INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (24, 120, 'Accepted event after departure of speaker');
INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (24, 144, 'Akzeptierter Event nach der Abreise des Referenten');
INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (25, 120, 'Accepted Event without slides');
INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (25, 144, 'Akzeptierte Veranstaltung ohne Folien');
INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (27, 120, 'Recommended event abstract length exceeded');
INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (27, 144, 'Empfohlene Veranstaltungsabstrakt-Länge überschritten');
INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (28, 120, 'Recommended event description length exceeded');
INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (28, 144, 'Empfohlene Veranstaltungsbeschreibungs-Länge überschritten');
INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (29, 120, 'Recommended person abstract length exceeded');
INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (30, 120, 'Recommended person description length exceeded');
INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (29, 144, 'Empfohlene Personenabstrakt-Länge überschritten');
INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (30, 144, 'Empfohlene Personenbeschreibungs-Länge überschritten');
INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (31, 120, 'Accepted and confirmed event without timeslot');
INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (32, 120, 'Accepted and unconfirmed event with timeslot');
INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (32, 144, 'Akzeptierte und unbestätigte Veranstaltung ohne Zeitfenster');
INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (31, 144, 'Akzeptierte und bestätigte Veranstaltung ohne Zeitfenster');
INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (35, 120, 'Speaker or moderator not available for an event');
INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (35, 144, 'Referent oder Moderator für einen Event nicht verfügbar');
INSERT INTO conflict_localized (conflict_id, language_id, name) VALUES (2, 120, 'Speaker or moderator does not speak the language of the event');


--
-- PostgreSQL database dump complete
--

