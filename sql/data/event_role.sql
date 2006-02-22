--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Name: event_role_event_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pentabarf
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('event_role', 'event_role_id'), 7, true);


--
-- Data for Name: event_role; Type: TABLE DATA; Schema: public; Owner: pentabarf
--

INSERT INTO event_role (event_role_id, tag, rank) VALUES (1, 'speaker', 1);
INSERT INTO event_role (event_role_id, tag, rank) VALUES (2, 'coordinator', 2);
INSERT INTO event_role (event_role_id, tag, rank) VALUES (3, 'moderator', 3);
INSERT INTO event_role (event_role_id, tag, rank) VALUES (4, 'visitor', 4);
INSERT INTO event_role (event_role_id, tag, rank) VALUES (5, 'reporter', NULL);
INSERT INTO event_role (event_role_id, tag, rank) VALUES (6, 'reviewer', NULL);
INSERT INTO event_role (event_role_id, tag, rank) VALUES (7, 'attendee', NULL);


--
-- PostgreSQL database dump complete
--

