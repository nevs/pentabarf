--
-- PostgreSQL database dump
--

BEGIN TRANSACTION;

SET client_encoding = 'UNICODE';

SET search_path = public, pg_catalog;

--
-- Data for TOC entry 2 (OID 66391)
-- Name: time_zone_localized; Type: TABLE DATA; Schema: public; Owner: pentabarf
--

INSERT INTO time_zone_localized (time_zone_id, language_id, name) VALUES (1, 120, 'London');
INSERT INTO time_zone_localized (time_zone_id, language_id, name) VALUES (2, 120, 'Berlin, Paris');
INSERT INTO time_zone_localized (time_zone_id, language_id, name) VALUES (3, 120, 'Vilnius');
INSERT INTO time_zone_localized (time_zone_id, language_id, name) VALUES (1, 144, 'London');
INSERT INTO time_zone_localized (time_zone_id, language_id, name) VALUES (2, 144, 'Berlin');
INSERT INTO time_zone_localized (time_zone_id, language_id, name) VALUES (3, 144, 'Wilna');

COMMIT TRANSACTION;

