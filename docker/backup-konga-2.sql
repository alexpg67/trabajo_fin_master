--
-- PostgreSQL database dump
--

-- Dumped from database version 11.0 (Debian 11.0-1.pgdg90+2)
-- Dumped by pg_dump version 11.0 (Debian 11.0-1.pgdg90+2)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: konga_api_health_checks; Type: TABLE; Schema: public; Owner: konga
--

CREATE TABLE public.konga_api_health_checks (
    id integer NOT NULL,
    api_id text,
    api json,
    health_check_endpoint text,
    notification_endpoint text,
    active boolean,
    data json,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone,
    "createdUserId" integer,
    "updatedUserId" integer
);


ALTER TABLE public.konga_api_health_checks OWNER TO konga;

--
-- Name: konga_api_health_checks_id_seq; Type: SEQUENCE; Schema: public; Owner: konga
--

CREATE SEQUENCE public.konga_api_health_checks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.konga_api_health_checks_id_seq OWNER TO konga;

--
-- Name: konga_api_health_checks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: konga
--

ALTER SEQUENCE public.konga_api_health_checks_id_seq OWNED BY public.konga_api_health_checks.id;


--
-- Name: konga_email_transports; Type: TABLE; Schema: public; Owner: konga
--

CREATE TABLE public.konga_email_transports (
    id integer NOT NULL,
    name text,
    description text,
    schema json,
    settings json,
    active boolean,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone,
    "createdUserId" integer,
    "updatedUserId" integer
);


ALTER TABLE public.konga_email_transports OWNER TO konga;

--
-- Name: konga_email_transports_id_seq; Type: SEQUENCE; Schema: public; Owner: konga
--

CREATE SEQUENCE public.konga_email_transports_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.konga_email_transports_id_seq OWNER TO konga;

--
-- Name: konga_email_transports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: konga
--

ALTER SEQUENCE public.konga_email_transports_id_seq OWNED BY public.konga_email_transports.id;


--
-- Name: konga_kong_nodes; Type: TABLE; Schema: public; Owner: konga
--

CREATE TABLE public.konga_kong_nodes (
    id integer NOT NULL,
    name text,
    type text,
    kong_admin_url text,
    netdata_url text,
    kong_api_key text,
    jwt_algorithm text,
    jwt_key text,
    jwt_secret text,
    username text,
    password text,
    kong_version text,
    health_checks boolean,
    health_check_details json,
    active boolean,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone,
    "createdUserId" integer,
    "updatedUserId" integer
);


ALTER TABLE public.konga_kong_nodes OWNER TO konga;

--
-- Name: konga_kong_nodes_id_seq; Type: SEQUENCE; Schema: public; Owner: konga
--

CREATE SEQUENCE public.konga_kong_nodes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.konga_kong_nodes_id_seq OWNER TO konga;

--
-- Name: konga_kong_nodes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: konga
--

ALTER SEQUENCE public.konga_kong_nodes_id_seq OWNED BY public.konga_kong_nodes.id;


--
-- Name: konga_kong_services; Type: TABLE; Schema: public; Owner: konga
--

CREATE TABLE public.konga_kong_services (
    id integer NOT NULL,
    service_id text,
    kong_node_id text,
    description text,
    tags json,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone,
    "createdUserId" integer,
    "updatedUserId" integer
);


ALTER TABLE public.konga_kong_services OWNER TO konga;

--
-- Name: konga_kong_services_id_seq; Type: SEQUENCE; Schema: public; Owner: konga
--

CREATE SEQUENCE public.konga_kong_services_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.konga_kong_services_id_seq OWNER TO konga;

--
-- Name: konga_kong_services_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: konga
--

ALTER SEQUENCE public.konga_kong_services_id_seq OWNED BY public.konga_kong_services.id;


--
-- Name: konga_kong_snapshot_schedules; Type: TABLE; Schema: public; Owner: konga
--

CREATE TABLE public.konga_kong_snapshot_schedules (
    id integer NOT NULL,
    connection integer,
    active boolean,
    cron text,
    "lastRunAt" date,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone,
    "createdUserId" integer,
    "updatedUserId" integer
);


ALTER TABLE public.konga_kong_snapshot_schedules OWNER TO konga;

--
-- Name: konga_kong_snapshot_schedules_id_seq; Type: SEQUENCE; Schema: public; Owner: konga
--

