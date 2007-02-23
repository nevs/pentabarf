--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Name: authorisation_authorisation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('authorisation_authorisation_id_seq', 37, true);


--
-- Data for Name: authorisation; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO authorisation (authorisation_id, tag, rank) VALUES (25, 'create_rating', NULL);
INSERT INTO authorisation (authorisation_id, tag, rank) VALUES (26, 'modify_rating', NULL);
INSERT INTO authorisation (authorisation_id, tag, rank) VALUES (27, 'delete_rating', NULL);
INSERT INTO authorisation (authorisation_id, tag, rank) VALUES (28, 'show_debug', NULL);
INSERT INTO authorisation (authorisation_id, tag, rank) VALUES (1, 'create_person', 1);
INSERT INTO authorisation (authorisation_id, tag, rank) VALUES (2, 'modify_person', 2);
INSERT INTO authorisation (authorisation_id, tag, rank) VALUES (3, 'delete_person', 3);
INSERT INTO authorisation (authorisation_id, tag, rank) VALUES (4, 'create_event', 4);
INSERT INTO authorisation (authorisation_id, tag, rank) VALUES (5, 'modify_event', 5);
INSERT INTO authorisation (authorisation_id, tag, rank) VALUES (6, 'delete_event', 6);
INSERT INTO authorisation (authorisation_id, tag, rank) VALUES (7, 'create_conference', 7);
INSERT INTO authorisation (authorisation_id, tag, rank) VALUES (8, 'modify_conference', 8);
INSERT INTO authorisation (authorisation_id, tag, rank) VALUES (9, 'delete_conference', 9);
INSERT INTO authorisation (authorisation_id, tag, rank) VALUES (11, 'modify_localization', 11);
INSERT INTO authorisation (authorisation_id, tag, rank) VALUES (16, 'create_roles', 16);
INSERT INTO authorisation (authorisation_id, tag, rank) VALUES (17, 'modify_roles', 17);
INSERT INTO authorisation (authorisation_id, tag, rank) VALUES (18, 'delete_roles', 18);
INSERT INTO authorisation (authorisation_id, tag, rank) VALUES (19, 'create_login', 19);
INSERT INTO authorisation (authorisation_id, tag, rank) VALUES (20, 'modify_login', 20);
INSERT INTO authorisation (authorisation_id, tag, rank) VALUES (21, 'delete_login', 21);
INSERT INTO authorisation (authorisation_id, tag, rank) VALUES (22, 'modify_own_person', 22);
INSERT INTO authorisation (authorisation_id, tag, rank) VALUES (23, 'modify_own_event', 23);
INSERT INTO authorisation (authorisation_id, tag, rank) VALUES (14, 'modify_valuelist', 14);
INSERT INTO authorisation (authorisation_id, tag, rank) VALUES (30, 'write_valuelist', NULL);
INSERT INTO authorisation (authorisation_id, tag, rank) VALUES (31, 'create_valuelist', NULL);
INSERT INTO authorisation (authorisation_id, tag, rank) VALUES (32, 'admin_login', NULL);
INSERT INTO authorisation (authorisation_id, tag, rank) VALUES (34, 'delete_localization', NULL);
INSERT INTO authorisation (authorisation_id, tag, rank) VALUES (33, 'create_localization', NULL);
INSERT INTO authorisation (authorisation_id, tag, rank) VALUES (35, 'move_event', NULL);
INSERT INTO authorisation (authorisation_id, tag, rank) VALUES (24, 'pentabarf_login', 24);
INSERT INTO authorisation (authorisation_id, tag, rank) VALUES (36, 'submission_login', NULL);
INSERT INTO authorisation (authorisation_id, tag, rank) VALUES (37, 'view_ratings', NULL);


--
-- PostgreSQL database dump complete
--

