
CREATE OR REPLACE VIEW view_report_pickup AS
  SELECT person_id,
         conference_id,
         language_id,
         view_person.name,
         'arrival' AS "type",
         arrival_from AS "from",
         arrival_to AS "to",
         arrival_transport_id AS transport_id,
         view_transport.name AS transport,
         view_transport.tag AS transport_tag,
         arrival_date AS "date",
         arrival_time AS "time",
         arrival_number AS "number"
    FROM person_travel
         INNER JOIN view_person USING (person_id)
         LEFT OUTER JOIN view_transport ON (
             person_travel.arrival_transport_id = view_transport.transport_id )
   WHERE f_arrival_pickup = 't'
UNION
 (SELECT person_id,
         conference_id,
         language_id,
         view_person.name,
         'departure' AS "type",
         departure_from AS "from",
         departure_to AS "to",
         departure_transport_id AS transport_id,
         view_transport.name AS transport,
         view_transport.tag AS transport_tag,
         departure_date AS "date",
         departure_time AS "time",
         departure_number AS "number"
    FROM person_travel
         INNER JOIN view_person USING (person_id)
         LEFT OUTER JOIN view_transport ON (
             departure_transport_id = view_transport.transport_id )
   WHERE f_departure_pickup = 't')
;

