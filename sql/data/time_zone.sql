--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Name: time_zone_time_zone_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pentabarf
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('time_zone', 'time_zone_id'), 3, true);


--
-- Data for Name: time_zone; Type: TABLE DATA; Schema: public; Owner: pentabarf
--

INSERT INTO time_zone (time_zone_id, tag, f_visible, f_preferred) VALUES (1, 'utc', false, false);
INSERT INTO time_zone (time_zone_id, tag, f_visible, f_preferred) VALUES (2, 'utc+1', false, false);
INSERT INTO time_zone (time_zone_id, tag, f_visible, f_preferred) VALUES (3, 'utc+2', false, false);


--
-- PostgreSQL database dump complete
--

