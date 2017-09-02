--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.8
-- Dumped by pg_dump version 9.5.8

-- Started on 2017-09-02 16:04:40 CEST

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 1 (class 3079 OID 12395)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2242 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 186 (class 1259 OID 16629)
-- Name: field; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE field (
    id bigint NOT NULL,
    variant_column_id bigint NOT NULL,
    relation text NOT NULL,
    options text
);


--
-- TOC entry 185 (class 1259 OID 16627)
-- Name: field_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE field_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2243 (class 0 OID 0)
-- Dependencies: 185
-- Name: field_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE field_id_seq OWNED BY field.id;


--
-- TOC entry 188 (class 1259 OID 16640)
-- Name: filter; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE filter (
    id bigint NOT NULL,
    name text
);


--
-- TOC entry 187 (class 1259 OID 16638)
-- Name: filter_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE filter_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2244 (class 0 OID 0)
-- Dependencies: 187
-- Name: filter_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE filter_id_seq OWNED BY filter.id;


--
-- TOC entry 191 (class 1259 OID 16668)
-- Name: privilege; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE privilege (
    user_id bigint NOT NULL,
    access_type text DEFAULT 'all'::text,
    region_id bigint,
    sample_metadata_id bigint NOT NULL
);


--
-- TOC entry 198 (class 1259 OID 17157)
-- Name: sample_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE sample_metadata (
    sample_id text,
    fake_id bigint NOT NULL
);


--
-- TOC entry 197 (class 1259 OID 17155)
-- Name: sample_metadata_fake_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE sample_metadata_fake_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2245 (class 0 OID 0)
-- Dependencies: 197
-- Name: sample_metadata_fake_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE sample_metadata_fake_id_seq OWNED BY sample_metadata.fake_id;


--
-- TOC entry 184 (class 1259 OID 16618)
-- Name: tab; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE tab (
    id bigint NOT NULL,
    name text NOT NULL
);


--
-- TOC entry 192 (class 1259 OID 16677)
-- Name: tab_field_filter; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE tab_field_filter (
    tab_id bigint NOT NULL,
    field_id bigint NOT NULL,
    filter_id bigint NOT NULL,
    default_value text
);


--
-- TOC entry 183 (class 1259 OID 16616)
-- Name: tab_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tab_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2246 (class 0 OID 0)
-- Dependencies: 183
-- Name: tab_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tab_id_seq OWNED BY tab.id;


--
-- TOC entry 181 (class 1259 OID 16600)
-- Name: transcript; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE transcript (
    "Chrom" bigint,
    "Position" bigint,
    "RSID" text,
    "Reference" text,
    "Alternate" text,
    "Consequence" text,
    "Protein Consequence" text,
    "Transcript Consequence" text,
    "Filter" text,
    "Annotation" text,
    "Flags" text,
    "Allele Count" bigint,
    "Allele Number" bigint,
    "Number of Homozygotes" bigint,
    "Allele Frequency" double precision,
    "Allele Count African" bigint,
    "Allele Number African" bigint,
    "Homozygote Count African" bigint,
    "Allele Count East Asian" bigint,
    "Allele Number East Asian" bigint,
    "Homozygote Count East Asian" bigint,
    "Allele Count European (Non-Finnish)" bigint,
    "Allele Number European (Non-Finnish)" bigint,
    "Homozygote Count European (Non-Finnish)" bigint,
    "Allele Count Finnish" bigint,
    "Allele Number Finnish" bigint,
    "Homozygote Count Finnish" bigint,
    "Allele Count Latino" bigint,
    "Allele Number Latino" bigint,
    "Homozygote Count Latino" bigint,
    "Allele Count Other" bigint,
    "Allele Number Other" bigint,
    "Homozygote Count Other" bigint,
    "Allele Count South Asian" bigint,
    "Allele Number South Asian" bigint,
    "Homozygote Count South Asian" bigint,
    id bigint NOT NULL,
    sample_id text NOT NULL
);


--
-- TOC entry 182 (class 1259 OID 16607)
-- Name: transcript_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE transcript_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2247 (class 0 OID 0)
-- Dependencies: 182
-- Name: transcript_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE transcript_id_seq OWNED BY transcript.id;


--
-- TOC entry 190 (class 1259 OID 16651)
-- Name: user; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "user" (
    id bigint NOT NULL,
    name text NOT NULL,
    role text DEFAULT 'user'::text,
    salt text,
    hash text
);


--
-- TOC entry 189 (class 1259 OID 16649)
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2248 (class 0 OID 0)
-- Dependencies: 189
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE user_id_seq OWNED BY "user".id;


--
-- TOC entry 196 (class 1259 OID 16701)
-- Name: user_smp_tab; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE user_smp_tab (
    user_id bigint NOT NULL,
    tab_field_filter_tab_id bigint NOT NULL,
    tab_field_filter_field_id bigint NOT NULL,
    tab_field_filter_filter_id bigint NOT NULL,
    value text,
    sample_metadata_id bigint
);


--
-- TOC entry 195 (class 1259 OID 16696)
-- Name: user_visible_variant_column; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE user_visible_variant_column (
    user_id bigint NOT NULL,
    variant_column_id bigint NOT NULL
);


--
-- TOC entry 194 (class 1259 OID 16687)
-- Name: variant_column; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE variant_column (
    id bigint NOT NULL,
    column_name text NOT NULL,
    fe_name text,
    type text
);


--
-- TOC entry 193 (class 1259 OID 16685)
-- Name: variant_column_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE variant_column_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2249 (class 0 OID 0)
-- Dependencies: 193
-- Name: variant_column_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE variant_column_id_seq OWNED BY variant_column.id;


