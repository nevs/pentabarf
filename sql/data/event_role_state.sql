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

INSERT INTO event_role_state (rank, event_role, event_role_state) VALUES (1, 'moderator', 'idea');
INSERT INTO event_role_state (rank, event_role, event_role_state) VALUES (2, 'moderator', 'enquired');
INSERT INTO event_role_state (rank, event_role, event_role_state) VALUES (3, 'moderator', 'canceled');
INSERT INTO event_role_state (rank, event_role, event_role_state) VALUES (4, 'moderator', 'declined');
INSERT INTO event_role_state (rank, event_role, event_role_state) VALUES (5, 'moderator', 'confirmed');
INSERT INTO event_role_state (rank, event_role, event_role_state) VALUES (5, 'speaker', 'confirmed');
INSERT INTO event_role_state (rank, event_role, event_role_state) VALUES (6, 'moderator', 'unclear');
INSERT INTO event_role_state (rank, event_role, event_role_state) VALUES (7, 'moderator', 'offer');
INSERT INTO event_role_state (rank, event_role, event_role_state) VALUES (1, 'speaker', 'idea');
INSERT INTO event_role_state (rank, event_role, event_role_state) VALUES (2, 'speaker', 'enquired');
INSERT INTO event_role_state (rank, event_role, event_role_state) VALUES (3, 'speaker', 'canceled');
INSERT INTO event_role_state (rank, event_role, event_role_state) VALUES (4, 'speaker', 'declined');
INSERT INTO event_role_state (rank, event_role, event_role_state) VALUES (6, 'speaker', 'unclear');
INSERT INTO event_role_state (rank, event_role, event_role_state) VALUES (7, 'speaker', 'offer');


--
-- PostgreSQL database dump complete
--

