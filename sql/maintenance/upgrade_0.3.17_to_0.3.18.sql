
BEGIN;

DROP VIEW view_schedule_simple;
DROP VIEW view_schedule_calendar;

CREATE INDEX log_event_related_event_id1_idx ON log.event_related( event_id1 );
CREATE INDEX log_event_related_event_id2_idx ON log.event_related( event_id2 );
CREATE INDEX log_event_related_log_transaction_id_idx ON log.event_related( log_transaction_id );

CREATE INDEX log_event_event_id_idx ON log.event( event_id );
CREATE INDEX log_event_log_transaction_id_idx ON log.event( log_transaction_id );

CREATE INDEX log_transport_localized_transport_idx ON log.transport_localized( transport );
CREATE INDEX log_transport_localized_log_transaction_id_idx ON log.transport_localized( log_transaction_id );

CREATE INDEX log_event_role_localized_event_role_idx ON log.event_role_localized( event_role );
CREATE INDEX log_event_role_localized_log_transaction_id_idx ON log.event_role_localized( log_transaction_id );

CREATE INDEX log_event_origin_event_origin_idx ON log.event_origin( event_origin );
CREATE INDEX log_event_origin_log_transaction_id_idx ON log.event_origin( log_transaction_id );

CREATE INDEX log_phone_type_localized_phone_type_idx ON log.phone_type_localized( phone_type );
CREATE INDEX log_phone_type_localized_log_transaction_id_idx ON log.phone_type_localized( log_transaction_id );

CREATE INDEX log_conflict_conflict_idx ON log.conflict( conflict );
CREATE INDEX log_conflict_log_transaction_id_idx ON log.conflict( log_transaction_id );

CREATE INDEX log_conflict_type_conflict_type_idx ON log.conflict_type( conflict_type );
CREATE INDEX log_conflict_type_log_transaction_id_idx ON log.conflict_type( log_transaction_id );

CREATE INDEX log_conflict_localized_conflict_idx ON log.conflict_localized( conflict );
CREATE INDEX log_conflict_localized_log_transaction_id_idx ON log.conflict_localized( log_transaction_id );

CREATE INDEX log_conference_phase_conflict_conference_phase_conflict_id_idx ON log.conference_phase_conflict( conference_phase_conflict_id );
CREATE INDEX log_conference_phase_conflict_log_transaction_id_idx ON log.conference_phase_conflict( log_transaction_id );

CREATE INDEX log_conflict_level_conflict_level_idx ON log.conflict_level( conflict_level );
CREATE INDEX log_conflict_level_log_transaction_id_idx ON log.conflict_level( log_transaction_id );

CREATE INDEX log_conflict_level_localized_conflict_level_idx ON log.conflict_level_localized( conflict_level );
CREATE INDEX log_conflict_level_localized_log_transaction_id_idx ON log.conflict_level_localized( log_transaction_id );

CREATE INDEX log_conference_day_conference_day_id_idx ON log.conference_day( conference_day_id );
CREATE INDEX log_conference_day_log_transaction_id_idx ON log.conference_day( log_transaction_id );

CREATE INDEX log_person_person_id_idx ON log.person( person_id );
CREATE INDEX log_person_log_transaction_id_idx ON log.person( log_transaction_id );

CREATE INDEX log_event_state_localized_event_state_idx ON log.event_state_localized( event_state );
CREATE INDEX log_event_state_localized_log_transaction_id_idx ON log.event_state_localized( log_transaction_id );

CREATE INDEX log_ui_message_localized_ui_message_idx ON log.ui_message_localized( ui_message );
CREATE INDEX log_ui_message_localized_log_transaction_id_idx ON log.ui_message_localized( log_transaction_id );

CREATE INDEX log_person_image_person_id_idx ON log.person_image( person_id );
CREATE INDEX log_person_image_log_transaction_id_idx ON log.person_image( log_transaction_id );

CREATE INDEX log_person_language_person_id_idx ON log.person_language( person_id );
CREATE INDEX log_person_language_log_transaction_id_idx ON log.person_language( log_transaction_id );

CREATE INDEX log_conference_person_link_conference_person_link_id_idx ON log.conference_person_link( conference_person_link_id );
CREATE INDEX log_conference_person_link_conference_person_id_idx ON log.conference_person_link( conference_person_id );
CREATE INDEX log_conference_person_link_log_transaction_id_idx ON log.conference_person_link( log_transaction_id );

CREATE INDEX log_conference_phase_localized_conference_phase_idx ON log.conference_phase_localized( conference_phase );
CREATE INDEX log_conference_phase_localized_log_transaction_id_idx ON log.conference_phase_localized( log_transaction_id );

