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
    status_id bigint NOT NULL
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
    euser_id bigint NOT NULL
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


--
-- Data for Name: answer_history; Type: TABLE DATA; Schema: public; Owner: euser
--

INSERT INTO public.answer_history (answer_history_id, date, answer_id, euser_id, question_id, test_id) VALUES (1, '2020-12-02 01:54:11.487774', 1, 1, 12, 1);


--
-- Data for Name: domain; Type: TABLE DATA; Schema: public; Owner: euser
--

INSERT INTO public.domain (domain_id, md5h, title, status_id, euser_id) VALUES (1, 'f36c55b1740b77205e3277ef1c030c92', 'Test Domain', 60, 1);


--
-- Data for Name: euser; Type: TABLE DATA; Schema: public; Owner: euser
--

INSERT INTO public.euser (euser_id, email, first_name, last_name, md5h, password, registration_date, status_id, user_type) VALUES (1, 'daka@gmail.com', 'Nikola', 'Dakic', '8d4aff29071ddee43ffa150a3c7aace8', '1234', NULL, 1, 'TEACHER');


--
-- Data for Name: link; Type: TABLE DATA; Schema: public; Owner: euser
--

INSERT INTO public.link (link_id, left_direction, right_direction, source_problem_id, status_id, target_problem_id, domain_id, md5h) VALUES (200, false, true, 194, 51, 198, 1, '77c6a7d152e3e870c6d804c19af0189e');
INSERT INTO public.link (link_id, left_direction, right_direction, source_problem_id, status_id, target_problem_id, domain_id, md5h) VALUES (184, true, false, 196, 50, 200, 1, 'faed8a49c644206635036583a8ba950b');
INSERT INTO public.link (link_id, left_direction, right_direction, source_problem_id, status_id, target_problem_id, domain_id, md5h) VALUES (185, true, false, 197, 50, 200, 1, 'e4a7301d248a28555ac8b14f97151966');
INSERT INTO public.link (link_id, left_direction, right_direction, source_problem_id, status_id, target_problem_id, domain_id, md5h) VALUES (199, true, false, 195, 51, 202, 1, '4651202fe8770582592dc614b5d53104');
INSERT INTO public.link (link_id, left_direction, right_direction, source_problem_id, status_id, target_problem_id, domain_id, md5h) VALUES (191, false, true, 194, 51, 202, 1, 'eb714aae5dd33930ab32ab1bf173008f');
INSERT INTO public.link (link_id, left_direction, right_direction, source_problem_id, status_id, target_problem_id, domain_id, md5h) VALUES (203, true, false, 194, 51, 202, 1, '1520465ad618cb9d6fc8c131c6f0a55b');
INSERT INTO public.link (link_id, left_direction, right_direction, source_problem_id, status_id, target_problem_id, domain_id, md5h) VALUES (183, true, false, 193, 51, 194, 1, '90431f5a2a396f4dbd4695ed980bf124');
INSERT INTO public.link (link_id, left_direction, right_direction, source_problem_id, status_id, target_problem_id, domain_id, md5h) VALUES (204, false, true, 194, 50, 202, 1, 'a599f66d73a72ee8185fd66d607065ea');
INSERT INTO public.link (link_id, left_direction, right_direction, source_problem_id, status_id, target_problem_id, domain_id, md5h) VALUES (190, false, true, 194, 50, 201, 1, 'fc99bb1866e90c2df3547983d14bff42');
INSERT INTO public.link (link_id, left_direction, right_direction, source_problem_id, status_id, target_problem_id, domain_id, md5h) VALUES (186, true, false, 193, 51, 196, 1, 'bbf5e5ce0333ec4973ab1d4a63549110');
INSERT INTO public.link (link_id, left_direction, right_direction, source_problem_id, status_id, target_problem_id, domain_id, md5h) VALUES (187, false, true, 193, 51, 199, 1, 'ea4973fd51e16b7b39db7358a589087b');
INSERT INTO public.link (link_id, left_direction, right_direction, source_problem_id, status_id, target_problem_id, domain_id, md5h) VALUES (188, false, true, 193, 51, 198, 1, 'a273de619c0528bf54d5fbe11dab3108');
INSERT INTO public.link (link_id, left_direction, right_direction, source_problem_id, status_id, target_problem_id, domain_id, md5h) VALUES (205, true, false, 199, 50, 202, 1, '521c806b8ea1b81ab22e041aeb610752');
INSERT INTO public.link (link_id, left_direction, right_direction, source_problem_id, status_id, target_problem_id, domain_id, md5h) VALUES (189, false, true, 193, 51, 194, 1, '96b7d7cf7ff7a46be9c5f3884bb7da4e');
INSERT INTO public.link (link_id, left_direction, right_direction, source_problem_id, status_id, target_problem_id, domain_id, md5h) VALUES (193, false, true, 194, 50, 195, 1, '195ddcaaeb73485da68ed09bb44dd7c1');
INSERT INTO public.link (link_id, left_direction, right_direction, source_problem_id, status_id, target_problem_id, domain_id, md5h) VALUES (206, true, false, 197, 50, 201, 1, 'a26ad272c521fcf5a274507db0ccad31');
INSERT INTO public.link (link_id, left_direction, right_direction, source_problem_id, status_id, target_problem_id, domain_id, md5h) VALUES (192, false, true, 194, 51, 203, 1, 'b3512a6950b68406c0959bd409f50562');
INSERT INTO public.link (link_id, left_direction, right_direction, source_problem_id, status_id, target_problem_id, domain_id, md5h) VALUES (207, true, false, 196, 50, 202, 1, 'c1da0e589bb1d3d407dea45e83708650');
INSERT INTO public.link (link_id, left_direction, right_direction, source_problem_id, status_id, target_problem_id, domain_id, md5h) VALUES (194, false, true, 198, 51, 203, 1, 'f930f33d5b58d3b7091bd2e487561778');
INSERT INTO public.link (link_id, left_direction, right_direction, source_problem_id, status_id, target_problem_id, domain_id, md5h) VALUES (208, false, true, 195, 50, 196, 1, '0964210181f0d10c9c4647f18ca952e5');
INSERT INTO public.link (link_id, left_direction, right_direction, source_problem_id, status_id, target_problem_id, domain_id, md5h) VALUES (201, true, false, 199, 50, 201, 1, '79e08a2152906f7235d9d73b488d3df8');
INSERT INTO public.link (link_id, left_direction, right_direction, source_problem_id, status_id, target_problem_id, domain_id, md5h) VALUES (202, false, true, 199, 50, 200, 1, '945c5fd14aaf8f9c7b51f52c3461291d');
INSERT INTO public.link (link_id, left_direction, right_direction, source_problem_id, status_id, target_problem_id, domain_id, md5h) VALUES (195, true, false, 198, 51, 199, 1, 'bf761b909600e43f3a7d5b55eb9ddb01');
INSERT INTO public.link (link_id, left_direction, right_direction, source_problem_id, status_id, target_problem_id, domain_id, md5h) VALUES (196, true, false, 198, 51, 202, 1, '244ca531439cc67bc6c120262593754d');
INSERT INTO public.link (link_id, left_direction, right_direction, source_problem_id, status_id, target_problem_id, domain_id, md5h) VALUES (197, false, true, 195, 51, 198, 1, '536a92df10bbb85f41d336bfe284ec81');
INSERT INTO public.link (link_id, left_direction, right_direction, source_problem_id, status_id, target_problem_id, domain_id, md5h) VALUES (198, false, true, 196, 51, 198, 1, '02d11041ddd0bcb6d579c90f9bf58f4a');


