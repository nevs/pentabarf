
CREATE TABLE mime_type (
  mime_type_id SERIAL NOT NULL,
  mime_type VARCHAR(128) NOT NULL UNIQUE,
  file_extension VARCHAR(16),
  f_image BOOL NOT NULL DEFAULT FALSE,
  PRIMARY KEY (mime_type_id)
);

