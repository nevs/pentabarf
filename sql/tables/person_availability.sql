
CREATE TABLE person_availability (
  person_availability_id SERIAL,
  person_id INTEGER NOT NULL,
  conference_id INTEGER NOT NULL,
  start_date TIMESTAMP WITH TIME ZONE NOT NULL,
  duration INTERVAL NOT NULL,
  FOREIGN KEY (person_id) REFERENCES person (person_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (conference_id) REFERENCES conference (conference_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (person_availability_id),
  UNIQUE (person_id, conference_id, start_date)
);

