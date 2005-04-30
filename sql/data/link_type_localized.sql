--
-- PostgreSQL database dump
--

BEGIN TRANSACTION;

SET client_encoding = 'UNICODE';

SET search_path = public, pg_catalog;

--
-- Data for TOC entry 2 (OID 66414)
-- Name: link_type_localized; Type: TABLE DATA; Schema: public; Owner: pentabarf
--

INSERT INTO link_type_localized (link_type_id, language_id, name) VALUES (1, 120, 'Home page');
INSERT INTO link_type_localized (link_type_id, language_id, name) VALUES (2, 120, 'weblog');
INSERT INTO link_type_localized (link_type_id, language_id, name) VALUES (3, 120, 'Request Tracker');
INSERT INTO link_type_localized (link_type_id, language_id, name) VALUES (1, 144, 'Öffentlicher Link');
INSERT INTO link_type_localized (link_type_id, language_id, name) VALUES (4, 120, 'Topic');
INSERT INTO link_type_localized (link_type_id, language_id, name) VALUES (2, 144, 'Weblog');
INSERT INTO link_type_localized (link_type_id, language_id, name) VALUES (3, 144, 'Request Tracker');
INSERT INTO link_type_localized (link_type_id, language_id, name) VALUES (4, 144, 'Link zum Orga Wiki');
INSERT INTO link_type_localized (link_type_id, language_id, name) VALUES (5, 120, 'Slides');
INSERT INTO link_type_localized (link_type_id, language_id, name) VALUES (6, 120, 'document');
INSERT INTO link_type_localized (link_type_id, language_id, name) VALUES (5, 144, 'Dokumentation');
INSERT INTO link_type_localized (link_type_id, language_id, name) VALUES (6, 144, 'Dokument');

COMMIT TRANSACTION;

