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
    question_id bigint,
    status_id bigint NOT NULL,
    order_value integer
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
    "position" integer,
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

INSERT INTO public.answer (answer_id, md5h, text, question_id, status_id, correct) VALUES (1, 'dadbbc2d1715f87059f3dd6a6843655f', 'Polymorphism is the property of something having many forms.', 12, 30, NULL);
INSERT INTO public.answer (answer_id, md5h, text, question_id, status_id, correct) VALUES (2, '0e71d82219018ece79d090eea7e74004', 'Yes', 13, 30, NULL);
INSERT INTO public.answer (answer_id, md5h, text, question_id, status_id, correct) VALUES (3, 'ad635f5066226cfcc4a8f2952405e30a', 'No', 13, 30, NULL);
INSERT INTO public.answer (answer_id, md5h, text, question_id, status_id, correct) VALUES (5, 'ce8be9283bd853bee32eaa05e513c6bc', 'Pokemon', 12, 30, false);
INSERT INTO public.answer (answer_id, md5h, text, question_id, status_id, correct) VALUES (8, 'ce8be9283bd853bee32eaa05e51321312', 'Variable is type of cat.', 16, 30, false);
INSERT INTO public.answer (answer_id, md5h, text, question_id, status_id, correct) VALUES (7, 'ce8be9283bd853bee32eaa05e51324343', 'Variable is a value that can change, depending on conditions or on information passed to the program', 16, 30, true);
INSERT INTO public.answer (answer_id, md5h, text, question_id, status_id, correct) VALUES (10, 'ce8be9283bd853bee32eaa05e5136546', 'Function is part of body.', 17, 30, true);
INSERT INTO public.answer (answer_id, md5h, text, question_id, status_id, correct) VALUES (9, 'ce8be9283bd853bee32eaa05e5132444', 'Named section of a program that performs a specific task.', 17, 30, false);
INSERT INTO public.answer (answer_id, md5h, text, question_id, status_id, correct) VALUES (16, 'ce8be9283bd853bee32eaa05e5138797', 'Use it with if keyword', 20, 30, true);
INSERT INTO public.answer (answer_id, md5h, text, question_id, status_id, correct) VALUES (15, 'ce8be9283bd853bee32eaa05e513287987', 'Use it without if keyword', 20, 30, false);
INSERT INTO public.answer (answer_id, md5h, text, question_id, status_id, correct) VALUES (14, 'ce8be9283bd853bee32eaa05e51324342', 'Dont use that, its totally useless.', 19, 30, false);
INSERT INTO public.answer (answer_id, md5h, text, question_id, status_id, correct) VALUES (13, 'ce8be9283bd853bee32eaa05e5132333', 'Use it with switch keyword', 19, 30, true);
INSERT INTO public.answer (answer_id, md5h, text, question_id, status_id, correct) VALUES (12, 'ce8be9283bd853bee32eaa05e51987987', 'Use it with while keyword', 18, 30, true);
INSERT INTO public.answer (answer_id, md5h, text, question_id, status_id, correct) VALUES (11, 'ce8be9283bd853bee32eaa05e51534534', 'Dont use while at all', 18, 30, false);


--
-- Data for Name: answer_history; Type: TABLE DATA; Schema: public; Owner: euser
--