--
-- TOC entry 2083 (class 2604 OID 16632)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY field ALTER COLUMN id SET DEFAULT nextval('field_id_seq'::regclass);


--
-- TOC entry 2084 (class 2604 OID 16643)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY filter ALTER COLUMN id SET DEFAULT nextval('filter_id_seq'::regclass);


--
-- TOC entry 2089 (class 2604 OID 17160)
-- Name: fake_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY sample_metadata ALTER COLUMN fake_id SET DEFAULT nextval('sample_metadata_fake_id_seq'::regclass);


--
-- TOC entry 2082 (class 2604 OID 16621)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY tab ALTER COLUMN id SET DEFAULT nextval('tab_id_seq'::regclass);


--
-- TOC entry 2081 (class 2604 OID 16609)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY transcript ALTER COLUMN id SET DEFAULT nextval('transcript_id_seq'::regclass);


--
-- TOC entry 2085 (class 2604 OID 16654)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "user" ALTER COLUMN id SET DEFAULT nextval('user_id_seq'::regclass);


--
-- TOC entry 2088 (class 2604 OID 16690)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY variant_column ALTER COLUMN id SET DEFAULT nextval('variant_column_id_seq'::regclass);


--
-- TOC entry 2105 (class 2606 OID 16695)
-- Name: DATA_COLUMNS_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY variant_column
    ADD CONSTRAINT "DATA_COLUMNS_pk" PRIMARY KEY (id);


--
-- TOC entry 2093 (class 2606 OID 16637)
-- Name: FIELD_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY field
    ADD CONSTRAINT "FIELD_pk" PRIMARY KEY (id);


--
-- TOC entry 2095 (class 2606 OID 16648)
-- Name: FILTER_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY filter
    ADD CONSTRAINT "FILTER_pk" PRIMARY KEY (id);


--
-- TOC entry 2091 (class 2606 OID 16626)
-- Name: TAB_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tab
    ADD CONSTRAINT "TAB_pk" PRIMARY KEY (id);


--
-- TOC entry 2097 (class 2606 OID 16659)
-- Name: USER_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT "USER_pk" PRIMARY KEY (id);


--
-- TOC entry 2101 (class 2606 OID 18053)
-- Name: privilege_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY privilege
    ADD CONSTRAINT privilege_pk PRIMARY KEY (user_id, sample_metadata_id);


--
-- TOC entry 2109 (class 2606 OID 17165)
-- Name: sample_metadata_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sample_metadata
    ADD CONSTRAINT sample_metadata_pk PRIMARY KEY (fake_id);


--
-- TOC entry 2111 (class 2606 OID 17172)
-- Name: sample_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sample_metadata
    ADD CONSTRAINT sample_uq UNIQUE (sample_id);


--
-- TOC entry 2103 (class 2606 OID 16684)
-- Name: tab_field_filter_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tab_field_filter
    ADD CONSTRAINT tab_field_filter_pk PRIMARY KEY (tab_id, field_id, filter_id);


--
-- TOC entry 2099 (class 2606 OID 17832)
-- Name: user_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_name_key UNIQUE (name);


--
-- TOC entry 2107 (class 2606 OID 16700)
-- Name: user_visible_variant_column_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_visible_variant_column
    ADD CONSTRAINT user_visible_variant_column_pk PRIMARY KEY (user_id, variant_column_id);


--
-- TOC entry 2115 (class 2606 OID 16714)
-- Name: field_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tab_field_filter
    ADD CONSTRAINT field_fk FOREIGN KEY (field_id) REFERENCES field(id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2116 (class 2606 OID 16719)
-- Name: filter_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tab_field_filter
    ADD CONSTRAINT filter_fk FOREIGN KEY (filter_id) REFERENCES filter(id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2121 (class 2606 OID 18043)
-- Name: sample_metadata_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_smp_tab
    ADD CONSTRAINT sample_metadata_fk FOREIGN KEY (sample_metadata_id) REFERENCES sample_metadata(fake_id);


--
-- TOC entry 2120 (class 2606 OID 16749)
-- Name: tab_field_filter_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_smp_tab
    ADD CONSTRAINT tab_field_filter_fk FOREIGN KEY (tab_field_filter_tab_id, tab_field_filter_field_id, tab_field_filter_filter_id) REFERENCES tab_field_filter(tab_id, field_id, filter_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2114 (class 2606 OID 16709)
-- Name: tab_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tab_field_filter
    ADD CONSTRAINT tab_fk FOREIGN KEY (tab_id) REFERENCES tab(id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2117 (class 2606 OID 16724)
-- Name: user_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_visible_variant_column
    ADD CONSTRAINT user_fk FOREIGN KEY (user_id) REFERENCES "user"(id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2113 (class 2606 OID 16739)
-- Name: user_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY privilege
    ADD CONSTRAINT user_fk FOREIGN KEY (user_id) REFERENCES "user"(id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2119 (class 2606 OID 16744)
-- Name: user_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_smp_tab
    ADD CONSTRAINT user_fk FOREIGN KEY (user_id) REFERENCES "user"(id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2112 (class 2606 OID 16729)
-- Name: variant_column_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY field
    ADD CONSTRAINT variant_column_fk FOREIGN KEY (variant_column_id) REFERENCES variant_column(id) MATCH FULL ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2118 (class 2606 OID 16734)
-- Name: variant_column_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_visible_variant_column
    ADD CONSTRAINT variant_column_fk FOREIGN KEY (variant_column_id) REFERENCES variant_column(id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


-- Completed on 2017-09-02 16:04:40 CEST

--
-- PostgreSQL database dump complete
--

