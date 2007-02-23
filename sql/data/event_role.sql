--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Name: event_role_event_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('event_role_event_role_id_seq', 8, true);


--
-- Data for Name: event_role; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO event_role (event_role_id, tag, rank, f_public) VALUES (1, 'speaker', 1, NULL);
INSERT INTO event_role (event_role_id, tag, rank, f_public) VALUES (2, 'coordinator', 2, NULL);
INSERT INTO event_role (event_role_id, tag, rank, f_public) VALUES (3, 'moderator', 3, NULL);
INSERT INTO event_role (event_role_id, tag, rank, f_public) VALUES (4, 'visitor', 4, NULL);
INSERT INTO event_role (event_role_id, tag, rank, f_public) VALUES (5, 'reporter', NULL, NULL);
INSERT INTO event_role (event_role_id, tag, rank, f_public) VALUES (6, 'reviewer', NULL, NULL);
INSERT INTO event_role (event_role_id, tag, rank, f_public) VALUES (7, 'attendee', NULL, NULL);
INSERT INTO event_role (event_role_id, tag, rank, f_public) VALUES (8, 'submitter', NULL, NULL);


--
-- PostgreSQL database dump complete
--

