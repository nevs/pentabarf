--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = auth, pg_catalog;

--
-- Data for Name: role_permission; Type: TABLE DATA; Schema: auth; Owner: -
--

INSERT INTO role_permission ("role", permission) VALUES ('developer', 'modify_person');
INSERT INTO role_permission ("role", permission) VALUES ('developer', 'delete_person');
INSERT INTO role_permission ("role", permission) VALUES ('developer', 'create_event');
INSERT INTO role_permission ("role", permission) VALUES ('developer', 'modify_event');
INSERT INTO role_permission ("role", permission) VALUES ('developer', 'delete_event');
INSERT INTO role_permission ("role", permission) VALUES ('developer', 'create_conference');
INSERT INTO role_permission ("role", permission) VALUES ('developer', 'modify_conference');
INSERT INTO role_permission ("role", permission) VALUES ('developer', 'delete_conference');
INSERT INTO role_permission ("role", permission) VALUES ('admin', 'create_person');
INSERT INTO role_permission ("role", permission) VALUES ('developer', 'modify_localization');
INSERT INTO role_permission ("role", permission) VALUES ('admin', 'delete_person');
INSERT INTO role_permission ("role", permission) VALUES ('admin', 'create_event');
INSERT INTO role_permission ("role", permission) VALUES ('admin', 'modify_event');
INSERT INTO role_permission ("role", permission) VALUES ('admin', 'delete_event');
INSERT INTO role_permission ("role", permission) VALUES ('admin', 'create_conference');
INSERT INTO role_permission ("role", permission) VALUES ('admin', 'modify_conference');
INSERT INTO role_permission ("role", permission) VALUES ('admin', 'delete_conference');
INSERT INTO role_permission ("role", permission) VALUES ('developer', 'create_person');
INSERT INTO role_permission ("role", permission) VALUES ('admin', 'modify_person');
INSERT INTO role_permission ("role", permission) VALUES ('developer', 'modify_valuelist');
INSERT INTO role_permission ("role", permission) VALUES ('developer', 'create_roles');
INSERT INTO role_permission ("role", permission) VALUES ('developer', 'modify_roles');
INSERT INTO role_permission ("role", permission) VALUES ('developer', 'delete_roles');
INSERT INTO role_permission ("role", permission) VALUES ('developer', 'create_login');
INSERT INTO role_permission ("role", permission) VALUES ('developer', 'modify_login');
INSERT INTO role_permission ("role", permission) VALUES ('developer', 'delete_login');
INSERT INTO role_permission ("role", permission) VALUES ('admin', 'modify_localization');
INSERT INTO role_permission ("role", permission) VALUES ('admin', 'modify_valuelist');
INSERT INTO role_permission ("role", permission) VALUES ('admin', 'create_roles');
INSERT INTO role_permission ("role", permission) VALUES ('admin', 'modify_roles');
INSERT INTO role_permission ("role", permission) VALUES ('admin', 'delete_roles');
INSERT INTO role_permission ("role", permission) VALUES ('admin', 'create_login');
INSERT INTO role_permission ("role", permission) VALUES ('admin', 'modify_login');
INSERT INTO role_permission ("role", permission) VALUES ('admin', 'delete_login');
INSERT INTO role_permission ("role", permission) VALUES ('developer', 'show_debug');
INSERT INTO role_permission ("role", permission) VALUES ('developer', 'modify_own_event');
INSERT INTO role_permission ("role", permission) VALUES ('admin', 'modify_own_event');
INSERT INTO role_permission ("role", permission) VALUES ('committee', 'modify_own_event');
INSERT INTO role_permission ("role", permission) VALUES ('developer', 'modify_own_person');
INSERT INTO role_permission ("role", permission) VALUES ('admin', 'modify_own_person');
INSERT INTO role_permission ("role", permission) VALUES ('developer', 'submission_login');
INSERT INTO role_permission ("role", permission) VALUES ('committee', 'create_event');
INSERT INTO role_permission ("role", permission) VALUES ('committee', 'modify_event');
INSERT INTO role_permission ("role", permission) VALUES ('committee', 'modify_conference');
INSERT INTO role_permission ("role", permission) VALUES ('admin', 'submission_login');
INSERT INTO role_permission ("role", permission) VALUES ('committee', 'submission_login');
INSERT INTO role_permission ("role", permission) VALUES ('developer', 'pentabarf_login');
INSERT INTO role_permission ("role", permission) VALUES ('admin', 'pentabarf_login');
INSERT INTO role_permission ("role", permission) VALUES ('reviewer', 'pentabarf_login');
INSERT INTO role_permission ("role", permission) VALUES ('committee', 'pentabarf_login');
INSERT INTO role_permission ("role", permission) VALUES ('developer', 'create_rating');
INSERT INTO role_permission ("role", permission) VALUES ('developer', 'modify_rating');
INSERT INTO role_permission ("role", permission) VALUES ('developer', 'delete_rating');
INSERT INTO role_permission ("role", permission) VALUES ('admin', 'create_rating');
INSERT INTO role_permission ("role", permission) VALUES ('reviewer', 'create_rating');
INSERT INTO role_permission ("role", permission) VALUES ('committee', 'create_rating');
INSERT INTO role_permission ("role", permission) VALUES ('admin', 'modify_rating');
INSERT INTO role_permission ("role", permission) VALUES ('reviewer', 'modify_rating');
INSERT INTO role_permission ("role", permission) VALUES ('committee', 'modify_rating');
INSERT INTO role_permission ("role", permission) VALUES ('admin', 'delete_rating');
INSERT INTO role_permission ("role", permission) VALUES ('reviewer', 'delete_rating');
INSERT INTO role_permission ("role", permission) VALUES ('committee', 'delete_rating');
INSERT INTO role_permission ("role", permission) VALUES ('developer', 'write_valuelist');
INSERT INTO role_permission ("role", permission) VALUES ('developer', 'create_valuelist');
INSERT INTO role_permission ("role", permission) VALUES ('developer', 'admin_login');
INSERT INTO role_permission ("role", permission) VALUES ('developer', 'create_localization');
INSERT INTO role_permission ("role", permission) VALUES ('developer', 'delete_localization');
INSERT INTO role_permission ("role", permission) VALUES ('admin', 'delete_localization');
INSERT INTO role_permission ("role", permission) VALUES ('admin', 'create_localization');
INSERT INTO role_permission ("role", permission) VALUES ('developer', 'move_event');
INSERT INTO role_permission ("role", permission) VALUES ('admin', 'move_event');
INSERT INTO role_permission ("role", permission) VALUES ('submitter', 'submission_login');
INSERT INTO role_permission ("role", permission) VALUES ('submitter', 'modify_own_person');
INSERT INTO role_permission ("role", permission) VALUES ('submitter', 'modify_own_event');
INSERT INTO role_permission ("role", permission) VALUES ('committee', 'create_conference');
INSERT INTO role_permission ("role", permission) VALUES ('reviewer', 'modify_own_person');
INSERT INTO role_permission ("role", permission) VALUES ('committee', 'create_person');
INSERT INTO role_permission ("role", permission) VALUES ('committee', 'modify_person');
INSERT INTO role_permission ("role", permission) VALUES ('committee', 'modify_own_person');
INSERT INTO role_permission ("role", permission) VALUES ('developer', 'view_ratings');
INSERT INTO role_permission ("role", permission) VALUES ('admin', 'view_ratings');
INSERT INTO role_permission ("role", permission) VALUES ('committee', 'view_ratings');
INSERT INTO role_permission ("role", permission) VALUES ('developer', 'modify_config');
INSERT INTO role_permission ("role", permission) VALUES ('admin', 'modify_config');
INSERT INTO role_permission ("role", permission) VALUES ('reviewer', 'modify_review');
INSERT INTO role_permission ("role", permission) VALUES ('admin', 'modify_review');
INSERT INTO role_permission ("role", permission) VALUES ('committee', 'modify_review');
INSERT INTO role_permission ("role", permission) VALUES ('developer', 'modify_review');


--
-- PostgreSQL database dump complete
--