INSERT INTO public.answer_history (answer_history_id, date, answer_id, euser_id, question_id, test_id) VALUES (1, '2020-12-02 01:54:11.487774', 1, 1, 12, 1);
INSERT INTO public.answer_history (answer_history_id, date, answer_id, euser_id, question_id, test_id) VALUES (651, NULL, 11, 3, 18, 5);
INSERT INTO public.answer_history (answer_history_id, date, answer_id, euser_id, question_id, test_id) VALUES (951, NULL, 13, 4, 19, 5);
INSERT INTO public.answer_history (answer_history_id, date, answer_id, euser_id, question_id, test_id) VALUES (401, NULL, 9, 3, 17, 5);
INSERT INTO public.answer_history (answer_history_id, date, answer_id, euser_id, question_id, test_id) VALUES (101, NULL, 7, 2, 16, 5);
INSERT INTO public.answer_history (answer_history_id, date, answer_id, euser_id, question_id, test_id) VALUES (801, NULL, 11, 6, 18, 5);
INSERT INTO public.answer_history (answer_history_id, date, answer_id, euser_id, question_id, test_id) VALUES (901, NULL, 13, 3, 19, 5);
INSERT INTO public.answer_history (answer_history_id, date, answer_id, euser_id, question_id, test_id) VALUES (501, NULL, 10, 5, 17, 5);
INSERT INTO public.answer_history (answer_history_id, date, answer_id, euser_id, question_id, test_id) VALUES (301, NULL, 7, 6, 16, 5);
INSERT INTO public.answer_history (answer_history_id, date, answer_id, euser_id, question_id, test_id) VALUES (351, NULL, 9, 2, 17, 5);
INSERT INTO public.answer_history (answer_history_id, date, answer_id, euser_id, question_id, test_id) VALUES (701, NULL, 11, 4, 18, 5);
INSERT INTO public.answer_history (answer_history_id, date, answer_id, euser_id, question_id, test_id) VALUES (601, NULL, 11, 2, 18, 5);
INSERT INTO public.answer_history (answer_history_id, date, answer_id, euser_id, question_id, test_id) VALUES (751, NULL, 11, 5, 18, 5);
INSERT INTO public.answer_history (answer_history_id, date, answer_id, euser_id, question_id, test_id) VALUES (1101, NULL, 15, 2, 20, 5);
INSERT INTO public.answer_history (answer_history_id, date, answer_id, euser_id, question_id, test_id) VALUES (1251, NULL, 15, 4, 20, 5);
INSERT INTO public.answer_history (answer_history_id, date, answer_id, euser_id, question_id, test_id) VALUES (1201, NULL, 15, 3, 20, 5);
INSERT INTO public.answer_history (answer_history_id, date, answer_id, euser_id, question_id, test_id) VALUES (851, NULL, 13, 2, 19, 5);
INSERT INTO public.answer_history (answer_history_id, date, answer_id, euser_id, question_id, test_id) VALUES (1051, NULL, 14, 6, 19, 5);
INSERT INTO public.answer_history (answer_history_id, date, answer_id, euser_id, question_id, test_id) VALUES (1301, NULL, 16, 5, 20, 5);
INSERT INTO public.answer_history (answer_history_id, date, answer_id, euser_id, question_id, test_id) VALUES (1351, NULL, 16, 6, 20, 5);
INSERT INTO public.answer_history (answer_history_id, date, answer_id, euser_id, question_id, test_id) VALUES (201, NULL, 7, 4, 16, 5);
INSERT INTO public.answer_history (answer_history_id, date, answer_id, euser_id, question_id, test_id) VALUES (151, NULL, 7, 3, 16, 5);
INSERT INTO public.answer_history (answer_history_id, date, answer_id, euser_id, question_id, test_id) VALUES (251, NULL, 7, 5, 16, 5);
INSERT INTO public.answer_history (answer_history_id, date, answer_id, euser_id, question_id, test_id) VALUES (1001, NULL, 13, 5, 19, 5);
INSERT INTO public.answer_history (answer_history_id, date, answer_id, euser_id, question_id, test_id) VALUES (451, NULL, 9, 4, 17, 5);
INSERT INTO public.answer_history (answer_history_id, date, answer_id, euser_id, question_id, test_id) VALUES (551, NULL, 9, 6, 17, 5);


--
-- Data for Name: domain; Type: TABLE DATA; Schema: public; Owner: euser
--

INSERT INTO public.domain (domain_id, md5h, title, status_id, euser_id) VALUES (1, 'f36c55b1740b77205e3277ef1c030c92', 'Test Domain', 60, 1);
INSERT INTO public.domain (domain_id, md5h, title, status_id, euser_id) VALUES (2, 'f36c55b1740b77205e3277ef1c030222', 'Osnove Programiranja', 60, 1);


--
-- Data for Name: euser; Type: TABLE DATA; Schema: public; Owner: euser
--

