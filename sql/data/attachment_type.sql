--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Data for Name: attachment_type; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO attachment_type (attachment_type, rank) VALUES ('slides', 1);
INSERT INTO attachment_type (attachment_type, rank) VALUES ('paper', 2);
INSERT INTO attachment_type (attachment_type, rank) VALUES ('other', 3);
INSERT INTO attachment_type (attachment_type, rank) VALUES ('audio', 4);
INSERT INTO attachment_type (attachment_type, rank) VALUES ('video', 5);


--
-- PostgreSQL database dump complete
--

