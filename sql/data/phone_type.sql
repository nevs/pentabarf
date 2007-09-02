--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Name: phone_type_phone_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('phone_type_phone_type_id_seq', 8, true);


--
-- Data for Name: phone_type; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO phone_type (phone_type_id, tag, scheme, rank) VALUES (1, 'phone', 'tel', NULL);
INSERT INTO phone_type (phone_type_id, tag, scheme, rank) VALUES (3, 'mobile', 'tel', NULL);
INSERT INTO phone_type (phone_type_id, tag, scheme, rank) VALUES (4, 'secretary', 'tel', NULL);
INSERT INTO phone_type (phone_type_id, tag, scheme, rank) VALUES (5, 'work', 'tel', NULL);
INSERT INTO phone_type (phone_type_id, tag, scheme, rank) VALUES (6, 'private', 'tel', NULL);
INSERT INTO phone_type (phone_type_id, tag, scheme, rank) VALUES (7, 'dect', 'tel', NULL);
INSERT INTO phone_type (phone_type_id, tag, scheme, rank) VALUES (8, 'skype', 'skype', NULL);
INSERT INTO phone_type (phone_type_id, tag, scheme, rank) VALUES (2, 'fax', 'fax', NULL);


--
-- PostgreSQL database dump complete
--