CREATE SEQUENCE public.konga_kong_snapshot_schedules_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.konga_kong_snapshot_schedules_id_seq OWNER TO konga;

--
-- Name: konga_kong_snapshot_schedules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: konga
--

ALTER SEQUENCE public.konga_kong_snapshot_schedules_id_seq OWNED BY public.konga_kong_snapshot_schedules.id;


--
-- Name: konga_kong_snapshots; Type: TABLE; Schema: public; Owner: konga
--

CREATE TABLE public.konga_kong_snapshots (
    id integer NOT NULL,
    name text,
    kong_node_name text,
    kong_node_url text,
    kong_version text,
    data json,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone,
    "createdUserId" integer,
    "updatedUserId" integer
);


ALTER TABLE public.konga_kong_snapshots OWNER TO konga;

--
-- Name: konga_kong_snapshots_id_seq; Type: SEQUENCE; Schema: public; Owner: konga
--

CREATE SEQUENCE public.konga_kong_snapshots_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.konga_kong_snapshots_id_seq OWNER TO konga;

--
-- Name: konga_kong_snapshots_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: konga
--

ALTER SEQUENCE public.konga_kong_snapshots_id_seq OWNED BY public.konga_kong_snapshots.id;


--
-- Name: konga_kong_upstream_alerts; Type: TABLE; Schema: public; Owner: konga
--

CREATE TABLE public.konga_kong_upstream_alerts (
    id integer NOT NULL,
    upstream_id text,
    connection integer,
    email boolean,
    slack boolean,
    cron text,
    active boolean,
    data json,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone,
    "createdUserId" integer,
    "updatedUserId" integer
);


ALTER TABLE public.konga_kong_upstream_alerts OWNER TO konga;

--
-- Name: konga_kong_upstream_alerts_id_seq; Type: SEQUENCE; Schema: public; Owner: konga
--

CREATE SEQUENCE public.konga_kong_upstream_alerts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.konga_kong_upstream_alerts_id_seq OWNER TO konga;

--
-- Name: konga_kong_upstream_alerts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: konga
--

ALTER SEQUENCE public.konga_kong_upstream_alerts_id_seq OWNED BY public.konga_kong_upstream_alerts.id;


--
-- Name: konga_netdata_connections; Type: TABLE; Schema: public; Owner: konga
--

CREATE TABLE public.konga_netdata_connections (
    id integer NOT NULL,
    "apiId" text,
    url text,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone,
    "createdUserId" integer,
    "updatedUserId" integer
);


ALTER TABLE public.konga_netdata_connections OWNER TO konga;

--
-- Name: konga_netdata_connections_id_seq; Type: SEQUENCE; Schema: public; Owner: konga
--

CREATE SEQUENCE public.konga_netdata_connections_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.konga_netdata_connections_id_seq OWNER TO konga;

--
-- Name: konga_netdata_connections_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: konga
--

ALTER SEQUENCE public.konga_netdata_connections_id_seq OWNED BY public.konga_netdata_connections.id;


--
-- Name: konga_passports; Type: TABLE; Schema: public; Owner: konga
--

CREATE TABLE public.konga_passports (
    id integer NOT NULL,
    protocol text,
    password text,
    provider text,
    identifier text,
    tokens json,
    "user" integer,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone
);


ALTER TABLE public.konga_passports OWNER TO konga;

--
-- Name: konga_passports_id_seq; Type: SEQUENCE; Schema: public; Owner: konga
--

CREATE SEQUENCE public.konga_passports_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.konga_passports_id_seq OWNER TO konga;

--
-- Name: konga_passports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: konga
--

ALTER SEQUENCE public.konga_passports_id_seq OWNED BY public.konga_passports.id;


--
-- Name: konga_settings; Type: TABLE; Schema: public; Owner: konga
--

CREATE TABLE public.konga_settings (
    id integer NOT NULL,
    data json,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone,
    "createdUserId" integer,
    "updatedUserId" integer
);


ALTER TABLE public.konga_settings OWNER TO konga;

--
-- Name: konga_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: konga
--

CREATE SEQUENCE public.konga_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.konga_settings_id_seq OWNER TO konga;

--
-- Name: konga_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: konga
--

ALTER SEQUENCE public.konga_settings_id_seq OWNED BY public.konga_settings.id;


--
-- Name: konga_users; Type: TABLE; Schema: public; Owner: konga
--

