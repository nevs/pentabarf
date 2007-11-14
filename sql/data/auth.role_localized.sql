--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = auth, pg_catalog;

--
-- Data for Name: role_localized; Type: TABLE DATA; Schema: auth; Owner: -
--

INSERT INTO role_localized ("role", translated, name) VALUES ('committee', 'en', 'Committee');
INSERT INTO role_localized ("role", translated, name) VALUES ('developer', 'de', 'Entwickler');
INSERT INTO role_localized ("role", translated, name) VALUES ('admin', 'de', 'Administrator');
INSERT INTO role_localized ("role", translated, name) VALUES ('reviewer', 'de', 'Reviewer');
INSERT INTO role_localized ("role", translated, name) VALUES ('committee', 'de', 'Komitee');
INSERT INTO role_localized ("role", translated, name) VALUES ('developer', 'en', 'Developer');
INSERT INTO role_localized ("role", translated, name) VALUES ('admin', 'en', 'Administrator');
INSERT INTO role_localized ("role", translated, name) VALUES ('reviewer', 'en', 'Reviewer');
INSERT INTO role_localized ("role", translated, name) VALUES ('submitter', 'de', 'Submitter');
INSERT INTO role_localized ("role", translated, name) VALUES ('submitter', 'en', 'Submitter');


--
-- PostgreSQL database dump complete
--

