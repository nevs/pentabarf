--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Name: event_origin_event_origin_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('event_origin_event_origin_id_seq', 2, true);


--
-- Data for Name: event_origin; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO event_origin (event_origin_id, tag, rank) VALUES (1, 'idea', 1);
INSERT INTO event_origin (event_origin_id, tag, rank) VALUES (2, 'submission', 2);


--
-- PostgreSQL database dump complete
--

