
CREATE TABLE master.transport_localized(
  transport TEXT NOT NULL,
  translated TEXT NOT NULL,
  name TEXT NOT NULL
);

CREATE TABLE transport_localized(
  PRIMARY KEY(transport,translated),
  FOREIGN KEY(transport) REFERENCES transport(transport) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY(translated) REFERENCES language(language) ON UPDATE CASCADE ON DELETE CASCADE
) INHERITS(master.transport_localized);

CREATE TABLE logging.transport_localized() INHERITS(master.logging, master.transport_localized);

