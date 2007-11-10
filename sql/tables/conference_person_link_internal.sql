
CREATE TABLE base.conference_person_link_internal (
  conference_person_link_internal_id SERIAL NOT NULL,
  conference_person_id INTEGER NOT NULL,
  link_type TEXT NOT NULL,
  url TEXT NOT NULL,
  description TEXT,
  rank INTEGER
);

CREATE TABLE conference_person_link_internal (
  FOREIGN KEY (conference_person_id) REFERENCES conference_person (conference_person_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (link_type) REFERENCES link_type (link_type) ON UPDATE CASCADE ON DELETE RESTRICT,
  PRIMARY KEY (conference_person_link_internal_id)
) INHERITS( base.conference_person_link_internal );

CREATE TABLE log.conference_person_link_internal (
) INHERITS( base.logging, base.conference_person_link_internal );

