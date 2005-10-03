
BEGIN TRANSACTION;

\i language.sql
\i language_localized.sql
\i country.sql
\i country_localized.sql
\i currency.sql
\i time_zone.sql
\i time_zone_localized.sql
\i ui_message.sql
\i ui_message_localized.sql
\i transport.sql
\i transport_localized.sql
\i link_type.sql
\i link_type_localized.sql
\i role.sql
\i role_localized.sql
\i authorisation.sql
\i authorisation_localized.sql
\i role_authorisation.sql
\i event_role.sql
\i event_role_localized.sql
\i event_role_state.sql
\i event_role_state_localized.sql
\i event_state.sql
\i event_state_localized.sql
\i event_state_progress.sql
\i event_state_progress_localized.sql
\i event_type.sql
\i event_type_localized.sql

COMMIT TRANSACTION;

