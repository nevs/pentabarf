--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Data for Name: event_role_state; Type: TABLE DATA; Schema: public; Owner: sven
--

INSERT INTO event_role_state (event_role, event_role_state, rank) VALUES ('speaker', 'confirmed', NULL);
INSERT INTO event_role_state (event_role, event_role_state, rank) VALUES ('speaker', 'idea', NULL);
INSERT INTO event_role_state (event_role, event_role_state, rank) VALUES ('speaker', 'enquired', NULL);
INSERT INTO event_role_state (event_role, event_role_state, rank) VALUES ('speaker', 'canceled', NULL);
INSERT INTO event_role_state (event_role, event_role_state, rank) VALUES ('speaker', 'declined', NULL);
INSERT INTO event_role_state (event_role, event_role_state, rank) VALUES ('speaker', 'unclear', NULL);
INSERT INTO event_role_state (event_role, event_role_state, rank) VALUES ('speaker', 'offer', NULL);
INSERT INTO event_role_state (event_role, event_role_state, rank) VALUES ('moderator', 'idea', NULL);
INSERT INTO event_role_state (event_role, event_role_state, rank) VALUES ('moderator', 'enquired', NULL);
INSERT INTO event_role_state (event_role, event_role_state, rank) VALUES ('moderator', 'canceled', NULL);
INSERT INTO event_role_state (event_role, event_role_state, rank) VALUES ('moderator', 'declined', NULL);
INSERT INTO event_role_state (event_role, event_role_state, rank) VALUES ('moderator', 'confirmed', NULL);
INSERT INTO event_role_state (event_role, event_role_state, rank) VALUES ('moderator', 'unclear', NULL);
INSERT INTO event_role_state (event_role, event_role_state, rank) VALUES ('moderator', 'offer', NULL);


--
-- PostgreSQL database dump complete
--

