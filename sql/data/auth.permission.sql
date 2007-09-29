--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = auth, pg_catalog;

--
-- Data for Name: permission; Type: TABLE DATA; Schema: auth; Owner: -
--

INSERT INTO permission (permission, rank) VALUES ('create_rating', NULL);
INSERT INTO permission (permission, rank) VALUES ('modify_rating', NULL);
INSERT INTO permission (permission, rank) VALUES ('delete_rating', NULL);
INSERT INTO permission (permission, rank) VALUES ('show_debug', NULL);
INSERT INTO permission (permission, rank) VALUES ('create_person', 1);
INSERT INTO permission (permission, rank) VALUES ('modify_person', 2);
INSERT INTO permission (permission, rank) VALUES ('delete_person', 3);
INSERT INTO permission (permission, rank) VALUES ('create_event', 4);
INSERT INTO permission (permission, rank) VALUES ('modify_event', 5);
INSERT INTO permission (permission, rank) VALUES ('delete_event', 6);
INSERT INTO permission (permission, rank) VALUES ('create_conference', 7);
INSERT INTO permission (permission, rank) VALUES ('modify_conference', 8);
INSERT INTO permission (permission, rank) VALUES ('delete_conference', 9);
INSERT INTO permission (permission, rank) VALUES ('modify_localization', 11);
INSERT INTO permission (permission, rank) VALUES ('create_roles', 16);
INSERT INTO permission (permission, rank) VALUES ('modify_roles', 17);
INSERT INTO permission (permission, rank) VALUES ('delete_roles', 18);
INSERT INTO permission (permission, rank) VALUES ('create_login', 19);
INSERT INTO permission (permission, rank) VALUES ('modify_login', 20);
INSERT INTO permission (permission, rank) VALUES ('delete_login', 21);
INSERT INTO permission (permission, rank) VALUES ('modify_own_person', 22);
INSERT INTO permission (permission, rank) VALUES ('modify_own_event', 23);
INSERT INTO permission (permission, rank) VALUES ('modify_valuelist', 14);
INSERT INTO permission (permission, rank) VALUES ('write_valuelist', NULL);
INSERT INTO permission (permission, rank) VALUES ('create_valuelist', NULL);
INSERT INTO permission (permission, rank) VALUES ('admin_login', NULL);
INSERT INTO permission (permission, rank) VALUES ('delete_localization', NULL);
INSERT INTO permission (permission, rank) VALUES ('create_localization', NULL);
INSERT INTO permission (permission, rank) VALUES ('move_event', NULL);
INSERT INTO permission (permission, rank) VALUES ('pentabarf_login', 24);
INSERT INTO permission (permission, rank) VALUES ('submission_login', NULL);
INSERT INTO permission (permission, rank) VALUES ('view_ratings', NULL);
INSERT INTO permission (permission, rank) VALUES ('modify_config', NULL);


--
-- PostgreSQL database dump complete
--