CREATE TABLE public.konga_users (
    id integer NOT NULL,
    username text,
    email text,
    "firstName" text,
    "lastName" text,
    admin boolean,
    node_id text,
    active boolean,
    "activationToken" text,
    node integer,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone,
    "createdUserId" integer,
    "updatedUserId" integer
);


ALTER TABLE public.konga_users OWNER TO konga;

--
-- Name: konga_users_id_seq; Type: SEQUENCE; Schema: public; Owner: konga
--

CREATE SEQUENCE public.konga_users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.konga_users_id_seq OWNER TO konga;

--
-- Name: konga_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: konga
--

ALTER SEQUENCE public.konga_users_id_seq OWNED BY public.konga_users.id;


--
-- Name: konga_api_health_checks id; Type: DEFAULT; Schema: public; Owner: konga
--

ALTER TABLE ONLY public.konga_api_health_checks ALTER COLUMN id SET DEFAULT nextval('public.konga_api_health_checks_id_seq'::regclass);


--
-- Name: konga_email_transports id; Type: DEFAULT; Schema: public; Owner: konga
--

ALTER TABLE ONLY public.konga_email_transports ALTER COLUMN id SET DEFAULT nextval('public.konga_email_transports_id_seq'::regclass);


--
-- Name: konga_kong_nodes id; Type: DEFAULT; Schema: public; Owner: konga
--

ALTER TABLE ONLY public.konga_kong_nodes ALTER COLUMN id SET DEFAULT nextval('public.konga_kong_nodes_id_seq'::regclass);


--
-- Name: konga_kong_services id; Type: DEFAULT; Schema: public; Owner: konga
--

ALTER TABLE ONLY public.konga_kong_services ALTER COLUMN id SET DEFAULT nextval('public.konga_kong_services_id_seq'::regclass);


--
-- Name: konga_kong_snapshot_schedules id; Type: DEFAULT; Schema: public; Owner: konga
--

ALTER TABLE ONLY public.konga_kong_snapshot_schedules ALTER COLUMN id SET DEFAULT nextval('public.konga_kong_snapshot_schedules_id_seq'::regclass);


--
-- Name: konga_kong_snapshots id; Type: DEFAULT; Schema: public; Owner: konga
--

ALTER TABLE ONLY public.konga_kong_snapshots ALTER COLUMN id SET DEFAULT nextval('public.konga_kong_snapshots_id_seq'::regclass);


--
-- Name: konga_kong_upstream_alerts id; Type: DEFAULT; Schema: public; Owner: konga
--

ALTER TABLE ONLY public.konga_kong_upstream_alerts ALTER COLUMN id SET DEFAULT nextval('public.konga_kong_upstream_alerts_id_seq'::regclass);


--
-- Name: konga_netdata_connections id; Type: DEFAULT; Schema: public; Owner: konga
--

ALTER TABLE ONLY public.konga_netdata_connections ALTER COLUMN id SET DEFAULT nextval('public.konga_netdata_connections_id_seq'::regclass);


--
-- Name: konga_passports id; Type: DEFAULT; Schema: public; Owner: konga
--

ALTER TABLE ONLY public.konga_passports ALTER COLUMN id SET DEFAULT nextval('public.konga_passports_id_seq'::regclass);


--
-- Name: konga_settings id; Type: DEFAULT; Schema: public; Owner: konga
--

ALTER TABLE ONLY public.konga_settings ALTER COLUMN id SET DEFAULT nextval('public.konga_settings_id_seq'::regclass);


--
-- Name: konga_users id; Type: DEFAULT; Schema: public; Owner: konga
--

ALTER TABLE ONLY public.konga_users ALTER COLUMN id SET DEFAULT nextval('public.konga_users_id_seq'::regclass);


--
-- Data for Name: konga_api_health_checks; Type: TABLE DATA; Schema: public; Owner: konga
--

COPY public.konga_api_health_checks (id, api_id, api, health_check_endpoint, notification_endpoint, active, data, "createdAt", "updatedAt", "createdUserId", "updatedUserId") FROM stdin;
\.


--
-- Data for Name: konga_email_transports; Type: TABLE DATA; Schema: public; Owner: konga
--

