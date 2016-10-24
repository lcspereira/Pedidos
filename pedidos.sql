--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.4
-- Dumped by pg_dump version 9.5.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: comarca_setor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE comarca_setor (
    id integer NOT NULL,
    nome character varying(100) NOT NULL
);


ALTER TABLE comarca_setor OWNER TO postgres;

--
-- Name: comarca_setor_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE comarca_setor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE comarca_setor_id_seq OWNER TO postgres;

--
-- Name: comarca_setor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE comarca_setor_id_seq OWNED BY comarca_setor.id;


--
-- Name: fila; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE fila (
    id integer NOT NULL,
    nome character varying NOT NULL
);


ALTER TABLE fila OWNER TO postgres;

--
-- Name: filas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE filas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE filas_id_seq OWNER TO postgres;

--
-- Name: filas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE filas_id_seq OWNED BY fila.id;


--
-- Name: item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE item (
    codigo character varying(16) NOT NULL,
    resumo character varying(500) NOT NULL,
    descricao character varying(1000),
    quant double precision NOT NULL
);


ALTER TABLE item OWNER TO postgres;

--
-- Name: patrimonio_item_pedido; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE patrimonio_item_pedido (
    pedido integer NOT NULL,
    item character varying(16) NOT NULL,
    patrimonio character varying(9) NOT NULL
);


ALTER TABLE patrimonio_item_pedido OWNER TO postgres;

--
-- Name: pedido; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE pedido (
    id integer NOT NULL,
    solicitante character varying(200) NOT NULL,
    comarca_setor integer NOT NULL,
    obs text NOT NULL,
    fila integer NOT NULL,
    status integer NOT NULL,
    data_pedido timestamp without time zone DEFAULT now()
);


ALTER TABLE pedido OWNER TO postgres;

--
-- Name: pedido_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE pedido_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pedido_id_seq OWNER TO postgres;

--
-- Name: pedido_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE pedido_id_seq OWNED BY pedido.id;


--
-- Name: pedido_item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE pedido_item (
    pedido integer NOT NULL,
    item character varying(16) NOT NULL,
    quant double precision NOT NULL
);


ALTER TABLE pedido_item OWNER TO postgres;

--
-- Name: status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE status (
    id integer NOT NULL,
    descr character varying NOT NULL
);


ALTER TABLE status OWNER TO postgres;

--
-- Name: status_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE status_id_seq OWNER TO postgres;

--
-- Name: status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE status_id_seq OWNED BY status.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY comarca_setor ALTER COLUMN id SET DEFAULT nextval('comarca_setor_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY fila ALTER COLUMN id SET DEFAULT nextval('filas_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pedido ALTER COLUMN id SET DEFAULT nextval('pedido_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY status ALTER COLUMN id SET DEFAULT nextval('status_id_seq'::regclass);


--
-- Data for Name: comarca_setor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY comarca_setor (id, nome) FROM stdin;
\.


--
-- Name: comarca_setor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('comarca_setor_id_seq', 1, false);


--
-- Data for Name: fila; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY fila (id, nome) FROM stdin;
\.


--
-- Name: filas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('filas_id_seq', 1, false);


--
-- Data for Name: item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY item (codigo, resumo, descricao, quant) FROM stdin;
\.


--
-- Data for Name: patrimonio_item_pedido; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY patrimonio_item_pedido (pedido, item, patrimonio) FROM stdin;
\.


--
-- Data for Name: pedido; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY pedido (id, solicitante, comarca_setor, obs, fila, status, data_pedido) FROM stdin;
\.


--
-- Name: pedido_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('pedido_id_seq', 1, false);


--
-- Data for Name: pedido_item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY pedido_item (pedido, item, quant) FROM stdin;
\.


--
-- Data for Name: status; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY status (id, descr) FROM stdin;
\.


--
-- Name: status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('status_id_seq', 1, false);


--
-- Name: comarca_setor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY comarca_setor
    ADD CONSTRAINT comarca_setor_pkey PRIMARY KEY (id);


--
-- Name: filas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY fila
    ADD CONSTRAINT filas_pkey PRIMARY KEY (id);


--
-- Name: item_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY item
    ADD CONSTRAINT item_pkey PRIMARY KEY (codigo);


--
-- Name: patrimonio_item_pedido_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY patrimonio_item_pedido
    ADD CONSTRAINT patrimonio_item_pedido_pkey PRIMARY KEY (pedido, item);


--
-- Name: pedido_item_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pedido_item
    ADD CONSTRAINT pedido_item_pkey PRIMARY KEY (pedido, item);


--
-- Name: pedido_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pedido
    ADD CONSTRAINT pedido_pkey PRIMARY KEY (id);


--
-- Name: status_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY status
    ADD CONSTRAINT status_pkey PRIMARY KEY (id);


--
-- Name: patrimonio_item_pedido_item_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY patrimonio_item_pedido
    ADD CONSTRAINT patrimonio_item_pedido_item_fkey FOREIGN KEY (item) REFERENCES item(codigo);


--
-- Name: patrimonio_item_pedido_pedido_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY patrimonio_item_pedido
    ADD CONSTRAINT patrimonio_item_pedido_pedido_fkey FOREIGN KEY (pedido) REFERENCES pedido(id);


--
-- Name: pedido_comarca_setor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pedido
    ADD CONSTRAINT pedido_comarca_setor_fkey FOREIGN KEY (comarca_setor) REFERENCES comarca_setor(id);


--
-- Name: pedido_fila_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pedido
    ADD CONSTRAINT pedido_fila_fkey FOREIGN KEY (fila) REFERENCES fila(id);


--
-- Name: pedido_item_item_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pedido_item
    ADD CONSTRAINT pedido_item_item_fkey FOREIGN KEY (item) REFERENCES item(codigo);


--
-- Name: pedido_item_pedido_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pedido_item
    ADD CONSTRAINT pedido_item_pedido_fkey FOREIGN KEY (pedido) REFERENCES pedido(id);


--
-- Name: pedido_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pedido
    ADD CONSTRAINT pedido_status_fkey FOREIGN KEY (status) REFERENCES status(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

