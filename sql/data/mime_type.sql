--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Data for Name: mime_type; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO mime_type (mime_type, file_extension, image) VALUES ('application/msword', 'doc', false);
INSERT INTO mime_type (mime_type, file_extension, image) VALUES ('image/tiff', 'tif', true);
INSERT INTO mime_type (mime_type, file_extension, image) VALUES ('application/postscript', 'ps', false);
INSERT INTO mime_type (mime_type, file_extension, image) VALUES ('application/x-gzip', 'gz', false);
INSERT INTO mime_type (mime_type, file_extension, image) VALUES ('application/x-msdos-program', 'exe', false);
INSERT INTO mime_type (mime_type, file_extension, image) VALUES ('image/jpeg', 'jpg', true);
INSERT INTO mime_type (mime_type, file_extension, image) VALUES ('image/gif', 'gif', true);
INSERT INTO mime_type (mime_type, file_extension, image) VALUES ('application/zip', 'zip', false);
INSERT INTO mime_type (mime_type, file_extension, image) VALUES ('application/vnd.ms-powerpoint', 'ppt', false);
INSERT INTO mime_type (mime_type, file_extension, image) VALUES ('image/png', 'png', true);
INSERT INTO mime_type (mime_type, file_extension, image) VALUES ('application/pdf', 'pdf', false);
INSERT INTO mime_type (mime_type, file_extension, image) VALUES ('text/plain', 'txt', false);
INSERT INTO mime_type (mime_type, file_extension, image) VALUES ('text/html', 'html', false);
INSERT INTO mime_type (mime_type, file_extension, image) VALUES ('application/vnd.sun.xml.writer', 'sxw', false);
INSERT INTO mime_type (mime_type, file_extension, image) VALUES ('application/vnd.sun.xml.impress', 'sxi', false);
INSERT INTO mime_type (mime_type, file_extension, image) VALUES ('application/rtf', 'rtf', false);
INSERT INTO mime_type (mime_type, file_extension, image) VALUES ('application/x-bzip2', 'bz2', false);
INSERT INTO mime_type (mime_type, file_extension, image) VALUES ('application/x-bittorrent', 'torrent', false);
INSERT INTO mime_type (mime_type, file_extension, image) VALUES ('text/rtf', 'rtf', false);
INSERT INTO mime_type (mime_type, file_extension, image) VALUES ('application/octet-stream', NULL, false);
INSERT INTO mime_type (mime_type, file_extension, image) VALUES ('application/x-shockwave-flash', 'swf', false);
INSERT INTO mime_type (mime_type, file_extension, image) VALUES ('image/pjpeg', 'jpg', true);
INSERT INTO mime_type (mime_type, file_extension, image) VALUES ('image/svg+xml', 'svg', false);


--
-- PostgreSQL database dump complete
--

