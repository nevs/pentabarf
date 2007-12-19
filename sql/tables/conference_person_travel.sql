
CREATE TABLE base.conference_person_travel (
  conference_person_id INTEGER NOT NULL,
  arrival_transport TEXT NOT NULL,
  arrival_from TEXT,
  arrival_to TEXT,
  arrival_number TEXT,
  arrival_date DATE,
  arrival_time TIME(0) WITH TIME ZONE,
  arrival_pickup BOOL NOT NULL DEFAULT FALSE,
  departure_pickup BOOL NOT NULL DEFAULT FALSE,
  departure_transport TEXT NOT NULL,
  departure_from TEXT,
  departure_to TEXT,
  departure_number TEXT,
  departure_date DATE,
  departure_time TIME(0) WITH TIME ZONE,
  travel_cost DECIMAL(16,2),
  travel_currency TEXT NOT NULL,
  accommodation_cost DECIMAL(16,2),
  accommodation_currency TEXT NOT NULL,
  accommodation_name TEXT,
  accommodation_street TEXT,
  accommodation_postcode TEXT,
  accommodation_city TEXT,
  accommodation_phone TEXT,
  accommodation_phone_room TEXT,
  arrived BOOL NOT NULL DEFAULT FALSE,
  fee DECIMAL(16,2),
  fee_currency TEXT NOT NULL,
  need_travel_cost BOOL NOT NULL DEFAULT FALSE,
  need_accommodation BOOL NOT NULL DEFAULT FALSE,
  need_accommodation_cost BOOL NOT NULL DEFAULT FALSE
);

CREATE TABLE conference_person_travel (
  FOREIGN KEY (conference_person_id) REFERENCES conference_person (conference_person_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (arrival_transport) REFERENCES transport (transport) ON UPDATE CASCADE ON DELETE RESTRICT,
  FOREIGN KEY (departure_transport) REFERENCES transport (transport) ON UPDATE CASCADE ON DELETE RESTRICT,
  FOREIGN KEY (travel_currency) REFERENCES currency (currency) ON UPDATE CASCADE ON DELETE RESTRICT,
  FOREIGN KEY (accommodation_currency) REFERENCES currency (currency) ON UPDATE CASCADE ON DELETE RESTRICT,
  FOREIGN KEY (fee_currency) REFERENCES currency (currency) ON UPDATE CASCADE ON DELETE RESTRICT,
  PRIMARY KEY (conference_person_id)
) INHERITS( base.conference_person_travel );

CREATE TABLE log.conference_person_travel (
) INHERITS( base.logging, base.conference_person_travel );

