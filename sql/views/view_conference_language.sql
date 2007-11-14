
CREATE OR REPLACE VIEW view_conference_language AS
  SELECT
    conference_language.language,
    conference_language.conference_id,
    language_localized.translated,
    language_localized.name
  FROM
    conference_language
    INNER JOIN language_localized ON ( conference_language.language = language_localized.translated )
;