COPY public.konga_email_transports (id, name, description, schema, settings, active, "createdAt", "updatedAt", "createdUserId", "updatedUserId") FROM stdin;
1	smtp	Send emails using the SMTP protocol	[{"name":"host","description":"The SMTP host","type":"text","required":true},{"name":"port","description":"The SMTP port","type":"text","required":true},{"name":"username","model":"auth.user","description":"The SMTP user username","type":"text","required":true},{"name":"password","model":"auth.pass","description":"The SMTP user password","type":"text","required":true},{"name":"secure","model":"secure","description":"Use secure connection","type":"boolean"}]	{"host":"","port":"","auth":{"user":"","pass":""},"secure":false}	t	2024-03-30 23:35:41+00	2024-04-01 14:27:45+00	\N	\N
2	sendmail	Pipe messages to the sendmail command	\N	{"sendmail":true}	f	2024-03-30 23:35:41+00	2024-04-01 14:27:45+00	\N	\N
3	mailgun	Send emails through Mailgun’s Web API	[{"name":"api_key","model":"auth.api_key","description":"The API key that you got from www.mailgun.com/cp","type":"text","required":true},{"name":"domain","model":"auth.domain","description":"One of your domain names listed at your https://mailgun.com/app/domains","type":"text","required":true}]	{"auth":{"api_key":"","domain":""}}	f	2024-03-30 23:35:41+00	2024-04-01 14:27:45+00	\N	\N
\.


--
-- Data for Name: konga_kong_nodes; Type: TABLE DATA; Schema: public; Owner: konga
--

COPY public.konga_kong_nodes (id, name, type, kong_admin_url, netdata_url, kong_api_key, jwt_algorithm, jwt_key, jwt_secret, username, password, kong_version, health_checks, health_check_details, active, "createdAt", "updatedAt", "createdUserId", "updatedUserId") FROM stdin;
1	kong-local	default	http://kong:8001	\N		HS256	\N	\N			3.6.1	f	\N	f	2024-03-30 23:36:49+00	2024-03-30 23:37:10+00	1	1
\.


--
-- Data for Name: konga_kong_services; Type: TABLE DATA; Schema: public; Owner: konga
--

COPY public.konga_kong_services (id, service_id, kong_node_id, description, tags, "createdAt", "updatedAt", "createdUserId", "updatedUserId") FROM stdin;
\.


--
-- Data for Name: konga_kong_snapshot_schedules; Type: TABLE DATA; Schema: public; Owner: konga
--

COPY public.konga_kong_snapshot_schedules (id, connection, active, cron, "lastRunAt", "createdAt", "updatedAt", "createdUserId", "updatedUserId") FROM stdin;
\.


--
-- Data for Name: konga_kong_snapshots; Type: TABLE DATA; Schema: public; Owner: konga
--

COPY public.konga_kong_snapshots (id, name, kong_node_name, kong_node_url, kong_version, data, "createdAt", "updatedAt", "createdUserId", "updatedUserId") FROM stdin;
\.


--
-- Data for Name: konga_kong_upstream_alerts; Type: TABLE DATA; Schema: public; Owner: konga
--

COPY public.konga_kong_upstream_alerts (id, upstream_id, connection, email, slack, cron, active, data, "createdAt", "updatedAt", "createdUserId", "updatedUserId") FROM stdin;
\.


--
-- Data for Name: konga_netdata_connections; Type: TABLE DATA; Schema: public; Owner: konga
--

COPY public.konga_netdata_connections (id, "apiId", url, "createdAt", "updatedAt", "createdUserId", "updatedUserId") FROM stdin;
\.


--
-- Data for Name: konga_passports; Type: TABLE DATA; Schema: public; Owner: konga
--

COPY public.konga_passports (id, protocol, password, provider, identifier, tokens, "user", "createdAt", "updatedAt") FROM stdin;
1	local	$2a$10$E/X.ElseklPnoPB/H.rv7uyXIWDfNueKr4GNT/vpFHpT2uTeIVmyu	\N	\N	\N	1	2024-03-30 23:36:16+00	2024-03-30 23:36:16+00
\.


--
-- Data for Name: konga_settings; Type: TABLE DATA; Schema: public; Owner: konga
--

