--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Name: conference_phase_conflict_conference_phase_conflict_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pentabarf
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('conference_phase_conflict', 'conference_phase_conflict_id'), 165, true);


--
-- Data for Name: conference_phase_conflict; Type: TABLE DATA; Schema: public; Owner: pentabarf
--

INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (10, 2, 1, 4);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (37, 2, 8, 2);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (38, 3, 8, 3);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (39, 4, 8, 5);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (40, 5, 8, 5);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (36, 1, 8, 2);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (17, 3, 1, 4);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (24, 4, 1, 4);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (31, 5, 1, 4);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (35, 5, 5, 1);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (3, 1, 6, 2);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (61, 1, 12, 4);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (46, 1, 9, 2);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (47, 2, 9, 3);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (48, 3, 9, 4);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (49, 4, 9, 4);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (50, 5, 9, 4);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (51, 1, 10, 2);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (52, 2, 10, 3);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (4, 1, 7, 5);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (53, 3, 10, 4);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (54, 4, 10, 5);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (2, 1, 2, 5);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (55, 5, 10, 5);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (16, 3, 7, 5);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (8, 2, 6, 3);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (30, 5, 7, 5);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (5, 1, 3, 5);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (15, 3, 6, 4);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (62, 2, 12, 4);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (63, 3, 12, 4);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (59, 4, 11, 4);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (131, 1, 26, 1);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (56, 1, 11, 1);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (57, 2, 11, 2);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (6, 1, 4, 5);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (58, 3, 11, 3);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (64, 4, 12, 4);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (65, 5, 12, 4);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (66, 1, 13, 4);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (67, 2, 13, 4);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (7, 1, 5, 5);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (68, 3, 13, 4);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (9, 2, 7, 5);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (69, 4, 13, 4);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (12, 2, 3, 5);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (13, 2, 4, 5);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (14, 2, 5, 5);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (70, 5, 13, 4);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (71, 1, 14, 1);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (72, 2, 14, 2);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (18, 3, 2, 5);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (20, 3, 4, 5);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (21, 3, 5, 5);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (23, 4, 7, 5);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (73, 3, 14, 3);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (25, 4, 2, 5);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (26, 4, 3, 5);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (28, 4, 5, 5);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (29, 5, 6, 5);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (74, 4, 14, 4);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (75, 5, 14, 4);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (32, 5, 2, 5);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (33, 5, 3, 5);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (34, 5, 4, 5);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (11, 2, 2, 5);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (19, 3, 3, 5);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (27, 4, 4, 5);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (76, 1, 15, 1);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (22, 4, 6, 5);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (1, 1, 1, 4);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (77, 2, 15, 2);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (78, 3, 15, 3);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (79, 4, 15, 4);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (80, 5, 15, 4);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (81, 1, 16, 3);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (82, 2, 16, 3);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (83, 3, 16, 3);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (84, 4, 16, 3);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (85, 5, 16, 3);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (86, 1, 17, 5);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (87, 2, 17, 5);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (88, 3, 17, 5);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (89, 4, 17, 5);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (90, 5, 17, 5);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (91, 1, 18, 3);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (92, 2, 18, 3);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (93, 3, 18, 3);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (94, 4, 18, 3);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (95, 5, 18, 3);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (96, 1, 22, 2);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (97, 1, 20, 2);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (99, 1, 21, 2);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (100, 2, 22, 2);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (103, 2, 21, 2);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (108, 4, 22, 4);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (110, 4, 19, 4);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (111, 4, 21, 4);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (112, 5, 22, 2);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (113, 5, 20, 2);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (114, 5, 19, 2);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (115, 5, 21, 2);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (104, 3, 22, 4);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (106, 3, 19, 4);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (107, 3, 21, 4);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (116, 1, 23, 2);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (117, 1, 24, 2);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (118, 2, 23, 2);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (119, 2, 24, 2);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (120, 3, 23, 4);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (121, 3, 24, 4);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (122, 4, 23, 5);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (123, 4, 24, 5);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (124, 5, 23, 1);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (125, 5, 24, 1);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (60, 5, 11, 5);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (126, 1, 25, 2);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (127, 2, 25, 2);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (128, 3, 25, 2);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (129, 4, 25, 5);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (130, 5, 25, 5);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (132, 1, 27, 2);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (133, 1, 28, 2);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (134, 1, 29, 2);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (135, 1, 30, 2);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (136, 2, 26, 1);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (137, 2, 27, 3);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (138, 2, 28, 3);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (139, 2, 30, 3);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (140, 2, 29, 3);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (141, 3, 26, 1);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (142, 3, 27, 4);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (143, 3, 28, 4);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (144, 3, 29, 4);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (145, 3, 30, 4);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (146, 4, 26, 1);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (147, 4, 27, 4);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (148, 4, 28, 4);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (149, 4, 29, 4);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (150, 4, 30, 4);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (151, 5, 26, 1);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (152, 5, 27, 1);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (153, 5, 28, 1);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (154, 5, 29, 1);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (155, 5, 30, 1);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (98, 1, 19, 3);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (102, 2, 19, 3);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (101, 2, 20, 3);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (105, 3, 20, 3);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (109, 4, 20, 3);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (156, 1, 31, 1);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (157, 1, 32, 1);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (160, 3, 31, 4);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (161, 3, 32, 4);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (162, 4, 31, 5);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (163, 4, 32, 5);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (164, 5, 31, 1);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (165, 5, 32, 1);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (158, 2, 31, 3);
INSERT INTO conference_phase_conflict (conference_phase_conflict_id, conference_phase_id, conflict_id, conflict_level_id) VALUES (159, 2, 32, 3);


--
-- PostgreSQL database dump complete
--

