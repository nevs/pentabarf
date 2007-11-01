--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = conflict, pg_catalog;

--
-- Data for Name: conflict_localized; Type: TABLE DATA; Schema: conflict; Owner: -
--

INSERT INTO conflict_localized (language_id, name, conflict) VALUES (120, 'Accepted and confirmed event without confirmed speaker', 'event_no_speaker');
INSERT INTO conflict_localized (language_id, name, conflict) VALUES (144, 'Akzeptierte und bestätigte Veranstaltung ohne bestätigten Referenten', 'event_no_speaker');
INSERT INTO conflict_localized (language_id, name, conflict) VALUES (120, 'Accepted Event without paper', 'event_no_paper');
INSERT INTO conflict_localized (language_id, name, conflict) VALUES (144, 'Akzeptierte Veranstaltung ohne Paper', 'event_no_paper');
INSERT INTO conflict_localized (language_id, name, conflict) VALUES (144, 'Referent oder Moderator spricht nicht die Sprache der Veranstaltung', 'event_person_language');
INSERT INTO conflict_localized (language_id, name, conflict) VALUES (120, 'Event without coordinator', 'event_no_coordinator');
INSERT INTO conflict_localized (language_id, name, conflict) VALUES (144, 'Veranstaltung ohne Koordinator', 'event_no_coordinator');
INSERT INTO conflict_localized (language_id, name, conflict) VALUES (120, 'Event with inconsistent public link', 'event_inconsistent_public_link');
INSERT INTO conflict_localized (language_id, name, conflict) VALUES (144, 'Veranstaltung mit inkonsistentem öffentlichen Verweis', 'event_inconsistent_public_link');
INSERT INTO conflict_localized (language_id, name, conflict) VALUES (120, 'Person with inconsistent public link', 'person_inconsistent_public_link');
INSERT INTO conflict_localized (language_id, name, conflict) VALUES (144, 'Person mit inkonsistentem öffentlichen Verweis', 'person_inconsistent_public_link');
INSERT INTO conflict_localized (language_id, name, conflict) VALUES (120, 'Accepted event with no language selected', 'event_no_language');
INSERT INTO conflict_localized (language_id, name, conflict) VALUES (144, 'Akzeptierte Veranstaltung ohne eingetragene Sprache', 'event_no_language');
INSERT INTO conflict_localized (language_id, name, conflict) VALUES (120, 'Accepted event without conference track', 'event_no_track');
INSERT INTO conflict_localized (language_id, name, conflict) VALUES (144, 'Akzeptierte Veranstaltung ohne Track', 'event_no_track');
INSERT INTO conflict_localized (language_id, name, conflict) VALUES (144, 'Akzeptierte Veranstaltung mit unvollständigen Angaben zu Tag, Raum oder Zeit', 'event_incomplete');
INSERT INTO conflict_localized (language_id, name, conflict) VALUES (120, 'Accepted event with data on incomplete day, room or time', 'event_incomplete');
INSERT INTO conflict_localized (language_id, name, conflict) VALUES (120, 'Two events at the same timeslot', 'event_event_time');
INSERT INTO conflict_localized (language_id, name, conflict) VALUES (144, 'Zwei Events belegen den selben Zeitraum', 'event_event_time');
INSERT INTO conflict_localized (language_id, name, conflict) VALUES (120, 'Event with missing unique tag', 'event_missing_tag');
INSERT INTO conflict_localized (language_id, name, conflict) VALUES (144, 'Veranstaltung mit fehlender eindeutiger Kennung', 'event_missing_tag');
INSERT INTO conflict_localized (language_id, name, conflict) VALUES (120, 'Events with duplicate tag', 'event_event_duplicate_tag');
INSERT INTO conflict_localized (language_id, name, conflict) VALUES (144, 'Veranstaltungen mit doppelter Kennung', 'event_event_duplicate_tag');
INSERT INTO conflict_localized (language_id, name, conflict) VALUES (120, 'Speaker or moderator without contact email address', 'person_no_email');
INSERT INTO conflict_localized (language_id, name, conflict) VALUES (144, 'Referent oder Moderator ohne Kontakt-E-Mail-Adresse', 'person_no_email');
INSERT INTO conflict_localized (language_id, name, conflict) VALUES (120, 'Speaker or moderator added to two simultaneously scheduled events', 'event_person_event_time_speaker_speaker');
INSERT INTO conflict_localized (language_id, name, conflict) VALUES (144, 'Referent oder Moderator für zwei parallel stattfindende Veranstaltungen eingetragen', 'event_person_event_time_speaker_speaker');
INSERT INTO conflict_localized (language_id, name, conflict) VALUES (120, 'Event with incorrectly named tag', 'event_inconsistent_tag');
INSERT INTO conflict_localized (language_id, name, conflict) VALUES (144, 'Veranstaltung mit fehlerhafter Kennung', 'event_inconsistent_tag');
INSERT INTO conflict_localized (language_id, name, conflict) VALUES (120, 'Speaker or moderator is visitor of another event at the same time', 'event_person_event_time_speaker_visitor');
INSERT INTO conflict_localized (language_id, name, conflict) VALUES (144, 'Referent oder Moderator ist gleichzeitig bei einer anderen Veranstaltung Besucher', 'event_person_event_time_speaker_visitor');
INSERT INTO conflict_localized (language_id, name, conflict) VALUES (120, 'Event has a language set which is not a conference language', 'event_conference_language');
INSERT INTO conflict_localized (language_id, name, conflict) VALUES (144, 'Eine Veranstaltung ist in einer Sprache die keine Konferenzsprache ist', 'event_conference_language');
INSERT INTO conflict_localized (language_id, name, conflict) VALUES (120, 'A person is visitor of two simultaneous events', 'event_person_event_time_visitor_visitor');
INSERT INTO conflict_localized (language_id, name, conflict) VALUES (144, 'Eine Person ist bei 2 parallelen Veranstaltungen als Besucher eingetragen', 'event_person_event_time_visitor_visitor');
INSERT INTO conflict_localized (language_id, name, conflict) VALUES (120, 'Accepted speaker or moderator without description', 'person_no_description');
INSERT INTO conflict_localized (language_id, name, conflict) VALUES (144, 'Akzeptierter Referent oder Moderator ohne Langbeschreibung', 'person_no_description');
INSERT INTO conflict_localized (language_id, name, conflict) VALUES (120, 'Accepted speaker or moderator without abstract', 'person_no_abstract');
INSERT INTO conflict_localized (language_id, name, conflict) VALUES (144, 'Akzeptierter Referent oder Moderator ohne Kurzbeschreibung', 'person_no_abstract');
INSERT INTO conflict_localized (language_id, name, conflict) VALUES (120, 'event without description', 'event_no_description');
INSERT INTO conflict_localized (language_id, name, conflict) VALUES (144, 'Veranstaltung ohne Langbeschreibung', 'event_no_description');
INSERT INTO conflict_localized (language_id, name, conflict) VALUES (120, 'event without abstract', 'event_no_abstract');
INSERT INTO conflict_localized (language_id, name, conflict) VALUES (144, 'Veranstaltung ohne Kurzbeschreibung', 'event_no_abstract');
INSERT INTO conflict_localized (language_id, name, conflict) VALUES (120, 'Accepted event before arrival of speaker', 'event_person_event_before_arrival');
INSERT INTO conflict_localized (language_id, name, conflict) VALUES (144, 'Akzeptierter Event vor der Ankunft des Referenten', 'event_person_event_before_arrival');
INSERT INTO conflict_localized (language_id, name, conflict) VALUES (120, 'Accepted event after departure of speaker', 'event_person_event_after_departure');
INSERT INTO conflict_localized (language_id, name, conflict) VALUES (144, 'Akzeptierter Event nach der Abreise des Referenten', 'event_person_event_after_departure');
INSERT INTO conflict_localized (language_id, name, conflict) VALUES (120, 'Accepted Event without slides', 'event_no_slides');
INSERT INTO conflict_localized (language_id, name, conflict) VALUES (144, 'Akzeptierte Veranstaltung ohne Folien', 'event_no_slides');
INSERT INTO conflict_localized (language_id, name, conflict) VALUES (120, 'Recommended event abstract length exceeded', 'event_abstract_length');
INSERT INTO conflict_localized (language_id, name, conflict) VALUES (144, 'Empfohlene Veranstaltungsabstrakt-Länge überschritten', 'event_abstract_length');
INSERT INTO conflict_localized (language_id, name, conflict) VALUES (120, 'Recommended event description length exceeded', 'event_description_length');
INSERT INTO conflict_localized (language_id, name, conflict) VALUES (144, 'Empfohlene Veranstaltungsbeschreibungs-Länge überschritten', 'event_description_length');
INSERT INTO conflict_localized (language_id, name, conflict) VALUES (120, 'Recommended person abstract length exceeded', 'person_abstract_length');
INSERT INTO conflict_localized (language_id, name, conflict) VALUES (120, 'Recommended person description length exceeded', 'person_description_length');
INSERT INTO conflict_localized (language_id, name, conflict) VALUES (144, 'Empfohlene Personenabstrakt-Länge überschritten', 'person_abstract_length');
INSERT INTO conflict_localized (language_id, name, conflict) VALUES (144, 'Empfohlene Personenbeschreibungs-Länge überschritten', 'person_description_length');
INSERT INTO conflict_localized (language_id, name, conflict) VALUES (120, 'Accepted and confirmed event without timeslot', 'event_accepted_without_timeslot');
INSERT INTO conflict_localized (language_id, name, conflict) VALUES (120, 'Accepted and unconfirmed event with timeslot', 'event_unconfirmed_with_timeslot');
INSERT INTO conflict_localized (language_id, name, conflict) VALUES (144, 'Akzeptierte und unbestätigte Veranstaltung ohne Zeitfenster', 'event_unconfirmed_with_timeslot');
INSERT INTO conflict_localized (language_id, name, conflict) VALUES (144, 'Akzeptierte und bestätigte Veranstaltung ohne Zeitfenster', 'event_accepted_without_timeslot');
INSERT INTO conflict_localized (language_id, name, conflict) VALUES (120, 'Speaker or moderator not available for an event', 'event_person_person_availability');
INSERT INTO conflict_localized (language_id, name, conflict) VALUES (144, 'Referent oder Moderator für einen Event nicht verfügbar', 'event_person_person_availability');
INSERT INTO conflict_localized (language_id, name, conflict) VALUES (120, 'Speaker or moderator does not speak the language of the event', 'event_person_language');


--
-- PostgreSQL database dump complete
--

