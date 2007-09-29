--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = auth, pg_catalog;

--
-- Data for Name: role; Type: TABLE DATA; Schema: auth; Owner: -
--

INSERT INTO "role" ("role", rank) VALUES ('developer', 1);
INSERT INTO "role" ("role", rank) VALUES ('admin', 2);
INSERT INTO "role" ("role", rank) VALUES ('committee', 3);
INSERT INTO "role" ("role", rank) VALUES ('reviewer', 4);
INSERT INTO "role" ("role", rank) VALUES ('submitter', 7);


--
-- PostgreSQL database dump complete
--