CREATE INDEX log_conference_team_conference_team_idx ON log.conference_team( conference_team );
CREATE INDEX log_conference_team_log_transaction_id_idx ON log.conference_team( log_transaction_id );

CREATE INDEX log_mime_type_localized_mime_type_idx ON log.mime_type_localized( mime_type );
CREATE INDEX log_mime_type_localized_log_transaction_id_idx ON log.mime_type_localized( log_transaction_id );

CREATE INDEX log_currency_localized_currency_idx ON log.currency_localized( currency );
CREATE INDEX log_currency_localized_log_transaction_id_idx ON log.currency_localized( log_transaction_id );

CREATE INDEX log_event_state_event_state_idx ON log.event_state( event_state );
CREATE INDEX log_event_state_log_transaction_id_idx ON log.event_state( log_transaction_id );

CREATE INDEX log_event_type_event_type_idx ON log.event_type( event_type );
CREATE INDEX log_event_type_log_transaction_id_idx ON log.event_type( log_transaction_id );

CREATE INDEX log_event_rating_category_event_rating_category_id_idx ON log.event_rating_category( event_rating_category_id );
CREATE INDEX log_event_rating_category_log_transaction_id_idx ON log.event_rating_category( log_transaction_id );

CREATE INDEX log_log_transaction_log_transaction_id_idx ON log.log_transaction( log_transaction_id );

CREATE INDEX log_log_transaction_involved_tables_log_transaction_id_idx ON log.log_transaction_involved_tables( log_transaction_id );

CREATE INDEX log_link_type_localized_link_type_idx ON log.link_type_localized( link_type );
CREATE INDEX log_link_type_localized_log_transaction_id_idx ON log.link_type_localized( log_transaction_id );

CREATE INDEX log_event_rating_event_id_idx ON log.event_rating( event_id );
CREATE INDEX log_event_rating_log_transaction_id_idx ON log.event_rating( log_transaction_id );

CREATE INDEX log_event_rating_remark_event_id_idx ON log.event_rating_remark( event_id );
CREATE INDEX log_event_rating_remark_log_transaction_id_idx ON log.event_rating_remark( log_transaction_id );

CREATE INDEX log_conference_phase_conference_phase_idx ON log.conference_phase( conference_phase );
CREATE INDEX log_conference_phase_log_transaction_id_idx ON log.conference_phase( log_transaction_id );

CREATE INDEX log_event_attachment_event_attachment_id_idx ON log.event_attachment( event_attachment_id );
CREATE INDEX log_event_attachment_log_transaction_id_idx ON log.event_attachment( log_transaction_id );

CREATE INDEX log_event_link_internal_event_link_internal_id_idx ON log.event_link_internal( event_link_internal_id );
CREATE INDEX log_event_link_internal_log_transaction_id_idx ON log.event_link_internal( log_transaction_id );

CREATE INDEX log_timezone_timezone_idx ON log.timezone( timezone );
CREATE INDEX log_timezone_log_transaction_id_idx ON log.timezone( log_transaction_id );

CREATE INDEX log_person_phone_person_phone_id_idx ON log.person_phone( person_phone_id );
CREATE INDEX log_person_phone_log_transaction_id_idx ON log.person_phone( log_transaction_id );

CREATE INDEX log_event_role_state_event_role_event_role_state_idx ON log.event_role_state( event_role, event_role_state );
CREATE INDEX log_event_role_state_log_transaction_id_idx ON log.event_role_state( log_transaction_id );

CREATE INDEX log_conference_room_conference_room_id_idx ON log.conference_room( conference_room_id );
CREATE INDEX log_conference_room_log_transaction_id_idx ON log.conference_room( log_transaction_id );

CREATE INDEX log_im_type_im_type_idx ON log.im_type( im_type );
CREATE INDEX log_im_type_log_transaction_id_idx ON log.im_type( log_transaction_id );

CREATE INDEX log_conference_release_conference_release_id_idx ON log.conference_release( conference_release_id );
CREATE INDEX log_conference_release_log_transaction_id_idx ON log.conference_release( log_transaction_id );

CREATE INDEX log_conference_conference_id_idx ON log.conference( conference_id );
CREATE INDEX log_conference_log_transaction_id_idx ON log.conference( log_transaction_id );

CREATE INDEX log_conference_person_travel_conference_person_id_idx ON log.conference_person_travel( conference_person_id );
CREATE INDEX log_conference_person_travel_log_transaction_id_idx ON log.conference_person_travel( log_transaction_id );

CREATE INDEX log_event_origin_localized_event_origin_idx ON log.event_origin_localized( event_origin );
CREATE INDEX log_event_origin_localized_log_transaction_id_idx ON log.event_origin_localized( log_transaction_id );