--
-- Data for Name: problem; Type: TABLE DATA; Schema: public; Owner: euser
--

INSERT INTO public.problem (problem_id, md5h, reflexive, title, domain_id, question_id, status_id) VALUES (194, 'ced5ea13ed68e1f32a36035ce638bda1', false, 'TO-DO', 1, NULL, 40);
INSERT INTO public.problem (problem_id, md5h, reflexive, title, domain_id, question_id, status_id) VALUES (195, '2f6aa3f38ef571a00f053b36254a704c', false, 'TO-DO', 1, NULL, 40);
INSERT INTO public.problem (problem_id, md5h, reflexive, title, domain_id, question_id, status_id) VALUES (196, '2d8653b2405fc88bc336dbd393242aa4', false, 'TO-DO', 1, NULL, 40);
INSERT INTO public.problem (problem_id, md5h, reflexive, title, domain_id, question_id, status_id) VALUES (197, '75e862b04e6b259d52712be95c0fc9c2', false, 'TO-DO', 1, NULL, 40);
INSERT INTO public.problem (problem_id, md5h, reflexive, title, domain_id, question_id, status_id) VALUES (199, '28ef6477eb37617082a908a740ce72cf', false, 'TO-DO', 1, NULL, 40);
INSERT INTO public.problem (problem_id, md5h, reflexive, title, domain_id, question_id, status_id) VALUES (200, '62e3ac5cacdf713f571d4ce21e2a03bb', false, 'TO-DO', 1, NULL, 40);
INSERT INTO public.problem (problem_id, md5h, reflexive, title, domain_id, question_id, status_id) VALUES (201, 'ba7389410b19007b90d8aee46a08317a', false, 'TO-DO', 1, NULL, 40);
INSERT INTO public.problem (problem_id, md5h, reflexive, title, domain_id, question_id, status_id) VALUES (202, '8efd61235a3374d0efb39f55530fc63f', false, 'TO-DO', 1, NULL, 40);
INSERT INTO public.problem (problem_id, md5h, reflexive, title, domain_id, question_id, status_id) VALUES (193, 'dd59d0d4eeeef36941bf109cd576218e', false, 'TO-DO', 1, NULL, 41);
INSERT INTO public.problem (problem_id, md5h, reflexive, title, domain_id, question_id, status_id) VALUES (203, 'b13c0394a22a5b9ecf78398eade7ae8a', false, 'TO-DO', 1, NULL, 41);
INSERT INTO public.problem (problem_id, md5h, reflexive, title, domain_id, question_id, status_id) VALUES (198, '233dde9eb68854ccf749554883b4da7c', false, 'TO-DO', 1, NULL, 41);


