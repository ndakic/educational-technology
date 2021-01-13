--
-- PostgreSQL database dump
--

-- Dumped from database version 9.3.24
-- Dumped by pg_dump version 12.5 (Ubuntu 12.5-0ubuntu0.20.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'SQL_ASCII';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: elearningdb; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE elearningdb WITH TEMPLATE = template0 ENCODING = 'SQL_ASCII' LC_COLLATE = 'C' LC_CTYPE = 'C';


ALTER DATABASE elearningdb OWNER TO postgres;

\connect elearningdb

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'SQL_ASCII';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

--
-- Name: answer; Type: TABLE; Schema: public; Owner: euser
--

CREATE TABLE public.answer (
    answer_id bigint NOT NULL,
    md5h character varying(255),
    text character varying(255),
    question_id bigint NOT NULL,
    status_id bigint NOT NULL,
    correct boolean
);


ALTER TABLE public.answer OWNER TO euser;

--
-- Name: answer_history; Type: TABLE; Schema: public; Owner: euser
--

CREATE TABLE public.answer_history (
    answer_history_id bigint NOT NULL,
    date timestamp without time zone,
    answer_id bigint NOT NULL,
    euser_id bigint NOT NULL,
    question_id bigint NOT NULL,
    test_id bigint NOT NULL
);


ALTER TABLE public.answer_history OWNER TO euser;

--
-- Name: answer_history_seq; Type: SEQUENCE; Schema: public; Owner: euser
--

CREATE SEQUENCE public.answer_history_seq
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.answer_history_seq OWNER TO euser;

--
-- Name: answer_id_seq; Type: SEQUENCE; Schema: public; Owner: euser
--

CREATE SEQUENCE public.answer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.answer_id_seq OWNER TO euser;

--
-- Name: domain; Type: TABLE; Schema: public; Owner: euser
--

CREATE TABLE public.domain (
    domain_id bigint NOT NULL,
    md5h character varying(255),
    title character varying(255),
    status_id bigint NOT NULL,
    euser_id bigint NOT NULL
);


ALTER TABLE public.domain OWNER TO euser;

--
-- Name: domain_id_seq; Type: SEQUENCE; Schema: public; Owner: euser
--

CREATE SEQUENCE public.domain_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.domain_id_seq OWNER TO euser;

--
-- Name: euser; Type: TABLE; Schema: public; Owner: euser
--

CREATE TABLE public.euser (
    euser_id bigint NOT NULL,
    email character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    md5h character varying(255),
    password character varying(255),
    registration_date timestamp without time zone,
    status_id bigint NOT NULL,
    user_type character varying(255)
);


ALTER TABLE public.euser OWNER TO euser;

--
-- Name: euser_id_seq; Type: SEQUENCE; Schema: public; Owner: euser
--

CREATE SEQUENCE public.euser_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.euser_id_seq OWNER TO euser;

--
-- Name: link; Type: TABLE; Schema: public; Owner: euser
--

CREATE TABLE public.link (
    link_id bigint NOT NULL,
    left_direction boolean,
    right_direction boolean,
    source_problem_id bigint,
    status_id bigint NOT NULL,
    target_problem_id bigint,
    domain_id bigint NOT NULL,
    md5h character varying(255)
);


ALTER TABLE public.link OWNER TO euser;

--
-- Name: link_id_seq; Type: SEQUENCE; Schema: public; Owner: euser
--

CREATE SEQUENCE public.link_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.link_id_seq OWNER TO euser;

--
-- Name: linkid_seq; Type: SEQUENCE; Schema: public; Owner: euser
--

CREATE SEQUENCE public.linkid_seq
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.linkid_seq OWNER TO euser;

--
-- Name: node_id_seq; Type: SEQUENCE; Schema: public; Owner: euser
--

CREATE SEQUENCE public.node_id_seq
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.node_id_seq OWNER TO euser;

--
-- Name: problem; Type: TABLE; Schema: public; Owner: euser
--

CREATE TABLE public.problem (
    problem_id bigint NOT NULL,
    md5h character varying(255),
    reflexive boolean,
    title character varying(255),
    domain_id bigint NOT NULL,
    status_id bigint NOT NULL,
    knowledge_state character varying(5000),
    probability double precision,
    credibility integer,
    x double precision,
    y double precision
);


ALTER TABLE public.problem OWNER TO euser;

--
-- Name: problem_id_seq; Type: SEQUENCE; Schema: public; Owner: euser
--

CREATE SEQUENCE public.problem_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.problem_id_seq OWNER TO euser;

--
-- Name: question; Type: TABLE; Schema: public; Owner: euser
--

CREATE TABLE public.question (
    question_id bigint NOT NULL,
    md5h character varying(255),
    text character varying(255),
    status_id bigint NOT NULL,
    test_id bigint NOT NULL,
    problem_id bigint
);


ALTER TABLE public.question OWNER TO euser;

--
-- Name: question_id_seq; Type: SEQUENCE; Schema: public; Owner: euser
--

CREATE SEQUENCE public.question_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.question_id_seq OWNER TO euser;

--
-- Name: status; Type: TABLE; Schema: public; Owner: euser
--

CREATE TABLE public.status (
    status_id bigint NOT NULL,
    description character varying(254),
    name character varying(254)
);


ALTER TABLE public.status OWNER TO euser;

--
-- Name: status_id_seq; Type: SEQUENCE; Schema: public; Owner: euser
--

CREATE SEQUENCE public.status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.status_id_seq OWNER TO euser;

--
-- Name: test; Type: TABLE; Schema: public; Owner: euser
--

CREATE TABLE public.test (
    test_id bigint NOT NULL,
    title character varying(255),
    status_id bigint NOT NULL,
    md5h character varying(255),
    creation_date timestamp without time zone,
    end_date timestamp without time zone,
    start_date timestamp without time zone,
    euser_id bigint NOT NULL,
    domain_id bigint
);


ALTER TABLE public.test OWNER TO euser;

--
-- Name: test_id_seq; Type: SEQUENCE; Schema: public; Owner: euser
--

CREATE SEQUENCE public.test_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.test_id_seq OWNER TO euser;

--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: euser
--

CREATE SEQUENCE public.user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_id_seq OWNER TO euser;

--
-- Data for Name: answer; Type: TABLE DATA; Schema: public; Owner: euser
--

INSERT INTO public.answer (answer_id, md5h, text, question_id, status_id, correct) VALUES (102, '382f13bc22de4222a23d4444f3698e26', '64', 61, 30, true);
INSERT INTO public.answer (answer_id, md5h, text, question_id, status_id, correct) VALUES (101, '260a8ba74d4b77a7b7bac3784e6fd5cf', '264', 60, 30, true);
INSERT INTO public.answer (answer_id, md5h, text, question_id, status_id, correct) VALUES (100, '2228b04b5362d62d79c506b016f68829', '254', 60, 30, false);
INSERT INTO public.answer (answer_id, md5h, text, question_id, status_id, correct) VALUES (99, 'b12aafd0533212ad2e13212db39300c5', '49', 59, 30, false);
INSERT INTO public.answer (answer_id, md5h, text, question_id, status_id, correct) VALUES (98, '62f162ff14aacda64af93f98ee210fe4', '51', 59, 30, true);
INSERT INTO public.answer (answer_id, md5h, text, question_id, status_id, correct) VALUES (97, '0ec7a3dac3ea3076f8ef87df0afd7bc1', '627', 58, 30, false);
INSERT INTO public.answer (answer_id, md5h, text, question_id, status_id, correct) VALUES (96, '7b5b3316388d53cebdc25f1ec14aa9ee', '637', 58, 30, true);
INSERT INTO public.answer (answer_id, md5h, text, question_id, status_id, correct) VALUES (107, 'ec2ab24e33860f6de97a47c62242763e', '532', 63, 30, false);
INSERT INTO public.answer (answer_id, md5h, text, question_id, status_id, correct) VALUES (106, '449ee7baf52581db4f6b66d4b272995b', '432', 63, 30, true);
INSERT INTO public.answer (answer_id, md5h, text, question_id, status_id, correct) VALUES (105, 'd0a241d11f98684d75eb5814eae1af94', '7', 62, 30, true);
INSERT INTO public.answer (answer_id, md5h, text, question_id, status_id, correct) VALUES (104, '7f50dabfedcbce2aac5c06e45afef5c4', '3', 62, 30, false);
INSERT INTO public.answer (answer_id, md5h, text, question_id, status_id, correct) VALUES (95, '3779c8c360fdab399be51f94809f36dc', '38', 57, 30, true);
INSERT INTO public.answer (answer_id, md5h, text, question_id, status_id, correct) VALUES (94, '0f3c5306644ce619caf36981003d8901', '36', 57, 30, false);
INSERT INTO public.answer (answer_id, md5h, text, question_id, status_id, correct) VALUES (93, '30dbf46664a1746c90856c5d4892b613', '6', 56, 30, false);
INSERT INTO public.answer (answer_id, md5h, text, question_id, status_id, correct) VALUES (92, '67847687fb94e37a744b20d6704df235', '4', 56, 30, true);
INSERT INTO public.answer (answer_id, md5h, text, question_id, status_id, correct) VALUES (103, 'b1d719d34b7b8fb347b4a70882ccb64a', '24', 61, 30, false);


--
-- Data for Name: answer_history; Type: TABLE DATA; Schema: public; Owner: euser
--

INSERT INTO public.answer_history (answer_history_id, date, answer_id, euser_id, question_id, test_id) VALUES (2502, '2021-01-13 15:36:18.675833', 92, 2, 56, 21);
INSERT INTO public.answer_history (answer_history_id, date, answer_id, euser_id, question_id, test_id) VALUES (2503, '2021-01-13 15:36:51.354394', 103, 2, 61, 21);
INSERT INTO public.answer_history (answer_history_id, date, answer_id, euser_id, question_id, test_id) VALUES (2504, '2021-01-13 15:36:51.468307', 107, 2, 63, 21);
INSERT INTO public.answer_history (answer_history_id, date, answer_id, euser_id, question_id, test_id) VALUES (2505, '2021-01-13 15:36:51.471835', 104, 2, 62, 21);
INSERT INTO public.answer_history (answer_history_id, date, answer_id, euser_id, question_id, test_id) VALUES (2506, '2021-01-13 15:38:31.924273', 98, 2, 59, 21);
INSERT INTO public.answer_history (answer_history_id, date, answer_id, euser_id, question_id, test_id) VALUES (2507, '2021-01-13 15:38:34.77308', 101, 2, 60, 21);
INSERT INTO public.answer_history (answer_history_id, date, answer_id, euser_id, question_id, test_id) VALUES (2508, '2021-01-13 15:38:39.044936', 96, 2, 58, 21);
INSERT INTO public.answer_history (answer_history_id, date, answer_id, euser_id, question_id, test_id) VALUES (2509, '2021-01-13 15:38:44.725216', 95, 2, 57, 21);
INSERT INTO public.answer_history (answer_history_id, date, answer_id, euser_id, question_id, test_id) VALUES (2552, '2021-01-13 15:46:32.051158', 92, 2, 56, 21);
INSERT INTO public.answer_history (answer_history_id, date, answer_id, euser_id, question_id, test_id) VALUES (2553, '2021-01-13 15:46:51.245797', 94, 2, 57, 21);
INSERT INTO public.answer_history (answer_history_id, date, answer_id, euser_id, question_id, test_id) VALUES (2554, '2021-01-13 15:46:51.370967', 107, 2, 63, 21);
INSERT INTO public.answer_history (answer_history_id, date, answer_id, euser_id, question_id, test_id) VALUES (2555, '2021-01-13 15:46:51.372915', 103, 2, 61, 21);
INSERT INTO public.answer_history (answer_history_id, date, answer_id, euser_id, question_id, test_id) VALUES (2556, '2021-01-13 15:46:51.374152', 104, 2, 62, 21);
INSERT INTO public.answer_history (answer_history_id, date, answer_id, euser_id, question_id, test_id) VALUES (2557, '2021-01-13 15:46:54.538231', 98, 2, 59, 21);
INSERT INTO public.answer_history (answer_history_id, date, answer_id, euser_id, question_id, test_id) VALUES (2558, '2021-01-13 15:47:00.969606', 97, 2, 58, 21);
INSERT INTO public.answer_history (answer_history_id, date, answer_id, euser_id, question_id, test_id) VALUES (2559, '2021-01-13 15:47:08.666842', 100, 2, 60, 21);


--
-- Data for Name: domain; Type: TABLE DATA; Schema: public; Owner: euser
--

INSERT INTO public.domain (domain_id, md5h, title, status_id, euser_id) VALUES (16, '0ae8563363c3eed8b1cb10eb42dabea9', 'Mata', 60, 1);


--
-- Data for Name: euser; Type: TABLE DATA; Schema: public; Owner: euser
--

INSERT INTO public.euser (euser_id, email, first_name, last_name, md5h, password, registration_date, status_id, user_type) VALUES (1, 'daka@gmail.com', 'Nikola', 'Dakic', '8d4aff29071ddee43ffa150a3c7aace8', '1234', NULL, 1, 'TEACHER');
INSERT INTO public.euser (euser_id, email, first_name, last_name, md5h, password, registration_date, status_id, user_type) VALUES (2, 'marko@gmail.com', 'Marko', 'Markovic', '5bc67bef74afd2fb0f5a370d72b1c913', '1234', NULL, 1, 'STUDENT');
INSERT INTO public.euser (euser_id, email, first_name, last_name, md5h, password, registration_date, status_id, user_type) VALUES (6, 'andrija@gmail.com', 'Andrija', 'Peric', '8d4aff29071ddee43ffa150a3c7aa266', '1234', NULL, 1, 'STUDENT');
INSERT INTO public.euser (euser_id, email, first_name, last_name, md5h, password, registration_date, status_id, user_type) VALUES (4, 'aleksandar@gmail.com', 'Aleksandar', 'Djukic', '8d4aff29071ddee43ffa150a3c7343', '1234', NULL, 1, 'STUDENT');
INSERT INTO public.euser (euser_id, email, first_name, last_name, md5h, password, registration_date, status_id, user_type) VALUES (3, 'nemanja@gmail.com', 'Nemanja', 'Letic', '8d4aff29071ddee43ffa150a3c7aa44', '1234', NULL, 1, 'STUDENT');
INSERT INTO public.euser (euser_id, email, first_name, last_name, md5h, password, registration_date, status_id, user_type) VALUES (5, 'milutin@gmail.com', 'Milutin', 'Maric', '8d4aff29071ddee43ffa150a3c7aa99', '1234', NULL, 1, 'STUDENT');


--
-- Data for Name: link; Type: TABLE DATA; Schema: public; Owner: euser
--

INSERT INTO public.link (link_id, left_direction, right_direction, source_problem_id, status_id, target_problem_id, domain_id, md5h) VALUES (593, false, true, 668, 50, 672, 16, '68063c260d620db4c205a236ea8547f0');
INSERT INTO public.link (link_id, left_direction, right_direction, source_problem_id, status_id, target_problem_id, domain_id, md5h) VALUES (594, false, true, 668, 50, 671, 16, 'ef899f0f693a379290e8286622c42da7');
INSERT INTO public.link (link_id, left_direction, right_direction, source_problem_id, status_id, target_problem_id, domain_id, md5h) VALUES (595, false, true, 668, 50, 670, 16, '38272216c2a8613b5d1e4a2edf86171f');
INSERT INTO public.link (link_id, left_direction, right_direction, source_problem_id, status_id, target_problem_id, domain_id, md5h) VALUES (596, false, true, 668, 50, 669, 16, 'd7fed624771ceb638f20dda05af0e56d');
INSERT INTO public.link (link_id, left_direction, right_direction, source_problem_id, status_id, target_problem_id, domain_id, md5h) VALUES (597, false, true, 670, 50, 679, 16, 'ccdf145901254036236d60b94f33e46d');
INSERT INTO public.link (link_id, left_direction, right_direction, source_problem_id, status_id, target_problem_id, domain_id, md5h) VALUES (598, false, true, 669, 50, 679, 16, 'be04c6d2b04cbe103415ae63b8718918');
INSERT INTO public.link (link_id, left_direction, right_direction, source_problem_id, status_id, target_problem_id, domain_id, md5h) VALUES (599, false, true, 671, 50, 679, 16, 'ee99881a484a9342495c4f4b90a5a9f4');
INSERT INTO public.link (link_id, left_direction, right_direction, source_problem_id, status_id, target_problem_id, domain_id, md5h) VALUES (600, false, true, 672, 50, 679, 16, 'ebfec987c79a5fb53d442990e5020ed0');
INSERT INTO public.link (link_id, left_direction, right_direction, source_problem_id, status_id, target_problem_id, domain_id, md5h) VALUES (601, false, true, 679, 50, 680, 16, '714351f6ffcb07d7d4651caae74beea5');
INSERT INTO public.link (link_id, left_direction, right_direction, source_problem_id, status_id, target_problem_id, domain_id, md5h) VALUES (602, false, true, 679, 50, 681, 16, '26fb09b0071932080a5c748d5252ff34');


--
-- Data for Name: problem; Type: TABLE DATA; Schema: public; Owner: euser
--

INSERT INTO public.problem (problem_id, md5h, reflexive, title, domain_id, status_id, knowledge_state, probability, credibility, x, y) VALUES (670, '10ac3c80e07f7ca3afd6e2adbb342a4f', false, 'Add up to 1000', 16, 40, 'Add up to 1000,Add up to 10', 11.9540229885057467, 104, 512, 378);
INSERT INTO public.problem (problem_id, md5h, reflexive, title, domain_id, status_id, knowledge_state, probability, credibility, x, y) VALUES (681, '31c8e03fc2091989310d1ce0863e11ce', false, 'division up to 100', 16, 40, 'division up to 100,multi up to 100,Add up to 1000,Add up to 10,Add up to 100,Sub up to 100,Sub up to 1000', 12.1839080459770113, 106, 716, 93);
INSERT INTO public.problem (problem_id, md5h, reflexive, title, domain_id, status_id, knowledge_state, probability, credibility, x, y) VALUES (680, '1b1c3a8651c81f92c53ed5fabea5a747', false, 'multi up to 1000', 16, 40, 'multi up to 1000,multi up to 100,Add up to 1000,Add up to 10,Add up to 100,Sub up to 100,Sub up to 1000', 12.1839080459770113, 106, 455, 98);
INSERT INTO public.problem (problem_id, md5h, reflexive, title, domain_id, status_id, knowledge_state, probability, credibility, x, y) VALUES (679, '55b6d9300b28c0d4faa6e7a629f6f871', false, 'multi up to 100', 16, 40, 'multi up to 100,Add up to 1000,Add up to 10,Add up to 100,Sub up to 100,Sub up to 1000', 11.2643678160919531, 98, 573.5999755859375, 201);
INSERT INTO public.problem (problem_id, md5h, reflexive, title, domain_id, status_id, knowledge_state, probability, credibility, x, y) VALUES (672, '928721c48d2936ba88b8c1c934d192e3', false, 'Sub up to 1000', 16, 40, 'Sub up to 1000,Add up to 10', 12.4137931034482758, 108, 793, 381);
INSERT INTO public.problem (problem_id, md5h, reflexive, title, domain_id, status_id, knowledge_state, probability, credibility, x, y) VALUES (668, 'e7ae4712c784e9ce38ba6bb4de3358f3', false, 'Add up to 10', 16, 40, 'Add up to 10', 13.7931034482758612, 120, 539, 488);
INSERT INTO public.problem (problem_id, md5h, reflexive, title, domain_id, status_id, knowledge_state, probability, credibility, x, y) VALUES (669, 'e88b625b2aae0bb2f9710f844920b09b', false, 'Add up to 100', 16, 40, 'Add up to 100,Add up to 10', 11.9540229885057467, 104, 381, 381);
INSERT INTO public.problem (problem_id, md5h, reflexive, title, domain_id, status_id, knowledge_state, probability, credibility, x, y) VALUES (671, '958ba8bbba0c3a8cfecd590f45337e89', false, 'Sub up to 100', 16, 40, 'Sub up to 100,Add up to 10', 14.2528735632183903, 124, 639, 378);


--
-- Data for Name: question; Type: TABLE DATA; Schema: public; Owner: euser
--

INSERT INTO public.question (question_id, md5h, text, status_id, test_id, problem_id) VALUES (56, '38dc4fccd8b3ee511e1a609533da1140', '2+2=?', 10, 21, 668);
INSERT INTO public.question (question_id, md5h, text, status_id, test_id, problem_id) VALUES (57, '2430b92edab09a7cfad754effc0c9cf9', '14+24=?', 10, 21, 669);
INSERT INTO public.question (question_id, md5h, text, status_id, test_id, problem_id) VALUES (58, '96077c2ac6b8cf789b235af30a54f808', '326+311=?', 10, 21, 670);
INSERT INTO public.question (question_id, md5h, text, status_id, test_id, problem_id) VALUES (59, '4c7681042d73297a4942d5bc9685bee1', '65-14=?', 10, 21, 671);
INSERT INTO public.question (question_id, md5h, text, status_id, test_id, problem_id) VALUES (60, '135766444f3f56bb6467f13a54abd355', '377-113=?', 10, 21, 672);
INSERT INTO public.question (question_id, md5h, text, status_id, test_id, problem_id) VALUES (61, '5689d28a6181f85cd8304c2e469fe320', '14*4=?', 10, 21, 679);
INSERT INTO public.question (question_id, md5h, text, status_id, test_id, problem_id) VALUES (62, '99f384916b6758d991fe93c42e4f79b8', '21/3=?', 10, 21, 681);
INSERT INTO public.question (question_id, md5h, text, status_id, test_id, problem_id) VALUES (63, '6b892fd12f4cb3cc2a0fb132331ed0c0', '18*24=?', 10, 21, 680);


--
-- Data for Name: status; Type: TABLE DATA; Schema: public; Owner: euser
--

INSERT INTO public.status (status_id, description, name) VALUES (2, 'User is Deleted', 'Deleted');
INSERT INTO public.status (status_id, description, name) VALUES (1, 'User is Active', 'Active');
INSERT INTO public.status (status_id, description, name) VALUES (10, 'Test is Active', 'Active');
INSERT INTO public.status (status_id, description, name) VALUES (11, 'Test is Deleted', 'Deleted');
INSERT INTO public.status (status_id, description, name) VALUES (20, 'Question is Active', 'Active');
INSERT INTO public.status (status_id, description, name) VALUES (21, 'Question is Deleted', 'Deleted');
INSERT INTO public.status (status_id, description, name) VALUES (30, 'Answer is Active', 'Active');
INSERT INTO public.status (status_id, description, name) VALUES (31, 'Answer is Deleted', 'Deleted');
INSERT INTO public.status (status_id, description, name) VALUES (40, 'Problem is Active', 'Active');
INSERT INTO public.status (status_id, description, name) VALUES (41, 'Problem is Deleted', 'Deleted');
INSERT INTO public.status (status_id, description, name) VALUES (50, 'Link is Active', 'Active');
INSERT INTO public.status (status_id, description, name) VALUES (51, 'Link is Deleted', 'Deleted');
INSERT INTO public.status (status_id, description, name) VALUES (60, 'Domain is Active', 'Active');
INSERT INTO public.status (status_id, description, name) VALUES (61, 'Domain is Deleted', 'Deleted');


--
-- Data for Name: test; Type: TABLE DATA; Schema: public; Owner: euser
--

INSERT INTO public.test (test_id, title, status_id, md5h, creation_date, end_date, start_date, euser_id, domain_id) VALUES (21, 'Aritmetičke operacije', 10, 'cf8174e63202397164d2473233ffc1ec', '2021-01-13 14:20:26.865475', '2021-01-15 00:00:00', '2021-01-13 00:00:00', 1, 16);


--
-- Name: answer_history_seq; Type: SEQUENCE SET; Schema: public; Owner: euser
--

SELECT pg_catalog.setval('public.answer_history_seq', 2601, true);


--
-- Name: answer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: euser
--

SELECT pg_catalog.setval('public.answer_id_seq', 107, true);


--
-- Name: domain_id_seq; Type: SEQUENCE SET; Schema: public; Owner: euser
--

SELECT pg_catalog.setval('public.domain_id_seq', 16, true);


--
-- Name: euser_id_seq; Type: SEQUENCE SET; Schema: public; Owner: euser
--

SELECT pg_catalog.setval('public.euser_id_seq', 2, true);


--
-- Name: link_id_seq; Type: SEQUENCE SET; Schema: public; Owner: euser
--

SELECT pg_catalog.setval('public.link_id_seq', 602, true);


--
-- Name: linkid_seq; Type: SEQUENCE SET; Schema: public; Owner: euser
--

SELECT pg_catalog.setval('public.linkid_seq', 1, false);


--
-- Name: node_id_seq; Type: SEQUENCE SET; Schema: public; Owner: euser
--

SELECT pg_catalog.setval('public.node_id_seq', 1, false);


--
-- Name: problem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: euser
--

SELECT pg_catalog.setval('public.problem_id_seq', 681, true);


--
-- Name: question_id_seq; Type: SEQUENCE SET; Schema: public; Owner: euser
--

SELECT pg_catalog.setval('public.question_id_seq', 63, true);


--
-- Name: status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: euser
--

SELECT pg_catalog.setval('public.status_id_seq', 1, false);


--
-- Name: test_id_seq; Type: SEQUENCE SET; Schema: public; Owner: euser
--

SELECT pg_catalog.setval('public.test_id_seq', 21, true);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: euser
--

SELECT pg_catalog.setval('public.user_id_seq', 1, false);


--
-- Name: answer_history answer_history_pkey; Type: CONSTRAINT; Schema: public; Owner: euser
--

ALTER TABLE ONLY public.answer_history
    ADD CONSTRAINT answer_history_pkey PRIMARY KEY (answer_history_id);


--
-- Name: answer answer_pkey; Type: CONSTRAINT; Schema: public; Owner: euser
--

ALTER TABLE ONLY public.answer
    ADD CONSTRAINT answer_pkey PRIMARY KEY (answer_id);


--
-- Name: domain domain_pkey; Type: CONSTRAINT; Schema: public; Owner: euser
--

ALTER TABLE ONLY public.domain
    ADD CONSTRAINT domain_pkey PRIMARY KEY (domain_id);


--
-- Name: euser euser_pkey; Type: CONSTRAINT; Schema: public; Owner: euser
--

ALTER TABLE ONLY public.euser
    ADD CONSTRAINT euser_pkey PRIMARY KEY (euser_id);


--
-- Name: link link_pkey; Type: CONSTRAINT; Schema: public; Owner: euser
--

ALTER TABLE ONLY public.link
    ADD CONSTRAINT link_pkey PRIMARY KEY (link_id);


--
-- Name: problem problem_pkey; Type: CONSTRAINT; Schema: public; Owner: euser
--

ALTER TABLE ONLY public.problem
    ADD CONSTRAINT problem_pkey PRIMARY KEY (problem_id);


--
-- Name: question question_pkey; Type: CONSTRAINT; Schema: public; Owner: euser
--

ALTER TABLE ONLY public.question
    ADD CONSTRAINT question_pkey PRIMARY KEY (question_id);


--
-- Name: status status_pkey; Type: CONSTRAINT; Schema: public; Owner: euser
--

ALTER TABLE ONLY public.status
    ADD CONSTRAINT status_pkey PRIMARY KEY (status_id);


--
-- Name: test test_pkey; Type: CONSTRAINT; Schema: public; Owner: euser
--

ALTER TABLE ONLY public.test
    ADD CONSTRAINT test_pkey PRIMARY KEY (test_id);


--
-- Name: answer_history fk4qk2oou906c3i0gpiibc74tm8; Type: FK CONSTRAINT; Schema: public; Owner: euser
--

ALTER TABLE ONLY public.answer_history
    ADD CONSTRAINT fk4qk2oou906c3i0gpiibc74tm8 FOREIGN KEY (answer_id) REFERENCES public.answer(answer_id);


--
-- Name: test fk5bb7ma72lj1fhp7x0jbb0peim; Type: FK CONSTRAINT; Schema: public; Owner: euser
--

ALTER TABLE ONLY public.test
    ADD CONSTRAINT fk5bb7ma72lj1fhp7x0jbb0peim FOREIGN KEY (status_id) REFERENCES public.status(status_id);


--
-- Name: question fk6e9te6j9nvngv9ndvrtt25kd; Type: FK CONSTRAINT; Schema: public; Owner: euser
--

ALTER TABLE ONLY public.question
    ADD CONSTRAINT fk6e9te6j9nvngv9ndvrtt25kd FOREIGN KEY (status_id) REFERENCES public.status(status_id);


--
-- Name: domain fk7g80gjetlluo81g155pdb22a6; Type: FK CONSTRAINT; Schema: public; Owner: euser
--

ALTER TABLE ONLY public.domain
    ADD CONSTRAINT fk7g80gjetlluo81g155pdb22a6 FOREIGN KEY (euser_id) REFERENCES public.euser(euser_id);


--
-- Name: euser fk8d323mbg2jnj3p5k7jkmgkyh6; Type: FK CONSTRAINT; Schema: public; Owner: euser
--

ALTER TABLE ONLY public.euser
    ADD CONSTRAINT fk8d323mbg2jnj3p5k7jkmgkyh6 FOREIGN KEY (status_id) REFERENCES public.status(status_id);


--
-- Name: answer fk8frr4bcabmmeyyu60qt7iiblo; Type: FK CONSTRAINT; Schema: public; Owner: euser
--

ALTER TABLE ONLY public.answer
    ADD CONSTRAINT fk8frr4bcabmmeyyu60qt7iiblo FOREIGN KEY (question_id) REFERENCES public.question(question_id);


--
-- Name: question fk8hejcpbbiq1qje11346akp3uj; Type: FK CONSTRAINT; Schema: public; Owner: euser
--

ALTER TABLE ONLY public.question
    ADD CONSTRAINT fk8hejcpbbiq1qje11346akp3uj FOREIGN KEY (test_id) REFERENCES public.test(test_id);


--
-- Name: test fkbdn6ftj7ih0gr5hwtibd2fgdb; Type: FK CONSTRAINT; Schema: public; Owner: euser
--

ALTER TABLE ONLY public.test
    ADD CONSTRAINT fkbdn6ftj7ih0gr5hwtibd2fgdb FOREIGN KEY (domain_id) REFERENCES public.domain(domain_id);


--
-- Name: link fkcr3fqviyqayt4to0a9cg741qx; Type: FK CONSTRAINT; Schema: public; Owner: euser
--

ALTER TABLE ONLY public.link
    ADD CONSTRAINT fkcr3fqviyqayt4to0a9cg741qx FOREIGN KEY (source_problem_id) REFERENCES public.problem(problem_id);


--
-- Name: link fkct2nfla7pio89laaic087e7yc; Type: FK CONSTRAINT; Schema: public; Owner: euser
--

ALTER TABLE ONLY public.link
    ADD CONSTRAINT fkct2nfla7pio89laaic087e7yc FOREIGN KEY (target_problem_id) REFERENCES public.problem(problem_id);


--
-- Name: link fkfdbxkcdh6fm9w4c4d72vpwmu3; Type: FK CONSTRAINT; Schema: public; Owner: euser
--

ALTER TABLE ONLY public.link
    ADD CONSTRAINT fkfdbxkcdh6fm9w4c4d72vpwmu3 FOREIGN KEY (status_id) REFERENCES public.status(status_id);


--
-- Name: problem fkhxavp9dgpd51uyg2vyhilj17k; Type: FK CONSTRAINT; Schema: public; Owner: euser
--

ALTER TABLE ONLY public.problem
    ADD CONSTRAINT fkhxavp9dgpd51uyg2vyhilj17k FOREIGN KEY (status_id) REFERENCES public.status(status_id);


--
-- Name: test fki9pb96r5dpb21v397srbxcmxq; Type: FK CONSTRAINT; Schema: public; Owner: euser
--

ALTER TABLE ONLY public.test
    ADD CONSTRAINT fki9pb96r5dpb21v397srbxcmxq FOREIGN KEY (euser_id) REFERENCES public.euser(euser_id);


--
-- Name: answer_history fkjlf4iiff1df7xlgmi4ympkyq3; Type: FK CONSTRAINT; Schema: public; Owner: euser
--

ALTER TABLE ONLY public.answer_history
    ADD CONSTRAINT fkjlf4iiff1df7xlgmi4ympkyq3 FOREIGN KEY (question_id) REFERENCES public.question(question_id);


--
-- Name: answer_history fkk9xw3589x0xo4rvkwa359coa8; Type: FK CONSTRAINT; Schema: public; Owner: euser
--

ALTER TABLE ONLY public.answer_history
    ADD CONSTRAINT fkk9xw3589x0xo4rvkwa359coa8 FOREIGN KEY (euser_id) REFERENCES public.euser(euser_id);


--
-- Name: problem fkkkgodk07k9dr5qjk679o4hqqe; Type: FK CONSTRAINT; Schema: public; Owner: euser
--

ALTER TABLE ONLY public.problem
    ADD CONSTRAINT fkkkgodk07k9dr5qjk679o4hqqe FOREIGN KEY (domain_id) REFERENCES public.domain(domain_id);


--
-- Name: answer fklrc0tjc6q37hjfwqqoi5sp84q; Type: FK CONSTRAINT; Schema: public; Owner: euser
--

ALTER TABLE ONLY public.answer
    ADD CONSTRAINT fklrc0tjc6q37hjfwqqoi5sp84q FOREIGN KEY (status_id) REFERENCES public.status(status_id);


--
-- Name: link fknq6dc1nj5ham4d8k593y5r3v6; Type: FK CONSTRAINT; Schema: public; Owner: euser
--

ALTER TABLE ONLY public.link
    ADD CONSTRAINT fknq6dc1nj5ham4d8k593y5r3v6 FOREIGN KEY (domain_id) REFERENCES public.domain(domain_id);


--
-- Name: answer_history fko5sj01ockkbu3yn4jaes4rcd3; Type: FK CONSTRAINT; Schema: public; Owner: euser
--

ALTER TABLE ONLY public.answer_history
    ADD CONSTRAINT fko5sj01ockkbu3yn4jaes4rcd3 FOREIGN KEY (test_id) REFERENCES public.test(test_id);


--
-- Name: domain fksf1bmy7i5tuv04ju7cjljvl5e; Type: FK CONSTRAINT; Schema: public; Owner: euser
--

ALTER TABLE ONLY public.domain
    ADD CONSTRAINT fksf1bmy7i5tuv04ju7cjljvl5e FOREIGN KEY (status_id) REFERENCES public.status(status_id);


--
-- Name: question fkt12cfelsl8rms435yttdo5p03; Type: FK CONSTRAINT; Schema: public; Owner: euser
--

ALTER TABLE ONLY public.question
    ADD CONSTRAINT fkt12cfelsl8rms435yttdo5p03 FOREIGN KEY (problem_id) REFERENCES public.problem(problem_id);


--
-- Name: DATABASE elearningdb; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON DATABASE elearningdb FROM PUBLIC;
REVOKE ALL ON DATABASE elearningdb FROM postgres;
GRANT ALL ON DATABASE elearningdb TO postgres;
GRANT CONNECT,TEMPORARY ON DATABASE elearningdb TO PUBLIC;
GRANT ALL ON DATABASE elearningdb TO euser;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

