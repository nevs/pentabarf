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

INSERT INTO link_type (link_type, "template", rank) VALUES ('orga wiki', 'https://22c3.cccv.de/wiki/', NULL);
INSERT INTO link_type (link_type, "template", rank) VALUES ('url', NULL, 1);
INSERT INTO link_type (link_type, "template", rank) VALUES ('rt entheovision', 'https://rt.entheovision.de/Ticket/Display.html?id=', NULL);
INSERT INTO link_type (link_type, "template", rank) VALUES ('rt cccv', 'https://rt.cccv.de/Ticket/Display.html?id=', NULL);


--
-- PostgreSQL database dump complete
--

