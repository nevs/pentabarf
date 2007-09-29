
CREATE TABLE time_zone (
  time_zone_id SERIAL NOT NULL,
  tag VARCHAR(32) NOT NULL UNIQUE,
  f_visible BOOL NOT NULL DEFAULT FALSE,
  f_preferred BOOL NOT NULL DEFAULT FALSE,
  PRIMARY KEY (time_zone_id)
);