COPY public.konga_settings (id, data, "createdAt", "updatedAt", "createdUserId", "updatedUserId") FROM stdin;
1	{"signup_enable":false,"signup_require_activation":false,"info_polling_interval":5000,"email_default_sender_name":"KONGA","email_default_sender":"konga@konga.test","email_notifications":false,"default_transport":"sendmail","notify_when":{"node_down":{"title":"A node is down or unresponsive","description":"Health checks must be enabled for the nodes that need to be monitored.","active":false},"api_down":{"title":"An API is down or unresponsive","description":"Health checks must be enabled for the APIs that need to be monitored.","active":false}},"integrations":[{"id":"slack","name":"Slack","image":"slack_rgb.png","config":{"enabled":false,"fields":[{"id":"slack_webhook_url","name":"Slack Webhook URL","type":"text","required":true,"value":""}],"slack_webhook_url":""}}],"user_permissions":{"apis":{"create":false,"read":true,"update":false,"delete":false},"services":{"create":false,"read":true,"update":false,"delete":false},"routes":{"create":false,"read":true,"update":false,"delete":false},"consumers":{"create":false,"read":true,"update":false,"delete":false},"plugins":{"create":false,"read":true,"update":false,"delete":false},"upstreams":{"create":false,"read":true,"update":false,"delete":false},"certificates":{"create":false,"read":true,"update":false,"delete":false},"connections":{"create":false,"read":true,"update":false,"delete":false},"users":{"create":false,"read":true,"update":false,"delete":false}}}	2024-03-30 23:35:41+00	2024-04-01 14:27:45+00	\N	\N
\.


--
-- Data for Name: konga_users; Type: TABLE DATA; Schema: public; Owner: konga
--

COPY public.konga_users (id, username, email, "firstName", "lastName", admin, node_id, active, "activationToken", node, "createdAt", "updatedAt", "createdUserId", "updatedUserId") FROM stdin;
1	Alex	alejandropalmier@gmail.com	\N	\N	t		t	908ec743-08b4-41fe-8b44-5148177fe187	1	2024-03-30 23:36:16+00	2024-03-30 23:37:10+00	\N	1
\.


--
-- Name: konga_api_health_checks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: konga
--

SELECT pg_catalog.setval('public.konga_api_health_checks_id_seq', 1, false);


--
-- Name: konga_email_transports_id_seq; Type: SEQUENCE SET; Schema: public; Owner: konga
--

SELECT pg_catalog.setval('public.konga_email_transports_id_seq', 3, true);


--
-- Name: konga_kong_nodes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: konga
--

SELECT pg_catalog.setval('public.konga_kong_nodes_id_seq', 1, true);


--
-- Name: konga_kong_services_id_seq; Type: SEQUENCE SET; Schema: public; Owner: konga
--

SELECT pg_catalog.setval('public.konga_kong_services_id_seq', 1, false);


--
-- Name: konga_kong_snapshot_schedules_id_seq; Type: SEQUENCE SET; Schema: public; Owner: konga
--

SELECT pg_catalog.setval('public.konga_kong_snapshot_schedules_id_seq', 1, false);


--
-- Name: konga_kong_snapshots_id_seq; Type: SEQUENCE SET; Schema: public; Owner: konga
--

SELECT pg_catalog.setval('public.konga_kong_snapshots_id_seq', 1, false);


--
-- Name: konga_kong_upstream_alerts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: konga
--

SELECT pg_catalog.setval('public.konga_kong_upstream_alerts_id_seq', 1, false);


--
-- Name: konga_netdata_connections_id_seq; Type: SEQUENCE SET; Schema: public; Owner: konga
--

SELECT pg_catalog.setval('public.konga_netdata_connections_id_seq', 1, false);


--
-- Name: konga_passports_id_seq; Type: SEQUENCE SET; Schema: public; Owner: konga
--

SELECT pg_catalog.setval('public.konga_passports_id_seq', 1, true);


--
-- Name: konga_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: konga
--

SELECT pg_catalog.setval('public.konga_settings_id_seq', 1, true);


--
-- Name: konga_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: konga
--

SELECT pg_catalog.setval('public.konga_users_id_seq', 1, true);


--
-- Name: konga_api_health_checks konga_api_health_checks_api_id_key; Type: CONSTRAINT; Schema: public; Owner: konga
--

ALTER TABLE ONLY public.konga_api_health_checks
    ADD CONSTRAINT konga_api_health_checks_api_id_key UNIQUE (api_id);


--
-- Name: konga_api_health_checks konga_api_health_checks_pkey; Type: CONSTRAINT; Schema: public; Owner: konga
--

ALTER TABLE ONLY public.konga_api_health_checks
    ADD CONSTRAINT konga_api_health_checks_pkey PRIMARY KEY (id);


--
-- Name: konga_email_transports konga_email_transports_name_key; Type: CONSTRAINT; Schema: public; Owner: konga
--

