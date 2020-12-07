--
-- PostgreSQL database dump
--

-- Dumped from database version 9.3.24
-- Dumped by pg_dump version 13.1 (Ubuntu 13.1-1.pgdg18.04+1)

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

CREATE DATABASE elearningdb WITH TEMPLATE = template0 ENCODING = 'SQL_ASCII' LOCALE = 'C';


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
-- Name: question; Type: TABLE; Schema: public; Owner: euser
--

CREATE TABLE public.question (
    question_id bigint NOT NULL,
    md5h character varying(255),
    "position" integer,
    text character varying(255),
    status_id bigint NOT NULL,
    test_id bigint NOT NULL
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

INSERT INTO public.answer VALUES (1, 'dadbbc2d1715f87059f3dd6a6843655f', 'Polymorphism is the property of something having many forms.', 12, 30, NULL);
INSERT INTO public.answer VALUES (2, '0e71d82219018ece79d090eea7e74004', 'Yes', 13, 30, NULL);
INSERT INTO public.answer VALUES (3, 'ad635f5066226cfcc4a8f2952405e30a', 'No', 13, 30, NULL);
INSERT INTO public.answer VALUES (5, 'ce8be9283bd853bee32eaa05e513c6bc', 'Pokemon', 12, 30, false);


--
-- Data for Name: answer_history; Type: TABLE DATA; Schema: public; Owner: euser
--

INSERT INTO public.answer_history VALUES (1, '2020-12-02 01:54:11.487774', 1, 1, 12, 1);


--
-- Data for Name: euser; Type: TABLE DATA; Schema: public; Owner: euser
--

INSERT INTO public.euser VALUES (1, 'daka@gmail.com', 'Nikola', 'Dakic', '8d4aff29071ddee43ffa150a3c7aace8', '1234', NULL, 1, 'TEACHER');


--
-- Data for Name: question; Type: TABLE DATA; Schema: public; Owner: euser
--

INSERT INTO public.question VALUES (12, '0eef3305e23483be88386624dd811e1a', NULL, 'What is polymorphism?', 20, 1);
INSERT INTO public.question VALUES (13, 'b29de7be69a042654bd4ae703d0b76d8', NULL, 'Can you override a private or static method in Java?', 20, 1);


--
-- Data for Name: status; Type: TABLE DATA; Schema: public; Owner: euser
--

INSERT INTO public.status VALUES (2, 'User is Deleted', 'Deleted');
INSERT INTO public.status VALUES (1, 'User is Active', 'Active');
INSERT INTO public.status VALUES (10, 'Test is Active', 'Active');
INSERT INTO public.status VALUES (11, 'Test is Deleted', 'Deleted');
INSERT INTO public.status VALUES (20, 'Question is Active', 'Active');
INSERT INTO public.status VALUES (21, 'Question is Deleted', 'Deleted');
INSERT INTO public.status VALUES (30, 'Answer is Active', 'Active');
INSERT INTO public.status VALUES (31, 'Answer is Deleted', 'Deleted');


--
-- Data for Name: test; Type: TABLE DATA; Schema: public; Owner: euser
--

INSERT INTO public.test VALUES (1, 'Prvi Test', 10, '71eccd018048d9e53156a94cc672afa7', NULL, NULL, NULL, 1);
INSERT INTO public.test VALUES (4, 'Test broj 2', 10, '5ebf875dcf519e2c6292f70e3aecf922', '2020-12-02 13:01:09.652144', '2020-12-22 01:00:00', '2020-12-02 01:00:00', 1);


--
-- Name: answer_history_seq; Type: SEQUENCE SET; Schema: public; Owner: euser
--

SELECT pg_catalog.setval('public.answer_history_seq', 51, true);


--
-- Name: answer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: euser
--

SELECT pg_catalog.setval('public.answer_id_seq', 6, true);


--
-- Name: euser_id_seq; Type: SEQUENCE SET; Schema: public; Owner: euser
--

SELECT pg_catalog.setval('public.euser_id_seq', 1, false);


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
-- Name: euser euser_pkey; Type: CONSTRAINT; Schema: public; Owner: euser
--

ALTER TABLE ONLY public.euser
    ADD CONSTRAINT euser_pkey PRIMARY KEY (euser_id);


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
-- Name: answer fklrc0tjc6q37hjfwqqoi5sp84q; Type: FK CONSTRAINT; Schema: public; Owner: euser
--

ALTER TABLE ONLY public.answer
    ADD CONSTRAINT fklrc0tjc6q37hjfwqqoi5sp84q FOREIGN KEY (status_id) REFERENCES public.status(status_id);


--
-- Name: answer_history fko5sj01ockkbu3yn4jaes4rcd3; Type: FK CONSTRAINT; Schema: public; Owner: euser
--

ALTER TABLE ONLY public.answer_history
    ADD CONSTRAINT fko5sj01ockkbu3yn4jaes4rcd3 FOREIGN KEY (test_id) REFERENCES public.test(test_id);


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

