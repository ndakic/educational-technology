--
-- PostgreSQL database dump
--

-- Dumped from database version 12.5 (Ubuntu 12.5-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.5 (Ubuntu 12.5-0ubuntu0.20.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: elearningdb; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE elearningdb WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';


ALTER DATABASE elearningdb OWNER TO postgres;

\connect elearningdb

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: answer; Type: TABLE; Schema: public; Owner: euser
--

CREATE TABLE public.answer (
    answer_id bigint NOT NULL,
    md5h character varying(255),
    text character varying(255),
    question_id bigint NOT NULL,
    status_id bigint NOT NULL
);


ALTER TABLE public.answer OWNER TO euser;

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



--
-- Data for Name: euser; Type: TABLE DATA; Schema: public; Owner: euser
--



--
-- Data for Name: question; Type: TABLE DATA; Schema: public; Owner: euser
--



--
-- Data for Name: status; Type: TABLE DATA; Schema: public; Owner: euser
--

INSERT INTO public.status (status_id, description, name) VALUES (1, 'Test is Active', 'Active');
INSERT INTO public.status (status_id, description, name) VALUES (2, 'Test is Deleted', 'Deleted');


--
-- Data for Name: test; Type: TABLE DATA; Schema: public; Owner: euser
--



--
-- Name: answer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: euser
--

SELECT pg_catalog.setval('public.answer_id_seq', 1, false);


--
-- Name: euser_id_seq; Type: SEQUENCE SET; Schema: public; Owner: euser
--

SELECT pg_catalog.setval('public.euser_id_seq', 1, false);


--
-- Name: question_id_seq; Type: SEQUENCE SET; Schema: public; Owner: euser
--

SELECT pg_catalog.setval('public.question_id_seq', 1, false);


--
-- Name: status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: euser
--

SELECT pg_catalog.setval('public.status_id_seq', 1, false);


--
-- Name: test_id_seq; Type: SEQUENCE SET; Schema: public; Owner: euser
--

SELECT pg_catalog.setval('public.test_id_seq', 1, false);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: euser
--

SELECT pg_catalog.setval('public.user_id_seq', 1, false);


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
-- Name: answer fklrc0tjc6q37hjfwqqoi5sp84q; Type: FK CONSTRAINT; Schema: public; Owner: euser
--

ALTER TABLE ONLY public.answer
    ADD CONSTRAINT fklrc0tjc6q37hjfwqqoi5sp84q FOREIGN KEY (status_id) REFERENCES public.status(status_id);


--
-- Name: DATABASE elearningdb; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON DATABASE elearningdb TO euser;


--
-- PostgreSQL database dump complete
--

