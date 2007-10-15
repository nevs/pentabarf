--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Data for Name: link_type; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO link_type ("template", rank, link_type) VALUES ('https://22c3.cccv.de/wiki/', NULL, 'orga wiki');
INSERT INTO link_type ("template", rank, link_type) VALUES (NULL, 1, 'url');
INSERT INTO link_type ("template", rank, link_type) VALUES ('https://rt.entheovision.de/Ticket/Display.html?id=', NULL, 'rt entheovision');
INSERT INTO link_type ("template", rank, link_type) VALUES ('https://rt.cccv.de/Ticket/Display.html?id=', NULL, 'rt cccv');


--
-- PostgreSQL database dump complete
--

