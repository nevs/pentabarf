
CREATE OR REPLACE VIEW view_report_pickup AS
  SELECT person_id,
         conference_id,
         translated,
         view_person.name,
         'arrival' AS "type",
         arrival_from AS "from",
         arrival_to AS "to",
         arrival_transport AS transport,
         transport_localized.name AS transport_name,
         arrival_date AS "date",
         arrival_time AS "time",
         arrival_number AS "number"
    FROM conference_person_travel
         INNER JOIN conference_person USING (conference_person_id)
         INNER JOIN view_person USING (person_id)
         LEFT OUTER JOIN transport_localized ON (
             conference_person_travel.arrival_transport = transport_localized.transport )
   WHERE arrival_pickup = 't'
UNION
 (SELECT person_id,
         conference_id,
         translated,
         view_person.name,
         'departure' AS "type",
         departure_from AS "from",
         departure_to AS "to",
         departure_transport AS transport,
         transport_localized.name AS transport_name,
         departure_date AS "date",
         departure_time AS "time",
         departure_number AS "number"
    FROM conference_person_travel
         INNER JOIN conference_person USING (conference_person_id)
         INNER JOIN view_person USING (person_id)
         LEFT OUTER JOIN transport_localized ON (
             conference_person_travel.departure_transport = transport_localized.transport )
   WHERE departure_pickup = 't')
;