CREATE INDEX log_event_image_event_id_idx ON log.event_image( event_id );
CREATE INDEX log_event_image_log_transaction_id_idx ON log.event_image( log_transaction_id );

CREATE INDEX log_conference_link_conference_id_idx ON log.conference_link( conference_id );
CREATE INDEX log_conference_link_log_transaction_id_idx ON log.conference_link( log_transaction_id );

CREATE INDEX log_conference_room_role_conference_room_id_idx ON log.conference_room_role( conference_room_id );
CREATE INDEX log_conference_room_role_log_transaction_id_idx ON log.conference_room_role( log_transaction_id );

CREATE INDEX log_event_feedback_event_feedback_id_idx ON log.event_feedback( event_feedback_id );
CREATE INDEX log_event_feedback_log_transaction_id_idx ON log.event_feedback( log_transaction_id );

CREATE INDEX log_country_localized_country_idx ON log.country_localized( country );
CREATE INDEX log_country_localized_log_transaction_id_idx ON log.country_localized( log_transaction_id );

CREATE INDEX log_person_im_person_im_id_idx ON log.person_im( person_im_id );
CREATE INDEX log_person_im_log_transaction_id_idx ON log.person_im( log_transaction_id );

CREATE INDEX log_transport_transport_idx ON log.transport( transport );
CREATE INDEX log_transport_log_transaction_id_idx ON log.transport( log_transaction_id );

CREATE INDEX log_conference_person_conference_person_id_idx ON log.conference_person( conference_person_id );
CREATE INDEX log_conference_person_log_transaction_id_idx ON log.conference_person( log_transaction_id );

CREATE INDEX log_event_link_event_link_id_idx ON log.event_link( event_link_id );
CREATE INDEX log_event_link_log_transaction_id_idx ON log.event_link( log_transaction_id );

CREATE INDEX log_event_role_event_role_idx ON log.event_role( event_role );
CREATE INDEX log_event_role_log_transaction_id_idx ON log.event_role( log_transaction_id );

CREATE INDEX log_role_role_idx ON log.role( role );
CREATE INDEX log_role_log_transaction_id_idx ON log.role( log_transaction_id );

CREATE INDEX log_domain_domain_idx ON log.domain( domain );
CREATE INDEX log_domain_log_transaction_id_idx ON log.domain( log_transaction_id );

CREATE INDEX log_role_localized_role_idx ON log.role_localized( role );
CREATE INDEX log_role_localized_log_transaction_id_idx ON log.role_localized( log_transaction_id );

CREATE INDEX log_permission_permission_idx ON log.permission( permission );
CREATE INDEX log_permission_log_transaction_id_idx ON log.permission( log_transaction_id );

CREATE INDEX log_role_permission_role_idx ON log.role_permission( role );
CREATE INDEX log_role_permission_log_transaction_id_idx ON log.role_permission( log_transaction_id );

CREATE INDEX log_account_account_id_idx ON log.account( account_id );
CREATE INDEX log_account_log_transaction_id_idx ON log.account( log_transaction_id );

CREATE INDEX log_account_activation_account_id_idx ON log.account_activation( account_id );
CREATE INDEX log_account_activation_log_transaction_id_idx ON log.account_activation( log_transaction_id );


CREATE INDEX log_account_role_account_id_idx ON log.account_role( account_id );
CREATE INDEX log_account_role_log_transaction_id_idx ON log.account_role( log_transaction_id );

CREATE INDEX log_object_domain_object_idx ON log.object_domain( object );
CREATE INDEX log_object_domain_log_transaction_id_idx ON log.object_domain( log_transaction_id );

CREATE INDEX log_permission_localized_permission_idx ON log.permission_localized( permission );
CREATE INDEX log_permission_localized_log_transaction_id_idx ON log.permission_localized( log_transaction_id );

CREATE INDEX log_account_password_reset_account_id_idx ON log.account_password_reset( account_id );
CREATE INDEX log_account_password_reset_log_transaction_id_idx ON log.account_password_reset( log_transaction_id );

CREATE INDEX log_country_country_idx ON log.country( country );
CREATE INDEX log_country_log_transaction_id_idx ON log.country( log_transaction_id );

CREATE INDEX log_event_person_event_person_id_idx ON log.event_person( event_person_id );
CREATE INDEX log_event_person_log_transaction_id_idx ON log.event_person( log_transaction_id );
CREATE INDEX log_event_type_localized_event_type_idx ON log.event_type_localized( event_type );
CREATE INDEX log_event_type_localized_log_transaction_id_idx ON log.event_type_localized( log_transaction_id );

