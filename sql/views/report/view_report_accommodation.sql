CREATE OR REPLACE VIEW view_report_accommodation AS
  SELECT
    person_id,
    conference_id,
    conference_person_id,
    first_name,
    last_name,
    COALESCE(conference_person.email,person.email) AS email,
    array_to_string( ARRAY(
      SELECT phone_number
        FROM person_phone
       WHERE person_phone.person_id=person.person_id
    ), ', ' ) AS phone,
    arrival_from,
    arrival_to,
    arrival_date,
    arrival_time,
    transport_arrival.name AS arrival_transport,
    arrival_pickup,
    departure_from,
    departure_to,
    departure_date,
    departure_time,
    transport_departure.name AS departure_transport,
    departure_pickup,
    travel_cost,
    travel_currency,
    accommodation_name,
    need_accommodation,
    accommodation_cost,
    accommodation_currency
  FROM
    conference_person
    INNER JOIN person USING(person_id)
    INNER JOIN conference_person_travel USING(conference_person_id)
    INNER JOIN transport_localized AS transport_arrival ON (
      transport_arrival.transport = conference_person_travel.arrival_transport AND
      transport_arrival.translated = 'de'
    )
    INNER JOIN transport_localized AS transport_departure ON (
      transport_departure.transport = conference_person_travel.departure_transport AND
      transport_departure.translated = 'de'
    )
  WHERE
    arrival_from IS NOT NULL OR
    arrival_to IS NOT NULL OR
    arrival_date IS NOT NULL OR
    arrival_time IS NOT NULL OR
    arrival_pickup = TRUE OR
    departure_from IS NOT NULL OR
    departure_to IS NOT NULL OR
    departure_date IS NOT NULL OR
    departure_time IS NOT NULL OR
    departure_pickup = TRUE OR
    travel_cost IS NOT NULL OR
    accommodation_name IS NOT NULL OR
    need_accommodation = TRUE OR
    accommodation_cost IS NOT NULL
;