ALTER TABLE ONLY public.konga_email_transports
    ADD CONSTRAINT konga_email_transports_name_key UNIQUE (name);


--
-- Name: konga_email_transports konga_email_transports_pkey; Type: CONSTRAINT; Schema: public; Owner: konga
--

ALTER TABLE ONLY public.konga_email_transports
    ADD CONSTRAINT konga_email_transports_pkey PRIMARY KEY (id);


--
-- Name: konga_kong_nodes konga_kong_nodes_pkey; Type: CONSTRAINT; Schema: public; Owner: konga
--

ALTER TABLE ONLY public.konga_kong_nodes
    ADD CONSTRAINT konga_kong_nodes_pkey PRIMARY KEY (id);


--
-- Name: konga_kong_services konga_kong_services_pkey; Type: CONSTRAINT; Schema: public; Owner: konga
--

ALTER TABLE ONLY public.konga_kong_services
    ADD CONSTRAINT konga_kong_services_pkey PRIMARY KEY (id);


--
-- Name: konga_kong_services konga_kong_services_service_id_key; Type: CONSTRAINT; Schema: public; Owner: konga
--

ALTER TABLE ONLY public.konga_kong_services
    ADD CONSTRAINT konga_kong_services_service_id_key UNIQUE (service_id);


--
-- Name: konga_kong_snapshot_schedules konga_kong_snapshot_schedules_pkey; Type: CONSTRAINT; Schema: public; Owner: konga
--

ALTER TABLE ONLY public.konga_kong_snapshot_schedules
    ADD CONSTRAINT konga_kong_snapshot_schedules_pkey PRIMARY KEY (id);


--
-- Name: konga_kong_snapshots konga_kong_snapshots_name_key; Type: CONSTRAINT; Schema: public; Owner: konga
--

ALTER TABLE ONLY public.konga_kong_snapshots
    ADD CONSTRAINT konga_kong_snapshots_name_key UNIQUE (name);


--
-- Name: konga_kong_snapshots konga_kong_snapshots_pkey; Type: CONSTRAINT; Schema: public; Owner: konga
--

ALTER TABLE ONLY public.konga_kong_snapshots
    ADD CONSTRAINT konga_kong_snapshots_pkey PRIMARY KEY (id);


--
-- Name: konga_kong_upstream_alerts konga_kong_upstream_alerts_pkey; Type: CONSTRAINT; Schema: public; Owner: konga
--

ALTER TABLE ONLY public.konga_kong_upstream_alerts
    ADD CONSTRAINT konga_kong_upstream_alerts_pkey PRIMARY KEY (id);


--
-- Name: konga_kong_upstream_alerts konga_kong_upstream_alerts_upstream_id_key; Type: CONSTRAINT; Schema: public; Owner: konga
--

ALTER TABLE ONLY public.konga_kong_upstream_alerts
    ADD CONSTRAINT konga_kong_upstream_alerts_upstream_id_key UNIQUE (upstream_id);


--
-- Name: konga_netdata_connections konga_netdata_connections_pkey; Type: CONSTRAINT; Schema: public; Owner: konga
--

ALTER TABLE ONLY public.konga_netdata_connections
    ADD CONSTRAINT konga_netdata_connections_pkey PRIMARY KEY (id);


--
-- Name: konga_passports konga_passports_pkey; Type: CONSTRAINT; Schema: public; Owner: konga
--

ALTER TABLE ONLY public.konga_passports
    ADD CONSTRAINT konga_passports_pkey PRIMARY KEY (id);


--
-- Name: konga_settings konga_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: konga
--

ALTER TABLE ONLY public.konga_settings
    ADD CONSTRAINT konga_settings_pkey PRIMARY KEY (id);


--
-- Name: konga_users konga_users_email_key; Type: CONSTRAINT; Schema: public; Owner: konga
--

ALTER TABLE ONLY public.konga_users
    ADD CONSTRAINT konga_users_email_key UNIQUE (email);


--
-- Name: konga_users konga_users_pkey; Type: CONSTRAINT; Schema: public; Owner: konga
--

ALTER TABLE ONLY public.konga_users
    ADD CONSTRAINT konga_users_pkey PRIMARY KEY (id);


--
-- Name: konga_users konga_users_username_key; Type: CONSTRAINT; Schema: public; Owner: konga
--

ALTER TABLE ONLY public.konga_users
    ADD CONSTRAINT konga_users_username_key UNIQUE (username);


--
-- PostgreSQL database dump complete
--

