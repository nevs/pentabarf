--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Name: event_origin_event_origin_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pentabarf
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('event_origin', 'event_origin_id'), 2, true);


--
-- Data for Name: event_origin; Type: TABLE DATA; Schema: public; Owner: pentabarf
--

INSERT INTO event_origin (event_origin_id, tag, rank) VALUES (1, 'idea', 1);
INSERT INTO event_origin (event_origin_id, tag, rank) VALUES (2, 'submission', 2);


--
-- PostgreSQL database dump complete
--

