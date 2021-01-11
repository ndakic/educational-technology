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

INSERT INTO public.answer (answer_id, md5h, text, question_id, status_id, correct) VALUES (43, '081c81e11ee97c40f832d76d693e0955', '5', 32, 10, false);
INSERT INTO public.answer (answer_id, md5h, text, question_id, status_id, correct) VALUES (44, 'd98a018ca3b16e339de3e37c7d03ff5c', '6', 32, 10, false);
INSERT INTO public.answer (answer_id, md5h, text, question_id, status_id, correct) VALUES (45, '3d8cbe1adbad02df0af59a5864eef4fe', '26', 33, 10, false);
INSERT INTO public.answer (answer_id, md5h, text, question_id, status_id, correct) VALUES (47, '4841562d53dbb134916238b2a2187c14', '4', 34, 10, false);
INSERT INTO public.answer (answer_id, md5h, text, question_id, status_id, correct) VALUES (48, 'e0a7dc3c6a1bcf4ff92eb175eb716cb1', '3', 34, 10, false);
INSERT INTO public.answer (answer_id, md5h, text, question_id, status_id, correct) VALUES (50, '354c1debcaa07f4543a9b17cd0c45b4c', '8', 35, 10, false);
INSERT INTO public.answer (answer_id, md5h, text, question_id, status_id, correct) VALUES (42, '57f8b6e10062f8e22bbbe00d8bca09b9', '4', 32, 10, true);
INSERT INTO public.answer (answer_id, md5h, text, question_id, status_id, correct) VALUES (49, 'e1855abc9168f58c4dfe68dde3b62be5', '7', 34, 10, true);
INSERT INTO public.answer (answer_id, md5h, text, question_id, status_id, correct) VALUES (46, 'dc9acc5580d242caab6e3d302d8b744f', '24', 33, 10, true);
INSERT INTO public.answer (answer_id, md5h, text, question_id, status_id, correct) VALUES (51, '4d0b6b5f3fc29d9819ba4a3b5d9d19c6', '9', 35, 10, true);


--
-- Data for Name: answer_history; Type: TABLE DATA; Schema: public; Owner: euser
--

INSERT INTO public.answer_history (answer_history_id, date, answer_id, euser_id, question_id, test_id) VALUES (1602, '2021-01-11 17:22:54.341343', 51, 2, 35, 12);
INSERT INTO public.answer_history (answer_history_id, date, answer_id, euser_id, question_id, test_id) VALUES (1603, '2021-01-11 17:22:54.347972', 42, 2, 32, 12);
INSERT INTO public.answer_history (answer_history_id, date, answer_id, euser_id, question_id, test_id) VALUES (1604, '2021-01-11 17:22:54.350513', 46, 2, 33, 12);
INSERT INTO public.answer_history (answer_history_id, date, answer_id, euser_id, question_id, test_id) VALUES (1605, '2021-01-11 17:22:54.354257', 47, 2, 34, 12);
INSERT INTO public.answer_history (answer_history_id, date, answer_id, euser_id, question_id, test_id) VALUES (1606, '2021-01-11 17:23:14.25612', 51, 2, 35, 12);
INSERT INTO public.answer_history (answer_history_id, date, answer_id, euser_id, question_id, test_id) VALUES (1607, '2021-01-11 17:23:14.260912', 42, 2, 32, 12);
INSERT INTO public.answer_history (answer_history_id, date, answer_id, euser_id, question_id, test_id) VALUES (1608, '2021-01-11 17:23:14.264396', 49, 2, 34, 12);
INSERT INTO public.answer_history (answer_history_id, date, answer_id, euser_id, question_id, test_id) VALUES (1609, '2021-01-11 17:23:14.267334', 46, 2, 33, 12);
INSERT INTO public.answer_history (answer_history_id, date, answer_id, euser_id, question_id, test_id) VALUES (1610, '2021-01-11 17:23:31.607544', 51, 2, 35, 12);
INSERT INTO public.answer_history (answer_history_id, date, answer_id, euser_id, question_id, test_id) VALUES (1611, '2021-01-11 17:23:31.612981', 42, 2, 32, 12);
INSERT INTO public.answer_history (answer_history_id, date, answer_id, euser_id, question_id, test_id) VALUES (1612, '2021-01-11 17:23:31.615415', 45, 2, 33, 12);
INSERT INTO public.answer_history (answer_history_id, date, answer_id, euser_id, question_id, test_id) VALUES (1613, '2021-01-11 17:23:31.61773', 48, 2, 34, 12);


--
-- Data for Name: domain; Type: TABLE DATA; Schema: public; Owner: euser
--

INSERT INTO public.domain (domain_id, md5h, title, status_id, euser_id) VALUES (9, 'b33b831a4ab38a0a8415fb6d5d9c6528', 'Algebra', 60, 1);


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

