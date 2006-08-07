
CREATE TABLE master.event_type(
  event_type TEXT NOT NULL
);

CREATE TABLE event_type(
  PRIMARY KEY(event_type)
) INHERITS(master.event_type);

CREATE TABLE logging.event_type(
) INHERITS(master.event_type);