INSERT INTO public.euser (euser_id, email, first_name, last_name, md5h, password, registration_date, status_id, user_type) VALUES (1, 'daka@gmail.com', 'Nikola', 'Dakic', '8d4aff29071ddee43ffa150a3c7aace8', '1234', NULL, 1, 'TEACHER');
INSERT INTO public.euser (euser_id, email, first_name, last_name, md5h, password, registration_date, status_id, user_type) VALUES (2, 'marko@gmail.com', 'Marko', 'Markovic', '8d4aff29071ddee43ffa150a3c7aa234', '1234', NULL, 1, 'STUDENT');
INSERT INTO public.euser (euser_id, email, first_name, last_name, md5h, password, registration_date, status_id, user_type) VALUES (6, 'andrija@gmail.com', 'Andrija', 'Peric', '8d4aff29071ddee43ffa150a3c7aa266', '1234', NULL, 1, 'STUDENT');
INSERT INTO public.euser (euser_id, email, first_name, last_name, md5h, password, registration_date, status_id, user_type) VALUES (4, 'aleksandar@gmail.com', 'Aleksandar', 'Djukic', '8d4aff29071ddee43ffa150a3c7343', '1234', NULL, 1, 'STUDENT');
INSERT INTO public.euser (euser_id, email, first_name, last_name, md5h, password, registration_date, status_id, user_type) VALUES (3, 'nemanja@gmail.com', 'Nemanja', 'Letic', '8d4aff29071ddee43ffa150a3c7aa44', '1234', NULL, 1, 'STUDENT');
INSERT INTO public.euser (euser_id, email, first_name, last_name, md5h, password, registration_date, status_id, user_type) VALUES (5, 'milutin@gmail.com', 'Milutin', 'Maric', '8d4aff29071ddee43ffa150a3c7aa99', '1234', NULL, 1, 'STUDENT');


--
-- Data for Name: link; Type: TABLE DATA; Schema: public; Owner: euser
--

INSERT INTO public.link (link_id, left_direction, right_direction, source_problem_id, status_id, target_problem_id, domain_id, md5h) VALUES (453, false, true, 478, 50, 479, 2, 'd6fab524b42e9e5f87d56d7b54a6f6dd');
INSERT INTO public.link (link_id, left_direction, right_direction, source_problem_id, status_id, target_problem_id, domain_id, md5h) VALUES (454, false, true, 478, 50, 481, 2, '897a06f1f6f09bb81626e51b656ad1d6');
INSERT INTO public.link (link_id, left_direction, right_direction, source_problem_id, status_id, target_problem_id, domain_id, md5h) VALUES (455, false, true, 480, 50, 479, 2, '77a9551dfe9ad7fe497eb6aa889fb19a');
INSERT INTO public.link (link_id, left_direction, right_direction, source_problem_id, status_id, target_problem_id, domain_id, md5h) VALUES (456, false, true, 478, 50, 480, 2, '7e34e33aa15622275fc055fd500e1eb9');
INSERT INTO public.link (link_id, left_direction, right_direction, source_problem_id, status_id, target_problem_id, domain_id, md5h) VALUES (457, false, true, 482, 50, 479, 2, '877a4e540b0e3b9e30a58c4ffa7804aa');
INSERT INTO public.link (link_id, left_direction, right_direction, source_problem_id, status_id, target_problem_id, domain_id, md5h) VALUES (458, false, true, 482, 50, 478, 2, '6e35cf530e7df7bc1bbaece85cb27358');


--
-- Data for Name: problem; Type: TABLE DATA; Schema: public; Owner: euser
--

