
CREATE TABLE base.conference_room_role (
  conference_room_id INTEGER NOT NULL,
  event_role TEXT NOT NULL,
  amount INTEGER NOT NULL DEFAULT 1
);

CREATE TABLE conference_room_role (
  FOREIGN KEY (conference_room_id) REFERENCES conference_room (conference_room_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (event_role) REFERENCES event_role (event_role) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (conference_id, conference_room, event_role)
) INHERITS( base.conference_room_role );

CREATE TABLE log.conference_room_role (
) INHERITS( base.logging, base.conference_room_role );

