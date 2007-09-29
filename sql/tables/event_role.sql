
CREATE TABLE event_role (
  event_role_id SERIAL NOT NULL,
  tag VARCHAR(32) NOT NULL UNIQUE,
  rank INTEGER,
  f_public BOOL,
  PRIMARY KEY (event_role_id)
);

