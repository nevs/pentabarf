--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Name: im_type_im_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pentabarf
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('im_type', 'im_type_id'), 7, true);


--
-- Data for Name: im_type; Type: TABLE DATA; Schema: public; Owner: pentabarf
--

INSERT INTO im_type (im_type_id, tag, scheme, rank) VALUES (2, 'jabber', 'jabber', 1);
INSERT INTO im_type (im_type_id, tag, scheme, rank) VALUES (4, 'icq', 'icq', 2);
INSERT INTO im_type (im_type_id, tag, scheme, rank) VALUES (3, 'aim', 'aim', 3);
INSERT INTO im_type (im_type_id, tag, scheme, rank) VALUES (6, 'msn', 'msn', 4);
INSERT INTO im_type (im_type_id, tag, scheme, rank) VALUES (7, 'yahoo', 'yahoo', 5);
INSERT INTO im_type (im_type_id, tag, scheme, rank) VALUES (5, 'gadugadu', 'gadugadu', 6);


--
-- PostgreSQL database dump complete
--

