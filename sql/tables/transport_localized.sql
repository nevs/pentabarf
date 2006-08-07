
CREATE TABLE master.transport_localized(
  transport TEXT,
  translated TEXT,
  name TEXT
) WITHOUT OIDS;

CREATE TABLE transport_localized() INHERITS(master.transport_localized);
CREATE TABLE logging.transport_localized() INHERITS(master.transport_localized);