INSERT INTO public.link (link_id, left_direction, right_direction, source_problem_id, status_id, target_problem_id, domain_id, md5h) VALUES (465, false, true, 496, 50, 497, 9, '7fe77c72d8798f4bac6259f8ba2bd225');
INSERT INTO public.link (link_id, left_direction, right_direction, source_problem_id, status_id, target_problem_id, domain_id, md5h) VALUES (466, false, true, 498, 50, 497, 9, '3eeb972f0bef9cbd6f3db7991b903990');
INSERT INTO public.link (link_id, left_direction, right_direction, source_problem_id, status_id, target_problem_id, domain_id, md5h) VALUES (467, false, true, 496, 50, 499, 9, '467f81dfe5da8dd70c0c4c8134f62a15');
INSERT INTO public.link (link_id, left_direction, right_direction, source_problem_id, status_id, target_problem_id, domain_id, md5h) VALUES (468, false, true, 498, 50, 499, 9, '370e82481c52157d6d9a2b6b668ebb6b');


--
-- Data for Name: problem; Type: TABLE DATA; Schema: public; Owner: euser
--

INSERT INTO public.problem (problem_id, md5h, reflexive, title, domain_id, status_id, order_value) VALUES (496, '2a5a85db98393fbb99da20d0305b912c', false, 'sabiranje', 9, 40, 1);
INSERT INTO public.problem (problem_id, md5h, reflexive, title, domain_id, status_id, order_value) VALUES (497, '52dee63fa1d65f9030b3f9f5cc65db76', false, 'mnozenje', 9, 40, 4);
INSERT INTO public.problem (problem_id, md5h, reflexive, title, domain_id, status_id, order_value) VALUES (498, '138eaf90feabdd4c376a2f57cb809aaf', false, 'oduzimanje', 9, 40, 1);
INSERT INTO public.problem (problem_id, md5h, reflexive, title, domain_id, status_id, order_value) VALUES (499, 'a5e6274c8bc15f8b10571b7ebc83a1a0', false, 'deljenje', 9, 40, 4);


--
-- Data for Name: question; Type: TABLE DATA; Schema: public; Owner: euser
--

INSERT INTO public.question (question_id, md5h, "position", text, status_id, test_id, problem_id) VALUES (32, '8f930f90ffccf558c0588d921116c128', NULL, '2+2=?', 10, 12, 496);
INSERT INTO public.question (question_id, md5h, "position", text, status_id, test_id, problem_id) VALUES (33, '424600136b4c51cf6be76bad09459385', NULL, '4*6=?', 10, 12, 497);
INSERT INTO public.question (question_id, md5h, "position", text, status_id, test_id, problem_id) VALUES (34, '76c5ea164cc78d08394dda6e71a44e3c', NULL, '21/3=?', 10, 12, 499);
INSERT INTO public.question (question_id, md5h, "position", text, status_id, test_id, problem_id) VALUES (35, '7a1925cb98484c7ff6383231d9e0a0b1', NULL, '18-9=?', 10, 12, 498);


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

INSERT INTO public.test (test_id, title, status_id, md5h, creation_date, end_date, start_date, euser_id, domain_id) VALUES (12, 'Aritmeticke operacije', 10, '140ec0aeb209a22d8472e88b376b203e', '2021-01-11 17:21:48.466676', '2021-01-16 00:00:00', '2021-01-11 00:00:00', 1, 9);


--
-- Name: answer_history_seq; Type: SEQUENCE SET; Schema: public; Owner: euser
--

SELECT pg_catalog.setval('public.answer_history_seq', 1651, true);


--
-- Name: answer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: euser
--

SELECT pg_catalog.setval('public.answer_id_seq', 57, true);


--
-- Name: domain_id_seq; Type: SEQUENCE SET; Schema: public; Owner: euser
--

SELECT pg_catalog.setval('public.domain_id_seq', 9, true);


--
-- Name: euser_id_seq; Type: SEQUENCE SET; Schema: public; Owner: euser
--

SELECT pg_catalog.setval('public.euser_id_seq', 2, true);


--
-- Name: link_id_seq; Type: SEQUENCE SET; Schema: public; Owner: euser
--

SELECT pg_catalog.setval('public.link_id_seq', 468, true);


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

SELECT pg_catalog.setval('public.problem_id_seq', 499, true);


--
-- Name: question_id_seq; Type: SEQUENCE SET; Schema: public; Owner: euser
--

SELECT pg_catalog.setval('public.question_id_seq', 38, true);


--
-- Name: status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: euser
--

SELECT pg_catalog.setval('public.status_id_seq', 1, false);


--
-- Name: test_id_seq; Type: SEQUENCE SET; Schema: public; Owner: euser
--

SELECT pg_catalog.setval('public.test_id_seq', 15, true);


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

