
CREATE TABLE master.event_role(
  event_role TEXT NOT NULL,
  public BOOL NOT NULL DEFAULT TRUE,
  rank INTEGER
);

CREATE TABLE public.event_role(
  PRIMARY KEY(event_role)
) INHERITS(master.event_role);

CREATE TABLE logging.event_role() INHERITS(master.logging, master.event_role);