--
-- Data for Name: question; Type: TABLE DATA; Schema: public; Owner: euser
--

INSERT INTO public.question (question_id, md5h, "position", text, status_id, test_id, problem_id) VALUES (12, '0eef3305e23483be88386624dd811e1a', NULL, 'What is polymorphism?', 20, 1, NULL);
INSERT INTO public.question (question_id, md5h, "position", text, status_id, test_id, problem_id) VALUES (13, 'b29de7be69a042654bd4ae703d0b76d8', NULL, 'Can you override a private or static method in Java?', 20, 1, NULL);


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

INSERT INTO public.test (test_id, title, status_id, md5h, creation_date, end_date, start_date, euser_id) VALUES (1, 'Prvi Test', 10, '71eccd018048d9e53156a94cc672afa7', NULL, NULL, NULL, 1);
INSERT INTO public.test (test_id, title, status_id, md5h, creation_date, end_date, start_date, euser_id) VALUES (4, 'Test broj 2', 10, '5ebf875dcf519e2c6292f70e3aecf922', '2020-12-02 13:01:09.652144', '2020-12-22 01:00:00', '2020-12-02 01:00:00', 1);


--
-- Name: answer_history_seq; Type: SEQUENCE SET; Schema: public; Owner: euser
--

SELECT pg_catalog.setval('public.answer_history_seq', 51, true);


--
-- Name: answer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: euser
--

SELECT pg_catalog.setval('public.answer_id_seq', 6, true);


--
-- Name: domain_id_seq; Type: SEQUENCE SET; Schema: public; Owner: euser
--

SELECT pg_catalog.setval('public.domain_id_seq', 4, true);


--
-- Name: euser_id_seq; Type: SEQUENCE SET; Schema: public; Owner: euser
--

SELECT pg_catalog.setval('public.euser_id_seq', 1, false);


--
-- Name: link_id_seq; Type: SEQUENCE SET; Schema: public; Owner: euser
--

SELECT pg_catalog.setval('public.link_id_seq', 208, true);


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

SELECT pg_catalog.setval('public.problem_id_seq', 203, true);


--
-- Name: question_id_seq; Type: SEQUENCE SET; Schema: public; Owner: euser
--

SELECT pg_catalog.setval('public.question_id_seq', 13, true);


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

