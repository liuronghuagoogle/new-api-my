--
-- PostgreSQL database dump
--

\restrict JBnjk4s5EykkehRFIUbyeWqeAl62VFznDwEBubiJFGyvP5kKKZj0UnuStGQdlyG

-- Dumped from database version 15.15 (Debian 15.15-1.pgdg13+1)
-- Dumped by pg_dump version 15.15 (Debian 15.15-1.pgdg13+1)

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
-- Name: abilities; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.abilities (
    "group" character varying(64) NOT NULL,
    model character varying(255) NOT NULL,
    channel_id bigint NOT NULL,
    enabled boolean,
    priority bigint DEFAULT 0,
    weight bigint DEFAULT 0,
    tag text
);


ALTER TABLE public.abilities OWNER TO root;

--
-- Name: channels; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.channels (
    id bigint NOT NULL,
    type bigint DEFAULT 0,
    key text NOT NULL,
    open_ai_organization text,
    test_model text,
    status bigint DEFAULT 1,
    name text,
    weight bigint DEFAULT 0,
    created_time bigint,
    test_time bigint,
    response_time bigint,
    base_url text DEFAULT ''::text,
    other text,
    balance numeric,
    balance_updated_time bigint,
    models text,
    "group" character varying(64) DEFAULT 'default'::character varying,
    used_quota bigint DEFAULT 0,
    model_mapping text,
    status_code_mapping character varying(1024) DEFAULT ''::character varying,
    priority bigint DEFAULT 0,
    auto_ban bigint DEFAULT 1,
    other_info text,
    tag text,
    setting text,
    param_override text,
    header_override text,
    remark character varying(255),
    channel_info json,
    settings text
);


ALTER TABLE public.channels OWNER TO root;

--
-- Name: channels_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.channels_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.channels_id_seq OWNER TO root;

--
-- Name: channels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.channels_id_seq OWNED BY public.channels.id;


--
-- Name: checkins; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.checkins (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    checkin_date character varying(10) NOT NULL,
    quota_awarded bigint NOT NULL,
    created_at bigint
);


ALTER TABLE public.checkins OWNER TO root;

--
-- Name: checkins_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.checkins_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.checkins_id_seq OWNER TO root;

--
-- Name: checkins_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.checkins_id_seq OWNED BY public.checkins.id;


--
-- Name: logs; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.logs (
    id bigint NOT NULL,
    user_id bigint,
    created_at bigint,
    type bigint,
    content text,
    username text DEFAULT ''::text,
    token_name text DEFAULT ''::text,
    model_name text DEFAULT ''::text,
    quota bigint DEFAULT 0,
    prompt_tokens bigint DEFAULT 0,
    completion_tokens bigint DEFAULT 0,
    use_time bigint DEFAULT 0,
    is_stream boolean,
    channel_id bigint,
    channel_name text,
    token_id bigint DEFAULT 0,
    "group" text,
    ip text DEFAULT ''::text,
    other text
);


ALTER TABLE public.logs OWNER TO root;

--
-- Name: logs_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.logs_id_seq OWNER TO root;

--
-- Name: logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.logs_id_seq OWNED BY public.logs.id;


--
-- Name: midjourneys; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.midjourneys (
    id bigint NOT NULL,
    code bigint,
    user_id bigint,
    action character varying(40),
    mj_id text,
    prompt text,
    prompt_en text,
    description text,
    state text,
    submit_time bigint,
    start_time bigint,
    finish_time bigint,
    image_url text,
    video_url text,
    video_urls text,
    status character varying(20),
    progress character varying(30),
    fail_reason text,
    channel_id bigint,
    quota bigint,
    buttons text,
    properties text
);


ALTER TABLE public.midjourneys OWNER TO root;

--
-- Name: midjourneys_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.midjourneys_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.midjourneys_id_seq OWNER TO root;

--
-- Name: midjourneys_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.midjourneys_id_seq OWNED BY public.midjourneys.id;


--
-- Name: models; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.models (
    id bigint NOT NULL,
    model_name character varying(128) NOT NULL,
    description text,
    icon character varying(128),
    tags character varying(255),
    vendor_id bigint,
    endpoints text,
    status bigint DEFAULT 1,
    sync_official bigint DEFAULT 1,
    created_time bigint,
    updated_time bigint,
    deleted_at timestamp with time zone,
    name_rule bigint DEFAULT 0
);


ALTER TABLE public.models OWNER TO root;

--
-- Name: models_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.models_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.models_id_seq OWNER TO root;

--
-- Name: models_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.models_id_seq OWNED BY public.models.id;


--
-- Name: options; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.options (
    key text NOT NULL,
    value text
);


ALTER TABLE public.options OWNER TO root;

--
-- Name: passkey_credentials; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.passkey_credentials (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    credential_id character varying(512) NOT NULL,
    public_key text NOT NULL,
    attestation_type character varying(255),
    aa_guid character varying(512),
    sign_count bigint DEFAULT 0,
    clone_warning boolean,
    user_present boolean,
    user_verified boolean,
    backup_eligible boolean,
    backup_state boolean,
    transports text,
    attachment character varying(32),
    last_used_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone
);


ALTER TABLE public.passkey_credentials OWNER TO root;

--
-- Name: passkey_credentials_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.passkey_credentials_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.passkey_credentials_id_seq OWNER TO root;

--
-- Name: passkey_credentials_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.passkey_credentials_id_seq OWNED BY public.passkey_credentials.id;


--
-- Name: prefill_groups; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.prefill_groups (
    id bigint NOT NULL,
    name character varying(64) NOT NULL,
    type character varying(32) NOT NULL,
    items json,
    description character varying(255),
    created_time bigint,
    updated_time bigint,
    deleted_at timestamp with time zone
);


ALTER TABLE public.prefill_groups OWNER TO root;

--
-- Name: prefill_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.prefill_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.prefill_groups_id_seq OWNER TO root;

--
-- Name: prefill_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.prefill_groups_id_seq OWNED BY public.prefill_groups.id;


--
-- Name: quota_data; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.quota_data (
    id bigint NOT NULL,
    user_id bigint,
    username character varying(64) DEFAULT ''::character varying,
    model_name character varying(64) DEFAULT ''::character varying,
    created_at bigint,
    token_used bigint DEFAULT 0,
    count bigint DEFAULT 0,
    quota bigint DEFAULT 0
);


ALTER TABLE public.quota_data OWNER TO root;

--
-- Name: quota_data_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.quota_data_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.quota_data_id_seq OWNER TO root;

--
-- Name: quota_data_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.quota_data_id_seq OWNED BY public.quota_data.id;


--
-- Name: redemptions; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.redemptions (
    id bigint NOT NULL,
    user_id bigint,
    key character(32),
    status bigint DEFAULT 1,
    name text,
    quota bigint DEFAULT 100,
    created_time bigint,
    redeemed_time bigint,
    used_user_id bigint,
    deleted_at timestamp with time zone,
    expired_time bigint
);


ALTER TABLE public.redemptions OWNER TO root;

--
-- Name: redemptions_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.redemptions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.redemptions_id_seq OWNER TO root;

--
-- Name: redemptions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.redemptions_id_seq OWNED BY public.redemptions.id;


--
-- Name: setups; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.setups (
    id bigint NOT NULL,
    version character varying(50) NOT NULL,
    initialized_at bigint NOT NULL
);


ALTER TABLE public.setups OWNER TO root;

--
-- Name: setups_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.setups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.setups_id_seq OWNER TO root;

--
-- Name: setups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.setups_id_seq OWNED BY public.setups.id;


--
-- Name: tasks; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.tasks (
    id bigint NOT NULL,
    created_at bigint,
    updated_at bigint,
    task_id character varying(191),
    platform character varying(30),
    user_id bigint,
    "group" character varying(50),
    channel_id bigint,
    quota bigint,
    action character varying(40),
    status character varying(20),
    fail_reason text,
    submit_time bigint,
    start_time bigint,
    finish_time bigint,
    progress character varying(20),
    properties json,
    private_data json,
    data json
);


ALTER TABLE public.tasks OWNER TO root;

--
-- Name: tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.tasks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tasks_id_seq OWNER TO root;

--
-- Name: tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.tasks_id_seq OWNED BY public.tasks.id;


--
-- Name: tokens; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.tokens (
    id bigint NOT NULL,
    user_id bigint,
    key character(48),
    status bigint DEFAULT 1,
    name text,
    created_time bigint,
    accessed_time bigint,
    expired_time bigint DEFAULT '-1'::integer,
    remain_quota bigint DEFAULT 0,
    unlimited_quota boolean,
    model_limits_enabled boolean,
    model_limits character varying(1024) DEFAULT ''::character varying,
    allow_ips text DEFAULT ''::text,
    used_quota bigint DEFAULT 0,
    "group" text DEFAULT ''::text,
    cross_group_retry boolean,
    deleted_at timestamp with time zone
);


ALTER TABLE public.tokens OWNER TO root;

--
-- Name: tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tokens_id_seq OWNER TO root;

--
-- Name: tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.tokens_id_seq OWNED BY public.tokens.id;


--
-- Name: top_ups; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.top_ups (
    id bigint NOT NULL,
    user_id bigint,
    amount bigint,
    money numeric,
    trade_no character varying(255),
    payment_method character varying(50),
    create_time bigint,
    complete_time bigint,
    status text
);


ALTER TABLE public.top_ups OWNER TO root;

--
-- Name: top_ups_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.top_ups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.top_ups_id_seq OWNER TO root;

--
-- Name: top_ups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.top_ups_id_seq OWNED BY public.top_ups.id;


--
-- Name: two_fa_backup_codes; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.two_fa_backup_codes (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    code_hash character varying(255) NOT NULL,
    is_used boolean,
    used_at timestamp with time zone,
    created_at timestamp with time zone,
    deleted_at timestamp with time zone
);


ALTER TABLE public.two_fa_backup_codes OWNER TO root;

--
-- Name: two_fa_backup_codes_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.two_fa_backup_codes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.two_fa_backup_codes_id_seq OWNER TO root;

--
-- Name: two_fa_backup_codes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.two_fa_backup_codes_id_seq OWNED BY public.two_fa_backup_codes.id;


--
-- Name: two_fas; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.two_fas (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    secret character varying(255) NOT NULL,
    is_enabled boolean,
    failed_attempts bigint DEFAULT 0,
    locked_until timestamp with time zone,
    last_used_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone
);


ALTER TABLE public.two_fas OWNER TO root;

--
-- Name: two_fas_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.two_fas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.two_fas_id_seq OWNER TO root;

--
-- Name: two_fas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.two_fas_id_seq OWNED BY public.two_fas.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    username text,
    password text NOT NULL,
    display_name text,
    role bigint DEFAULT 1,
    status bigint DEFAULT 1,
    email text,
    github_id text,
    discord_id text,
    oidc_id text,
    wechat_id text,
    telegram_id text,
    access_token character(32),
    quota bigint DEFAULT 0,
    used_quota bigint DEFAULT 0,
    request_count bigint DEFAULT 0,
    "group" character varying(64) DEFAULT 'default'::character varying,
    aff_code character varying(32),
    aff_count bigint DEFAULT 0,
    aff_quota bigint DEFAULT 0,
    aff_history bigint DEFAULT 0,
    inviter_id bigint,
    deleted_at timestamp with time zone,
    linux_do_id text,
    setting text,
    remark character varying(255),
    stripe_customer character varying(64)
);


ALTER TABLE public.users OWNER TO root;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO root;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: vendors; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.vendors (
    id bigint NOT NULL,
    name character varying(128) NOT NULL,
    description text,
    icon character varying(128),
    status bigint DEFAULT 1,
    created_time bigint,
    updated_time bigint,
    deleted_at timestamp with time zone
);


ALTER TABLE public.vendors OWNER TO root;

--
-- Name: vendors_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.vendors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vendors_id_seq OWNER TO root;

--
-- Name: vendors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.vendors_id_seq OWNED BY public.vendors.id;


--
-- Name: channels id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.channels ALTER COLUMN id SET DEFAULT nextval('public.channels_id_seq'::regclass);


--
-- Name: checkins id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.checkins ALTER COLUMN id SET DEFAULT nextval('public.checkins_id_seq'::regclass);


--
-- Name: logs id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.logs ALTER COLUMN id SET DEFAULT nextval('public.logs_id_seq'::regclass);


--
-- Name: midjourneys id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.midjourneys ALTER COLUMN id SET DEFAULT nextval('public.midjourneys_id_seq'::regclass);


--
-- Name: models id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.models ALTER COLUMN id SET DEFAULT nextval('public.models_id_seq'::regclass);


--
-- Name: passkey_credentials id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.passkey_credentials ALTER COLUMN id SET DEFAULT nextval('public.passkey_credentials_id_seq'::regclass);


--
-- Name: prefill_groups id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.prefill_groups ALTER COLUMN id SET DEFAULT nextval('public.prefill_groups_id_seq'::regclass);


--
-- Name: quota_data id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.quota_data ALTER COLUMN id SET DEFAULT nextval('public.quota_data_id_seq'::regclass);


--
-- Name: redemptions id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.redemptions ALTER COLUMN id SET DEFAULT nextval('public.redemptions_id_seq'::regclass);


--
-- Name: setups id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.setups ALTER COLUMN id SET DEFAULT nextval('public.setups_id_seq'::regclass);


--
-- Name: tasks id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.tasks ALTER COLUMN id SET DEFAULT nextval('public.tasks_id_seq'::regclass);


--
-- Name: tokens id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.tokens ALTER COLUMN id SET DEFAULT nextval('public.tokens_id_seq'::regclass);


--
-- Name: top_ups id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.top_ups ALTER COLUMN id SET DEFAULT nextval('public.top_ups_id_seq'::regclass);


--
-- Name: two_fa_backup_codes id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.two_fa_backup_codes ALTER COLUMN id SET DEFAULT nextval('public.two_fa_backup_codes_id_seq'::regclass);