INSERT INTO public.problem (problem_id, md5h, reflexive, title, domain_id, question_id, status_id, order_value) VALUES (486, '429fe744a5837fe66a8cc6e5d14e7f21', false, 'title', 1, NULL, 41, 0);
INSERT INTO public.problem (problem_id, md5h, reflexive, title, domain_id, question_id, status_id, order_value) VALUES (464, '54a4f5a6c862dc2492e964e883ff9fd2', false, 'problem 1', 1, NULL, 40, 1);
INSERT INTO public.problem (problem_id, md5h, reflexive, title, domain_id, question_id, status_id, order_value) VALUES (467, 'a3aa6fc6a9e10e099c96e93db10881fd', false, 'problem 2', 1, NULL, 40, 2);
INSERT INTO public.problem (problem_id, md5h, reflexive, title, domain_id, question_id, status_id, order_value) VALUES (465, '9ad735b7d59765489099e9fcab68bbb5', false, 'problem 3', 1, NULL, 40, 2);
INSERT INTO public.problem (problem_id, md5h, reflexive, title, domain_id, question_id, status_id, order_value) VALUES (466, 'b29955e8013439236dfdb0253d123964', false, 'problem 4', 1, NULL, 40, 2);
INSERT INTO public.problem (problem_id, md5h, reflexive, title, domain_id, question_id, status_id, order_value) VALUES (481, 'd2a4bb05345607201f12961d9f9483', false, 'Switch statement', 2, 19, 40, 2);
INSERT INTO public.problem (problem_id, md5h, reflexive, title, domain_id, question_id, status_id, order_value) VALUES (468, 'a5385e1ce27b3d7d10eaf3b62853ffae', false, 'problem 5', 1, NULL, 40, 9);
INSERT INTO public.problem (problem_id, md5h, reflexive, title, domain_id, question_id, status_id, order_value) VALUES (480, 'd2a4bb053f6907201662961d9f9493', false, 'While', 2, 18, 40, 3);
INSERT INTO public.problem (problem_id, md5h, reflexive, title, domain_id, question_id, status_id, order_value) VALUES (479, 'd2a4bb053f6447201f12961d9f9413', false, 'Functions', 2, 17, 40, 6);
INSERT INTO public.problem (problem_id, md5h, reflexive, title, domain_id, question_id, status_id, order_value) VALUES (482, 'd2a4bb053f6907201867961d9f943', false, 'if condition', 2, 20, 40, 1);
INSERT INTO public.problem (problem_id, md5h, reflexive, title, domain_id, question_id, status_id, order_value) VALUES (469, 'ef66d3cfff95dc7e16bd8bbaeb8e81cb', false, 'problem 6', 1, NULL, 40, 10);
INSERT INTO public.problem (problem_id, md5h, reflexive, title, domain_id, question_id, status_id, order_value) VALUES (470, '19a325c4a313c73e7485f25a35aedc4e', false, 'problem 7', 1, NULL, 40, 10);
INSERT INTO public.problem (problem_id, md5h, reflexive, title, domain_id, question_id, status_id, order_value) VALUES (478, 'd2a4bb053f6907201f12961d9f9423', false, 'Variables', 2, 16, 40, 5);
INSERT INTO public.problem (problem_id, md5h, reflexive, title, domain_id, question_id, status_id, order_value) VALUES (472, '563c161d6f12a5f0c01a97d8f3bd0e28', false, 'title', 1, NULL, 40, 11);
INSERT INTO public.problem (problem_id, md5h, reflexive, title, domain_id, question_id, status_id, order_value) VALUES (471, 'fc0a0726831c58285f67c40429f5366b', false, 'problem 77', 1, NULL, 40, 11);
INSERT INTO public.problem (problem_id, md5h, reflexive, title, domain_id, question_id, status_id, order_value) VALUES (476, 'd2a4bb053f6907201f12961d9f94eca0', false, '2', 1, NULL, 40, 1);
INSERT INTO public.problem (problem_id, md5h, reflexive, title, domain_id, question_id, status_id, order_value) VALUES (474, '5b4f49adb6fe01aadee8c47521366912', false, '1', 1, NULL, 40, 4);
INSERT INTO public.problem (problem_id, md5h, reflexive, title, domain_id, question_id, status_id, order_value) VALUES (475, '68f14685edf1b648ee6455bbab42f430', false, '3', 1, NULL, 40, 3);
INSERT INTO public.problem (problem_id, md5h, reflexive, title, domain_id, question_id, status_id, order_value) VALUES (477, '9eeccd1fdd972442be15f86a2a639cad', false, '4', 1, NULL, 40, 2);
INSERT INTO public.problem (problem_id, md5h, reflexive, title, domain_id, question_id, status_id, order_value) VALUES (473, 'a3b19f89355103d833d76cb793d38758', false, 'title', 1, NULL, 41, 0);
INSERT INTO public.problem (problem_id, md5h, reflexive, title, domain_id, question_id, status_id, order_value) VALUES (484, 'a92ce908626ddede4e32e4a673ffc454', false, 'title', 1, NULL, 41, 0);
INSERT INTO public.problem (problem_id, md5h, reflexive, title, domain_id, question_id, status_id, order_value) VALUES (485, 'ee6caedc811b9a63148dc1684248222f', false, 'title', 1, NULL, 40, 0);
INSERT INTO public.problem (problem_id, md5h, reflexive, title, domain_id, question_id, status_id, order_value) VALUES (487, 'de0ddc6c25f5d1bf528bba338b40361f', false, 'title', 1, NULL, 41, 0);


--
-- Data for Name: question; Type: TABLE DATA; Schema: public; Owner: euser
--

