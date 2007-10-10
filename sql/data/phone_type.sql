--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Data for Name: phone_type; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO phone_type (scheme, rank, phone_type) VALUES ('tel', NULL, 'phone');
INSERT INTO phone_type (scheme, rank, phone_type) VALUES ('tel', NULL, 'mobile');
INSERT INTO phone_type (scheme, rank, phone_type) VALUES ('tel', NULL, 'secretary');
INSERT INTO phone_type (scheme, rank, phone_type) VALUES ('tel', NULL, 'work');
INSERT INTO phone_type (scheme, rank, phone_type) VALUES ('tel', NULL, 'private');
INSERT INTO phone_type (scheme, rank, phone_type) VALUES ('tel', NULL, 'dect');
INSERT INTO phone_type (scheme, rank, phone_type) VALUES ('skype', NULL, 'skype');
INSERT INTO phone_type (scheme, rank, phone_type) VALUES ('fax', NULL, 'fax');


--
-- PostgreSQL database dump complete
--

