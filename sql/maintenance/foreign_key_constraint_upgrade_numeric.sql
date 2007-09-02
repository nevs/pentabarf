
BEGIN;

-- foreign key constraint changes for table conference
ALTER TABLE conference DROP CONSTRAINT "$1";
ALTER TABLE conference DROP CONSTRAINT "$2";
ALTER TABLE conference DROP CONSTRAINT "$3";
ALTER TABLE conference DROP CONSTRAINT "$4";
ALTER TABLE conference DROP CONSTRAINT "$5";

ALTER TABLE conference ADD CONSTRAINT "conference_conference_phase_id_fkey" FOREIGN KEY (conference_phase_id) REFERENCES conference_phase (conference_phase_id) ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE conference ADD CONSTRAINT "conference_country_id_fkey" FOREIGN KEY (country_id) REFERENCES country (country_id) ON UPDATE CASCADE ON DELETE SET NULL;
ALTER TABLE conference ADD CONSTRAINT "conference_time_zone_id_fkey" FOREIGN KEY (time_zone_id) REFERENCES time_zone (time_zone_id) ON UPDATE CASCADE ON DELETE SET NULL;
ALTER TABLE conference ADD CONSTRAINT "conference_currency_id_fkey" FOREIGN KEY (currency_id) REFERENCES currency (currency_id) ON UPDATE CASCADE ON DELETE SET NULL;
ALTER TABLE conference ADD CONSTRAINT "conference_last_modified_by_fkey" FOREIGN KEY (last_modified_by) REFERENCES person (person_id) ON UPDATE CASCADE ON DELETE SET NULL;

