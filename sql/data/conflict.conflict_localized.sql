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

INSERT INTO conflict_localized (conflict, translated, name) VALUES ('event_no_speaker', 'en', 'Accepted and confirmed event without confirmed speaker');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('event_no_speaker', 'de', 'Akzeptierte und bestätigte Veranstaltung ohne bestätigten Referenten');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('event_no_paper', 'en', 'Accepted Event without paper');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('event_no_paper', 'de', 'Akzeptierte Veranstaltung ohne Paper');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('event_person_language', 'de', 'Referent oder Moderator spricht nicht die Sprache der Veranstaltung');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('event_no_coordinator', 'en', 'Event without coordinator');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('event_no_coordinator', 'de', 'Veranstaltung ohne Koordinator');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('event_inconsistent_public_link', 'en', 'Event with inconsistent public link');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('event_inconsistent_public_link', 'de', 'Veranstaltung mit inkonsistentem öffentlichen Verweis');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('person_inconsistent_public_link', 'en', 'Person with inconsistent public link');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('person_inconsistent_public_link', 'de', 'Person mit inkonsistentem öffentlichen Verweis');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('event_no_language', 'en', 'Accepted event with no language selected');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('event_no_language', 'de', 'Akzeptierte Veranstaltung ohne eingetragene Sprache');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('event_no_track', 'en', 'Accepted event without conference track');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('event_no_track', 'de', 'Akzeptierte Veranstaltung ohne Track');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('event_incomplete', 'de', 'Akzeptierte Veranstaltung mit unvollständigen Angaben zu Tag, Raum oder Zeit');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('event_incomplete', 'en', 'Accepted event with data on incomplete day, room or time');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('event_event_time', 'en', 'Two events at the same timeslot');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('event_event_time', 'de', 'Zwei Events belegen den selben Zeitraum');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('event_missing_tag', 'en', 'Event with missing unique tag');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('event_missing_tag', 'de', 'Veranstaltung mit fehlender eindeutiger Kennung');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('event_event_duplicate_tag', 'en', 'Events with duplicate tag');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('event_event_duplicate_tag', 'de', 'Veranstaltungen mit doppelter Kennung');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('person_no_email', 'en', 'Speaker or moderator without contact email address');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('person_no_email', 'de', 'Referent oder Moderator ohne Kontakt-E-Mail-Adresse');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('event_person_event_time_speaker_speaker', 'en', 'Speaker or moderator added to two simultaneously scheduled events');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('event_person_event_time_speaker_speaker', 'de', 'Referent oder Moderator für zwei parallel stattfindende Veranstaltungen eingetragen');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('event_inconsistent_tag', 'en', 'Event with incorrectly named tag');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('event_inconsistent_tag', 'de', 'Veranstaltung mit fehlerhafter Kennung');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('event_person_event_time_speaker_visitor', 'en', 'Speaker or moderator is visitor of another event at the same time');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('event_person_event_time_speaker_visitor', 'de', 'Referent oder Moderator ist gleichzeitig bei einer anderen Veranstaltung Besucher');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('event_conference_language', 'en', 'Event has a language set which is not a conference language');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('event_conference_language', 'de', 'Eine Veranstaltung ist in einer Sprache die keine Konferenzsprache ist');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('event_person_event_time_visitor_visitor', 'en', 'A person is visitor of two simultaneous events');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('event_person_event_time_visitor_visitor', 'de', 'Eine Person ist bei 2 parallelen Veranstaltungen als Besucher eingetragen');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('person_no_description', 'en', 'Accepted speaker or moderator without description');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('person_no_description', 'de', 'Akzeptierter Referent oder Moderator ohne Langbeschreibung');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('person_no_abstract', 'en', 'Accepted speaker or moderator without abstract');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('person_no_abstract', 'de', 'Akzeptierter Referent oder Moderator ohne Kurzbeschreibung');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('event_no_description', 'en', 'event without description');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('event_no_description', 'de', 'Veranstaltung ohne Langbeschreibung');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('event_no_abstract', 'en', 'event without abstract');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('event_no_abstract', 'de', 'Veranstaltung ohne Kurzbeschreibung');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('event_person_event_before_arrival', 'en', 'Accepted event before arrival of speaker');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('event_person_event_before_arrival', 'de', 'Akzeptierter Event vor der Ankunft des Referenten');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('event_person_event_after_departure', 'en', 'Accepted event after departure of speaker');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('event_person_event_after_departure', 'de', 'Akzeptierter Event nach der Abreise des Referenten');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('event_no_slides', 'en', 'Accepted Event without slides');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('event_no_slides', 'de', 'Akzeptierte Veranstaltung ohne Folien');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('event_abstract_length', 'en', 'Recommended event abstract length exceeded');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('event_abstract_length', 'de', 'Empfohlene Veranstaltungsabstrakt-Länge überschritten');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('event_description_length', 'en', 'Recommended event description length exceeded');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('event_description_length', 'de', 'Empfohlene Veranstaltungsbeschreibungs-Länge überschritten');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('person_abstract_length', 'en', 'Recommended person abstract length exceeded');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('person_description_length', 'en', 'Recommended person description length exceeded');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('person_abstract_length', 'de', 'Empfohlene Personenabstrakt-Länge überschritten');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('person_description_length', 'de', 'Empfohlene Personenbeschreibungs-Länge überschritten');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('event_accepted_without_timeslot', 'en', 'Accepted and confirmed event without timeslot');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('event_unconfirmed_with_timeslot', 'en', 'Accepted and unconfirmed event with timeslot');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('event_unconfirmed_with_timeslot', 'de', 'Akzeptierte und unbestätigte Veranstaltung ohne Zeitfenster');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('event_accepted_without_timeslot', 'de', 'Akzeptierte und bestätigte Veranstaltung ohne Zeitfenster');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('event_person_person_availability', 'en', 'Speaker or moderator not available for an event');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('event_person_person_availability', 'de', 'Referent oder Moderator für einen Event nicht verfügbar');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('event_person_language', 'en', 'Speaker or moderator does not speak the language of the event');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('event_paper_unknown', 'en', 'Event with unknown paper state.');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('event_paper_unknown', 'de', 'Veranstaltung mit unklarem Paper-Status.');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('event_person_event_time_attendee', 'en', 'Attendee with two events at the same time.');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('event_person_event_time_attendee', 'de', 'Besucher mit zwei gleichzeitigen Veranstaltungen.');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('event_slides_unknown', 'en', 'Event with unknown slides state.');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('event_slides_unknown', 'de', 'Veranstaltung mit unklarem Folien-Status.');


--
-- PostgreSQL database dump complete
--

