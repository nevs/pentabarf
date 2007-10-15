
CREATE TABLE mime_type (
  mime_type TEXT NOT NULL,
  file_extension VARCHAR(16),
  f_image BOOL NOT NULL DEFAULT FALSE,
  PRIMARY KEY (mime_type)
);

