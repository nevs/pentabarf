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

INSERT INTO phone_type (phone_type, scheme, rank) VALUES ('phone', 'tel', NULL);
INSERT INTO phone_type (phone_type, scheme, rank) VALUES ('mobile', 'tel', NULL);
INSERT INTO phone_type (phone_type, scheme, rank) VALUES ('secretary', 'tel', NULL);
INSERT INTO phone_type (phone_type, scheme, rank) VALUES ('work', 'tel', NULL);
INSERT INTO phone_type (phone_type, scheme, rank) VALUES ('private', 'tel', NULL);
INSERT INTO phone_type (phone_type, scheme, rank) VALUES ('dect', 'tel', NULL);
INSERT INTO phone_type (phone_type, scheme, rank) VALUES ('skype', 'skype', NULL);
INSERT INTO phone_type (phone_type, scheme, rank) VALUES ('fax', 'fax', NULL);


--
-- PostgreSQL database dump complete
--

