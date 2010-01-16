
BEGIN;

-- register event_without_break_after and event_without_break_before
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (176, 'chaos', 'event_without_break_after', 'error');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (177, 'discord', 'event_without_break_after', 'error');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (178, 'bureaucracy', 'event_without_break_after', 'error');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (179, 'confusion', 'event_without_break_after', 'error');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (180, 'aftermath', 'event_without_break_after', 'silent');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (181, 'chaos', 'event_without_break_before', 'error');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (182, 'discord', 'event_without_break_before', 'error');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (183, 'bureaucracy', 'event_without_break_before', 'error');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (184, 'confusion', 'event_without_break_before', 'error');
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase, conflict, conflict_level) VALUES (185, 'aftermath', 'event_without_break_before', 'silent');
INSERT INTO conflict (conflict, conflict_type) VALUES ('event_without_break_after', 'event_event');
INSERT INTO conflict (conflict, conflict_type) VALUES ('event_without_break_before', 'event_event');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('event_without_break_after', 'de', 'Veranstaltung ohne Pause danach');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('event_without_break_after', 'en', 'Event without break after');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('event_without_break_before', 'de', 'Veranstaltultung ohne Pause davor');
INSERT INTO conflict_localized (conflict, translated, name) VALUES ('event_without_break_before', 'en', 'Event without break before');

COMMIT;
