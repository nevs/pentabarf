
CREATE TABLE master.event_role_state(
  event_role TEXT NOT NULL,
  event_role_state TEXT NOT NULL,
  rank INTEGER
);

CREATE TABLE public.event_role_state(
  PRIMARY KEY(event_role, event_role_state),
  FOREIGN KEY(event_role) REFERENCES event_role(event_role)
) INHERITS(master.event_role_state);

CREATE TABLE logging.event_role_state() INHERITS(master.logging, master.event_role_state);

