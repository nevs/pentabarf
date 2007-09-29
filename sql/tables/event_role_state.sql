
CREATE TABLE event_role_state (
  event_role_state_id SERIAL NOT NULL,
  event_role_id INTEGER NOT NULL,
  tag VARCHAR(32) NOT NULL,
  rank INTEGER,
  FOREIGN KEY (event_role_id) REFERENCES event_role (event_role_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (event_role_state_id)
);