-- foreign key constraint changes for table conference_image
ALTER TABLE conference_image DROP CONSTRAINT "$1";
ALTER TABLE conference_image DROP CONSTRAINT "$2";
ALTER TABLE conference_image DROP CONSTRAINT "$3";
ALTER TABLE conference_image ADD CONSTRAINT "conference_image_conference_id_fkey" FOREIGN KEY (conference_id) REFERENCES conference (conference_id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE conference_image ADD CONSTRAINT "conference_image_mime_type_id_fkey" FOREIGN KEY (mime_type_id) REFERENCES mime_type (mime_type_id) ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE conference_image ADD CONSTRAINT "conference_image_last_modified_by_fkey" FOREIGN KEY (last_modified_by) REFERENCES person(person_id) ON UPDATE CASCADE ON DELETE SET NULL;

-- foreign key constraint changes for table conference_language
ALTER TABLE conference_language DROP CONSTRAINT "$1";
ALTER TABLE conference_language DROP CONSTRAINT "$2";
ALTER TABLE conference_language ADD CONSTRAINT "conference_language_conference_id_fkey" FOREIGN KEY (conference_id) REFERENCES conference (conference_id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE conference_language ADD CONSTRAINT "conference_language_language_id_fkey" FOREIGN KEY (language_id) REFERENCES language (language_id) ON UPDATE CASCADE ON DELETE RESTRICT;

-- foreign key constraint changes for table conference_person
ALTER TABLE conference_person DROP CONSTRAINT "$1";
ALTER TABLE conference_person DROP CONSTRAINT "$2";
ALTER TABLE conference_person DROP CONSTRAINT "$3";
ALTER TABLE conference_person ADD CONSTRAINT "conference_person_conference_id_fkey" FOREIGN KEY (conference_id) REFERENCES conference (conference_id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE conference_person ADD CONSTRAINT "conference_person_person_id_fkey" FOREIGN KEY (person_id) REFERENCES person (person_id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE conference_person ADD CONSTRAINT "conference_person_last_modified_by_fkey" FOREIGN KEY (last_modified_by) REFERENCES person (person_id) ON UPDATE CASCADE ON DELETE SET NULL;

-- foreign key constraint changes for table conference_person_link_internal
ALTER TABLE conference_person_link_internal DROP CONSTRAINT "$1";
ALTER TABLE conference_person_link_internal DROP CONSTRAINT "$2";
ALTER TABLE conference_person_link_internal ADD CONSTRAINT "conference_person_link_internal_conference_person_id_fkey" FOREIGN KEY (conference_person_id) REFERENCES conference_person (conference_person_id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE conference_person_link_internal ADD CONSTRAINT "conference_person_link_internal_link_type_id_fkey" FOREIGN KEY (link_type_id) REFERENCES link_type (link_type_id) ON UPDATE CASCADE ON DELETE RESTRICT;

-- foreign key constraint changes for table conference_phase_conflict
ALTER TABLE conference_phase_conflict DROP CONSTRAINT "$1";
ALTER TABLE conference_phase_conflict DROP CONSTRAINT "$2";
ALTER TABLE conference_phase_conflict DROP CONSTRAINT "$3";
ALTER TABLE conference_phase_conflict ADD CONSTRAINT "conference_phase_conflict_conference_phase_id_fkey" FOREIGN KEY (conference_phase_id) REFERENCES conference_phase (conference_phase_id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE conference_phase_conflict ADD CONSTRAINT "conference_phase_conflict_conflict_id_fkey" FOREIGN KEY (conflict_id) REFERENCES conflict (conflict_id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE conference_phase_conflict ADD CONSTRAINT "conference_phase_conflict_conflict_level_id_fkey" FOREIGN KEY (conflict_level_id) REFERENCES conflict_level (conflict_level_id) ON UPDATE CASCADE ON DELETE RESTRICT;

-- foreign key constraint changes for table conflict
ALTER TABLE conflict DROP CONSTRAINT "$1";
ALTER TABLE conflict ADD CONSTRAINT "conflict_conflict_type_id_fkey" FOREIGN KEY (conflict_type_id) REFERENCES conflict_type (conflict_type_id) ON UPDATE CASCADE ON DELETE RESTRICT;

-- foreign key constraint changes for table event
ALTER TABLE event DROP CONSTRAINT "$1";
ALTER TABLE event DROP CONSTRAINT "$2";
ALTER TABLE event DROP CONSTRAINT "$3";
ALTER TABLE event DROP CONSTRAINT "$4";
ALTER TABLE event DROP CONSTRAINT "$5";
ALTER TABLE event DROP CONSTRAINT "$6";
ALTER TABLE event DROP CONSTRAINT "$7";
ALTER TABLE event DROP CONSTRAINT "$8";
ALTER TABLE event DROP CONSTRAINT "$9";
ALTER TABLE event DROP CONSTRAINT "$10";
ALTER TABLE event ADD CONSTRAINT "event_conference_id_fkey" FOREIGN KEY (conference_id) REFERENCES conference (conference_id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE event ADD CONSTRAINT "event_conference_track_id_fkey" FOREIGN KEY (conference_track_id) REFERENCES conference_track (conference_track_id) ON UPDATE CASCADE ON DELETE SET NULL;
ALTER TABLE event ADD CONSTRAINT "event_team_id_fkey" FOREIGN KEY (team_id) REFERENCES team(team_id) ON UPDATE CASCADE ON DELETE SET NULL;
ALTER TABLE event ADD CONSTRAINT "event_event_type_id_fkey" FOREIGN KEY (event_type_id) REFERENCES event_type (event_type_id) ON UPDATE CASCADE ON DELETE SET NULL;
ALTER TABLE event ADD CONSTRAINT "event_event_origin_id_fkey" FOREIGN KEY (event_origin_id) REFERENCES event_origin (event_origin_id) ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE event ADD CONSTRAINT "event_event_state_id_fkey" FOREIGN KEY (event_state_id) REFERENCES event_state (event_state_id) ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE event ADD CONSTRAINT "event_event_state_progress_id_fkey" FOREIGN KEY (event_state_progress_id) REFERENCES event_state_progress (event_state_progress_id) ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE event ADD CONSTRAINT "event_language_id_fkey" FOREIGN KEY (language_id) REFERENCES language (language_id) ON UPDATE CASCADE ON DELETE SET NULL;
ALTER TABLE event ADD CONSTRAINT "event_room_id_fkey" FOREIGN KEY (room_id) REFERENCES room (room_id) ON UPDATE CASCADE ON DELETE SET NULL;
ALTER TABLE event ADD CONSTRAINT "event_last_modified_by_fkey" FOREIGN KEY (last_modified_by) REFERENCES person (person_id) ON UPDATE CASCADE ON DELETE SET NULL;

-- foreign key constraint changes for table event_attachment

ALTER TABLE event_attachment DROP CONSTRAINT "$1";
ALTER TABLE event_attachment DROP CONSTRAINT "$2";
ALTER TABLE event_attachment DROP CONSTRAINT "$3";
ALTER TABLE event_attachment DROP CONSTRAINT "$4";
ALTER TABLE event_attachment ADD CONSTRAINT "event_attachment_attachment_type_id_fkey" FOREIGN KEY (attachment_type_id) REFERENCES attachment_type (attachment_type_id) ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE event_attachment ADD CONSTRAINT "event_attachment_event_id_fkey" FOREIGN KEY (event_id) REFERENCES event (event_id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE event_attachment ADD CONSTRAINT "event_attachment_mime_type_id_fkey" FOREIGN KEY (mime_type_id) REFERENCES mime_type (mime_type_id) ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE event_attachment ADD CONSTRAINT "event_attachment_last_modified_by_fkey" FOREIGN KEY (last_modified_by) REFERENCES person (person_id) ON UPDATE CASCADE ON DELETE SET NULL;

-- foreign key constraint changes for table event_image
ALTER TABLE event_image DROP CONSTRAINT "$1";
ALTER TABLE event_image DROP CONSTRAINT "$2";
ALTER TABLE event_image DROP CONSTRAINT "$3";
ALTER TABLE event_image ADD CONSTRAINT "event_image_event_id_fkey" FOREIGN KEY (event_id) REFERENCES event (event_id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE event_image ADD CONSTRAINT "event_image_mime_type_id_fkey" FOREIGN KEY (mime_type_id) REFERENCES mime_type (mime_type_id) ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE event_image ADD CONSTRAINT "event_image_last_modified_by_fkey" FOREIGN KEY (last_modified_by) REFERENCES person (person_id) ON UPDATE CASCADE ON DELETE SET NULL;

-- foreign key constraint changes for table event_link_internal
ALTER TABLE event_link_internal DROP CONSTRAINT "$1";
ALTER TABLE event_link_internal DROP CONSTRAINT "$2";
ALTER TABLE event_link_internal ADD CONSTRAINT "event_link_internal_event_id_fkey" FOREIGN KEY (event_id) REFERENCES event (event_id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE event_link_internal ADD CONSTRAINT "event_link_internal_link_type_id_fkey" FOREIGN KEY (link_type_id) REFERENCES link_type (link_type_id) ON UPDATE CASCADE ON DELETE RESTRICT;

-- foreign key constraint changes for table event_person
ALTER TABLE event_person DROP CONSTRAINT "$1";
ALTER TABLE event_person DROP CONSTRAINT "$2";
ALTER TABLE event_person DROP CONSTRAINT "$3";
ALTER TABLE event_person DROP CONSTRAINT "$4";
ALTER TABLE event_person DROP CONSTRAINT "$5";
ALTER TABLE event_person ADD CONSTRAINT "event_person_event_id_fkey" FOREIGN KEY (event_id) REFERENCES event (event_id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE event_person ADD CONSTRAINT "event_person_person_id_fkey" FOREIGN KEY (person_id) REFERENCES person (person_id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE event_person ADD CONSTRAINT "event_person_event_role_id_fkey" FOREIGN KEY (event_role_id) REFERENCES event_role (event_role_id) ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE event_person ADD CONSTRAINT "event_person_event_role_state_id_fkey" FOREIGN KEY (event_role_state_id) REFERENCES event_role_state (event_role_state_id) ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE event_person ADD CONSTRAINT "event_person_last_modified_by_fkey" FOREIGN KEY (last_modified_by) REFERENCES person (person_id) ON UPDATE CASCADE ON DELETE SET NULL;

-- foreign key constraint changes for table person
ALTER TABLE person DROP CONSTRAINT "$1";
ALTER TABLE person DROP CONSTRAINT "$2";
ALTER TABLE person ADD CONSTRAINT "person_country_id_fkey" FOREIGN KEY (country_id) REFERENCES country (country_id) ON UPDATE CASCADE ON DELETE SET NULL;
ALTER TABLE person ADD CONSTRAINT "person_last_modified_by_fkey" FOREIGN KEY (last_modified_by) REFERENCES person (person_id) ON UPDATE CASCADE ON DELETE SET NULL;

-- foreign key constraint changes for table person_im
ALTER TABLE person_im DROP CONSTRAINT "$1";
ALTER TABLE person_im DROP CONSTRAINT "$2";
ALTER TABLE person_im ADD CONSTRAINT "person_im_person_id_fkey" FOREIGN KEY (person_id) REFERENCES person (person_id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE person_im ADD CONSTRAINT "person_im_im_type_id_fkey" FOREIGN KEY (im_type_id) REFERENCES im_type (im_type_id) ON UPDATE CASCADE ON DELETE RESTRICT;

-- foreign key constraint changes for table person_image
ALTER TABLE person_image DROP CONSTRAINT "$1";
ALTER TABLE person_image DROP CONSTRAINT "$2";
ALTER TABLE person_image DROP CONSTRAINT "$3";
ALTER TABLE person_image ADD CONSTRAINT "person_image_person_id_fkey" FOREIGN KEY (person_id) REFERENCES person (person_id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE person_image ADD CONSTRAINT "person_image_mime_type_id_fkey" FOREIGN KEY (mime_type_id) REFERENCES mime_type (mime_type_id) ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE person_image ADD CONSTRAINT "person_image_last_modified_by_fkey" FOREIGN KEY (last_modified_by) REFERENCES person (person_id) ON UPDATE CASCADE ON DELETE SET NULL;

-- foreign key constraint changes for table person_language
ALTER TABLE person_language DROP CONSTRAINT "$1";
ALTER TABLE person_language DROP CONSTRAINT "$2";
ALTER TABLE person_language ADD CONSTRAINT "person_language_person_id_fkey" FOREIGN KEY (person_id) REFERENCES person (person_id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE person_language ADD CONSTRAINT "person_language_language_id_fkey" FOREIGN KEY (language_id) REFERENCES language (language_id) ON UPDATE CASCADE ON DELETE RESTRICT;

-- foreign key constraint changes for table person_phone
ALTER TABLE person_phone DROP CONSTRAINT "$1";
ALTER TABLE person_phone DROP CONSTRAINT "$2";
ALTER TABLE person_phone ADD CONSTRAINT "person_phone_person_id_fkey" FOREIGN KEY (person_id) REFERENCES person (person_id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE person_phone ADD CONSTRAINT "person_phone_phone_type_id_fkey" FOREIGN KEY (phone_type_id) REFERENCES phone_type (phone_type_id) ON UPDATE CASCADE ON DELETE RESTRICT;

-- foreign key constraint changes for table person_travel
ALTER TABLE person_travel DROP CONSTRAINT "$1";
ALTER TABLE person_travel DROP CONSTRAINT "$2";
ALTER TABLE person_travel DROP CONSTRAINT "$3";
ALTER TABLE person_travel DROP CONSTRAINT "$4";
ALTER TABLE person_travel DROP CONSTRAINT "$5";
ALTER TABLE person_travel DROP CONSTRAINT "$6";
ALTER TABLE person_travel DROP CONSTRAINT "$7";
ALTER TABLE person_travel DROP CONSTRAINT "$8";
ALTER TABLE person_travel ADD CONSTRAINT "person_travel_person_id_fkey" FOREIGN KEY (person_id) REFERENCES person (person_id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE person_travel ADD CONSTRAINT "person_travel_conference_id_fkey" FOREIGN KEY (conference_id) REFERENCES conference (conference_id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE person_travel ADD CONSTRAINT "person_travel_arrival_transport_id_fkey" FOREIGN KEY (arrival_transport_id) REFERENCES transport (transport_id) ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE person_travel ADD CONSTRAINT "person_travel_departure_transport_id_fkey" FOREIGN KEY (departure_transport_id) REFERENCES transport (transport_id) ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE person_travel ADD CONSTRAINT "person_travel_travel_currency_id_fkey" FOREIGN KEY (travel_currency_id) REFERENCES currency (currency_id) ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE person_travel ADD CONSTRAINT "person_travel_accommodation_currency_id_fkey" FOREIGN KEY (accommodation_currency_id) REFERENCES currency (currency_id) ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE person_travel ADD CONSTRAINT "person_travel_fee_currency_id_fkey" FOREIGN KEY (fee_currency_id) REFERENCES currency (currency_id) ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE person_travel ADD CONSTRAINT "person_travel_last_modified_by_fkey" FOREIGN KEY (last_modified_by) REFERENCES person (person_id) ON UPDATE CASCADE ON DELETE SET NULL;

COMMIT;

