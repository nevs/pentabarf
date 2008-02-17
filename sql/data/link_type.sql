
SET client_encoding = 'UTF8';
SET search_path = public, pg_catalog;

INSERT INTO link_type (link_type, "template", rank) VALUES ('orga wiki', 'https://22c3.cccv.de/wiki/', NULL);
INSERT INTO link_type (link_type, "template", rank) VALUES ('rt cccv', 'https://rt.cccv.de/Ticket/Display.html?id=', NULL);
INSERT INTO link_type (link_type, "template", rank) VALUES ('rt entheovision', 'https://rt.entheovision.de/Ticket/Display.html?id=', NULL);
INSERT INTO link_type (link_type, "template", rank) VALUES ('url', NULL, 1);
