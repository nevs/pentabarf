--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Name: mime_type_mime_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('mime_type_mime_type_id_seq', 22, true);


--
-- Data for Name: mime_type; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO mime_type (mime_type_id, mime_type, file_extension, f_image) VALUES (9, 'application/msword', 'doc', false);
INSERT INTO mime_type (mime_type_id, mime_type, file_extension, f_image) VALUES (14, 'image/tiff', 'tif', true);
INSERT INTO mime_type (mime_type_id, mime_type, file_extension, f_image) VALUES (13, 'application/postscript', 'ps', false);
INSERT INTO mime_type (mime_type_id, mime_type, file_extension, f_image) VALUES (15, 'application/x-gzip', 'gz', false);
INSERT INTO mime_type (mime_type_id, mime_type, file_extension, f_image) VALUES (10, 'application/x-msdos-program', 'exe', false);
INSERT INTO mime_type (mime_type_id, mime_type, file_extension, f_image) VALUES (1, 'image/jpeg', 'jpg', true);
INSERT INTO mime_type (mime_type_id, mime_type, file_extension, f_image) VALUES (2, 'image/gif', 'gif', true);
INSERT INTO mime_type (mime_type_id, mime_type, file_extension, f_image) VALUES (11, 'application/zip', 'zip', false);
INSERT INTO mime_type (mime_type_id, mime_type, file_extension, f_image) VALUES (5, 'application/vnd.ms-powerpoint', 'ppt', false);
INSERT INTO mime_type (mime_type_id, mime_type, file_extension, f_image) VALUES (3, 'image/png', 'png', true);
INSERT INTO mime_type (mime_type_id, mime_type, file_extension, f_image) VALUES (4, 'application/pdf', 'pdf', false);
INSERT INTO mime_type (mime_type_id, mime_type, file_extension, f_image) VALUES (6, 'text/plain', 'txt', false);
INSERT INTO mime_type (mime_type_id, mime_type, file_extension, f_image) VALUES (16, 'text/html', 'html', false);
INSERT INTO mime_type (mime_type_id, mime_type, file_extension, f_image) VALUES (7, 'application/vnd.sun.xml.writer', 'sxw', false);
INSERT INTO mime_type (mime_type_id, mime_type, file_extension, f_image) VALUES (8, 'application/vnd.sun.xml.impress', 'sxi', false);
INSERT INTO mime_type (mime_type_id, mime_type, file_extension, f_image) VALUES (17, 'application/rtf', 'rtf', false);
INSERT INTO mime_type (mime_type_id, mime_type, file_extension, f_image) VALUES (18, 'application/x-bzip2', 'bz2', false);
INSERT INTO mime_type (mime_type_id, mime_type, file_extension, f_image) VALUES (19, 'application/x-bittorrent', 'torrent', false);
INSERT INTO mime_type (mime_type_id, mime_type, file_extension, f_image) VALUES (20, 'text/rtf', 'rtf', false);
INSERT INTO mime_type (mime_type_id, mime_type, file_extension, f_image) VALUES (12, 'application/octet-stream', NULL, false);
INSERT INTO mime_type (mime_type_id, mime_type, file_extension, f_image) VALUES (21, 'application/x-shockwave-flash', 'swf', false);
INSERT INTO mime_type (mime_type_id, mime_type, file_extension, f_image) VALUES (22, 'image/pjpeg', 'jpg', true);


--
-- PostgreSQL database dump complete
--

