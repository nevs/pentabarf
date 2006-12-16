
CREATE TABLE master.link_type_localized(
  link_type TEXT NOT NULL,
  translated TEXT NOT NULL,
  name TEXT NOT NULL
);

CREATE TABLE link_type_localized(
  PRIMARY KEY(link_type, translated),
  FOREIGN KEY(link_type) REFERENCES link_type(link_type) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY(translated) REFERENCES language(language) ON UPDATE CASCADE ON DELETE CASCADE
) INHERITS(master.link_type_localized);

CREATE TABLE logging.link_type_localized() INHERITS(master.logging, master.link_type_localized);