INSERT INTO public.question (question_id, md5h, "position", text, status_id, test_id, problem_id) VALUES (12, '0eef3305e23483be88386624dd811e1a', NULL, 'What is polymorphism?', 20, 1, 464);
INSERT INTO public.question (question_id, md5h, "position", text, status_id, test_id, problem_id) VALUES (13, 'b29de7be69a042654bd4ae703d0b76d8', NULL, 'Can you override a private or static method in Java?', 20, 1, 467);
INSERT INTO public.question (question_id, md5h, "position", text, status_id, test_id, problem_id) VALUES (14, 'b29de7be69a042654bd4ae703d0b763', NULL, 'blblab?', 20, 1, 468);
INSERT INTO public.question (question_id, md5h, "position", text, status_id, test_id, problem_id) VALUES (16, 'b29de7be69a042654bd4ae703d0b333', NULL, 'What is variable?', 20, 5, 478);
INSERT INTO public.question (question_id, md5h, "position", text, status_id, test_id, problem_id) VALUES (17, 'b29de7be69a042654bd4ae703d44444', NULL, 'What is function?', 20, 5, 479);
INSERT INTO public.question (question_id, md5h, "position", text, status_id, test_id, problem_id) VALUES (18, 'b29de7be69a042654bd4ae703d234234', NULL, 'How to use while?', 20, 5, 480);
INSERT INTO public.question (question_id, md5h, "position", text, status_id, test_id, problem_id) VALUES (19, 'b29de7be69a042654bd4ae7038888', NULL, 'How to use switch statement?', 20, 5, 481);
INSERT INTO public.question (question_id, md5h, "position", text, status_id, test_id, problem_id) VALUES (20, 'b29de7be69a042654bd4ae7039999', NULL, 'What is if statement?', 20, 5, 482);


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

INSERT INTO public.test (test_id, title, status_id, md5h, creation_date, end_date, start_date, euser_id, domain_id) VALUES (1, 'Prvi Test', 10, '71eccd018048d9e53156a94cc672afa7', NULL, NULL, NULL, 1, NULL);
INSERT INTO public.test (test_id, title, status_id, md5h, creation_date, end_date, start_date, euser_id, domain_id) VALUES (4, 'Test broj 2', 10, '5ebf875dcf519e2c6292f70e3aecf922', '2020-12-02 13:01:09.652144', '2020-12-22 01:00:00', '2020-12-02 01:00:00', 1, NULL);
INSERT INTO public.test (test_id, title, status_id, md5h, creation_date, end_date, start_date, euser_id, domain_id) VALUES (5, 'Osnove Programiranja Test', 10, '33bf875dcf519e2c6292f70e3aecf933', '2020-12-30 15:08:41', '2021-01-01 15:08:48', '2021-01-30 15:09:06', 1, 2);


--
-- Name: answer_history_seq; Type: SEQUENCE SET; Schema: public; Owner: euser
--

SELECT pg_catalog.setval('public.answer_history_seq', 1451, true);


--
-- Name: answer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: euser
--

SELECT pg_catalog.setval('public.answer_id_seq', 16, true);


--
-- Name: domain_id_seq; Type: SEQUENCE SET; Schema: public; Owner: euser
--

SELECT pg_catalog.setval('public.domain_id_seq', 4, true);


--
-- Name: euser_id_seq; Type: SEQUENCE SET; Schema: public; Owner: euser
--

SELECT pg_catalog.setval('public.euser_id_seq', 2, true);


--
-- Name: link_id_seq; Type: SEQUENCE SET; Schema: public; Owner: euser
--

SELECT pg_catalog.setval('public.link_id_seq', 458, true);


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

SELECT pg_catalog.setval('public.problem_id_seq', 487, true);


--
-- Name: question_id_seq; Type: SEQUENCE SET; Schema: public; Owner: euser
--

SELECT pg_catalog.setval('public.question_id_seq', 20, true);


--
-- Name: status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: euser
--

SELECT pg_catalog.setval('public.status_id_seq', 1, false);


--
-- Name: test_id_seq; Type: SEQUENCE SET; Schema: public; Owner: euser
--

SELECT pg_catalog.setval('public.test_id_seq', 4, true);


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
-- Name: problem fkhtlnfo1o63pdmxrnnr5977ha3; Type: FK CONSTRAINT; Schema: public; Owner: euser
--

ALTER TABLE ONLY public.problem
    ADD CONSTRAINT fkhtlnfo1o63pdmxrnnr5977ha3 FOREIGN KEY (question_id) REFERENCES public.question(question_id);


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

