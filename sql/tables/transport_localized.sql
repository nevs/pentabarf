
CREATE TABLE master.transport_localized(
  transport TEXT NOT NULL,
  translated TEXT NOT NULL,
  name TEXT NOT NULL
) WITHOUT OIDS;

CREATE TABLE transport_localized(
  PRIMARY KEY(transport,translated),
  FOREIGN KEY(transport) REFERENCES transport(transport) ON UPDATE CASCADE,
  FOREIGN KEY(translated) REFERENCES language(language) ON UPDATE CASCADE
) INHERITS(master.transport_localized);

CREATE TABLE logging.transport_localized() INHERITS(master.transport_localized);

