--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Data for Name: event_role_state; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO event_role_state (event_role_state, event_role, rank) VALUES ('idea', 'moderator', 1);
INSERT INTO event_role_state (event_role_state, event_role, rank) VALUES ('enquired', 'moderator', 2);
INSERT INTO event_role_state (event_role_state, event_role, rank) VALUES ('canceled', 'moderator', 3);
INSERT INTO event_role_state (event_role_state, event_role, rank) VALUES ('declined', 'moderator', 4);
INSERT INTO event_role_state (event_role_state, event_role, rank) VALUES ('confirmed', 'moderator', 5);
INSERT INTO event_role_state (event_role_state, event_role, rank) VALUES ('confirmed', 'speaker', 5);
INSERT INTO event_role_state (event_role_state, event_role, rank) VALUES ('unclear', 'moderator', 6);
INSERT INTO event_role_state (event_role_state, event_role, rank) VALUES ('offer', 'moderator', 7);
INSERT INTO event_role_state (event_role_state, event_role, rank) VALUES ('idea', 'speaker', 1);
INSERT INTO event_role_state (event_role_state, event_role, rank) VALUES ('enquired', 'speaker', 2);
INSERT INTO event_role_state (event_role_state, event_role, rank) VALUES ('canceled', 'speaker', 3);
INSERT INTO event_role_state (event_role_state, event_role, rank) VALUES ('declined', 'speaker', 4);
INSERT INTO event_role_state (event_role_state, event_role, rank) VALUES ('unclear', 'speaker', 6);
INSERT INTO event_role_state (event_role_state, event_role, rank) VALUES ('offer', 'speaker', 7);


--
-- PostgreSQL database dump complete
--

