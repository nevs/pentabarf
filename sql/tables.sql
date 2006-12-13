-- script to create  all tables

BEGIN TRANSACTION;

\i tables/logging.sql

\i tables/language.sql
\i tables/language_localized.sql

\i tables/ui_message.sql
\i tables/ui_message_localized.sql

\i tables/country.sql
\i tables/country_localized.sql

\i tables/currency.sql
\i tables/currency_localized.sql

\i tables/im_type.sql
\i tables/im_type_localized.sql

\i tables/link_type.sql
\i tables/link_type_localized.sql

\i tables/mime_type.sql
\i tables/mime_type_localized.sql

\i tables/phone_type.sql
\i tables/phone_type_localized.sql

\i tables/transport.sql
\i tables/transport_localized.sql

\i tables/conference_phase.sql
\i tables/conference_phase_localized.sql

\i tables/conference.sql
\i tables/conference_image.sql
\i tables/conference_language.sql
\i tables/conference_track.sql
\i tables/conference_team.sql
\i tables/conference_room.sql

\i tables/person.sql
\i tables/person_image.sql

\i tables/event_type.sql
\i tables/event_origin.sql
\i tables/event_state.sql
\i tables/event_state_progress.sql

\i tables/event.sql
\i tables/event_image.sql

\i tables/event_role.sql
\i tables/event_role_state.sql

\i tables/event_person.sql

\i functions/logging/activate_logging.sql

SELECT logging.activate_logging();

COMMIT TRANSACTION;

