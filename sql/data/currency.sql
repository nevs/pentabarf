--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Name: currency_currency_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pentabarf
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('currency', 'currency_id'), 173, true);


--
-- Data for Name: currency; Type: TABLE DATA; Schema: public; Owner: pentabarf
--

INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (1, 'AED', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (2, 'AFA', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (3, 'ALL', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (4, 'AMD', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (5, 'ANG', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (6, 'AOA', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (7, 'ARS', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (8, 'AUD', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (9, 'AWG', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (10, 'AZM', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (11, 'BAM', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (12, 'BBD', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (13, 'BDT', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (14, 'BGN', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (15, 'BHD', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (16, 'BIF', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (17, 'BMD', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (18, 'BND', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (19, 'BOB', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (20, 'BRL', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (21, 'BSD', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (22, 'BTN', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (23, 'BWP', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (24, 'BYR', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (25, 'BZD', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (26, 'CAD', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (27, 'CDF', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (28, 'CHF', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (29, 'CLP', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (30, 'CNY', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (31, 'COP', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (32, 'CRC', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (33, 'CSD', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (34, 'CUP', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (35, 'CVE', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (36, 'CYP', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (37, 'CZK', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (38, 'DJF', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (40, 'DOP', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (41, 'DZD', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (42, 'EEK', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (43, 'EGP', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (44, 'ERN', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (45, 'ETB', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (47, 'FJD', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (48, 'FKP', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (50, 'GEL', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (51, 'GGP', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (52, 'GHC', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (53, 'GIP', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (54, 'GMD', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (55, 'GNF', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (56, 'GTQ', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (57, 'GYD', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (58, 'HKD', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (59, 'HNL', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (60, 'HRK', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (61, 'HTG', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (62, 'HUF', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (63, 'IDR', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (64, 'ILS', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (65, 'IMP', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (66, 'INR', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (67, 'IQD', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (68, 'IRR', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (69, 'ISK', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (70, 'JEP', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (71, 'JMD', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (72, 'JOD', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (74, 'KES', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (75, 'KGS', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (76, 'KHR', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (77, 'KMF', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (78, 'KPW', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (79, 'KRW', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (80, 'KWD', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (81, 'KYD', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (82, 'KZT', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (83, 'LAK', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (84, 'LBP', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (85, 'LKR', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (86, 'LRD', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (87, 'LSL', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (88, 'LTL', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (89, 'LVL', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (90, 'LYD', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (91, 'MAD', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (92, 'MDL', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (93, 'MGA', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (94, 'MKD', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (95, 'MMK', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (96, 'MNT', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (97, 'MOP', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (98, 'MRO', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (99, 'MTL', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (100, 'MUR', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (101, 'MVR', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (102, 'MWK', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (103, 'MXN', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (104, 'MYR', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (105, 'MZM', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (106, 'NAD', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (107, 'NGN', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (108, 'NIO', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (109, 'NOK', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (110, 'NPR', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (111, 'NZD', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (112, 'OMR', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (113, 'PAB', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (114, 'PEN', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (115, 'PGK', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (116, 'PHP', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (117, 'PKR', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (118, 'PLN', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (119, 'PYG', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (120, 'QAR', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (121, 'ROL', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (122, 'RUR', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (123, 'RWF', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (124, 'SAR', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (125, 'SBD', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (126, 'SCR', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (127, 'SDD', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (129, 'SGD', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (130, 'SHP', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (131, 'SIT', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (132, 'SKK', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (133, 'SLL', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (134, 'SOS', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (135, 'SPL', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (136, 'SRD', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (137, 'STD', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (138, 'SVC', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (139, 'SYP', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (140, 'SZL', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (141, 'THB', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (142, 'TJS', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (143, 'TMM', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (144, 'TND', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (145, 'TOP', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (146, 'TRL', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (147, 'TTD', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (148, 'TVD', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (149, 'TWD', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (150, 'TZS', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (151, 'UAH', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (152, 'UGX', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (154, 'UYU', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (155, 'UZS', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (156, 'VEB', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (157, 'VND', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (158, 'VUV', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (159, 'WST', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (160, 'XAF', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (161, 'XAG', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (162, 'XAU', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (163, 'XCD', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (164, 'XDR', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (165, 'XOF', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (166, 'XPD', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (167, 'XPF', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (168, 'XPT', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (169, 'YER', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (170, 'ZAR', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (171, 'ZMK', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (172, 'ZWD', false, false, false, NULL);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (153, 'USD', false, true, false, 1.28560);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (73, 'JPY', false, false, false, 136.51000);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (39, 'DKK', false, false, false, 7.43340);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (128, 'SEK', false, false, false, 9.10800);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (46, 'EUR', true, true, false, 1.00000);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (49, 'GBP', false, true, false, 0.69775);
INSERT INTO currency (currency_id, iso_4217_code, f_default, f_visible, f_preferred, exchange_rate) VALUES (173, 'DEM', false, true, false, NULL);


--
-- PostgreSQL database dump complete
--

