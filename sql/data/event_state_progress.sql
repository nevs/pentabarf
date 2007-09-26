--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Data for Name: event_state_progress; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO event_state_progress (rank, event_state, event_state_progress) VALUES (1, 'undecided', 'new');
INSERT INTO event_state_progress (rank, event_state, event_state_progress) VALUES (2, 'undecided', 'review');
INSERT INTO event_state_progress (rank, event_state, event_state_progress) VALUES (3, 'undecided', 'candidate');
INSERT INTO event_state_progress (rank, event_state, event_state_progress) VALUES (4, 'undecided', 'withdrawn');
INSERT INTO event_state_progress (rank, event_state, event_state_progress) VALUES (1, 'accepted', 'unconfirmed');
INSERT INTO event_state_progress (rank, event_state, event_state_progress) VALUES (2, 'accepted', 'confirmed');
INSERT INTO event_state_progress (rank, event_state, event_state_progress) VALUES (3, 'accepted', 'canceled');
INSERT INTO event_state_progress (rank, event_state, event_state_progress) VALUES (1, 'rejected', 'unconfirmed');
INSERT INTO event_state_progress (rank, event_state, event_state_progress) VALUES (2, 'rejected', 'confirmed');
INSERT INTO event_state_progress (rank, event_state, event_state_progress) VALUES (5, 'undecided', 'rejection-candidate');


--
-- PostgreSQL database dump complete
--