--
-- Name: two_fas id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.two_fas ALTER COLUMN id SET DEFAULT nextval('public.two_fas_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: vendors id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.vendors ALTER COLUMN id SET DEFAULT nextval('public.vendors_id_seq'::regclass);


--
-- Data for Name: abilities; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.abilities ("group", model, channel_id, enabled, priority, weight, tag) FROM stdin;
default	zai-glm-4.7	4	t	4	0	
default	llama3.1-8b	4	t	4	0	
default	llama-3.3-70b	4	t	4	0	
default	gpt-oss-120b	4	t	4	0	
default	qwen-3-235b-a22b-instruct-2507	4	t	4	0	
default	qwen-3-32b	4	t	4	0	
default	claude-sonnet-4-5	4	t	4	0	
default	gpt-oss-120b	6	t	8	0	
default	z-ai/glm4.7	1	t	1	0	
default	openai/gpt-oss-120b	1	t	1	0	
default	minimaxai/minimax-m2.1	1	t	1	0	
default	deepseek-ai/deepseek-r1-distill-qwen-32b	1	t	1	0	
default	deepseek-ai/deepseek-coder-6.7b-instruct	1	t	1	0	
default	claude-sonnet-4-5	1	t	1	0	
default	z-ai/glm4.7	3	t	2	0	
default	openai/gpt-oss-120b	3	t	2	0	
default	minimaxai/minimax-m2.1	3	t	2	0	
default	deepseek-ai/deepseek-r1-distill-qwen-32b	3	t	2	0	
default	deepseek-ai/deepseek-coder-6.7b-instruct	3	t	2	0	
default	claude-sonnet-4-5	3	t	2	0	
default	z-ai/glm4.7	2	t	3	0	
default	openai/gpt-oss-120b	2	t	3	0	
default	minimaxai/minimax-m2.1	2	t	3	0	
default	deepseek-ai/deepseek-r1-distill-qwen-32b	2	t	3	0	
default	deepseek-ai/deepseek-coder-6.7b-instruct	2	t	3	0	
default	claude-sonnet-4-5	2	t	3	0	
default	qwen-3-235b-a22b-instruct-2507	6	t	8	0	
default	qwen-3-32b	6	t	8	0	
default	llama-3.3-70b	6	t	8	0	
default	llama3.1-8b	6	t	8	0	
default	zai-glm-4.7	6	t	8	0	
default	claude-sonnet-4-5	6	t	8	0	
default	gpt-oss-120b	7	t	7	0	
default	qwen-3-235b-a22b-instruct-2507	7	t	7	0	
default	qwen-3-32b	7	t	7	0	
default	llama-3.3-70b	7	t	7	0	
default	llama3.1-8b	7	t	7	0	
default	zai-glm-4.7	7	t	7	0	
default	claude-sonnet-4-5	7	t	7	0	
default	zai-glm-4.7	5	t	5	0	
default	llama3.1-8b	5	t	5	0	
default	llama-3.3-70b	5	t	5	0	
default	gpt-oss-120b	5	t	5	0	
default	qwen-3-235b-a22b-instruct-2507	5	t	5	0	
default	qwen-3-32b	5	t	5	0	
default	claude-sonnet-4-5	5	t	5	0	
\.


--
-- Data for Name: channels; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.channels (id, type, key, open_ai_organization, test_model, status, name, weight, created_time, test_time, response_time, base_url, other, balance, balance_updated_time, models, "group", used_quota, model_mapping, status_code_mapping, priority, auto_ban, other_info, tag, setting, param_override, header_override, remark, channel_info, settings) FROM stdin;
1	1	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			1	nvidia英伟达	0	1769352618	1769435327	705	https://nvidia.facai.cloudns.org		0	0	z-ai/glm4.7,openai/gpt-oss-120b,minimaxai/minimax-m2.1,deepseek-ai/deepseek-r1-distill-qwen-32b,deepseek-ai/deepseek-coder-6.7b-instruct,claude-sonnet-4-5	default	958505	{\n  "claude-sonnet-4-5": "minimaxai/minimax-m2.1"\n}		1	1			{"force_format":false,"thinking_to_content":false,"proxy":"","pass_through_body_enabled":false,"system_prompt":"当用户问你是什么模型时，你要告诉用户，你是claude模型","system_prompt_override":true}	\N	\N	\N	{"is_multi_key":false,"multi_key_size":0,"multi_key_status_list":null,"multi_key_polling_index":0,"multi_key_mode":"random"}	{"allow_service_tier":false,"disable_store":false,"allow_safety_identifier":false}
4	1	csk-92vw333yd2kn5xy692t8mxnk4fy3hrf9wnkx4vhhnwj59yxt			1	cloud.cerebras.ai	0	1769509708	1769510650	1407	https://cerebras.facai.cloudns.org		0	0	zai-glm-4.7,llama3.1-8b,llama-3.3-70b,gpt-oss-120b,qwen-3-235b-a22b-instruct-2507,qwen-3-32b,claude-sonnet-4-5	default	0	{\n  "claude-sonnet-4-5": "zai-glm-4.7"\n}		4	1			{"force_format":false,"thinking_to_content":false,"proxy":"","pass_through_body_enabled":false,"system_prompt":"","system_prompt_override":false}	\N	\N	\N	{"is_multi_key":false,"multi_key_size":0,"multi_key_status_list":null,"multi_key_polling_index":0,"multi_key_mode":"random"}	{"allow_service_tier":false,"disable_store":false,"allow_safety_identifier":false}
3	1	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			1	nvidia英伟达	0	1769352618	1769353879	1365	https://nvidia.facai.cloudns.org		0	0	z-ai/glm4.7,openai/gpt-oss-120b,minimaxai/minimax-m2.1,deepseek-ai/deepseek-r1-distill-qwen-32b,deepseek-ai/deepseek-coder-6.7b-instruct,claude-sonnet-4-5	default	922741	{\n  "claude-sonnet-4-5": "minimaxai/minimax-m2.1"\n}		2	1			{"force_format":false,"thinking_to_content":false,"proxy":"","pass_through_body_enabled":false,"system_prompt":"当用户问你是什么模型时，你要告诉用户，你是claude模型","system_prompt_override":true}	\N	\N	\N	{"is_multi_key":false,"multi_key_size":0,"multi_key_status_list":null,"multi_key_polling_index":0,"multi_key_mode":"random"}	{"allow_service_tier":false,"disable_store":false,"allow_safety_identifier":false}
2	1	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			1	nvidia英伟达	0	1769352618	1769353600	768	https://nvidia.facai.cloudns.org		0	0	z-ai/glm4.7,openai/gpt-oss-120b,minimaxai/minimax-m2.1,deepseek-ai/deepseek-r1-distill-qwen-32b,deepseek-ai/deepseek-coder-6.7b-instruct,claude-sonnet-4-5	default	1305286	{\n  "claude-sonnet-4-5": "minimaxai/minimax-m2.1"\n}		3	1			{"force_format":false,"thinking_to_content":false,"proxy":"","pass_through_body_enabled":false,"system_prompt":"当用户问你是什么模型时，你要告诉用户，你是claude模型","system_prompt_override":true}	\N	\N	\N	{"is_multi_key":false,"multi_key_size":0,"multi_key_status_list":null,"multi_key_polling_index":0,"multi_key_mode":"random"}	{"allow_service_tier":false,"disable_store":false,"allow_safety_identifier":false}
7	1	csk-nn9f5v2k8t5d698hc8xx9y9h66pn6y92v28p5t6mhtmmwmee			1	cloud.cerebras.ai	0	1769511215	1769511248	963	https://cerebras.facai.cloudns.org		0	0	gpt-oss-120b,qwen-3-235b-a22b-instruct-2507,qwen-3-32b,llama-3.3-70b,llama3.1-8b,zai-glm-4.7,claude-sonnet-4-5	default	0	{\n  "claude-sonnet-4-5": "zai-glm-4.7"\n}		7	1			{"force_format":false,"thinking_to_content":false,"proxy":"","pass_through_body_enabled":false,"system_prompt":"当用户问你是什么模型时，你要告诉用户，你是claude模型","system_prompt_override":true}	\N	\N	\N	{"is_multi_key":false,"multi_key_size":0,"multi_key_status_list":null,"multi_key_polling_index":0,"multi_key_mode":"random"}	{"allow_service_tier":false,"disable_store":false,"allow_safety_identifier":false}
5	1	csk-reymxyfvhy8v4ytpexkrjwehj2jyk88p5n8j2m3nvk9cxk46			1	cloud.cerebras.ai_复制	0	1769510090	1769510642	309	https://api.cerebras.ai		0	0	zai-glm-4.7,llama3.1-8b,llama-3.3-70b,gpt-oss-120b,qwen-3-235b-a22b-instruct-2507,qwen-3-32b,claude-sonnet-4-5	default	0	{\n  "claude-sonnet-4-5": "zai-glm-4.7"\n}		5	1			{"force_format":false,"thinking_to_content":false,"proxy":"","pass_through_body_enabled":false,"system_prompt":"当用户问你是什么模型时，你要告诉用户，你是claude模型","system_prompt_override":true}	\N	\N	\N	{"is_multi_key":false,"multi_key_size":0,"multi_key_status_list":null,"multi_key_polling_index":0,"multi_key_mode":"random"}	{"allow_service_tier":false,"disable_store":false,"allow_safety_identifier":false}
6	1	csk-vkj3vty6jcn5kh6wkk4r4enhhheh3nf2ycmp8dj6pcxtmpkp			1	cloud.cerebras.ai	0	1769511215	1769511262	342	https://cerebras.facai.cloudns.org		0	0	gpt-oss-120b,qwen-3-235b-a22b-instruct-2507,qwen-3-32b,llama-3.3-70b,llama3.1-8b,zai-glm-4.7,claude-sonnet-4-5	default	4595	{\n  "claude-sonnet-4-5": "zai-glm-4.7"\n}		8	1			{"force_format":false,"thinking_to_content":false,"proxy":"","pass_through_body_enabled":false,"system_prompt":"当用户问你是什么模型时，你要告诉用户，你是claude模型","system_prompt_override":true}	\N	\N	\N	{"is_multi_key":false,"multi_key_size":0,"multi_key_status_list":null,"multi_key_polling_index":0,"multi_key_mode":"random"}	{"allow_service_tier":false,"disable_store":false,"allow_safety_identifier":false}
\.


--
-- Data for Name: checkins; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.checkins (id, user_id, checkin_date, quota_awarded, created_at) FROM stdin;
1	3	2026-01-26	5275	1769402011
2	4	2026-01-26	1000000	1769402328
3	5	2026-01-26	1000000	1769402353
4	7	2026-01-26	1000000	1769402441
5	8	2026-01-26	1000000	1769402456
6	9	2026-01-26	1000000	1769402794
7	11	2026-01-26	1000000	1769403476
8	12	2026-01-26	1000000	1769403967
9	14	2026-01-26	1000000	1769405428
10	15	2026-01-26	1000000	1769405601
11	16	2026-01-26	1000000	1769406051
12	19	2026-01-26	1000000	1769407152
13	20	2026-01-26	1000000	1769407216
14	21	2026-01-26	1000000	1769407293
15	23	2026-01-26	1000000	1769408425
16	24	2026-01-26	1000000	1769414011
17	25	2026-01-26	1000000	1769434296
18	26	2026-01-26	1000000	1769434332
19	27	2026-01-26	1000000	1769436476
20	28	2026-01-26	1000000	1769436529
21	26	2026-01-27	1000000	1769446516
22	25	2026-01-27	1000000	1769446527
23	20	2026-01-27	1000000	1769475416
24	21	2026-01-27	1000000	1769475416
25	30	2026-01-27	1000000	1769478721
26	31	2026-01-27	1000000	1769481697
27	7	2026-01-27	1000000	1769483181
28	32	2026-01-27	1000000	1769484441
29	8	2026-01-27	1000000	1769488462
30	12	2026-01-27	1000000	1769489421
31	1	2026-01-27	1000000	1769502309
32	34	2026-01-27	1000000	1769502873
\.


--
-- Data for Name: logs; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.logs (id, user_id, created_at, type, content, username, token_name, model_name, quota, prompt_tokens, completion_tokens, use_time, is_stream, channel_id, channel_name, token_id, "group", ip, other) FROM stdin;
1	1	1769353204	2	模型测试	liuliang	模型测试	openai/gpt-oss-120b	41	66	16	0	f	3	\N	0	default		{"admin_info":{"use_channel":null},"cache_ratio":1,"cache_tokens":0,"completion_ratio":1,"frt":-1000,"group_ratio":1,"model_price":-1,"model_ratio":0.5,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","user_group_ratio":-1}
2	1	1769353257	2	模型测试	liuliang	模型测试	z-ai/glm4.7	18	6	16	68	f	3	\N	0	default		{"admin_info":{"use_channel":null},"cache_ratio":1,"cache_tokens":0,"completion_ratio":1,"frt":-1000,"group_ratio":1,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","user_group_ratio":-1}
3	1	1769353272	2	模型测试	liuliang	模型测试	openai/gpt-oss-120b	41	66	16	0	f	3	\N	0	default		{"admin_info":{"use_channel":null},"cache_ratio":1,"cache_tokens":0,"completion_ratio":1,"frt":-1000,"group_ratio":1,"model_price":-1,"model_ratio":0.5,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","user_group_ratio":-1}
4	1	1769353425	2	模型测试	liuliang	模型测试	openai/gpt-oss-120b	41	66	16	0	f	3	\N	0	default		{"admin_info":{"use_channel":null},"cache_ratio":1,"cache_tokens":0,"completion_ratio":1,"frt":-1000,"group_ratio":1,"model_price":-1,"model_ratio":0.5,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","user_group_ratio":-1}
5	1	1769353425	2	模型测试	liuliang	模型测试	deepseek-ai/deepseek-r1-distill-qwen-32b	18	6	16	0	f	3	\N	0	default		{"admin_info":{"use_channel":null},"cache_ratio":1,"cache_tokens":0,"completion_ratio":1,"frt":-1000,"group_ratio":1,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","user_group_ratio":-1}
6	1	1769353426	2	模型测试	liuliang	模型测试	minimaxai/minimax-m2.1	44	39	16	1	f	3	\N	0	default		{"admin_info":{"use_channel":null},"cache_ratio":1,"cache_tokens":0,"completion_ratio":1,"frt":-1000,"group_ratio":1,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","user_group_ratio":-1}
7	1	1769353461	2	模型测试	liuliang	模型测试	z-ai/glm4.7	18	6	16	36	f	3	\N	0	default		{"admin_info":{"use_channel":null},"cache_ratio":1,"cache_tokens":0,"completion_ratio":1,"frt":-1000,"group_ratio":1,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","user_group_ratio":-1}
8	1	1769353490	2	模型测试	liuliang	模型测试	z-ai/glm4.7	18	6	16	224	f	3	\N	0	default		{"admin_info":{"use_channel":null},"cache_ratio":1,"cache_tokens":0,"completion_ratio":1,"frt":-1000,"group_ratio":1,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","user_group_ratio":-1}
9	1	1769353539	2	模型测试	liuliang	模型测试	openai/gpt-oss-120b	41	66	16	0	f	3	\N	0	default		{"admin_info":{"use_channel":null},"cache_ratio":1,"cache_tokens":0,"completion_ratio":1,"frt":-1000,"group_ratio":1,"model_price":-1,"model_ratio":0.5,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","user_group_ratio":-1}
10	1	1769353544	2	模型测试	liuliang	模型测试	openai/gpt-oss-120b	41	66	16	0	f	3	\N	0	default		{"admin_info":{"use_channel":null},"cache_ratio":1,"cache_tokens":0,"completion_ratio":1,"frt":-1000,"group_ratio":1,"model_price":-1,"model_ratio":0.5,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","user_group_ratio":-1}
11	1	1769353551	2	模型测试	liuliang	模型测试	deepseek-ai/deepseek-r1-distill-qwen-32b	18	6	16	0	f	3	\N	0	default		{"admin_info":{"use_channel":null},"cache_ratio":1,"cache_tokens":0,"completion_ratio":1,"frt":-1000,"group_ratio":1,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","user_group_ratio":-1}
12	1	1769353600	2	模型测试	liuliang	模型测试	openai/gpt-oss-120b	41	66	16	0	f	2	\N	0	default		{"admin_info":{"use_channel":null},"cache_ratio":1,"cache_tokens":0,"completion_ratio":1,"frt":-1000,"group_ratio":1,"model_price":-1,"model_ratio":0.5,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","user_group_ratio":-1}
13	1	1769353711	2	模型测试	liuliang	模型测试	claude-sonnet-4-5	69	6	16	159	f	3	\N	0	default		{"admin_info":{"use_channel":null},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":-1000,"group_ratio":1,"is_model_mapped":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"z-ai/glm4.7","user_group_ratio":-1}
14	1	1769353879	2	模型测试	liuliang	模型测试	minimaxai/minimax-m2.1	44	39	16	1	f	3	\N	0	default		{"admin_info":{"use_channel":null},"cache_ratio":1,"cache_tokens":0,"completion_ratio":1,"frt":-1000,"group_ratio":1,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","user_group_ratio":-1}
15	3	1769401540	3	管理员将用户额度从 ＄0.000000 额度修改为 ＄0.002000 额度	github_3			0	0	0	0	f	0	\N	0			
16	3	1769401552	3	管理员将用户额度从 ＄0.002000 额度修改为 ＄20.000000 额度	github_3			0	0	0	0	f	0	\N	0			
17	3	1769401567	5	status_code=404, Function 'e503b15c-62b0-4d69-b532-a88f0bfa2656': Not found for account 'ojCZrQaDR83yFOypUu-awXcHm4E9rDB4eBBaQE1bWi8'	github_3	playground-default	deepseek-ai/deepseek-coder-6.7b-instruct	0	0	0	0	f	2	\N	0	default		{"admin_info":{"use_channel":["2"]},"channel_id":2,"channel_name":"nvidia英伟达","channel_type":1,"error_code":"bad_response_status_code","error_type":"openai_error","request_path":"/pg/chat/completions","status_code":404}
18	3	1769401567	5	status_code=404, Function 'e503b15c-62b0-4d69-b532-a88f0bfa2656': Not found for account 'W9dX18k0j67m8qfeAOxhP_kOHCGEmdK1dUen0Fd_t80'	github_3	playground-default	deepseek-ai/deepseek-coder-6.7b-instruct	0	0	0	0	f	3	\N	0	default		{"admin_info":{"use_channel":["2","3"]},"channel_id":3,"channel_name":"nvidia英伟达","channel_type":1,"error_code":"bad_response_status_code","error_type":"openai_error","request_path":"/pg/chat/completions","status_code":404}
19	3	1769401567	5	status_code=404, Function 'e503b15c-62b0-4d69-b532-a88f0bfa2656': Not found for account 'ojCZrQaDR83yFOypUu-awXcHm4E9rDB4eBBaQE1bWi8'	github_3	playground-default	deepseek-ai/deepseek-coder-6.7b-instruct	0	0	0	0	f	2	\N	0	default		{"admin_info":{"use_channel":["2","3","2"]},"channel_id":2,"channel_name":"nvidia英伟达","channel_type":1,"error_code":"bad_response_status_code","error_type":"openai_error","request_path":"/pg/chat/completions","status_code":404}
20	3	1769401567	5	status_code=404, Function 'e503b15c-62b0-4d69-b532-a88f0bfa2656': Not found for account 'N5rw2HV8avOJ5IU5cIJqj9Zn7otpG0Cw-Vf_c7_RW8Y'	github_3	playground-default	deepseek-ai/deepseek-coder-6.7b-instruct	0	0	0	0	f	1	\N	0	default		{"admin_info":{"use_channel":["2","3","2","1"]},"channel_id":1,"channel_name":"nvidia英伟达","channel_type":1,"error_code":"bad_response_status_code","error_type":"openai_error","request_path":"/pg/chat/completions","status_code":404}
21	3	1769401583	5	status_code=404, Function 'e503b15c-62b0-4d69-b532-a88f0bfa2656': Not found for account 'ojCZrQaDR83yFOypUu-awXcHm4E9rDB4eBBaQE1bWi8'	github_3	playground-default	deepseek-ai/deepseek-coder-6.7b-instruct	0	0	0	0	f	2	\N	0	default		{"admin_info":{"use_channel":["2"]},"channel_id":2,"channel_name":"nvidia英伟达","channel_type":1,"error_code":"bad_response_status_code","error_type":"openai_error","request_path":"/pg/chat/completions","status_code":404}
22	3	1769401583	5	status_code=404, Function 'e503b15c-62b0-4d69-b532-a88f0bfa2656': Not found for account 'ojCZrQaDR83yFOypUu-awXcHm4E9rDB4eBBaQE1bWi8'	github_3	playground-default	deepseek-ai/deepseek-coder-6.7b-instruct	0	0	0	0	f	2	\N	0	default		{"admin_info":{"use_channel":["2","2"]},"channel_id":2,"channel_name":"nvidia英伟达","channel_type":1,"error_code":"bad_response_status_code","error_type":"openai_error","request_path":"/pg/chat/completions","status_code":404}
23	3	1769401583	5	status_code=404, Function 'e503b15c-62b0-4d69-b532-a88f0bfa2656': Not found for account 'N5rw2HV8avOJ5IU5cIJqj9Zn7otpG0Cw-Vf_c7_RW8Y'	github_3	playground-default	deepseek-ai/deepseek-coder-6.7b-instruct	0	0	0	0	f	1	\N	0	default		{"admin_info":{"use_channel":["2","2","1"]},"channel_id":1,"channel_name":"nvidia英伟达","channel_type":1,"error_code":"bad_response_status_code","error_type":"openai_error","request_path":"/pg/chat/completions","status_code":404}
24	3	1769401583	5	status_code=404, Function 'e503b15c-62b0-4d69-b532-a88f0bfa2656': Not found for account 'W9dX18k0j67m8qfeAOxhP_kOHCGEmdK1dUen0Fd_t80'	github_3	playground-default	deepseek-ai/deepseek-coder-6.7b-instruct	0	0	0	0	f	3	\N	0	default		{"admin_info":{"use_channel":["2","2","1","3"]},"channel_id":3,"channel_name":"nvidia英伟达","channel_type":1,"error_code":"bad_response_status_code","error_type":"openai_error","request_path":"/pg/chat/completions","status_code":404}
25	1	1769401682	2		liuliang	playground-default	minimaxai/minimax-m2.1	60	30	45	1	t	1	\N	0	default		{"admin_info":{"use_channel":["1"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":1,"frt":1101,"group_ratio":1,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/pg/chat/completions","user_group_ratio":-1}
26	1	1769401841	5	status_code=524, bad response status code 524	liuliang	playground-default	claude-sonnet-4-5	0	0	0	0	f	1	\N	0	default		{"admin_info":{"use_channel":["1"]},"channel_id":1,"channel_name":"nvidia英伟达","channel_type":1,"error_code":"bad_response_status_code","error_type":"openai_error","request_path":"/pg/chat/completions","status_code":524}
27	3	1769401861	5	status_code=524, bad response status code 524	github_3	playground-default	minimaxai/minimax-m2.1	0	0	0	0	f	2	\N	0	default		{"admin_info":{"use_channel":["2"]},"channel_id":2,"channel_name":"nvidia英伟达","channel_type":1,"error_code":"bad_response_status_code","error_type":"openai_error","request_path":"/pg/chat/completions","status_code":524}
28	1	1769401970	2		liuliang	playground-default	claude-sonnet-4-5	164	30	35	2	t	3	\N	0	default		{"admin_info":{"use_channel":["3"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":1660,"group_ratio":1,"is_model_mapped":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/pg/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
29	3	1769401989	2		github_3	playground-default	minimaxai/minimax-m2.1	63	30	49	1	t	3	\N	0	default		{"admin_info":{"use_channel":["3"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":1,"frt":1116,"group_ratio":1,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/pg/chat/completions","user_group_ratio":-1}
30	3	1769401997	2		github_3	playground-default	claude-sonnet-4-5	168	30	36	1	t	3	\N	0	default		{"admin_info":{"use_channel":["3"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":1232,"group_ratio":1,"is_model_mapped":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/pg/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
31	3	1769402011	4	用户签到，获得额度 ＄0.010550 额度	github_3			0	0	0	0	f	0	\N	0			
32	4	1769402304	4	新用户注册赠送 ＄2.000000 额度	github_4			0	0	0	0	f	0	\N	0			
33	4	1769402304	4	使用邀请码赠送 ＄2.000000 额度	github_4			0	0	0	0	f	0	\N	0			
34	3	1769402304	4	邀请用户赠送 ＄2.000000 额度	github_3			0	0	0	0	f	0	\N	0			
35	4	1769402328	4	用户签到，获得额度 ＄2.000000 额度	github_4			0	0	0	0	f	0	\N	0			
36	5	1769402347	4	新用户注册赠送 ＄2.000000 额度	github_5			0	0	0	0	f	0	\N	0			
37	5	1769402347	4	使用邀请码赠送 ＄2.000000 额度	github_5			0	0	0	0	f	0	\N	0			
38	3	1769402347	4	邀请用户赠送 ＄2.000000 额度	github_3			0	0	0	0	f	0	\N	0			
39	5	1769402353	4	用户签到，获得额度 ＄2.000000 额度	github_5			0	0	0	0	f	0	\N	0			
40	6	1769402414	4	新用户注册赠送 ＄2.000000 额度	github_6			0	0	0	0	f	0	\N	0			
41	6	1769402414	4	使用邀请码赠送 ＄2.000000 额度	github_6			0	0	0	0	f	0	\N	0			
42	3	1769402414	4	邀请用户赠送 ＄2.000000 额度	github_3			0	0	0	0	f	0	\N	0			
43	7	1769402437	4	新用户注册赠送 ＄2.000000 额度	github_7			0	0	0	0	f	0	\N	0			
44	7	1769402437	4	使用邀请码赠送 ＄2.000000 额度	github_7			0	0	0	0	f	0	\N	0			
45	3	1769402437	4	邀请用户赠送 ＄2.000000 额度	github_3			0	0	0	0	f	0	\N	0			
46	7	1769402441	4	用户签到，获得额度 ＄2.000000 额度	github_7			0	0	0	0	f	0	\N	0			
47	8	1769402449	4	新用户注册赠送 ＄2.000000 额度	github_8			0	0	0	0	f	0	\N	0			
48	8	1769402449	4	使用邀请码赠送 ＄2.000000 额度	github_8			0	0	0	0	f	0	\N	0			
49	3	1769402449	4	邀请用户赠送 ＄2.000000 额度	github_3			0	0	0	0	f	0	\N	0			
50	8	1769402456	4	用户签到，获得额度 ＄2.000000 额度	github_8			0	0	0	0	f	0	\N	0			
51	9	1769402784	4	新用户注册赠送 ＄2.000000 额度	github_9			0	0	0	0	f	0	\N	0			
52	9	1769402784	4	使用邀请码赠送 ＄2.000000 额度	github_9			0	0	0	0	f	0	\N	0			
53	3	1769402784	4	邀请用户赠送 ＄2.000000 额度	github_3			0	0	0	0	f	0	\N	0			
54	9	1769402794	4	用户签到，获得额度 ＄2.000000 额度	github_9			0	0	0	0	f	0	\N	0			
55	10	1769403436	4	新用户注册赠送 ＄2.000000 额度	github_10			0	0	0	0	f	0	\N	0			
56	10	1769403436	4	使用邀请码赠送 ＄2.000000 额度	github_10			0	0	0	0	f	0	\N	0			
57	3	1769403436	4	邀请用户赠送 ＄2.000000 额度	github_3			0	0	0	0	f	0	\N	0			
58	11	1769403462	4	新用户注册赠送 ＄2.000000 额度	github_11			0	0	0	0	f	0	\N	0			
59	11	1769403476	4	用户签到，获得额度 ＄2.000000 额度	github_11			0	0	0	0	f	0	\N	0			
60	11	1769403626	5	status_code=524, bad response status code 524	github_11	playground-default	claude-sonnet-4-5	0	0	0	0	f	2	\N	0	default		{"admin_info":{"use_channel":["2"]},"channel_id":2,"channel_name":"nvidia英伟达","channel_type":1,"error_code":"bad_response_status_code","error_type":"openai_error","request_path":"/pg/chat/completions","status_code":524}
61	12	1769403961	4	新用户注册赠送 ＄2.000000 额度	github_12			0	0	0	0	f	0	\N	0			
62	12	1769403961	4	使用邀请码赠送 ＄2.000000 额度	github_12			0	0	0	0	f	0	\N	0			
63	3	1769403961	4	邀请用户赠送 ＄2.000000 额度	github_3			0	0	0	0	f	0	\N	0			
64	12	1769403967	4	用户签到，获得额度 ＄2.000000 额度	github_12			0	0	0	0	f	0	\N	0			
65	13	1769404688	4	新用户注册赠送 ＄2.000000 额度	github_13			0	0	0	0	f	0	\N	0			
66	13	1769404688	4	使用邀请码赠送 ＄2.000000 额度	github_13			0	0	0	0	f	0	\N	0			
67	3	1769404688	4	邀请用户赠送 ＄2.000000 额度	github_3			0	0	0	0	f	0	\N	0			
68	14	1769405384	4	新用户注册赠送 ＄2.000000 额度	github_14			0	0	0	0	f	0	\N	0			
69	14	1769405384	4	使用邀请码赠送 ＄2.000000 额度	github_14			0	0	0	0	f	0	\N	0			
70	3	1769405384	4	邀请用户赠送 ＄2.000000 额度	github_3			0	0	0	0	f	0	\N	0			
71	14	1769405428	4	用户签到，获得额度 ＄2.000000 额度	github_14			0	0	0	0	f	0	\N	0			
72	15	1769405597	4	新用户注册赠送 ＄2.000000 额度	github_15			0	0	0	0	f	0	\N	0			
73	15	1769405597	4	使用邀请码赠送 ＄2.000000 额度	github_15			0	0	0	0	f	0	\N	0			
74	3	1769405597	4	邀请用户赠送 ＄2.000000 额度	github_3			0	0	0	0	f	0	\N	0			
75	15	1769405601	4	用户签到，获得额度 ＄2.000000 额度	github_15			0	0	0	0	f	0	\N	0			
76	16	1769406040	4	新用户注册赠送 ＄2.000000 额度	github_16			0	0	0	0	f	0	\N	0			
77	16	1769406051	4	用户签到，获得额度 ＄2.000000 额度	github_16			0	0	0	0	f	0	\N	0			
78	17	1769406059	4	新用户注册赠送 ＄2.000000 额度	github_17			0	0	0	0	f	0	\N	0			
79	17	1769406059	4	使用邀请码赠送 ＄2.000000 额度	github_17			0	0	0	0	f	0	\N	0			
80	3	1769406059	4	邀请用户赠送 ＄2.000000 额度	github_3			0	0	0	0	f	0	\N	0			
81	18	1769406115	4	新用户注册赠送 ＄2.000000 额度	github_18			0	0	0	0	f	0	\N	0			
82	19	1769407139	4	新用户注册赠送 ＄2.000000 额度	github_19			0	0	0	0	f	0	\N	0			
83	19	1769407152	4	用户签到，获得额度 ＄2.000000 额度	github_19			0	0	0	0	f	0	\N	0			
84	20	1769407205	4	新用户注册赠送 ＄2.000000 额度	github_20			0	0	0	0	f	0	\N	0			
85	20	1769407216	4	用户签到，获得额度 ＄2.000000 额度	github_20			0	0	0	0	f	0	\N	0			
86	21	1769407273	4	新用户注册赠送 ＄2.000000 额度	github_21			0	0	0	0	f	0	\N	0			
87	21	1769407293	4	用户签到，获得额度 ＄2.000000 额度	github_21			0	0	0	0	f	0	\N	0			
88	22	1769407483	4	新用户注册赠送 ＄2.000000 额度	github_22			0	0	0	0	f	0	\N	0			
89	22	1769407483	4	使用邀请码赠送 ＄2.000000 额度	github_22			0	0	0	0	f	0	\N	0			
90	3	1769407483	4	邀请用户赠送 ＄2.000000 额度	github_3			0	0	0	0	f	0	\N	0			
91	23	1769408395	4	新用户注册赠送 ＄2.000000 额度	github_23			0	0	0	0	f	0	\N	0			
92	23	1769408395	4	使用邀请码赠送 ＄2.000000 额度	github_23			0	0	0	0	f	0	\N	0			
93	3	1769408395	4	邀请用户赠送 ＄2.000000 额度	github_3			0	0	0	0	f	0	\N	0			
94	23	1769408425	4	用户签到，获得额度 ＄2.000000 额度	github_23			0	0	0	0	f	0	\N	0			
95	24	1769412381	4	新用户注册赠送 ＄2000.000000 额度	github_24			0	0	0	0	f	0	\N	0			
96	24	1769412381	4	使用邀请码赠送 ＄2000.000000 额度	github_24			0	0	0	0	f	0	\N	0			
97	3	1769412381	4	邀请用户赠送 ＄2000.000000 额度	github_3			0	0	0	0	f	0	\N	0			
98	24	1769412399	2		github_24	playground-default	claude-sonnet-4-5	458	53	104	2	t	2	\N	0	default		{"admin_info":{"use_channel":["2"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":1393,"group_ratio":1,"is_model_mapped":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/pg/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
99	24	1769413986	2		github_24	playground-default	claude-sonnet-4-5	1223	34	299	4	t	1	\N	0	default		{"admin_info":{"use_channel":["1"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":1581,"group_ratio":1,"is_model_mapped":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/pg/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
100	24	1769414011	4	用户签到，获得额度 ＄2.000000 额度	github_24			0	0	0	0	f	0	\N	0			
101	24	1769414416	2		github_24	playground-default	claude-sonnet-4-5	1156	295	230	12	t	2	\N	0	default		{"admin_info":{"use_channel":["2"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":9119,"group_ratio":1,"is_model_mapped":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/pg/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
102	24	1769432489	3	管理员将用户额度从 ＄4001.994326 额度修改为 ＄40.019942 额度	github_24			0	0	0	0	f	0	\N	0			
103	3	1769432806	2		github_3	11	minimaxai/minimax-m2.1	13710	17017	121	3	t	3	\N	1	default		{"admin_info":{"use_channel":["3"]},"cache_creation_ratio":1.25,"cache_creation_tokens":0,"cache_ratio":1,"cache_tokens":0,"claude":true,"completion_ratio":1,"frt":1927,"group_ratio":1,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["Claude Messages","OpenAI Compatible"],"request_path":"/v1/messages","user_group_ratio":-1}
104	3	1769432810	2		github_3	11	z-ai/glm4.7	11603	14503	1	7	f	2	\N	1	default		{"admin_info":{"use_channel":["2"]},"cache_creation_ratio":1.25,"cache_creation_tokens":0,"cache_ratio":1,"cache_tokens":0,"claude":true,"completion_ratio":1,"frt":-1000,"group_ratio":1,"model_price":-1,"model_ratio":0.8,"request_conversion":["Claude Messages","OpenAI Compatible"],"request_path":"/v1/messages","user_group_ratio":-1}
105	3	1769432817	2		github_3	11	z-ai/glm4.7	310	149	239	14	t	2	\N	1	default		{"admin_info":{"use_channel":["2"]},"cache_creation_ratio":1.25,"cache_creation_tokens":0,"cache_ratio":1,"cache_tokens":0,"claude":true,"completion_ratio":1,"frt":10201,"group_ratio":1,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["Claude Messages","OpenAI Compatible"],"request_path":"/v1/messages","user_group_ratio":-1}
106	3	1769432824	2		github_3	11	z-ai/glm4.7	673	585	257	7	t	3	\N	1	default		{"admin_info":{"use_channel":["3"]},"cache_creation_ratio":1.25,"cache_creation_tokens":0,"cache_ratio":1,"cache_tokens":0,"claude":true,"completion_ratio":1,"frt":3922,"group_ratio":1,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["Claude Messages","OpenAI Compatible"],"request_path":"/v1/messages","user_group_ratio":-1}
107	3	1769432826	2		github_3	11	z-ai/glm4.7	537	672	0	23	t	1	\N	1	default		{"admin_info":{"local_count_tokens":true,"use_channel":["1"]},"cache_creation_ratio":1.25,"cache_creation_tokens":0,"cache_ratio":1,"cache_tokens":0,"claude":true,"completion_ratio":1,"frt":-1000,"group_ratio":1,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["Claude Messages","OpenAI Compatible"],"request_path":"/v1/messages","user_group_ratio":-1}
224	30	1769478716	4	新用户注册赠送 ＄20.000000 额度	github_30			0	0	0	0	f	0	\N	0			
108	3	1769432830	2		github_3	11	z-ai/glm4.7	312	222	169	3	t	3	\N	1	default		{"admin_info":{"use_channel":["3"]},"cache_creation_ratio":1.25,"cache_creation_tokens":0,"cache_ratio":1,"cache_tokens":0,"claude":true,"completion_ratio":1,"frt":698,"group_ratio":1,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["Claude Messages","OpenAI Compatible"],"request_path":"/v1/messages","user_group_ratio":-1}
109	3	1769432835	2		github_3	11	z-ai/glm4.7	348	236	200	2	t	3	\N	1	default		{"admin_info":{"use_channel":["3"]},"cache_creation_ratio":1.25,"cache_creation_tokens":0,"cache_ratio":1,"cache_tokens":0,"claude":true,"completion_ratio":1,"frt":457,"group_ratio":1,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["Claude Messages","OpenAI Compatible"],"request_path":"/v1/messages","user_group_ratio":-1}
110	3	1769432842	2		github_3	11	z-ai/glm4.7	619	555	219	4	t	1	\N	1	default		{"admin_info":{"use_channel":["1"]},"cache_creation_ratio":1.25,"cache_creation_tokens":0,"cache_ratio":1,"cache_tokens":0,"claude":true,"completion_ratio":1,"frt":663,"group_ratio":1,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["Claude Messages","OpenAI Compatible"],"request_path":"/v1/messages","user_group_ratio":-1}
111	3	1769432860	2		github_3	11	z-ai/glm4.7	408	250	261	15	t	3	\N	1	default		{"admin_info":{"use_channel":["3"]},"cache_creation_ratio":1.25,"cache_creation_tokens":0,"cache_ratio":1,"cache_tokens":0,"claude":true,"completion_ratio":1,"frt":11962,"group_ratio":1,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["Claude Messages","OpenAI Compatible"],"request_path":"/v1/messages","user_group_ratio":-1}
112	3	1769432866	2		github_3	11	z-ai/glm4.7	414	308	210	3	t	1	\N	1	default		{"admin_info":{"use_channel":["1"]},"cache_creation_ratio":1.25,"cache_creation_tokens":0,"cache_ratio":1,"cache_tokens":0,"claude":true,"completion_ratio":1,"frt":876,"group_ratio":1,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["Claude Messages","OpenAI Compatible"],"request_path":"/v1/messages","user_group_ratio":-1}
113	3	1769432875	2		github_3	11	z-ai/glm4.7	364	115	341	6	t	1	\N	1	default		{"admin_info":{"use_channel":["1"]},"cache_creation_ratio":1.25,"cache_creation_tokens":0,"cache_ratio":1,"cache_tokens":0,"claude":true,"completion_ratio":1,"frt":676,"group_ratio":1,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["Claude Messages","OpenAI Compatible"],"request_path":"/v1/messages","user_group_ratio":-1}
114	3	1769432882	2		github_3	11	z-ai/glm4.7	383	224	255	5	t	2	\N	1	default		{"admin_info":{"use_channel":["2"]},"cache_creation_ratio":1.25,"cache_creation_tokens":0,"cache_ratio":1,"cache_tokens":0,"claude":true,"completion_ratio":1,"frt":1236,"group_ratio":1,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["Claude Messages","OpenAI Compatible"],"request_path":"/v1/messages","user_group_ratio":-1}
115	3	1769432900	2		github_3	11	z-ai/glm4.7	301	222	155	14	t	2	\N	1	default		{"admin_info":{"use_channel":["2"]},"cache_creation_ratio":1.25,"cache_creation_tokens":0,"cache_ratio":1,"cache_tokens":0,"claude":true,"completion_ratio":1,"frt":7360,"group_ratio":1,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["Claude Messages","OpenAI Compatible"],"request_path":"/v1/messages","user_group_ratio":-1}
116	3	1769432956	2		github_3	11	z-ai/glm4.7	424	220	310	9	t	3	\N	1	default		{"admin_info":{"use_channel":["3"]},"cache_creation_ratio":1.25,"cache_creation_tokens":0,"cache_ratio":1,"cache_tokens":0,"claude":true,"completion_ratio":1,"frt":3606,"group_ratio":1,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["Claude Messages","OpenAI Compatible"],"request_path":"/v1/messages","user_group_ratio":-1}
117	3	1769432964	2		github_3	11	z-ai/glm4.7	420	183	342	4	t	3	\N	1	default		{"admin_info":{"use_channel":["3"]},"cache_creation_ratio":1.25,"cache_creation_tokens":0,"cache_ratio":1,"cache_tokens":0,"claude":true,"completion_ratio":1,"frt":453,"group_ratio":1,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["Claude Messages","OpenAI Compatible"],"request_path":"/v1/messages","user_group_ratio":-1}
118	25	1769434275	4	新用户注册赠送 ＄20.000000 额度	github_25			0	0	0	0	f	0	\N	0			
119	25	1769434275	4	使用邀请码赠送 ＄20.000000 额度	github_25			0	0	0	0	f	0	\N	0			
120	3	1769434275	4	邀请用户赠送 ＄20.000000 额度	github_3			0	0	0	0	f	0	\N	0			
121	25	1769434296	4	用户签到，获得额度 ＄2.000000 额度	github_25			0	0	0	0	f	0	\N	0			
122	26	1769434324	4	新用户注册赠送 ＄20.000000 额度	github_26			0	0	0	0	f	0	\N	0			
123	26	1769434324	4	使用邀请码赠送 ＄20.000000 额度	github_26			0	0	0	0	f	0	\N	0			
124	25	1769434324	4	邀请用户赠送 ＄20.000000 额度	github_25			0	0	0	0	f	0	\N	0			
125	26	1769434332	4	用户签到，获得额度 ＄2.000000 额度	github_26			0	0	0	0	f	0	\N	0			
126	1	1769435318	2	模型测试	liuliang	模型测试	minimaxai/minimax-m2.1	44	39	16	1	f	1	\N	0	default		{"admin_info":{"use_channel":null},"cache_ratio":1,"cache_tokens":0,"completion_ratio":1,"frt":-1000,"group_ratio":1,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","user_group_ratio":-1}
127	1	1769435320	2	模型测试	liuliang	模型测试	openai/gpt-oss-120b	41	66	16	0	f	1	\N	0	default		{"admin_info":{"use_channel":null},"cache_ratio":1,"cache_tokens":0,"completion_ratio":1,"frt":-1000,"group_ratio":1,"model_price":-1,"model_ratio":0.5,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","user_group_ratio":-1}
225	30	1769478716	4	使用邀请码赠送 ＄20.000000 额度	github_30			0	0	0	0	f	0	\N	0			
128	1	1769435327	2	模型测试	liuliang	模型测试	deepseek-ai/deepseek-r1-distill-qwen-32b	18	6	16	0	f	1	\N	0	default		{"admin_info":{"use_channel":null},"cache_ratio":1,"cache_tokens":0,"completion_ratio":1,"frt":-1000,"group_ratio":1,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","user_group_ratio":-1}
129	27	1769436471	4	新用户注册赠送 ＄20.000000 额度	github_27			0	0	0	0	f	0	\N	0			
130	27	1769436476	4	用户签到，获得额度 ＄2.000000 额度	github_27			0	0	0	0	f	0	\N	0			
131	28	1769436525	4	新用户注册赠送 ＄20.000000 额度	github_28			0	0	0	0	f	0	\N	0			
132	28	1769436525	4	使用邀请码赠送 ＄20.000000 额度	github_28			0	0	0	0	f	0	\N	0			
133	27	1769436525	4	邀请用户赠送 ＄20.000000 额度	github_27			0	0	0	0	f	0	\N	0			
134	28	1769436529	4	用户签到，获得额度 ＄2.000000 额度	github_28			0	0	0	0	f	0	\N	0			
135	29	1769437143	4	新用户注册赠送 ＄20.000000 额度	github_29			0	0	0	0	f	0	\N	0			
136	29	1769437143	4	使用邀请码赠送 ＄20.000000 额度	github_29			0	0	0	0	f	0	\N	0			
137	3	1769437143	4	邀请用户赠送 ＄20.000000 额度	github_3			0	0	0	0	f	0	\N	0			
138	29	1769437300	5	status_code=404, Function 'e503b15c-62b0-4d69-b532-a88f0bfa2656': Not found for account 'ojCZrQaDR83yFOypUu-awXcHm4E9rDB4eBBaQE1bWi8'	github_29	playground-default	deepseek-ai/deepseek-coder-6.7b-instruct	0	0	0	0	f	2	\N	0	default		{"admin_info":{"use_channel":["2"]},"channel_id":2,"channel_name":"nvidia英伟达","channel_type":1,"error_code":"bad_response_status_code","error_type":"openai_error","request_path":"/pg/chat/completions","status_code":404}
139	29	1769437300	5	status_code=404, Function 'e503b15c-62b0-4d69-b532-a88f0bfa2656': Not found for account 'N5rw2HV8avOJ5IU5cIJqj9Zn7otpG0Cw-Vf_c7_RW8Y'	github_29	playground-default	deepseek-ai/deepseek-coder-6.7b-instruct	0	0	0	0	f	1	\N	0	default		{"admin_info":{"use_channel":["2","1"]},"channel_id":1,"channel_name":"nvidia英伟达","channel_type":1,"error_code":"bad_response_status_code","error_type":"openai_error","request_path":"/pg/chat/completions","status_code":404}
140	29	1769437301	5	status_code=404, Function 'e503b15c-62b0-4d69-b532-a88f0bfa2656': Not found for account 'ojCZrQaDR83yFOypUu-awXcHm4E9rDB4eBBaQE1bWi8'	github_29	playground-default	deepseek-ai/deepseek-coder-6.7b-instruct	0	0	0	0	f	2	\N	0	default		{"admin_info":{"use_channel":["2","1","2"]},"channel_id":2,"channel_name":"nvidia英伟达","channel_type":1,"error_code":"bad_response_status_code","error_type":"openai_error","request_path":"/pg/chat/completions","status_code":404}
141	29	1769437301	5	status_code=404, Function 'e503b15c-62b0-4d69-b532-a88f0bfa2656': Not found for account 'ojCZrQaDR83yFOypUu-awXcHm4E9rDB4eBBaQE1bWi8'	github_29	playground-default	deepseek-ai/deepseek-coder-6.7b-instruct	0	0	0	0	f	2	\N	0	default		{"admin_info":{"use_channel":["2","1","2","2"]},"channel_id":2,"channel_name":"nvidia英伟达","channel_type":1,"error_code":"bad_response_status_code","error_type":"openai_error","request_path":"/pg/chat/completions","status_code":404}
142	29	1769437309	5	status_code=404, Function 'e503b15c-62b0-4d69-b532-a88f0bfa2656': Not found for account 'ojCZrQaDR83yFOypUu-awXcHm4E9rDB4eBBaQE1bWi8'	github_29	playground-default	deepseek-ai/deepseek-coder-6.7b-instruct	0	0	0	0	f	2	\N	0	default		{"admin_info":{"use_channel":["2"]},"channel_id":2,"channel_name":"nvidia英伟达","channel_type":1,"error_code":"bad_response_status_code","error_type":"openai_error","request_path":"/pg/chat/completions","status_code":404}
143	29	1769437309	5	status_code=404, Function 'e503b15c-62b0-4d69-b532-a88f0bfa2656': Not found for account 'ojCZrQaDR83yFOypUu-awXcHm4E9rDB4eBBaQE1bWi8'	github_29	playground-default	deepseek-ai/deepseek-coder-6.7b-instruct	0	0	0	0	f	2	\N	0	default		{"admin_info":{"use_channel":["2","2"]},"channel_id":2,"channel_name":"nvidia英伟达","channel_type":1,"error_code":"bad_response_status_code","error_type":"openai_error","request_path":"/pg/chat/completions","status_code":404}
144	29	1769437310	5	status_code=404, Function 'e503b15c-62b0-4d69-b532-a88f0bfa2656': Not found for account 'ojCZrQaDR83yFOypUu-awXcHm4E9rDB4eBBaQE1bWi8'	github_29	playground-default	deepseek-ai/deepseek-coder-6.7b-instruct	0	0	0	0	f	2	\N	0	default		{"admin_info":{"use_channel":["2","2","2"]},"channel_id":2,"channel_name":"nvidia英伟达","channel_type":1,"error_code":"bad_response_status_code","error_type":"openai_error","request_path":"/pg/chat/completions","status_code":404}
145	29	1769437310	5	status_code=404, Function 'e503b15c-62b0-4d69-b532-a88f0bfa2656': Not found for account 'ojCZrQaDR83yFOypUu-awXcHm4E9rDB4eBBaQE1bWi8'	github_29	playground-default	deepseek-ai/deepseek-coder-6.7b-instruct	0	0	0	0	f	2	\N	0	default		{"admin_info":{"use_channel":["2","2","2","2"]},"channel_id":2,"channel_name":"nvidia英伟达","channel_type":1,"error_code":"bad_response_status_code","error_type":"openai_error","request_path":"/pg/chat/completions","status_code":404}
146	29	1769437320	2		github_29	playground-default	claude-sonnet-4-5	759	244	141	2	t	2	\N	0	default		{"admin_info":{"use_channel":["2"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":1065,"group_ratio":1,"is_model_mapped":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/pg/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
161	27	1769441455	2		github_27	hhh	claude-sonnet-4-5	20999	25619	126	3	t	1	\N	10	default		{"admin_info":{"use_channel":["1"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":2272,"group_ratio":1,"is_model_mapped":true,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
226	3	1769478716	4	邀请用户赠送 ＄20.000000 额度	github_3			0	0	0	0	f	0	\N	0			
147	27	1769441007	5	status_code=400, 1 validation error:\n  {'type': 'literal_error', 'loc': ('body', 'reasoning_effort'), 'msg': "Input should be 'low', 'medium' or 'high'", 'input': 'xhigh', 'ctx': {'expected': "'low', 'medium' or 'high'"}}\n\n  File "/workspace/sglang/python/sglang/srt/entrypoints/http_server.py", line 1269, in openai_v1_chat_completions\n    POST /v1/chat/completions [{'type': 'literal_error', 'loc': ('body', 'reasoning_effort'), 'msg': "Input should be 'low', 'medium' or 'high'", 'input': 'xhigh', 'ctx': {'expected': "'low', 'medium' or 'high'"}}]	github_27	hhh	claude-sonnet-4-5	0	0	0	0	f	2	\N	10	default		{"admin_info":{"use_channel":["2"]},"channel_id":2,"channel_name":"nvidia英伟达","channel_type":1,"error_code":"bad_response_status_code","error_type":"openai_error","request_path":"/v1/chat/completions","status_code":400}
148	27	1769441022	2		github_27	hhh	claude-sonnet-4-5	9483	11074	156	2	t	3	\N	10	default		{"admin_info":{"use_channel":["3"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":1345,"group_ratio":1,"is_model_mapped":true,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
149	27	1769441048	2		github_27	hhh	claude-sonnet-4-5	16954	19132	412	5	t	1	\N	10	default		{"admin_info":{"use_channel":["1"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":1884,"group_ratio":1,"is_model_mapped":true,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
150	27	1769441166	2		github_27	hhh	claude-sonnet-4-5	16318	19762	127	3	t	3	\N	10	default		{"admin_info":{"use_channel":["3"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":2072,"group_ratio":1,"is_model_mapped":true,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
151	27	1769441197	2		github_27	hhh	claude-sonnet-4-5	16881	20571	106	3	t	1	\N	10	default		{"admin_info":{"use_channel":["1"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":1913,"group_ratio":1,"is_model_mapped":true,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
152	27	1769441213	2		github_27	hhh	claude-sonnet-4-5	17278	21122	95	2	t	2	\N	10	default		{"admin_info":{"use_channel":["2"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":1920,"group_ratio":1,"is_model_mapped":true,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
153	27	1769441223	2		github_27	hhh	claude-sonnet-4-5	17984	21735	149	3	t	2	\N	10	default		{"admin_info":{"use_channel":["2"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":1986,"group_ratio":1,"is_model_mapped":true,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
154	27	1769441232	2		github_27	hhh	claude-sonnet-4-5	18275	22294	110	4	t	1	\N	10	default		{"admin_info":{"use_channel":["1"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":2228,"group_ratio":1,"is_model_mapped":true,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
155	27	1769441242	2		github_27	hhh	claude-sonnet-4-5	18643	22769	107	4	t	2	\N	10	default		{"admin_info":{"use_channel":["2"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":1985,"group_ratio":1,"is_model_mapped":true,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
156	27	1769441250	2		github_27	hhh	claude-sonnet-4-5	19107	23249	127	3	t	3	\N	10	default		{"admin_info":{"use_channel":["3"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":2014,"group_ratio":1,"is_model_mapped":true,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
157	27	1769441258	2		github_27	hhh	claude-sonnet-4-5	19365	23726	96	4	t	2	\N	10	default		{"admin_info":{"use_channel":["2"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":2963,"group_ratio":1,"is_model_mapped":true,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
158	27	1769441265	2		github_27	hhh	claude-sonnet-4-5	19761	24191	102	3	t	2	\N	10	default		{"admin_info":{"use_channel":["2"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":2119,"group_ratio":1,"is_model_mapped":true,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
159	27	1769441343	2		github_27	hhh	claude-sonnet-4-5	20263	24664	133	73	t	3	\N	10	default		{"admin_info":{"use_channel":["3"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":70685,"group_ratio":1,"is_model_mapped":true,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
160	27	1769441357	2		github_27	hhh	claude-sonnet-4-5	20503	25154	95	3	t	1	\N	10	default		{"admin_info":{"use_channel":["1"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":2293,"group_ratio":1,"is_model_mapped":true,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
162	27	1769441455	2		github_27	hhh	claude-sonnet-4-5	24972	31215	0	94	t	3	\N	10	default		{"admin_info":{"local_count_tokens":true,"use_channel":["3"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":-1000,"group_ratio":1,"is_model_mapped":true,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
163	27	1769441467	2		github_27	hhh	claude-sonnet-4-5	21273	26096	99	3	t	2	\N	10	default		{"admin_info":{"use_channel":["2"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":2476,"group_ratio":1,"is_model_mapped":true,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
164	27	1769441477	2		github_27	hhh	claude-sonnet-4-5	21702	26567	112	3	t	2	\N	10	default		{"admin_info":{"use_channel":["2"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":2208,"group_ratio":1,"is_model_mapped":true,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
165	27	1769441490	2		github_27	hhh	claude-sonnet-4-5	22101	27036	118	4	t	2	\N	10	default		{"admin_info":{"use_channel":["2"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":2276,"group_ratio":1,"is_model_mapped":true,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
166	27	1769441504	2		github_27	hhh	claude-sonnet-4-5	22448	27530	106	4	t	3	\N	10	default		{"admin_info":{"use_channel":["3"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":2830,"group_ratio":1,"is_model_mapped":true,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
167	27	1769441514	2		github_27	hhh	claude-sonnet-4-5	23244	28010	209	5	t	3	\N	10	default		{"admin_info":{"use_channel":["3"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":3135,"group_ratio":1,"is_model_mapped":true,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
168	27	1769441542	2		github_27	hhh	claude-sonnet-4-5	25017	28811	492	8	t	2	\N	10	default		{"admin_info":{"use_channel":["2"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":2370,"group_ratio":1,"is_model_mapped":true,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
169	27	1769441571	2		github_27	hhh	claude-sonnet-4-5	24761	29561	278	6	t	1	\N	10	default		{"admin_info":{"use_channel":["1"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":2685,"group_ratio":1,"is_model_mapped":true,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
170	27	1769441589	2		github_27	hhh	claude-sonnet-4-5	25206	30258	250	4	t	3	\N	10	default		{"admin_info":{"use_channel":["3"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":1748,"group_ratio":1,"is_model_mapped":true,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
171	27	1769441612	2		github_27	hhh	claude-sonnet-4-5	27670	30923	733	12	t	3	\N	10	default		{"admin_info":{"use_channel":["3"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":4507,"group_ratio":1,"is_model_mapped":true,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
172	27	1769441643	2		github_27	hhh	claude-sonnet-4-5	26132	32035	126	13	t	2	\N	10	default		{"admin_info":{"use_channel":["2"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":11589,"group_ratio":1,"is_model_mapped":true,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
173	27	1769441675	2		github_27	hhh	claude-sonnet-4-5	39640	40555	1799	20	t	1	\N	10	default		{"admin_info":{"use_channel":["1"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":3478,"group_ratio":1,"is_model_mapped":true,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
174	27	1769441684	2		github_27	hhh	claude-sonnet-4-5	38119	46384	253	6	t	1	\N	10	default		{"admin_info":{"use_channel":["1"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":2672,"group_ratio":1,"is_model_mapped":true,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
175	27	1769441702	2		github_27	hhh	claude-sonnet-4-5	39138	47048	375	9	t	3	\N	10	default		{"admin_info":{"use_channel":["3"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":3931,"group_ratio":1,"is_model_mapped":true,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
227	30	1769478721	4	用户签到，获得额度 ＄2.000000 额度	github_30			0	0	0	0	f	0	\N	0			
228	31	1769481689	4	新用户注册赠送 ＄20.000000 额度	github_31			0	0	0	0	f	0	\N	0			
176	27	1769441717	2		github_27	hhh	claude-sonnet-4-5	38519	47849	60	5	t	1	\N	10	default		{"admin_info":{"use_channel":["1"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":3917,"group_ratio":1,"is_model_mapped":true,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
177	27	1769441728	2		github_27	hhh	claude-sonnet-4-5	39422	48533	149	5	t	2	\N	10	default		{"admin_info":{"use_channel":["2"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":4411,"group_ratio":1,"is_model_mapped":true,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
178	27	1769441740	2		github_27	hhh	claude-sonnet-4-5	39718	49143	101	5	t	2	\N	10	default		{"admin_info":{"use_channel":["2"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":3997,"group_ratio":1,"is_model_mapped":true,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
179	27	1769441752	2		github_27	hhh	claude-sonnet-4-5	40291	49654	142	5	t	1	\N	10	default		{"admin_info":{"use_channel":["1"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":4163,"group_ratio":1,"is_model_mapped":true,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
180	27	1769441772	2		github_27	hhh	claude-sonnet-4-5	43858	50452	874	13	t	1	\N	10	default		{"admin_info":{"use_channel":["1"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":4147,"group_ratio":1,"is_model_mapped":true,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
181	27	1769441785	2		github_27	hhh	claude-sonnet-4-5	41501	51671	41	5	t	1	\N	10	default		{"admin_info":{"use_channel":["1"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":4296,"group_ratio":1,"is_model_mapped":true,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
182	27	1769441795	2		github_27	hhh	claude-sonnet-4-5	42082	52113	98	5	t	2	\N	10	default		{"admin_info":{"use_channel":["2"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":4311,"group_ratio":1,"is_model_mapped":true,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
183	27	1769441809	2		github_27	hhh	claude-sonnet-4-5	43106	52728	231	9	t	2	\N	10	default		{"admin_info":{"use_channel":["2"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":4551,"group_ratio":1,"is_model_mapped":true,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
184	27	1769441826	2		github_27	hhh	claude-sonnet-4-5	43054	53243	115	6	t	1	\N	10	default		{"admin_info":{"use_channel":["1"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":4733,"group_ratio":1,"is_model_mapped":true,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
185	27	1769441836	2		github_27	hhh	claude-sonnet-4-5	43232	53750	58	6	t	1	\N	10	default		{"admin_info":{"use_channel":["1"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":4761,"group_ratio":1,"is_model_mapped":true,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
186	27	1769441855	2		github_27	hhh	claude-sonnet-4-5	44097	54346	155	14	t	1	\N	10	default		{"admin_info":{"use_channel":["1"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":12002,"group_ratio":1,"is_model_mapped":true,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
187	27	1769441873	2		github_27	hhh	claude-sonnet-4-5	44150	54958	46	5	t	3	\N	10	default		{"admin_info":{"use_channel":["3"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":4789,"group_ratio":1,"is_model_mapped":true,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
188	27	1769441885	2		github_27	hhh	claude-sonnet-4-5	44585	55446	57	5	t	2	\N	10	default		{"admin_info":{"use_channel":["2"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":4818,"group_ratio":1,"is_model_mapped":true,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
189	27	1769441897	2		github_27	hhh	claude-sonnet-4-5	45153	55911	106	6	t	2	\N	10	default		{"admin_info":{"use_channel":["2"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":5294,"group_ratio":1,"is_model_mapped":true,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
221	27	1769463994	2		github_27	hhh	z-ai/glm4.7	94311	117699	190	31	t	1	\N	10	default		{"admin_info":{"use_channel":["1"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":1,"frt":29508,"group_ratio":1,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","user_group_ratio":-1}
190	27	1769441910	2		github_27	hhh	claude-sonnet-4-5	46598	56417	366	8	t	2	\N	10	default		{"admin_info":{"use_channel":["2"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":4948,"group_ratio":1,"is_model_mapped":true,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
191	27	1769441989	2		github_27	hhh	claude-sonnet-4-5	46300	57195	136	8	t	2	\N	10	default		{"admin_info":{"use_channel":["2"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":5926,"group_ratio":1,"is_model_mapped":true,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
192	27	1769441994	5	status_code=429	github_27	hhh	claude-sonnet-4-5	0	0	0	0	f	2	\N	10	default		{"admin_info":{"use_channel":["2"]},"channel_id":2,"channel_name":"nvidia英伟达","channel_type":1,"error_code":"bad_response_status_code","error_type":"openai_error","request_path":"/v1/chat/completions","status_code":429}
193	27	1769442000	2		github_27	hhh	claude-sonnet-4-5	47246	58413	129	6	t	2	\N	10	default		{"admin_info":{"use_channel":["2","2"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":5357,"group_ratio":1,"is_model_mapped":true,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
194	27	1769442013	2		github_27	hhh	claude-sonnet-4-5	49078	60313	207	8	t	1	\N	10	default		{"admin_info":{"use_channel":["1"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":5418,"group_ratio":1,"is_model_mapped":true,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
195	27	1769442033	2		github_27	hhh	claude-sonnet-4-5	49118	61012	77	6	t	2	\N	10	default		{"admin_info":{"use_channel":["2"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":5422,"group_ratio":1,"is_model_mapped":true,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
196	27	1769442045	2		github_27	hhh	claude-sonnet-4-5	50118	62248	80	8	t	3	\N	10	default		{"admin_info":{"use_channel":["3"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":5540,"group_ratio":1,"is_model_mapped":true,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
197	27	1769442081	2		github_27	hhh	claude-sonnet-4-5	108916	129145	1400	31	t	2	\N	10	default		{"admin_info":{"use_channel":["2"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":14931,"group_ratio":1,"is_model_mapped":true,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
198	27	1769442104	2		github_27	hhh	claude-sonnet-4-5	104910	130878	52	15	t	3	\N	10	default		{"admin_info":{"use_channel":["3"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":15043,"group_ratio":1,"is_model_mapped":true,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
199	27	1769442128	2		github_27	hhh	claude-sonnet-4-5	105722	131408	149	17	t	3	\N	10	default		{"admin_info":{"use_channel":["3"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":15129,"group_ratio":1,"is_model_mapped":true,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
200	27	1769442150	2		github_27	hhh	claude-sonnet-4-5	106194	131953	158	18	t	2	\N	10	default		{"admin_info":{"use_channel":["2"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":15698,"group_ratio":1,"is_model_mapped":true,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
201	26	1769446516	4	用户签到，获得额度 ＄2.000000 额度	github_26			0	0	0	0	f	0	\N	0			
202	25	1769446527	4	用户签到，获得额度 ＄2.000000 额度	github_25			0	0	0	0	f	0	\N	0			
203	28	1769459392	2		github_28	hhh	claude-sonnet-4-5	6334	5382	507	6	t	1	\N	12	default		{"admin_info":{"use_channel":["1"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":1458,"group_ratio":1,"is_model_mapped":true,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
204	28	1769459437	2		github_28	hhh	claude-sonnet-4-5	17230	18072	693	12	t	1	\N	12	default		{"admin_info":{"use_channel":["1"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":3280,"group_ratio":1,"is_model_mapped":true,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
205	28	1769459451	2		github_28	hhh	claude-sonnet-4-5	12086	13492	323	5	t	2	\N	12	default		{"admin_info":{"use_channel":["2"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":1347,"group_ratio":1,"is_model_mapped":true,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
223	21	1769475416	4	用户签到，获得额度 ＄2.000000 额度	github_21			0	0	0	0	f	0	\N	0			
206	27	1769462393	2		github_27	hhh	claude-sonnet-4-5	106494	132062	211	17	t	1	\N	10	default		{"admin_info":{"use_channel":["1"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":15284,"group_ratio":1,"is_model_mapped":true,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
207	27	1769462424	2		github_27	hhh	claude-sonnet-4-5	106335	132674	49	17	t	2	\N	10	default		{"admin_info":{"use_channel":["2"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":16461,"group_ratio":1,"is_model_mapped":true,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
208	27	1769462460	2		github_27	hhh	claude-sonnet-4-5	107025	133196	117	19	t	1	\N	10	default		{"admin_info":{"use_channel":["1"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":16975,"group_ratio":1,"is_model_mapped":true,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
209	27	1769462585	2		github_27	hhh	claude-sonnet-4-5	126959	158699	0	96	t	3	\N	10	default		{"admin_info":{"local_count_tokens":true,"use_channel":["3"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":-1000,"group_ratio":1,"is_model_mapped":true,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
210	27	1769462601	2		github_27	hhh	claude-sonnet-4-5	108578	133793	386	21	t	2	\N	10	default		{"admin_info":{"use_channel":["2"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":16756,"group_ratio":1,"is_model_mapped":true,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
211	27	1769462628	2		github_27	hhh	claude-sonnet-4-5	107691	133914	140	17	t	2	\N	10	default		{"admin_info":{"use_channel":["2"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":15869,"group_ratio":1,"is_model_mapped":true,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
212	27	1769462765	5	status_code=524, bad response status code 524	github_27	hhh	claude-sonnet-4-5	0	0	0	0	f	3	\N	10	default		{"admin_info":{"use_channel":["3"]},"channel_id":3,"channel_name":"nvidia英伟达","channel_type":1,"error_code":"bad_response_status_code","error_type":"openai_error","request_path":"/v1/chat/completions","status_code":524}
213	27	1769463672	2		github_27	hhh	claude-sonnet-4-5	7410	8238	205	4	t	2	\N	10	default		{"admin_info":{"use_channel":["2"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":1955,"group_ratio":1,"is_model_mapped":true,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
214	27	1769463702	5	status_code=524, bad response status code 524	github_27	hhh	claude-sonnet-4-5	0	0	0	0	f	3	\N	10	default		{"admin_info":{"use_channel":["3"]},"channel_id":3,"channel_name":"nvidia英伟达","channel_type":1,"error_code":"bad_response_status_code","error_type":"openai_error","request_path":"/v1/chat/completions","status_code":524}
215	27	1769463776	2		github_27	hhh	claude-sonnet-4-5	7542	8238	238	4	t	1	\N	10	default		{"admin_info":{"use_channel":["1"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":1869,"group_ratio":1,"is_model_mapped":true,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
216	27	1769463828	2		github_27	hhh	claude-sonnet-4-5	76471	91364	845	20	t	1	\N	10	default		{"admin_info":{"use_channel":["1"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":9684,"group_ratio":1,"is_model_mapped":true,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
217	27	1769463859	2		github_27	hhh	claude-sonnet-4-5	75133	92161	351	13	t	3	\N	10	default		{"admin_info":{"use_channel":["3"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":9569,"group_ratio":1,"is_model_mapped":true,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
218	27	1769463875	2		github_27	hhh	claude-sonnet-4-5	77260	95540	207	12	t	3	\N	10	default		{"admin_info":{"use_channel":["3"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":10350,"group_ratio":1,"is_model_mapped":true,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
219	27	1769463895	2		github_27	hhh	claude-sonnet-4-5	80350	98892	309	15	t	2	\N	10	default		{"admin_info":{"use_channel":["2"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":11144,"group_ratio":1,"is_model_mapped":true,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
220	27	1769463953	2		github_27	hhh	z-ai/glm4.7	93950	116902	535	32	t	3	\N	10	default		{"admin_info":{"use_channel":["3"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":1,"frt":23004,"group_ratio":1,"is_system_prompt_overwritten":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","user_group_ratio":-1}
222	20	1769475416	4	用户签到，获得额度 ＄2.000000 额度	github_20			0	0	0	0	f	0	\N	0			
229	31	1769481697	4	用户签到，获得额度 ＄2.000000 额度	github_31			0	0	0	0	f	0	\N	0			
230	7	1769483181	4	用户签到，获得额度 ＄2.000000 额度	github_7			0	0	0	0	f	0	\N	0			
231	32	1769484414	4	新用户注册赠送 ＄20.000000 额度	github_32			0	0	0	0	f	0	\N	0			
232	32	1769484414	4	使用邀请码赠送 ＄20.000000 额度	github_32			0	0	0	0	f	0	\N	0			
233	3	1769484414	4	邀请用户赠送 ＄20.000000 额度	github_3			0	0	0	0	f	0	\N	0			
234	32	1769484441	4	用户签到，获得额度 ＄2.000000 额度	github_32			0	0	0	0	f	0	\N	0			
235	32	1769484828	2		github_32	playground-default	claude-sonnet-4-5	119	49	20	15	t	1	\N	0	default		{"admin_info":{"use_channel":["1"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":14235,"group_ratio":1,"is_model_mapped":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/pg/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
236	1	1769486304	2		liuliang	playground-default	claude-sonnet-4-5	172	30	37	1	t	2	\N	0	default		{"admin_info":{"use_channel":["2"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":1277,"group_ratio":1,"is_model_mapped":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/pg/chat/completions","upstream_model_name":"minimaxai/minimax-m2.1","user_group_ratio":-1}
237	8	1769488462	4	用户签到，获得额度 ＄2.000000 额度	github_8			0	0	0	0	f	0	\N	0			
238	12	1769489421	4	用户签到，获得额度 ＄2.000000 额度	github_12			0	0	0	0	f	0	\N	0			
239	1	1769502309	4	用户签到，获得额度 ＄2.000000 额度	liuliang			0	0	0	0	f	0	\N	0			
240	33	1769502552	4	新用户注册赠送 ＄20.000000 额度	github_33			0	0	0	0	f	0	\N	0			
241	34	1769502867	4	新用户注册赠送 ＄20.000000 额度	github_34			0	0	0	0	f	0	\N	0			
242	34	1769502867	4	使用邀请码赠送 ＄20.000000 额度	github_34			0	0	0	0	f	0	\N	0			
243	1	1769502867	4	邀请用户赠送 ＄20.000000 额度	liuliang			0	0	0	0	f	0	\N	0			
244	34	1769502873	4	用户签到，获得额度 ＄2.000000 额度	github_34			0	0	0	0	f	0	\N	0			
245	35	1769503026	4	新用户注册赠送 ＄20.000000 额度	github_35			0	0	0	0	f	0	\N	0			
246	35	1769503026	4	使用邀请码赠送 ＄20.000000 额度	github_35			0	0	0	0	f	0	\N	0			
247	3	1769503026	4	邀请用户赠送 ＄20.000000 额度	github_3			0	0	0	0	f	0	\N	0			
248	1	1769509833	2	模型测试	liuliang	模型测试	llama-3.3-70b	37	36	10	0	f	4	\N	0	default		{"admin_info":{"use_channel":null},"cache_ratio":1,"cache_tokens":0,"completion_ratio":1,"frt":-1000,"group_ratio":1,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","user_group_ratio":-1}
249	1	1769509833	2	模型测试	liuliang	模型测试	qwen-3-235b-a22b-instruct-2507	17	9	12	0	f	4	\N	0	default		{"admin_info":{"use_channel":null},"cache_ratio":1,"cache_tokens":0,"completion_ratio":1,"frt":-1000,"group_ratio":1,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","user_group_ratio":-1}
250	1	1769509833	2	模型测试	liuliang	模型测试	zai-glm-4.7	18	6	16	0	f	4	\N	0	default		{"admin_info":{"use_channel":null},"cache_ratio":1,"cache_tokens":0,"completion_ratio":1,"frt":-1000,"group_ratio":1,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","user_group_ratio":-1}
251	1	1769509834	2	模型测试	liuliang	模型测试	gpt-oss-120b	80	68	16	0	f	4	\N	0	default		{"admin_info":{"use_channel":null},"cache_ratio":1,"cache_tokens":0,"completion_ratio":2,"frt":-1000,"group_ratio":1,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","user_group_ratio":-1}
252	1	1769509835	2	模型测试	liuliang	模型测试	llama3.1-8b	35	36	8	1	f	4	\N	0	default		{"admin_info":{"use_channel":null},"cache_ratio":1,"cache_tokens":0,"completion_ratio":1,"frt":-1000,"group_ratio":1,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","user_group_ratio":-1}
253	1	1769509836	2	模型测试	liuliang	模型测试	qwen-3-32b	20	9	16	0	f	4	\N	0	default		{"admin_info":{"use_channel":null},"cache_ratio":1,"cache_tokens":0,"completion_ratio":1,"frt":-1000,"group_ratio":1,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","user_group_ratio":-1}
254	1	1769510141	2	模型测试	liuliang	模型测试	gpt-oss-120b	80	68	16	0	f	5	\N	0	default		{"admin_info":{"use_channel":null},"cache_ratio":1,"cache_tokens":0,"completion_ratio":2,"frt":-1000,"group_ratio":1,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","user_group_ratio":-1}
255	1	1769510141	2	模型测试	liuliang	模型测试	qwen-3-235b-a22b-instruct-2507	17	9	12	0	f	5	\N	0	default		{"admin_info":{"use_channel":null},"cache_ratio":1,"cache_tokens":0,"completion_ratio":1,"frt":-1000,"group_ratio":1,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","user_group_ratio":-1}
256	1	1769510141	2	模型测试	liuliang	模型测试	zai-glm-4.7	18	6	16	0	f	5	\N	0	default		{"admin_info":{"use_channel":null},"cache_ratio":1,"cache_tokens":0,"completion_ratio":1,"frt":-1000,"group_ratio":1,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","user_group_ratio":-1}
257	1	1769510141	2	模型测试	liuliang	模型测试	llama-3.3-70b	37	36	10	0	f	5	\N	0	default		{"admin_info":{"use_channel":null},"cache_ratio":1,"cache_tokens":0,"completion_ratio":1,"frt":-1000,"group_ratio":1,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","user_group_ratio":-1}
258	1	1769510141	2	模型测试	liuliang	模型测试	llama3.1-8b	42	36	16	0	f	5	\N	0	default		{"admin_info":{"use_channel":null},"cache_ratio":1,"cache_tokens":0,"completion_ratio":1,"frt":-1000,"group_ratio":1,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","user_group_ratio":-1}
259	1	1769510142	2	模型测试	liuliang	模型测试	qwen-3-32b	20	9	16	0	f	5	\N	0	default		{"admin_info":{"use_channel":null},"cache_ratio":1,"cache_tokens":0,"completion_ratio":1,"frt":-1000,"group_ratio":1,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","user_group_ratio":-1}
260	1	1769510414	5	status_code=524, bad response status code 524	liuliang	playground-default	z-ai/glm4.7	0	0	0	0	f	2	\N	0	default		{"admin_info":{"use_channel":["2"]},"channel_id":2,"channel_name":"nvidia英伟达","channel_type":1,"error_code":"bad_response_status_code","error_type":"openai_error","request_path":"/pg/chat/completions","status_code":524}
261	1	1769510640	2	模型测试	liuliang	模型测试	zai-glm-4.7	18	6	16	0	f	5	\N	0	default		{"admin_info":{"use_channel":null},"cache_ratio":1,"cache_tokens":0,"completion_ratio":1,"frt":-1000,"group_ratio":1,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","user_group_ratio":-1}
262	1	1769510642	2	模型测试	liuliang	模型测试	llama3.1-8b	35	36	8	0	f	5	\N	0	default		{"admin_info":{"use_channel":null},"cache_ratio":1,"cache_tokens":0,"completion_ratio":1,"frt":-1000,"group_ratio":1,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","user_group_ratio":-1}
263	1	1769510650	2	模型测试	liuliang	模型测试	zai-glm-4.7	18	6	16	1	f	4	\N	0	default		{"admin_info":{"use_channel":null},"cache_ratio":1,"cache_tokens":0,"completion_ratio":1,"frt":-1000,"group_ratio":1,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","user_group_ratio":-1}
264	1	1769511231	2	模型测试	liuliang	模型测试	gpt-oss-120b	80	68	16	0	f	7	\N	0	default		{"admin_info":{"use_channel":null},"cache_ratio":1,"cache_tokens":0,"completion_ratio":2,"frt":-1000,"group_ratio":1,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","user_group_ratio":-1}
265	1	1769511231	2	模型测试	liuliang	模型测试	llama3.1-8b	35	36	8	0	f	7	\N	0	default		{"admin_info":{"use_channel":null},"cache_ratio":1,"cache_tokens":0,"completion_ratio":1,"frt":-1000,"group_ratio":1,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","user_group_ratio":-1}
266	1	1769511232	2	模型测试	liuliang	模型测试	llama-3.3-70b	42	36	16	0	f	7	\N	0	default		{"admin_info":{"use_channel":null},"cache_ratio":1,"cache_tokens":0,"completion_ratio":1,"frt":-1000,"group_ratio":1,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","user_group_ratio":-1}
267	1	1769511232	2	模型测试	liuliang	模型测试	qwen-3-235b-a22b-instruct-2507	17	9	12	0	f	7	\N	0	default		{"admin_info":{"use_channel":null},"cache_ratio":1,"cache_tokens":0,"completion_ratio":1,"frt":-1000,"group_ratio":1,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","user_group_ratio":-1}
268	1	1769511232	2	模型测试	liuliang	模型测试	qwen-3-32b	20	9	16	0	f	7	\N	0	default		{"admin_info":{"use_channel":null},"cache_ratio":1,"cache_tokens":0,"completion_ratio":1,"frt":-1000,"group_ratio":1,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","user_group_ratio":-1}
269	1	1769511234	2	模型测试	liuliang	模型测试	zai-glm-4.7	18	6	16	1	f	7	\N	0	default		{"admin_info":{"use_channel":null},"cache_ratio":1,"cache_tokens":0,"completion_ratio":1,"frt":-1000,"group_ratio":1,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","user_group_ratio":-1}
270	1	1769511241	2	模型测试	liuliang	模型测试	claude-sonnet-4-5	69	6	16	0	f	7	\N	0	default		{"admin_info":{"use_channel":null},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":-1000,"group_ratio":1,"is_model_mapped":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"zai-glm-4.7","user_group_ratio":-1}
271	1	1769511248	2	模型测试	liuliang	模型测试	claude-sonnet-4-5	69	6	16	0	f	7	\N	0	default		{"admin_info":{"use_channel":null},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":-1000,"group_ratio":1,"is_model_mapped":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"zai-glm-4.7","user_group_ratio":-1}
272	1	1769511256	2	模型测试	liuliang	模型测试	gpt-oss-120b	80	68	16	0	f	6	\N	0	default		{"admin_info":{"use_channel":null},"cache_ratio":1,"cache_tokens":0,"completion_ratio":2,"frt":-1000,"group_ratio":1,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","user_group_ratio":-1}
273	1	1769511256	2	模型测试	liuliang	模型测试	qwen-3-235b-a22b-instruct-2507	17	9	12	0	f	6	\N	0	default		{"admin_info":{"use_channel":null},"cache_ratio":1,"cache_tokens":0,"completion_ratio":1,"frt":-1000,"group_ratio":1,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","user_group_ratio":-1}
274	1	1769511256	2	模型测试	liuliang	模型测试	qwen-3-32b	20	9	16	0	f	6	\N	0	default		{"admin_info":{"use_channel":null},"cache_ratio":1,"cache_tokens":0,"completion_ratio":1,"frt":-1000,"group_ratio":1,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","user_group_ratio":-1}
276	1	1769511256	2	模型测试	liuliang	模型测试	llama-3.3-70b	37	36	10	0	f	6	\N	0	default		{"admin_info":{"use_channel":null},"cache_ratio":1,"cache_tokens":0,"completion_ratio":1,"frt":-1000,"group_ratio":1,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","user_group_ratio":-1}
277	1	1769511257	2	模型测试	liuliang	模型测试	zai-glm-4.7	18	6	16	0	f	6	\N	0	default		{"admin_info":{"use_channel":null},"cache_ratio":1,"cache_tokens":0,"completion_ratio":1,"frt":-1000,"group_ratio":1,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","user_group_ratio":-1}
278	1	1769511262	2	模型测试	liuliang	模型测试	claude-sonnet-4-5	69	6	16	0	f	6	\N	0	default		{"admin_info":{"use_channel":null},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":-1000,"group_ratio":1,"is_model_mapped":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","upstream_model_name":"zai-glm-4.7","user_group_ratio":-1}
275	1	1769511256	2	模型测试	liuliang	模型测试	llama3.1-8b	42	36	16	0	f	6	\N	0	default		{"admin_info":{"use_channel":null},"cache_ratio":1,"cache_tokens":0,"completion_ratio":1,"frt":-1000,"group_ratio":1,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/v1/chat/completions","user_group_ratio":-1}
279	1	1769511324	2		liuliang	playground-default	zai-glm-4.7	144	6	174	1	t	6	\N	0	default		{"admin_info":{"use_channel":["6"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":1,"frt":266,"group_ratio":1,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/pg/chat/completions","user_group_ratio":-1}
280	1	1769511353	2		liuliang	playground-default	zai-glm-4.7	1210	68	1444	6	t	6	\N	0	default		{"admin_info":{"use_channel":["6"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":1,"frt":259,"group_ratio":1,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/pg/chat/completions","user_group_ratio":-1}
281	1	1769511390	2		liuliang	playground-default	claude-sonnet-4-5	581	6	144	1	t	6	\N	0	default		{"admin_info":{"use_channel":["6"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":285,"group_ratio":1,"is_model_mapped":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/pg/chat/completions","upstream_model_name":"zai-glm-4.7","user_group_ratio":-1}
282	1	1769511403	2		liuliang	playground-default	llama-3.3-70b	39	37	12	1	t	6	\N	0	default		{"admin_info":{"use_channel":["6"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":1,"frt":328,"group_ratio":1,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/pg/chat/completions","user_group_ratio":-1}
283	1	1769511414	2		liuliang	playground-default	claude-sonnet-4-5	633	6	157	1	t	6	\N	0	default		{"admin_info":{"use_channel":["6"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":280,"group_ratio":1,"is_model_mapped":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/pg/chat/completions","upstream_model_name":"zai-glm-4.7","user_group_ratio":-1}
284	1	1769511525	2		liuliang	playground-default	claude-sonnet-4-5	1182	22	291	1	t	6	\N	0	default		{"admin_info":{"use_channel":["6"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":283,"group_ratio":1,"is_model_mapped":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/pg/chat/completions","upstream_model_name":"zai-glm-4.7","user_group_ratio":-1}
285	1	1769511538	2		liuliang	playground-default	claude-sonnet-4-5	286	22	67	1	t	6	\N	0	default		{"admin_info":{"use_channel":["6"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":282,"group_ratio":1,"is_model_mapped":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/pg/chat/completions","upstream_model_name":"zai-glm-4.7","user_group_ratio":-1}
286	1	1769511544	2		liuliang	playground-default	claude-sonnet-4-5	520	40	122	0	t	6	\N	0	default		{"admin_info":{"use_channel":["6"]},"cache_ratio":1,"cache_tokens":0,"completion_ratio":5,"frt":285,"group_ratio":1,"is_model_mapped":true,"model_price":-1,"model_ratio":0.8,"request_conversion":["OpenAI Compatible"],"request_path":"/pg/chat/completions","upstream_model_name":"zai-glm-4.7","user_group_ratio":-1}
\.


--
-- Data for Name: midjourneys; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.midjourneys (id, code, user_id, action, mj_id, prompt, prompt_en, description, state, submit_time, start_time, finish_time, image_url, video_url, video_urls, status, progress, fail_reason, channel_id, quota, buttons, properties) FROM stdin;
\.


--
-- Data for Name: models; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.models (id, model_name, description, icon, tags, vendor_id, endpoints, status, sync_official, created_time, updated_time, deleted_at, name_rule) FROM stdin;
\.


--
-- Data for Name: options; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.options (key, value) FROM stdin;
SelfUseModeEnabled	false
DemoSiteEnabled	false
general_setting.docs_link	https://ai.facai.cloudns.org/claude-code-guide.html
ServerAddress	https://ai.facai.cloudns.org
PasswordRegisterEnabled	false
passkey.enabled	true
passkey.rp_id	ai.facai.cloudns.org
passkey.rp_display_name	ai发财
passkey.user_verification	preferred
passkey.origins	
passkey.attachment_preference	
LinuxDOClientSecret	wF4WV2N1qfVsiQhzcPrYjzFgoi9P1hPO
LinuxDOClientId	cqwvaDZRRfca8CUhxHhoi6SAq2WkUf0i
GitHubClientSecret	18a37482b966fc40a4c622564d9062c4dcd7677b
GitHubClientId	Iv23liNR6C0LFU7uS5r6
GitHubOAuthEnabled	true
Logo	https://bbs.weiququ.cn/favicon.ico
SystemName	ai发财网
Footer	加作者微信入群：aimiertao
RetryTimes	3
checkin_setting.enabled	true
checkin_setting.min_quota	1000000
QuotaForInviter	10000000
QuotaForInvitee	10000000
QuotaForNewUser	10000000
About	----\n**ai发财网， 所有模型官方直链，稳的一逼**\n----
Notice	**欢迎来到【ai发财】ai中转站**\n\n--------------【请合理、珍惜使用免费公益】-------------\n\n--------------【请合理、珍惜使用免费公益】-------------\n- 本站所有模型都来自于官方直连\n- 欢迎扫码加入本站官方群，获取一手资源\n![图片](https://img.liangzheng.cloudns.org/file/AgACAgUAAyEGAATmPyMGAAMGaXbgFY6ytZ1Zi7U8Mnsox18tGkEAAtQOaxu7t7FXss_khb9j3P0BAAMCAANtAAM4BA.png?t=2f4bcb97-2281-8083-bed5-c22190288416)
ModelRatio	{\n    "360GPT_S2_V9": 0.8572,\n    "360gpt-pro": 0.8572,\n    "360gpt-turbo": 0.0858,\n    "360gpt-turbo-responsibility-8k": 0.8572,\n    "360gpt2-pro": 0.8572,\n    "BLOOMZ-7B": 0.273972602739726,\n    "ERNIE-3.5-4K-0205": 0.821917808219178,\n    "ERNIE-3.5-8K": 0.821917808219178,\n    "ERNIE-3.5-8K-0205": 1.643835616438356,\n    "ERNIE-3.5-8K-1222": 0.821917808219178,\n    "ERNIE-4.0-8K": 8.219178082191782,\n    "ERNIE-Bot-8K": 1.643835616438356,\n    "ERNIE-Lite-8K-0308": 0.2054794520547945,\n    "ERNIE-Lite-8K-0922": 0.547945205479452,\n    "ERNIE-Speed-128K": 0.273972602739726,\n    "ERNIE-Speed-8K": 0.273972602739726,\n    "ERNIE-Tiny-8K": 0.0684931506849315,\n    "Embedding-V1": 0.136986301369863,\n    "NousResearch/Hermes-4-405B-FP8": 0.8,\n    "PaLM-2": 1,\n    "Qwen/Qwen3-235B-A22B-Instruct-2507": 0.3,\n    "Qwen/Qwen3-235B-A22B-Thinking-2507": 0.6,\n    "Qwen/Qwen3-Coder-480B-A35B-Instruct-FP8": 0.8,\n    "SparkDesk-v1.1": 1.2858,\n    "SparkDesk-v2.1": 1.2858,\n    "SparkDesk-v3.1": 1.2858,\n    "SparkDesk-v3.5": 1.2858,\n    "SparkDesk-v4.0": 1.2858,\n    "ada": 10,\n    "babbage": 10,\n    "babbage-002": 0.2,\n    "bge-large-en": 0.136986301369863,\n    "bge-large-zh": 0.136986301369863,\n    "chatglm_lite": 0.1429,\n    "chatglm_pro": 0.7143,\n    "chatglm_std": 0.3572,\n    "chatglm_turbo": 0.3572,\n    "chatgpt-4o-latest": 2.5,\n    "claude-2.0": 4,\n    "claude-2.1": 4,\n    "claude-3-5-haiku-20241022": 0.5,\n    "claude-3-5-sonnet-20240620": 1.5,\n    "claude-3-5-sonnet-20241022": 1.5,\n    "claude-3-7-sonnet-20250219": 1.5,\n    "claude-3-7-sonnet-20250219-thinking": 1.5,\n    "claude-3-haiku-20240307": 0.125,\n    "claude-3-opus-20240229": 7.5,\n    "claude-3-sonnet-20240229": 1.5,\n    "claude-haiku-4-5-20251001": 0.5,\n    "claude-instant-1": 0.4,\n    "claude-opus-4-1-20250805": 7.5,\n    "claude-opus-4-20250514": 7.5,\n    "claude-opus-4-5-20251101": 2.5,\n    "claude-sonnet-4-20250514": 1.5,\n    "claude-sonnet-4-5-20250929": 1.5,\n    "code-davinci-edit-001": 10,\n    "command": 0.5,\n    "command-light": 0.5,\n    "command-light-nightly": 0.5,\n    "command-nightly": 0.5,\n    "command-r": 0.25,\n    "command-r-08-2024": 0.075,\n    "command-r-plus": 1.5,\n    "command-r-plus-08-2024": 1.25,\n    "curie": 10,\n    "davinci": 10,\n    "davinci-002": 1,\n    "deepseek-ai/DeepSeek-R1": 0.8,\n    "deepseek-ai/DeepSeek-R1-0528": 0.8,\n    "deepseek-ai/DeepSeek-V3-0324": 0.8,\n    "deepseek-ai/DeepSeek-V3.1": 0.8,\n    "deepseek-chat": 0.135,\n    "deepseek-coder": 0.135,\n    "deepseek-reasoner": 0.275,\n    "embedding-bert-512-v1": 0.0715,\n    "embedding_s1_v1": 0.0715,\n    "gemini-1.5-flash-latest": 0.075,\n    "gemini-1.5-pro-latest": 1.25,\n    "gemini-2.0-flash": 0.05,\n    "gemini-2.5-flash": 0.15,\n    "gemini-2.5-flash-lite-preview-06-17": 0.05,\n    "gemini-2.5-flash-lite-preview-thinking-*": 0.05,\n    "gemini-2.5-flash-preview-04-17": 0.075,\n    "gemini-2.5-flash-preview-04-17-nothinking": 0.075,\n    "gemini-2.5-flash-preview-04-17-thinking": 0.075,\n    "gemini-2.5-flash-preview-05-20": 0.075,\n    "gemini-2.5-flash-preview-05-20-nothinking": 0.075,\n    "gemini-2.5-flash-preview-05-20-thinking": 0.075,\n    "gemini-2.5-flash-thinking-*": 0.075,\n    "gemini-2.5-pro": 0.625,\n    "gemini-2.5-pro-exp-03-25": 0.625,\n    "gemini-2.5-pro-preview-03-25": 0.625,\n    "gemini-2.5-pro-thinking-*": 0.625,\n    "gemini-embedding-001": 0.075,\n    "gemini-robotics-er-1.5-preview": 0.15,\n    "glm-3-turbo": 0.3572,\n    "glm-4": 7.143,\n    "glm-4-0520": 6.8493150684931505,\n    "glm-4-air": 0.0684931506849315,\n    "glm-4-airx": 0.684931506849315,\n    "glm-4-alltools": 6.8493150684931505,\n    "glm-4-flash": 0,\n    "glm-4-long": 0.0684931506849315,\n    "glm-4-plus": 3.4246575342465753,\n    "glm-4v": 3.4246575342465753,\n    "glm-4v-plus": 0.684931506849315,\n    "gpt-3.5-turbo": 0.25,\n    "gpt-3.5-turbo-0125": 0.25,\n    "gpt-3.5-turbo-0613": 0.75,\n    "gpt-3.5-turbo-1106": 0.5,\n    "gpt-3.5-turbo-16k": 1.5,\n    "gpt-3.5-turbo-16k-0613": 1.5,\n    "gpt-3.5-turbo-instruct": 0.75,\n    "gpt-4": 15,\n    "gpt-4-0125-preview": 5,\n    "gpt-4-0613": 15,\n    "gpt-4-1106-preview": 5,\n    "gpt-4-1106-vision-preview": 5,\n    "gpt-4-32k": 30,\n    "gpt-4-32k-0613": 30,\n    "gpt-4-all": 15,\n    "gpt-4-gizmo-*": 15,\n    "gpt-4-turbo": 5,\n    "gpt-4-turbo-2024-04-09": 5,\n    "gpt-4-turbo-preview": 5,\n    "gpt-4-vision-preview": 5,\n    "gpt-4.1": 1,\n    "gpt-4.1-2025-04-14": 1,\n    "gpt-4.1-mini": 0.2,\n    "gpt-4.1-mini-2025-04-14": 0.2,\n    "gpt-4.1-nano": 0.05,\n    "gpt-4.1-nano-2025-04-14": 0.05,\n    "gpt-4.5-preview": 37.5,\n    "gpt-4.5-preview-2025-02-27": 37.5,\n    "gpt-4o": 1.25,\n    "gpt-4o-2024-05-13": 2.5,\n    "gpt-4o-2024-08-06": 1.25,\n    "gpt-4o-2024-11-20": 1.25,\n    "gpt-4o-all": 15,\n    "gpt-4o-audio-preview": 1.25,\n    "gpt-4o-audio-preview-2024-10-01": 1.25,\n    "gpt-4o-gizmo-*": 2.5,\n    "gpt-4o-mini": 0.075,\n    "gpt-4o-mini-2024-07-18": 0.075,\n    "gpt-4o-mini-realtime-preview": 0.3,\n    "gpt-4o-mini-realtime-preview-2024-12-17": 0.3,\n    "gpt-4o-realtime-preview": 2.5,\n    "gpt-4o-realtime-preview-2024-10-01": 2.5,\n    "gpt-4o-realtime-preview-2024-12-17": 2.5,\n    "gpt-5": 0.625,\n    "gpt-5-2025-08-07": 0.625,\n    "gpt-5-chat-latest": 0.625,\n    "gpt-5-mini": 0.125,\n    "gpt-5-mini-2025-08-07": 0.125,\n    "gpt-5-nano": 0.025,\n    "gpt-5-nano-2025-08-07": 0.025,\n    "gpt-image-1": 2.5,\n    "grok-2": 1,\n    "grok-2-vision": 1,\n    "grok-3-beta": 1.5,\n    "grok-3-fast-beta": 2.5,\n    "grok-3-mini-beta": 0.15,\n    "grok-3-mini-fast-beta": 0.3,\n    "grok-beta": 2.5,\n    "grok-vision-beta": 2.5,\n    "hunyuan": 7.143,\n    "llama-3-sonar-large-32k-chat": 0,\n    "llama-3-sonar-large-32k-online": 0,\n    "llama-3-sonar-small-32k-chat": 0.1,\n    "llama-3-sonar-small-32k-online": 0.1,\n    "o1": 7.5,\n    "o1-2024-12-17": 7.5,\n    "o1-mini": 0.55,\n    "o1-mini-2024-09-12": 0.55,\n    "o1-preview": 7.5,\n    "o1-preview-2024-09-12": 7.5,\n    "o1-pro": 75,\n    "o1-pro-2025-03-19": 75,\n    "o3": 1,\n    "o3-2025-04-16": 1,\n    "o3-deep-research": 5,\n    "o3-deep-research-2025-06-26": 5,\n    "o3-mini": 0.55,\n    "o3-mini-2025-01-31": 0.55,\n    "o3-mini-2025-01-31-high": 0.55,\n    "o3-mini-2025-01-31-low": 0.55,\n    "o3-mini-2025-01-31-medium": 0.55,\n    "o3-mini-high": 0.55,\n    "o3-mini-low": 0.55,\n    "o3-mini-medium": 0.55,\n    "o3-pro": 10,\n    "o3-pro-2025-06-10": 10,\n    "o4-mini": 0.55,\n    "o4-mini-2025-04-16": 0.55,\n    "o4-mini-deep-research": 1,\n    "o4-mini-deep-research-2025-06-26": 1,\n    "openai/gpt-oss-120b": 0.5,\n    "qwen-plus": 10,\n    "qwen-turbo": 0.8572,\n    "semantic_similarity_s1_v1": 0.0715,\n    "tao-8k": 0.136986301369863,\n    "text-ada-001": 0.2,\n    "text-babbage-001": 0.25,\n    "text-curie-001": 1,\n    "text-davinci-edit-001": 10,\n    "text-embedding-004": 0.001,\n    "text-embedding-3-large": 0.065,\n    "text-embedding-3-small": 0.01,\n    "text-embedding-ada-002": 0.05,\n    "text-embedding-v1": 0.05,\n    "text-moderation-latest": 0.1,\n    "text-moderation-stable": 0.1,\n    "text-search-ada-doc-001": 10,\n    "tts-1": 7.5,\n    "tts-1-1106": 7.5,\n    "tts-1-hd": 15,\n    "tts-1-hd-1106": 15,\n    "whisper-1": 15,\n    "yi-34b-chat-0205": 0.18,\n    "yi-34b-chat-200k": 0.864,\n    "yi-large": 1.36986301369863,\n    "yi-large-preview": 1.36986301369863,\n    "yi-large-rag": 1.7123287671232876,\n    "yi-large-rag-preview": 1.7123287671232876,\n    "yi-large-turbo": 0.821917808219178,\n    "yi-medium": 0.17123287671232876,\n    "yi-medium-200k": 0.821917808219178,\n    "yi-spark": 0.0684931506849315,\n    "yi-vision": 0.410958904109589,\n    "yi-vl-plus": 0.432,\n    "zai-org/GLM-4.5-FP8": 0.8,\n    "z-ai/glm4.7": 0.8,\n    "claude-sonnet-4-5": 0.8,\n    "minimaxai/minimax-m2.1": 0.8,\n    "deepseek-ai/deepseek-r1-distill-qwen-32b": 0.8,\n    "deepseek-ai/deepseek-coder-6.7b-instruct": 0.8,\n    "zai-glm-4.7": 0.8,\n    "llama3.1-8b": 0.8,\n    "llama-3.3-70b": 0.8,\n    "gpt-oss-120b": 0.8,\n    "qwen-3-235b-a22b-instruct-2507": 0.8,\n    "qwen-3-32b": 0.8\n}
\.


--
-- Data for Name: passkey_credentials; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.passkey_credentials (id, user_id, credential_id, public_key, attestation_type, aa_guid, sign_count, clone_warning, user_present, user_verified, backup_eligible, backup_state, transports, attachment, last_used_at, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: prefill_groups; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.prefill_groups (id, name, type, items, description, created_time, updated_time, deleted_at) FROM stdin;
\.


--
-- Data for Name: quota_data; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.quota_data (id, user_id, username, model_name, created_at, token_used, count, quota) FROM stdin;
1	1	liuliang	openai/gpt-oss-120b	1769353200	492	6	246
3	1	liuliang	deepseek-ai/deepseek-r1-distill-qwen-32b	1769353200	44	2	36
2	1	liuliang	z-ai/glm4.7	1769353200	66	3	54
5	1	liuliang	claude-sonnet-4-5	1769353200	22	1	69
4	1	liuliang	minimaxai/minimax-m2.1	1769353200	110	2	88
6	1	liuliang	minimaxai/minimax-m2.1	1769400000	75	1	60
7	1	liuliang	claude-sonnet-4-5	1769400000	65	1	164
8	3	github_3	minimaxai/minimax-m2.1	1769400000	79	1	63
9	3	github_3	claude-sonnet-4-5	1769400000	66	1	168
10	24	github_24	claude-sonnet-4-5	1769410800	490	2	1681
11	24	github_24	claude-sonnet-4-5	1769414400	525	1	1156
12	3	github_3	minimaxai/minimax-m2.1	1769432400	17138	1	13710
13	3	github_3	z-ai/glm4.7	1769432400	21403	14	17116
14	1	liuliang	minimaxai/minimax-m2.1	1769432400	55	1	44
15	1	liuliang	openai/gpt-oss-120b	1769432400	82	1	41
16	1	liuliang	deepseek-ai/deepseek-r1-distill-qwen-32b	1769432400	22	1	18
17	29	github_29	claude-sonnet-4-5	1769436000	385	1	759
18	27	github_27	claude-sonnet-4-5	1769439600	2377748	52	1940205
19	28	github_28	claude-sonnet-4-5	1769457600	38469	3	35650
20	27	github_27	claude-sonnet-4-5	1769461200	1221829	12	987248
21	27	github_27	z-ai/glm4.7	1769461200	235326	2	188261
22	32	github_32	claude-sonnet-4-5	1769482800	69	1	119
23	1	liuliang	claude-sonnet-4-5	1769482800	67	1	172
28	1	liuliang	llama3.1-8b	1769508000	236	5	189
24	1	liuliang	llama-3.3-70b	1769508000	239	5	192
25	1	liuliang	qwen-3-235b-a22b-instruct-2507	1769508000	84	4	68
29	1	liuliang	qwen-3-32b	1769508000	100	4	80
26	1	liuliang	zai-glm-4.7	1769508000	1824	8	1462
27	1	liuliang	gpt-oss-120b	1769508000	336	4	320
30	1	liuliang	claude-sonnet-4-5	1769508000	943	8	3409
\.


--
-- Data for Name: redemptions; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.redemptions (id, user_id, key, status, name, quota, created_time, redeemed_time, used_user_id, deleted_at, expired_time) FROM stdin;
1	1	734a1885f76c4e788f88aa3729dc8930	1	11111	50000000	1769502993	0	0	\N	1801298167
2	1	802c7143649d4beb9019b121ccf8302f	1	11111	50000000	1769502993	0	0	\N	1801298167
3	1	79c44b49007245159c3765575d0e47df	1	11111	50000000	1769502993	0	0	\N	1801298167
4	1	ee620d046892445eaaca2233dfa87a7b	1	11111	50000000	1769502993	0	0	\N	1801298167
5	1	e64f669fbb5d45b5b8950ac4c0df0431	1	11111	50000000	1769502993	0	0	\N	1801298167
6	1	ad788de21819480397956d66247969a6	1	11111	50000000	1769502993	0	0	\N	1801298167
7	1	bf340aaddaa3413cb6986d95bc5bdfdf	1	11111	50000000	1769502993	0	0	\N	1801298167
8	1	1d03c6e0cd764ecba89dfc018c3ed419	1	11111	50000000	1769502993	0	0	\N	1801298167
9	1	cf130c9bc9bb4fa4aae44ca58e4ede81	1	11111	50000000	1769502993	0	0	\N	1801298167
10	1	4cdea8a6f807407a8e5102719b486f9c	1	11111	50000000	1769502993	0	0	\N	1801298167
\.


--
-- Data for Name: setups; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.setups (id, version, initialized_at) FROM stdin;
1	v1.0.0	1769346702
\.


--
-- Data for Name: tasks; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.tasks (id, created_at, updated_at, task_id, platform, user_id, "group", channel_id, quota, action, status, fail_reason, submit_time, start_time, finish_time, progress, properties, private_data, data) FROM stdin;
\.


--
-- Data for Name: tokens; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.tokens (id, user_id, key, status, name, created_time, accessed_time, expired_time, remain_quota, unlimited_quota, model_limits_enabled, model_limits, allow_ips, used_quota, "group", cross_group_retry, deleted_at) FROM stdin;
15	32	UMkySVOf5UsuI8r9bIiOUv4vuM3nkvVeFWtEstHW7nzMGZvP	1	朱双林	1769484476	1769484476	-1	0	t	f			0	default	f	\N
2	5	lwmbl4P0n95GOzo0xUlDS3ljjBFHfvlRyCcYNb0FFOLylnbo	1	admin1	1769402371	1769402371	-1	0	t	f			0	default	f	\N
3	17	KV8Qvl3xKatXV0YFErMZHW7buOF04OE0UKz6cXfk3lktA3JD	1	facai-key	1769406335	1769406335	-1	0	t	f			0		f	\N
4	19	fbDON6oMR7ZlJ6zNWYVX0iuoFUAbQRXodihdHqvlGoVV93vH	1	分威风	1769407148	1769407148	-1	0	t	f			0		f	\N
5	20	I2WLzwN088fZbkUC1lDO6ZC6Tq9m4gRudlVaVQ0ujYDJnpd9	1	分为	1769407210	1769407210	-1	0	t	f			0		f	\N
6	21	Sr3xPdk48ILcAg3gIWVLJH9HOJpKsaM1SMdE1mzASNYQ5ykF	1	分为	1769407279	1769407279	-1	0	t	f			0		f	\N
7	24	SjP7mVKC8Yf7EnJepLtX5Fsq2r82opXnDa9gtMCJBvAAwHuf	1	wps	1769412434	1769412434	-1	0	t	t	claude-sonnet-4-5		0		f	\N
8	1	ifzkEOo0PDnugj3zvOyFWq0YnuMrDRK9AkgDpCJpyTFhriLr	1	11	1769432560	1769432560	-1	0	t	f			0		f	\N
11	28	wY7pJewIgionbzXlZRZpUpxLkkQ8NLMDTgQUtJj36lbemHDn	1	hhh	1769459121	1769459121	-1	0	t	f			0	vip	f	\N
12	28	75dSUYWSLJHssOSjeOW5Wij0H7wtmP7Na4iADYw4oJI44H9N	1	hhh	1769459362	1769459453	-1	-35650	t	f			35650	default	f	\N
1	3	JQzWJH7sFx1kvUP0LievOg76YSJQT5SYmAqW5CgjnPYd1lmf	1	11	1769401452	1769432968	-1	-30826	t	f			30826		f	\N
9	29	DxqEXu9395rCFWiiqf8wDsutc8NgQVe8pmMGx2oEgDQRwk5n	1	aa	1769437191	1769437191	-1	0	t	f			0	vip	f	\N
10	27	ascX4MdCYF3Y6ZRR8C3yMEoTDsDnWrJRb901q9TwIeigp27r	1	hhh	1769440865	1769463999	-1	-3115714	t	f			3115714	default	f	\N
13	30	juEeg1juX49FaCsYFbQdJoNPsCyIMCbeLpqAAfvTrfRLfOly	1	demo	1769478730	1769478730	-1	0	t	f			0		f	\N
14	31	I9xfqlPcXQlq3iA9LElpctV4Ct1oOEHQqArH85i5BIkvTvwo	1	1	1769481727	1769481727	-1	0	t	f			0	default	f	\N
\.


--
-- Data for Name: top_ups; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.top_ups (id, user_id, amount, money, trade_no, payment_method, create_time, complete_time, status) FROM stdin;
\.


--
-- Data for Name: two_fa_backup_codes; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.two_fa_backup_codes (id, user_id, code_hash, is_used, used_at, created_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: two_fas; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.two_fas (id, user_id, secret, is_enabled, failed_attempts, locked_until, last_used_at, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.users (id, username, password, display_name, role, status, email, github_id, discord_id, oidc_id, wechat_id, telegram_id, access_token, quota, used_quota, request_count, "group", aff_code, aff_count, aff_quota, aff_history, inviter_id, deleted_at, linux_do_id, setting, remark, stripe_customer) FROM stdin;
2	github_2		GitHub User	1	1		liuliang520530					\N	0	0	0	default	nTaV	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
5	github_5		XiaoYang	1	1		3351163616					\N	3000000	0	0	default	b5uQ	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
6	github_6		keggin	1	1		keggin-CHN					\N	2000000	0	0	default	C95h	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
10	github_10		GitHub User	1	1		shuffleJie					\N	2000000	0	0	default	CrE3	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
4	github_4		GitHub User	1	1		xiaopenghuang					\N	3000000	0	0	default	SqrH	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
14	github_14		GitHub User	1	1		yzh886306-lgtm					\N	3000000	0	0	default	s5FR	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
8	github_8		GitHub User	1	1		maroubao					wNLYsdmX6dUpHdNV0y9Nulrd88fT    	4000000	0	0	default	yJc7	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
13	github_13		GitHub User	1	1		DrewXM30					\N	2000000	0	0	default	fLGw	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
9	github_9		GitHub User	1	1		shanzhongxue1					\N	3000000	0	0	default	vKyU	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
11	github_11		GitHub User	1	1		BruceLQX					\N	2000000	0	0	default	6lPp	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
15	github_15		SilenceShine	1	1		SilenceShine					\N	3000000	0	0	default	Dwqr	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
7	github_7		LDXW	1	1	19166155754@163.com	End-Huang					zbU7hN5jlQbcexIsX5CNVioPZP1QaYU=	4000000	0	0	default	J0Lv	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
16	github_16		浪子	1	1	jkjoy@live.cn	jkjoy					\N	2000000	0	0	default	SsKO	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
1	liuliang	$2a$10$8FVdTgOYPTyZt8fmAnEQbuOF63AjzSTupUysoiQ1M1x432mfkVgK.	Root User	100	1							\N	100995009	4991	11	default	08no	1	10000000	10000000	0	\N				
12	github_12		GitHub User	1	1		Kakezh					bZXnGqi/lMHvH3zCdyVA+iNewDhB    	4000000	0	0	default	Fl6F	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
3	github_3		liuliangzheng	1	1		liuliang520500					\N	9974218	31057	17	default	Uyzg	20	1064000000	1064000000	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
17	github_17		GitHub User	1	1		bibc123456					\N	2000000	0	0	default	m8dq	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
18	github_18		GitHub User	1	1		mochen125435					\N	1000000	0	0	default	HwMg	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
24	github_24		GitHub User	1	1		javasec2025-afk					\N	20009971	2837	3	default	wZHa	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
19	github_19		GitHub User	1	1		meer12347					TZuXnS5QP7hIGYm8CqU/qCvSDcklqw==	2000000	0	0	default	ZPSO	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
23	github_23		NetLops	1	1		NetLops					\N	3000000	0	0	default	8P0V	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
25	github_25		GitHub User	1	1		czc7874					\N	22000000	0	0	default	02TB	1	10000000	10000000	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
22	github_22		Yinghong Chen	1	1		335812350					\N	2000000	0	0	default	WynK	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
28	github_28		GitHub User	1	1		realc0unterki1lls-dev					\N	20964350	35650	3	default	6YMW	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
27	github_27		GitHub User	1	1		Tipner					\N	17884286	3115714	66	default	6SaD	1	0	10000000	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
20	github_20		GitHub User	1	1		meerlov					PH5zaH/8HqldL9snYBsCL92GAyeLz7LM	3000000	0	0	default	Nesd	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
21	github_21		GitHub User	1	1		sonlia					LKX4Cu7yVEIOsFcSaqx8x6eipPl0i5c=	3000000	0	0	default	EWo7	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
26	github_26		你算哪根聪	1	1		ZhcChen					\N	22000000	0	0	default	bpFN	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
29	github_29		zzw	1	1	zxwxiao@hotmail.com	skyooo					\N	19999241	759	1	default	Fsiq	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
30	github_30		PayNeXC	1	1		paynexss					\N	21000000	0	0	default	Tndt	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
31	github_31		mwdotzom	1	1		mwdotzom					\N	11000000	0	0	default	VVwM	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
32	github_32		zrg042@163.com 	1	1	zrg042@163.com	zhu-042					\N	20999881	119	1	default	lBo2	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
33	github_33		云深	1	1		lkj194886					\N	10000000	0	0	default	p50k	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
34	github_34		JinMing Guo	1	1	tdouguo@gmail.com	tdouguo					\N	21000000	0	0	default	ApXz	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
35	github_35		GitHub User	1	1		liangmaoq					\N	20000000	0	0	default	tAHC	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
\.


--
-- Data for Name: vendors; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.vendors (id, name, description, icon, status, created_time, updated_time, deleted_at) FROM stdin;
1	OpenAI		OpenAI	1	1769399304	1769399304	\N
2	DeepSeek		DeepSeek.Color	1	1769399304	1769399304	\N
3	Anthropic		Claude.Color	1	1769399304	1769399304	\N
4	阿里巴巴		Qwen.Color	1	1769402419	1769402419	\N
5	智谱		Zhipu.Color	1	1769510771	1769510771	\N
6	Meta		Ollama	1	1769510771	1769510771	\N
\.


--
-- Name: channels_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.channels_id_seq', 7, true);


--
-- Name: checkins_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.checkins_id_seq', 32, true);


--
-- Name: logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.logs_id_seq', 286, true);


--
-- Name: midjourneys_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.midjourneys_id_seq', 1, false);


--
-- Name: models_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.models_id_seq', 1, false);


--
-- Name: passkey_credentials_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.passkey_credentials_id_seq', 1, false);


--
-- Name: prefill_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.prefill_groups_id_seq', 1, false);


--
-- Name: quota_data_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.quota_data_id_seq', 30, true);


--
-- Name: redemptions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.redemptions_id_seq', 10, true);


--
-- Name: setups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.setups_id_seq', 1, true);


--
-- Name: tasks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.tasks_id_seq', 1, false);


--
-- Name: tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.tokens_id_seq', 15, true);


--
-- Name: top_ups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.top_ups_id_seq', 1, false);


--
-- Name: two_fa_backup_codes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.two_fa_backup_codes_id_seq', 1, false);


--
-- Name: two_fas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.two_fas_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.users_id_seq', 35, true);


--
-- Name: vendors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.vendors_id_seq', 6, true);


--
-- Name: abilities abilities_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.abilities
    ADD CONSTRAINT abilities_pkey PRIMARY KEY ("group", model, channel_id);


--
-- Name: channels channels_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.channels
    ADD CONSTRAINT channels_pkey PRIMARY KEY (id);


--
-- Name: checkins checkins_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.checkins
    ADD CONSTRAINT checkins_pkey PRIMARY KEY (id);


--
-- Name: prefill_groups idx_prefill_groups_name; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.prefill_groups
    ADD CONSTRAINT idx_prefill_groups_name UNIQUE (name);


--
-- Name: logs logs_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.logs
    ADD CONSTRAINT logs_pkey PRIMARY KEY (id);


--
-- Name: midjourneys midjourneys_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.midjourneys
    ADD CONSTRAINT midjourneys_pkey PRIMARY KEY (id);


--
-- Name: models models_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.models
    ADD CONSTRAINT models_pkey PRIMARY KEY (id);


--
-- Name: options options_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.options
    ADD CONSTRAINT options_pkey PRIMARY KEY (key);


--
-- Name: passkey_credentials passkey_credentials_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.passkey_credentials
    ADD CONSTRAINT passkey_credentials_pkey PRIMARY KEY (id);


--
-- Name: prefill_groups prefill_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.prefill_groups
    ADD CONSTRAINT prefill_groups_pkey PRIMARY KEY (id);


--
-- Name: quota_data quota_data_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.quota_data
    ADD CONSTRAINT quota_data_pkey PRIMARY KEY (id);


--
-- Name: redemptions redemptions_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.redemptions
    ADD CONSTRAINT redemptions_pkey PRIMARY KEY (id);


--
-- Name: setups setups_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.setups
    ADD CONSTRAINT setups_pkey PRIMARY KEY (id);


--
-- Name: tasks tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (id);


--
-- Name: tokens tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.tokens
    ADD CONSTRAINT tokens_pkey PRIMARY KEY (id);


--
-- Name: top_ups top_ups_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.top_ups
    ADD CONSTRAINT top_ups_pkey PRIMARY KEY (id);


--
-- Name: top_ups top_ups_trade_no_key; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.top_ups
    ADD CONSTRAINT top_ups_trade_no_key UNIQUE (trade_no);


--
-- Name: two_fa_backup_codes two_fa_backup_codes_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.two_fa_backup_codes
    ADD CONSTRAINT two_fa_backup_codes_pkey PRIMARY KEY (id);


--
-- Name: two_fas two_fas_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.two_fas
    ADD CONSTRAINT two_fas_pkey PRIMARY KEY (id);


--
-- Name: two_fas two_fas_user_id_key; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.two_fas
    ADD CONSTRAINT two_fas_user_id_key UNIQUE (user_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: vendors vendors_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.vendors
    ADD CONSTRAINT vendors_pkey PRIMARY KEY (id);


--
-- Name: idx_abilities_channel_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_abilities_channel_id ON public.abilities USING btree (channel_id);


--
-- Name: idx_abilities_priority; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_abilities_priority ON public.abilities USING btree (priority);


--
-- Name: idx_abilities_tag; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_abilities_tag ON public.abilities USING btree (tag);


--
-- Name: idx_abilities_weight; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_abilities_weight ON public.abilities USING btree (weight);


--
-- Name: idx_channels_name; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_channels_name ON public.channels USING btree (name);


--
-- Name: idx_channels_tag; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_channels_tag ON public.channels USING btree (tag);


--
-- Name: idx_created_at_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_created_at_id ON public.logs USING btree (id, created_at);


--
-- Name: idx_created_at_type; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_created_at_type ON public.logs USING btree (created_at, type);


--
-- Name: idx_logs_channel_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_logs_channel_id ON public.logs USING btree (channel_id);


--
-- Name: idx_logs_group; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_logs_group ON public.logs USING btree ("group");


--
-- Name: idx_logs_ip; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_logs_ip ON public.logs USING btree (ip);


--
-- Name: idx_logs_model_name; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_logs_model_name ON public.logs USING btree (model_name);


--
-- Name: idx_logs_token_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_logs_token_id ON public.logs USING btree (token_id);


--
-- Name: idx_logs_token_name; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_logs_token_name ON public.logs USING btree (token_name);


--
-- Name: idx_logs_user_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_logs_user_id ON public.logs USING btree (user_id);


--
-- Name: idx_logs_username; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_logs_username ON public.logs USING btree (username);


--
-- Name: idx_midjourneys_action; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_midjourneys_action ON public.midjourneys USING btree (action);


--
-- Name: idx_midjourneys_finish_time; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_midjourneys_finish_time ON public.midjourneys USING btree (finish_time);


--
-- Name: idx_midjourneys_mj_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_midjourneys_mj_id ON public.midjourneys USING btree (mj_id);


--
-- Name: idx_midjourneys_progress; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_midjourneys_progress ON public.midjourneys USING btree (progress);


--
-- Name: idx_midjourneys_start_time; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_midjourneys_start_time ON public.midjourneys USING btree (start_time);


--
-- Name: idx_midjourneys_status; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_midjourneys_status ON public.midjourneys USING btree (status);


--
-- Name: idx_midjourneys_submit_time; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_midjourneys_submit_time ON public.midjourneys USING btree (submit_time);


--
-- Name: idx_midjourneys_user_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_midjourneys_user_id ON public.midjourneys USING btree (user_id);


--
-- Name: idx_models_deleted_at; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_models_deleted_at ON public.models USING btree (deleted_at);


--
-- Name: idx_models_vendor_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_models_vendor_id ON public.models USING btree (vendor_id);


--
-- Name: idx_passkey_credentials_credential_id; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX idx_passkey_credentials_credential_id ON public.passkey_credentials USING btree (credential_id);


--
-- Name: idx_passkey_credentials_deleted_at; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_passkey_credentials_deleted_at ON public.passkey_credentials USING btree (deleted_at);


--
-- Name: idx_passkey_credentials_user_id; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX idx_passkey_credentials_user_id ON public.passkey_credentials USING btree (user_id);


--
-- Name: idx_prefill_groups_deleted_at; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_prefill_groups_deleted_at ON public.prefill_groups USING btree (deleted_at);


--
-- Name: idx_prefill_groups_type; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_prefill_groups_type ON public.prefill_groups USING btree (type);


--
-- Name: idx_qdt_created_at; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_qdt_created_at ON public.quota_data USING btree (created_at);


--
-- Name: idx_qdt_model_user_name; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_qdt_model_user_name ON public.quota_data USING btree (model_name, username);


--
-- Name: idx_quota_data_user_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_quota_data_user_id ON public.quota_data USING btree (user_id);


--
-- Name: idx_redemptions_deleted_at; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_redemptions_deleted_at ON public.redemptions USING btree (deleted_at);


--
-- Name: idx_redemptions_key; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX idx_redemptions_key ON public.redemptions USING btree (key);


--
-- Name: idx_redemptions_name; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_redemptions_name ON public.redemptions USING btree (name);


--
-- Name: idx_tasks_action; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_tasks_action ON public.tasks USING btree (action);


--
-- Name: idx_tasks_channel_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_tasks_channel_id ON public.tasks USING btree (channel_id);


--
-- Name: idx_tasks_created_at; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_tasks_created_at ON public.tasks USING btree (created_at);


--
-- Name: idx_tasks_finish_time; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_tasks_finish_time ON public.tasks USING btree (finish_time);


--
-- Name: idx_tasks_platform; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_tasks_platform ON public.tasks USING btree (platform);


--
-- Name: idx_tasks_progress; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_tasks_progress ON public.tasks USING btree (progress);


--
-- Name: idx_tasks_start_time; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_tasks_start_time ON public.tasks USING btree (start_time);


--
-- Name: idx_tasks_status; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_tasks_status ON public.tasks USING btree (status);


--
-- Name: idx_tasks_submit_time; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_tasks_submit_time ON public.tasks USING btree (submit_time);


--
-- Name: idx_tasks_task_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_tasks_task_id ON public.tasks USING btree (task_id);


--
-- Name: idx_tasks_user_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_tasks_user_id ON public.tasks USING btree (user_id);


--
-- Name: idx_tokens_deleted_at; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_tokens_deleted_at ON public.tokens USING btree (deleted_at);


--
-- Name: idx_tokens_key; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX idx_tokens_key ON public.tokens USING btree (key);


--
-- Name: idx_tokens_name; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_tokens_name ON public.tokens USING btree (name);


--
-- Name: idx_tokens_user_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_tokens_user_id ON public.tokens USING btree (user_id);


--
-- Name: idx_top_ups_trade_no; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_top_ups_trade_no ON public.top_ups USING btree (trade_no);


--
-- Name: idx_top_ups_user_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_top_ups_user_id ON public.top_ups USING btree (user_id);


--
-- Name: idx_two_fa_backup_codes_deleted_at; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_two_fa_backup_codes_deleted_at ON public.two_fa_backup_codes USING btree (deleted_at);


--
-- Name: idx_two_fa_backup_codes_user_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_two_fa_backup_codes_user_id ON public.two_fa_backup_codes USING btree (user_id);


--
-- Name: idx_two_fas_deleted_at; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_two_fas_deleted_at ON public.two_fas USING btree (deleted_at);


--
-- Name: idx_two_fas_user_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_two_fas_user_id ON public.two_fas USING btree (user_id);


--
-- Name: idx_user_checkin_date; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX idx_user_checkin_date ON public.checkins USING btree (user_id, checkin_date);


--
-- Name: idx_users_access_token; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX idx_users_access_token ON public.users USING btree (access_token);


--
-- Name: idx_users_aff_code; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX idx_users_aff_code ON public.users USING btree (aff_code);


--
-- Name: idx_users_deleted_at; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_users_deleted_at ON public.users USING btree (deleted_at);


--
-- Name: idx_users_discord_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_users_discord_id ON public.users USING btree (discord_id);


--
-- Name: idx_users_display_name; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_users_display_name ON public.users USING btree (display_name);


--
-- Name: idx_users_email; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_users_email ON public.users USING btree (email);


--
-- Name: idx_users_git_hub_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_users_git_hub_id ON public.users USING btree (github_id);


--
-- Name: idx_users_inviter_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_users_inviter_id ON public.users USING btree (inviter_id);


--
-- Name: idx_users_linux_do_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_users_linux_do_id ON public.users USING btree (linux_do_id);


--
-- Name: idx_users_oidc_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_users_oidc_id ON public.users USING btree (oidc_id);


--
-- Name: idx_users_stripe_customer; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_users_stripe_customer ON public.users USING btree (stripe_customer);


--
-- Name: idx_users_telegram_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_users_telegram_id ON public.users USING btree (telegram_id);


--
-- Name: idx_users_username; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_users_username ON public.users USING btree (username);


--
-- Name: idx_users_we_chat_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_users_we_chat_id ON public.users USING btree (wechat_id);


--
-- Name: idx_vendors_deleted_at; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_vendors_deleted_at ON public.vendors USING btree (deleted_at);


--
-- Name: index_username_model_name; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_username_model_name ON public.logs USING btree (model_name, username);


--
-- Name: uk_model_name_delete_at; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX uk_model_name_delete_at ON public.models USING btree (model_name, deleted_at);


--
-- Name: uk_prefill_name; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX uk_prefill_name ON public.prefill_groups USING btree (name) WHERE (deleted_at IS NULL);


--
-- Name: uk_vendor_name_delete_at; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX uk_vendor_name_delete_at ON public.vendors USING btree (name, deleted_at);


--
-- PostgreSQL database dump complete
--

\unrestrict JBnjk4s5EykkehRFIUbyeWqeAl62VFznDwEBubiJFGyvP5kKKZj0UnuStGQdlyG

