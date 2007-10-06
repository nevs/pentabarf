
CREATE TABLE event_role_state (
  event_role_state TEXT NOT NULL,
  event_role TEXT NOT NULL,
  rank INTEGER,
  FOREIGN KEY (event_role) REFERENCES event_role (event_role) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (event_role,event_role_state)
);

