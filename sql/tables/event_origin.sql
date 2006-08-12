
CREATE TABLE master.event_origin(
  event_origin TEXT NOT NULL
);

CREATE TABLE event_origin(
  PRIMARY KEY(event_origin)
) INHERITS(master.event_origin);

CREATE TABLE logging.event_origin() INHERITS(master.event_origin);