CREATE INDEX log_language_localized_language_idx ON log.language_localized( language );
CREATE INDEX log_language_localized_log_transaction_id_idx ON log.language_localized( log_transaction_id );

CREATE INDEX log_conference_language_conference_id_idx ON log.conference_language( conference_id );
CREATE INDEX log_conference_language_log_transaction_id_idx ON log.conference_language( log_transaction_id );

CREATE INDEX log_phone_type_phone_type_idx ON log.phone_type( phone_type );
CREATE INDEX log_phone_type_log_transaction_id_idx ON log.phone_type( log_transaction_id );

CREATE INDEX log_attachment_type_localized_attachment_type_idx ON log.attachment_type_localized( attachment_type );
CREATE INDEX log_attachment_type_localized_log_transaction_id_idx ON log.attachment_type_localized( log_transaction_id );

CREATE INDEX log_language_language_idx ON log.language( language );
CREATE INDEX log_language_log_transaction_id_idx ON log.language( log_transaction_id );

CREATE INDEX log_mime_type_mime_type_idx ON log.mime_type( mime_type );
CREATE INDEX log_mime_type_log_transaction_id_idx ON log.mime_type( log_transaction_id );

CREATE INDEX log_event_role_state_localized_event_role_event_role_state_idx ON log.event_role_state_localized( event_role, event_role_state );
CREATE INDEX log_event_role_state_localized_log_transaction_id_idx ON log.event_role_state_localized( log_transaction_id );

CREATE INDEX log_attachment_type_attachment_type_idx ON log.attachment_type( attachment_type );
CREATE INDEX log_attachment_type_log_transaction_id_idx ON log.attachment_type( log_transaction_id );

CREATE INDEX log_currency_currency_idx ON log.currency( currency );
CREATE INDEX log_currency_log_transaction_id_idx ON log.currency( log_transaction_id );

CREATE INDEX log_event_state_progress_localized_event_state_event_state_progress_idx ON log.event_state_progress_localized( event_state, event_state_progress );
CREATE INDEX log_event_state_progress_localized_log_transaction_id_idx ON log.event_state_progress_localized( log_transaction_id );

CREATE INDEX log_conference_track_conference_track_id_idx ON log.conference_track( conference_track_id );
CREATE INDEX log_conference_track_log_transaction_id_idx ON log.conference_track( log_transaction_id );

CREATE INDEX log_im_type_localized_im_type_idx ON log.im_type_localized( im_type );
CREATE INDEX log_im_type_localized_log_transaction_id_idx ON log.im_type_localized( log_transaction_id );

CREATE INDEX log_link_type_link_type_idx ON log.link_type( link_type );
CREATE INDEX log_link_type_log_transaction_id_idx ON log.link_type( log_transaction_id );

CREATE INDEX log_event_state_progress_idx ON log.event_state_progress( event_state, event_state_progress );
CREATE INDEX log_event_state_progress_log_transaction_id_idx ON log.event_state_progress( log_transaction_id );

CREATE INDEX log_conference_person_link_internal_pkey_idx ON log.conference_person_link_internal( conference_person_link_internal_id );
CREATE INDEX log_conference_person_link_internal_conference_person_id_idx ON log.conference_person_link_internal( conference_person_id );
CREATE INDEX log_conference_person_link_internal_log_transaction_id_idx ON log.conference_person_link_internal( log_transaction_id );

CREATE INDEX log_conference_image_conference_id_idx ON log.conference_image( conference_id );
CREATE INDEX log_conference_image_log_transaction_id_idx ON log.conference_image( log_transaction_id );

CREATE INDEX log_custom_conference_conference_id_idx ON log.custom_conference( conference_id );
CREATE INDEX log_custom_conference_log_transaction_id_idx ON log.custom_conference( log_transaction_id );

CREATE INDEX log_custom_conference_person_conference_id_person_id_idx ON log.custom_conference_person( conference_id, person_id );
CREATE INDEX log_custom_conference_person_log_transaction_id_idx ON log.custom_conference_person( log_transaction_id );

CREATE INDEX log_custom_event_event_id_idx ON log.custom_event( event_id );
CREATE INDEX log_custom_event_log_transaction_id_idx ON log.custom_event( log_transaction_id );

CREATE INDEX log_custom_fields_table_name_field_name_idx ON log.custom_fields( table_name, field_name );
CREATE INDEX log_custom_fields_log_transaction_id_idx ON log.custom_fields( log_transaction_id );

CREATE INDEX log_custom_person_person_id_idx ON log.custom_person( person_id );
CREATE INDEX log_custom_person_log_transaction_id_idx ON log.custom_person( log_transaction_id );

COMMIT;

