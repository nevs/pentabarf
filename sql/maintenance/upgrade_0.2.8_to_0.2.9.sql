
DROP VIEW view_event_image_modification ;
DROP VIEW view_person_image_modification ;
DROP VIEW view_conference_image_modification ;
DROP VIEW view_event_image ;
DROP VIEW view_person_image ;
DROP VIEW view_conference_image ;
DROP VIEW view_schedule ;
DROP VIEW view_schedule_event ;
DROP VIEW view_schedule_person ;
DROP VIEW view_visitor_schedule ;
DROP VIEW view_report_arrived ;
DROP VIEW view_report_expenses ;
DROP VIEW view_report_feedback ;
DROP VIEW view_report_paper ;
DROP VIEW view_report_pickup ;
DROP VIEW view_report_schedule_coordinator ;
DROP VIEW view_report_schedule_gender ;
DROP VIEW view_conference_person ;
DROP VIEW view_conference_person_link_internal ;
DROP VIEW view_conference_persons ;
DROP VIEW view_event_attachment ;
DROP VIEW view_event_link_internal ;
DROP VIEW view_event_person ;
DROP VIEW view_event_person_simple_person ;
DROP VIEW view_event_rating ;
DROP VIEW view_event_rating_public ;
DROP VIEW view_event_related ;
DROP VIEW view_event_search_persons ;
DROP VIEW view_event_state_combined ;
DROP VIEW view_find_conference ;
DROP VIEW view_find_event ;
DROP VIEW view_find_person ;
DROP VIEW view_jid_login ;
DROP VIEW view_last_active ;
DROP VIEW view_mail_accepted_speaker ;
DROP VIEW view_mail_all_reviewer ;
DROP VIEW view_mail_all_speaker ;
DROP VIEW view_mail_missing_slides ;
DROP VIEW view_person_rating ;
DROP VIEW view_recent_changes ;
DROP VIEW view_review ;
DROP VIEW view_event ;
DROP VIEW view_person ;

ALTER TABLE person_travel ADD COLUMN f_need_accommodation BOOL NOT NULL DEFAULT FALSE;
ALTER TABLE conference ADD COLUMN email TEXT;
ALTER TABLE conference_logging ADD COLUMN email TEXT;

ALTER TABLE account_activation ADD COLUMN conference_id INTEGER REFERENCES conference( conference_id );

ALTER TABLE event ALTER tag TYPE TEXT;
ALTER TABLE event ALTER title TYPE TEXT;
ALTER TABLE event ALTER subtitle TYPE TEXT;

ALTER TABLE event_logging ALTER tag TYPE TEXT;
ALTER TABLE event_logging ALTER title TYPE TEXT;
ALTER TABLE event_logging ALTER subtitle TYPE TEXT;

ALTER TABLE conference ALTER title TYPE TEXT;
ALTER TABLE conference ALTER subtitle TYPE TEXT;
ALTER TABLE conference ALTER acronym TYPE TEXT;
ALTER TABLE conference ALTER venue TYPE TEXT;
ALTER TABLE conference ALTER city TYPE TEXT;

ALTER TABLE conference_logging ALTER title TYPE TEXT;
ALTER TABLE conference_logging ALTER subtitle TYPE TEXT;
ALTER TABLE conference_logging ALTER acronym TYPE TEXT;
ALTER TABLE conference_logging ALTER venue TYPE TEXT;
ALTER TABLE conference_logging ALTER city TYPE TEXT;

