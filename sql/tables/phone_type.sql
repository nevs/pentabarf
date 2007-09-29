
CREATE TABLE phone_type (
  phone_type_id SERIAL NOT NULL,
  tag VARCHAR(32) NOT NULL UNIQUE,
  scheme VARCHAR(32),
  rank INTEGER,
  PRIMARY KEY (phone_type_id)
);

