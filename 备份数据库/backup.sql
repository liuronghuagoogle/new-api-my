--
-- PostgreSQL database dump
--

\restrict bBTsJhoUkV3IxPapVCXCBegFlUQOclstIGFWIVLc3euLg5bEkV5joegWPzgpp6h

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
default	gpt-oss-120b	6	t	8	0	
default	qwen-3-235b-a22b-instruct-2507	6	t	8	0	
default	qwen-3-32b	6	t	8	0	
default	llama-3.3-70b	6	t	8	0	
default	llama3.1-8b	6	t	8	0	
default	zai-glm-4.7	6	t	8	0	
default	zai-glm-4.7	5	t	5	0	
default	llama3.1-8b	5	t	5	0	
default	llama-3.3-70b	5	t	5	0	
default	gpt-oss-120b	5	t	5	0	
default	qwen-3-235b-a22b-instruct-2507	5	t	5	0	
default	qwen-3-32b	5	t	5	0	
default	z-ai/glm4.7	1	t	1	0	
default	openai/gpt-oss-120b	1	t	1	0	
default	minimaxai/minimax-m2.1	1	t	1	0	
default	deepseek-ai/deepseek-r1-distill-qwen-32b	1	t	1	0	
default	deepseek-ai/deepseek-coder-6.7b-instruct	1	t	1	0	
default	claude-sonnet-4-5	1	t	1	0	
default	claude-sonnet-4-5-20250929	1	t	1	0	
default	z-ai/glm4.7	3	t	2	0	
default	openai/gpt-oss-120b	3	t	2	0	
default	minimaxai/minimax-m2.1	3	t	2	0	
default	deepseek-ai/deepseek-r1-distill-qwen-32b	3	t	2	0	
default	deepseek-ai/deepseek-coder-6.7b-instruct	3	t	2	0	
default	claude-sonnet-4-5	3	t	2	0	
default	claude-sonnet-4-5-20250929	3	t	2	0	
default	z-ai/glm4.7	2	t	3	0	
default	openai/gpt-oss-120b	2	t	3	0	
default	minimaxai/minimax-m2.1	2	t	3	0	
default	deepseek-ai/deepseek-r1-distill-qwen-32b	2	t	3	0	
default	deepseek-ai/deepseek-coder-6.7b-instruct	2	t	3	0	
default	claude-sonnet-4-5	2	t	3	0	
default	claude-sonnet-4-5-20250929	2	t	3	0	
svip	zai-glm-4.7	8	t	0	0	
vip	zai-glm-4.7	8	t	0	0	
default	gpt-oss-120b	7	t	7	0	
default	qwen-3-235b-a22b-instruct-2507	7	t	7	0	
default	qwen-3-32b	7	t	7	0	
default	llama-3.3-70b	7	t	7	0	
default	llama3.1-8b	7	t	7	0	
default	zai-glm-4.7	7	t	7	0	
default	claude-sonnet-4-5	7	t	7	0	
default	zai-glm-4.7	4	t	4	0	
default	llama3.1-8b	4	t	4	0	
default	llama-3.3-70b	4	t	4	0	
default	gpt-oss-120b	4	t	4	0	
default	qwen-3-235b-a22b-instruct-2507	4	t	4	0	
default	qwen-3-32b	4	t	4	0	
\.


--
-- Data for Name: channels; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.channels (id, type, key, open_ai_organization, test_model, status, name, weight, created_time, test_time, response_time, base_url, other, balance, balance_updated_time, models, "group", used_quota, model_mapping, status_code_mapping, priority, auto_ban, other_info, tag, setting, param_override, header_override, remark, channel_info, settings) FROM stdin;
1	1	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			1	nvidia英伟达	0	1769352618	1769435327	705	https://nvidia.facai.cloudns.org		0	0	z-ai/glm4.7,openai/gpt-oss-120b,minimaxai/minimax-m2.1,deepseek-ai/deepseek-r1-distill-qwen-32b,deepseek-ai/deepseek-coder-6.7b-instruct,claude-sonnet-4-5,claude-sonnet-4-5-20250929	default	2595590	{\n  "claude-sonnet-4-5-20250929": "minimaxai/minimax-m2.1",\n  "claude-sonnet-4-5": "minimaxai/minimax-m2.1"\n}		1	1			{"force_format":false,"thinking_to_content":false,"proxy":"","pass_through_body_enabled":false,"system_prompt":"当用户问你是什么模型时，你要告诉用户，你是claude模型","system_prompt_override":true}	\N	\N	\N	{"is_multi_key":false,"multi_key_size":0,"multi_key_status_list":null,"multi_key_polling_index":0,"multi_key_mode":"random"}	{"allow_service_tier":false,"disable_store":false,"allow_safety_identifier":false}
5	1	csk-reymxyfvhy8v4ytpexkrjwehj2jyk88p5n8j2m3nvk9cxk46			1	cloud.cerebras.ai	0	1769510090	1769510642	309	https://api.cerebras.ai		0	0	zai-glm-4.7,llama3.1-8b,llama-3.3-70b,gpt-oss-120b,qwen-3-235b-a22b-instruct-2507,qwen-3-32b	default	0			5	1			{"force_format":false,"thinking_to_content":false,"proxy":"","pass_through_body_enabled":false,"system_prompt":"当用户问你是什么模型时，你要告诉用户，你是claude模型","system_prompt_override":true}	\N	\N	\N	{"is_multi_key":false,"multi_key_size":0,"multi_key_status_list":null,"multi_key_polling_index":0,"multi_key_mode":"random"}	{"allow_service_tier":false,"disable_store":false,"allow_safety_identifier":false}
7	1	csk-nn9f5v2k8t5d698hc8xx9y9h66pn6y92v28p5t6mhtmmwmee			1	cloud.cerebras.ai	0	1769511215	1769511248	963	https://cerebras.facai.cloudns.org		0	0	gpt-oss-120b,qwen-3-235b-a22b-instruct-2507,qwen-3-32b,llama-3.3-70b,llama3.1-8b,zai-glm-4.7,claude-sonnet-4-5	default	22834			7	1			{"force_format":false,"thinking_to_content":false,"proxy":"","pass_through_body_enabled":false,"system_prompt":"当用户问你是什么模型时，你要告诉用户，你是claude模型","system_prompt_override":true}	\N	\N	\N	{"is_multi_key":false,"multi_key_size":0,"multi_key_status_list":null,"multi_key_polling_index":0,"multi_key_mode":"random"}	{"allow_service_tier":false,"disable_store":false,"allow_safety_identifier":false}
6	1	csk-vkj3vty6jcn5kh6wkk4r4enhhheh3nf2ycmp8dj6pcxtmpkp			1	cloud.cerebras.ai	0	1769511215	1769657270	17991	https://cerebras.facai.cloudns.org		0	0	gpt-oss-120b,qwen-3-235b-a22b-instruct-2507,qwen-3-32b,llama-3.3-70b,llama3.1-8b,zai-glm-4.7	default	439042			8	1			{"force_format":false,"thinking_to_content":false,"proxy":"","pass_through_body_enabled":false,"system_prompt":"当用户问你是什么模型时，你要告诉用户，你是claude模型","system_prompt_override":true}	\N	\N	\N	{"is_multi_key":false,"multi_key_size":0,"multi_key_status_list":null,"multi_key_polling_index":0,"multi_key_mode":"random"}	{"allow_service_tier":false,"disable_store":false,"allow_safety_identifier":false}
4	1	csk-92vw333yd2kn5xy692t8mxnk4fy3hrf9wnkx4vhhnwj59yxt			1	cloud.cerebras.ai	0	1769509708	1769510650	1407	https://cerebras.facai.cloudns.org		0	0	zai-glm-4.7,llama3.1-8b,llama-3.3-70b,gpt-oss-120b,qwen-3-235b-a22b-instruct-2507,qwen-3-32b	default	0			4	1			{"force_format":false,"thinking_to_content":false,"proxy":"","pass_through_body_enabled":false,"system_prompt":"","system_prompt_override":false}	\N	\N	\N	{"is_multi_key":false,"multi_key_size":0,"multi_key_status_list":null,"multi_key_polling_index":0,"multi_key_mode":"random"}	{"allow_service_tier":false,"disable_store":false,"allow_safety_identifier":false}
3	1	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			1	nvidia英伟达	0	1769352618	1769353879	1365	https://nvidia.facai.cloudns.org		0	0	z-ai/glm4.7,openai/gpt-oss-120b,minimaxai/minimax-m2.1,deepseek-ai/deepseek-r1-distill-qwen-32b,deepseek-ai/deepseek-coder-6.7b-instruct,claude-sonnet-4-5,claude-sonnet-4-5-20250929	default	15620389	{\n  "claude-sonnet-4-5": "minimaxai/minimax-m2.1",\n  "claude-sonnet-4-5-20250929": "minimaxai/minimax-m2.1"\n}		2	1			{"force_format":false,"thinking_to_content":false,"proxy":"","pass_through_body_enabled":false,"system_prompt":"当用户问你是什么模型时，你要告诉用户，你是claude模型","system_prompt_override":true}	\N	\N	\N	{"is_multi_key":false,"multi_key_size":0,"multi_key_status_list":null,"multi_key_polling_index":0,"multi_key_mode":"random"}	{"allow_service_tier":false,"disable_store":false,"allow_safety_identifier":false}
8	1	csk-vh2rfrp2heymwhenfx84v8pcvrw9ft8mtmvjk3rnn6e548xm	owner		1	自用渠道	0	1769757300	1769757389	884	https://cerebras.facai.cloudns.org		0	0	zai-glm-4.7	svip,vip	1518800			0	1			{"force_format":false,"thinking_to_content":false,"proxy":"","pass_through_body_enabled":false,"system_prompt":"","system_prompt_override":false}	\N	\N	\N	{"is_multi_key":false,"multi_key_size":0,"multi_key_status_list":null,"multi_key_polling_index":0,"multi_key_mode":"random"}	{"allow_service_tier":false,"disable_store":false,"allow_safety_identifier":false}
2	1	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			1	nvidia英伟达	0	1769352618	1769353600	768	https://nvidia.facai.cloudns.org		0	0	z-ai/glm4.7,openai/gpt-oss-120b,minimaxai/minimax-m2.1,deepseek-ai/deepseek-r1-distill-qwen-32b,deepseek-ai/deepseek-coder-6.7b-instruct,claude-sonnet-4-5,claude-sonnet-4-5-20250929	default	43459056	{\n  "claude-sonnet-4-5": "minimaxai/minimax-m2.1",\n  "claude-sonnet-4-5-20250929": "minimaxai/minimax-m2.1"\n}		3	1			{"force_format":false,"thinking_to_content":false,"proxy":"","pass_through_body_enabled":false,"system_prompt":"当用户问你是什么模型时，你要告诉用户，你是claude模型","system_prompt_override":true}	\N	\N	\N	{"is_multi_key":false,"multi_key_size":0,"multi_key_status_list":null,"multi_key_polling_index":0,"multi_key_mode":"random"}	{"allow_service_tier":false,"disable_store":false,"allow_safety_identifier":false}
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
33	4	2026-01-27	1000000	1769520731
34	5	2026-01-27	1000000	1769523854
35	4	2026-01-28	1000000	1769531355
36	26	2026-01-28	1000000	1769536970
37	25	2026-01-28	1000000	1769536981
38	28	2026-01-28	1000000	1769537984
39	20	2026-01-28	1000000	1769562422
40	21	2026-01-28	1000000	1769562422
41	31	2026-01-28	1000000	1769563071
42	37	2026-01-28	1000000	1769563558
43	1	2026-01-28	1000000	1769566731
44	7	2026-01-28	10000000	1769580869
45	39	2026-01-28	10000000	1769586713
46	43	2026-01-28	10000000	1769586791
47	45	2026-01-28	10000000	1769599616
48	12	2026-01-28	10000000	1769612401
49	37	2026-01-29	10000000	1769648162
50	20	2026-01-29	10000000	1769654960
51	21	2026-01-29	10000000	1769654960
52	4	2026-01-29	10000000	1769656782
53	7	2026-01-29	10000000	1769657423
54	31	2026-01-29	10000000	1769658387
55	8	2026-01-29	10000000	1769660129
56	46	2026-01-29	10000000	1769686143
57	12	2026-01-29	10000000	1769698759
58	47	2026-01-29	10000000	1769701348
59	4	2026-01-30	10000000	1769703001
60	47	2026-01-30	10000000	1769704119
61	27	2026-01-30	10000000	1769705309
62	20	2026-01-30	10000000	1769735489
63	21	2026-01-30	10000000	1769735489
64	31	2026-01-30	10000000	1769739576
65	7	2026-01-30	10000000	1769743683
66	48	2026-01-30	10000000	1769744328
67	8	2026-01-30	10000000	1769750070
68	39	2026-01-30	10000000	1769754761
69	37	2026-01-30	10000000	1769776977
70	54	2026-01-30	10000000	1769781143
71	55	2026-01-30	10000000	1769781673
72	21	2026-01-31	10000000	1769789194
73	20	2026-01-31	10000000	1769789194
74	8	2026-01-31	10000000	1769791232
75	37	2026-01-31	10000000	1769817955
76	4	2026-01-31	10000000	1769826063
77	56	2026-01-31	10000000	1769826920
78	7	2026-01-31	10000000	1769828350
79	58	2026-01-31	10000000	1769857051
80	54	2026-01-31	10000000	1769866412
81	59	2026-01-31	10000000	1769871405
82	21	2026-02-01	10000000	1769875284
83	20	2026-02-01	10000000	1769875284
84	4	2026-02-01	10000000	1769875720
85	27	2026-02-01	10000000	1769910498
86	56	2026-02-01	10000000	1769910583
87	8	2026-02-01	10000000	1769925497
88	47	2026-02-01	10000000	1769928099
89	59	2026-02-01	10000000	1769929445
90	12	2026-02-01	10000000	1769932626
91	7	2026-02-01	10000000	1769934324
92	37	2026-02-01	10000000	1769947022
93	63	2026-02-01	10000000	1769947777
94	64	2026-02-01	10000000	1769959366
95	63	2026-02-02	10000000	1769961708
96	20	2026-02-02	10000000	1769962086
97	21	2026-02-02	10000000	1769962086
98	4	2026-02-02	10000000	1769963522
99	65	2026-02-02	10000000	1769975124
100	27	2026-02-02	10000000	1769985964
101	48	2026-02-02	10000000	1769993213
102	64	2026-02-02	10000000	1769994823
103	56	2026-02-02	10000000	1769996375
104	31	2026-02-02	10000000	1770012689
105	8	2026-02-02	10000000	1770013556
106	37	2026-02-02	10000000	1770023615
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
About	----\n**ai发财网， 所有模型官方直链，稳的一逼**\n----\n![](https://img.liangzheng.cloudns.org/file/AgACAgUAAyEGAATmPyMGAAMIaXs5EtDaAAGv9_roVXfaeMmVdF3XAAJrD2sbmYzYV3GasvRN3mqsAQADAgADdwADOAQ.png)
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
RetryTimes	3
checkin_setting.enabled	true
QuotaForInviter	10000000
QuotaForInvitee	10000000
QuotaForNewUser	10000000
Notice	**欢迎来到【ai发财】ai中转站**\n\n--------------【请合理、珍惜使用免费公益】-------------\n\n--------------【请合理、珍惜使用免费公益】-------------\n- 本站所有模型都来自于官方直连\n- 欢迎扫码加入本站官方群，获取一手资源\n![图片](https://img.liangzheng.cloudns.org/file/AgACAgUAAyEGAATmPyMGAAMGaXbgFY6ytZ1Zi7U8Mnsox18tGkEAAtQOaxu7t7FXss_khb9j3P0BAAMCAANtAAM4BA.png?t=2f4bcb97-2281-8083-bed5-c22190288416)
ModelRatio	{\n    "360GPT_S2_V9": 0.8572,\n    "360gpt-pro": 0.8572,\n    "360gpt-turbo": 0.0858,\n    "360gpt-turbo-responsibility-8k": 0.8572,\n    "360gpt2-pro": 0.8572,\n    "BLOOMZ-7B": 0.273972602739726,\n    "ERNIE-3.5-4K-0205": 0.821917808219178,\n    "ERNIE-3.5-8K": 0.821917808219178,\n    "ERNIE-3.5-8K-0205": 1.643835616438356,\n    "ERNIE-3.5-8K-1222": 0.821917808219178,\n    "ERNIE-4.0-8K": 8.219178082191782,\n    "ERNIE-Bot-8K": 1.643835616438356,\n    "ERNIE-Lite-8K-0308": 0.2054794520547945,\n    "ERNIE-Lite-8K-0922": 0.547945205479452,\n    "ERNIE-Speed-128K": 0.273972602739726,\n    "ERNIE-Speed-8K": 0.273972602739726,\n    "ERNIE-Tiny-8K": 0.0684931506849315,\n    "Embedding-V1": 0.136986301369863,\n    "NousResearch/Hermes-4-405B-FP8": 0.8,\n    "PaLM-2": 1,\n    "Qwen/Qwen3-235B-A22B-Instruct-2507": 0.3,\n    "Qwen/Qwen3-235B-A22B-Thinking-2507": 0.6,\n    "Qwen/Qwen3-Coder-480B-A35B-Instruct-FP8": 0.8,\n    "SparkDesk-v1.1": 1.2858,\n    "SparkDesk-v2.1": 1.2858,\n    "SparkDesk-v3.1": 1.2858,\n    "SparkDesk-v3.5": 1.2858,\n    "SparkDesk-v4.0": 1.2858,\n    "ada": 10,\n    "babbage": 10,\n    "babbage-002": 0.2,\n    "bge-large-en": 0.136986301369863,\n    "bge-large-zh": 0.136986301369863,\n    "chatglm_lite": 0.1429,\n    "chatglm_pro": 0.7143,\n    "chatglm_std": 0.3572,\n    "chatglm_turbo": 0.3572,\n    "chatgpt-4o-latest": 2.5,\n    "claude-2.0": 4,\n    "claude-2.1": 4,\n    "claude-3-5-haiku-20241022": 0.5,\n    "claude-3-5-sonnet-20240620": 1.5,\n    "claude-3-5-sonnet-20241022": 1.5,\n    "claude-3-7-sonnet-20250219": 1.5,\n    "claude-3-7-sonnet-20250219-thinking": 1.5,\n    "claude-3-haiku-20240307": 0.125,\n    "claude-3-opus-20240229": 7.5,\n    "claude-3-sonnet-20240229": 1.5,\n    "claude-haiku-4-5-20251001": 0.5,\n    "claude-instant-1": 0.4,\n    "claude-opus-4-1-20250805": 7.5,\n    "claude-opus-4-20250514": 7.5,\n    "claude-opus-4-5-20251101": 2.5,\n    "claude-sonnet-4-20250514": 1.5,\n    "claude-sonnet-4-5-20250929": 1.5,\n    "code-davinci-edit-001": 10,\n    "command": 0.5,\n    "command-light": 0.5,\n    "command-light-nightly": 0.5,\n    "command-nightly": 0.5,\n    "command-r": 0.25,\n    "command-r-08-2024": 0.075,\n    "command-r-plus": 1.5,\n    "command-r-plus-08-2024": 1.25,\n    "curie": 10,\n    "davinci": 10,\n    "davinci-002": 1,\n    "deepseek-ai/DeepSeek-R1": 0.8,\n    "deepseek-ai/DeepSeek-R1-0528": 0.8,\n    "deepseek-ai/DeepSeek-V3-0324": 0.8,\n    "deepseek-ai/DeepSeek-V3.1": 0.8,\n    "deepseek-chat": 0.135,\n    "deepseek-coder": 0.135,\n    "deepseek-reasoner": 0.275,\n    "embedding-bert-512-v1": 0.0715,\n    "embedding_s1_v1": 0.0715,\n    "gemini-1.5-flash-latest": 0.075,\n    "gemini-1.5-pro-latest": 1.25,\n    "gemini-2.0-flash": 0.05,\n    "gemini-2.5-flash": 0.15,\n    "gemini-2.5-flash-lite-preview-06-17": 0.05,\n    "gemini-2.5-flash-lite-preview-thinking-*": 0.05,\n    "gemini-2.5-flash-preview-04-17": 0.075,\n    "gemini-2.5-flash-preview-04-17-nothinking": 0.075,\n    "gemini-2.5-flash-preview-04-17-thinking": 0.075,\n    "gemini-2.5-flash-preview-05-20": 0.075,\n    "gemini-2.5-flash-preview-05-20-nothinking": 0.075,\n    "gemini-2.5-flash-preview-05-20-thinking": 0.075,\n    "gemini-2.5-flash-thinking-*": 0.075,\n    "gemini-2.5-pro": 0.625,\n    "gemini-2.5-pro-exp-03-25": 0.625,\n    "gemini-2.5-pro-preview-03-25": 0.625,\n    "gemini-2.5-pro-thinking-*": 0.625,\n    "gemini-embedding-001": 0.075,\n    "gemini-robotics-er-1.5-preview": 0.15,\n    "glm-3-turbo": 0.3572,\n    "glm-4": 7.143,\n    "glm-4-0520": 6.8493150684931505,\n    "glm-4-air": 0.0684931506849315,\n    "glm-4-airx": 0.684931506849315,\n    "glm-4-alltools": 6.8493150684931505,\n    "glm-4-flash": 0,\n    "glm-4-long": 0.0684931506849315,\n    "glm-4-plus": 3.4246575342465753,\n    "glm-4v": 3.4246575342465753,\n    "glm-4v-plus": 0.684931506849315,\n    "gpt-3.5-turbo": 0.25,\n    "gpt-3.5-turbo-0125": 0.25,\n    "gpt-3.5-turbo-0613": 0.75,\n    "gpt-3.5-turbo-1106": 0.5,\n    "gpt-3.5-turbo-16k": 1.5,\n    "gpt-3.5-turbo-16k-0613": 1.5,\n    "gpt-3.5-turbo-instruct": 0.75,\n    "gpt-4": 15,\n    "gpt-4-0125-preview": 5,\n    "gpt-4-0613": 15,\n    "gpt-4-1106-preview": 5,\n    "gpt-4-1106-vision-preview": 5,\n    "gpt-4-32k": 30,\n    "gpt-4-32k-0613": 30,\n    "gpt-4-all": 15,\n    "gpt-4-gizmo-*": 15,\n    "gpt-4-turbo": 5,\n    "gpt-4-turbo-2024-04-09": 5,\n    "gpt-4-turbo-preview": 5,\n    "gpt-4-vision-preview": 5,\n    "gpt-4.1": 1,\n    "gpt-4.1-2025-04-14": 1,\n    "gpt-4.1-mini": 0.2,\n    "gpt-4.1-mini-2025-04-14": 0.2,\n    "gpt-4.1-nano": 0.05,\n    "gpt-4.1-nano-2025-04-14": 0.05,\n    "gpt-4.5-preview": 37.5,\n    "gpt-4.5-preview-2025-02-27": 37.5,\n    "gpt-4o": 1.25,\n    "gpt-4o-2024-05-13": 2.5,\n    "gpt-4o-2024-08-06": 1.25,\n    "gpt-4o-2024-11-20": 1.25,\n    "gpt-4o-all": 15,\n    "gpt-4o-audio-preview": 1.25,\n    "gpt-4o-audio-preview-2024-10-01": 1.25,\n    "gpt-4o-gizmo-*": 2.5,\n    "gpt-4o-mini": 0.075,\n    "gpt-4o-mini-2024-07-18": 0.075,\n    "gpt-4o-mini-realtime-preview": 0.3,\n    "gpt-4o-mini-realtime-preview-2024-12-17": 0.3,\n    "gpt-4o-realtime-preview": 2.5,\n    "gpt-4o-realtime-preview-2024-10-01": 2.5,\n    "gpt-4o-realtime-preview-2024-12-17": 2.5,\n    "gpt-5": 0.625,\n    "gpt-5-2025-08-07": 0.625,\n    "gpt-5-chat-latest": 0.625,\n    "gpt-5-mini": 0.125,\n    "gpt-5-mini-2025-08-07": 0.125,\n    "gpt-5-nano": 0.025,\n    "gpt-5-nano-2025-08-07": 0.025,\n    "gpt-image-1": 2.5,\n    "grok-2": 1,\n    "grok-2-vision": 1,\n    "grok-3-beta": 1.5,\n    "grok-3-fast-beta": 2.5,\n    "grok-3-mini-beta": 0.15,\n    "grok-3-mini-fast-beta": 0.3,\n    "grok-beta": 2.5,\n    "grok-vision-beta": 2.5,\n    "hunyuan": 7.143,\n    "llama-3-sonar-large-32k-chat": 0,\n    "llama-3-sonar-large-32k-online": 0,\n    "llama-3-sonar-small-32k-chat": 0.1,\n    "llama-3-sonar-small-32k-online": 0.1,\n    "o1": 7.5,\n    "o1-2024-12-17": 7.5,\n    "o1-mini": 0.55,\n    "o1-mini-2024-09-12": 0.55,\n    "o1-preview": 7.5,\n    "o1-preview-2024-09-12": 7.5,\n    "o1-pro": 75,\n    "o1-pro-2025-03-19": 75,\n    "o3": 1,\n    "o3-2025-04-16": 1,\n    "o3-deep-research": 5,\n    "o3-deep-research-2025-06-26": 5,\n    "o3-mini": 0.55,\n    "o3-mini-2025-01-31": 0.55,\n    "o3-mini-2025-01-31-high": 0.55,\n    "o3-mini-2025-01-31-low": 0.55,\n    "o3-mini-2025-01-31-medium": 0.55,\n    "o3-mini-high": 0.55,\n    "o3-mini-low": 0.55,\n    "o3-mini-medium": 0.55,\n    "o3-pro": 10,\n    "o3-pro-2025-06-10": 10,\n    "o4-mini": 0.55,\n    "o4-mini-2025-04-16": 0.55,\n    "o4-mini-deep-research": 1,\n    "o4-mini-deep-research-2025-06-26": 1,\n    "openai/gpt-oss-120b": 0.5,\n    "qwen-plus": 10,\n    "qwen-turbo": 0.8572,\n    "semantic_similarity_s1_v1": 0.0715,\n    "tao-8k": 0.136986301369863,\n    "text-ada-001": 0.2,\n    "text-babbage-001": 0.25,\n    "text-curie-001": 1,\n    "text-davinci-edit-001": 10,\n    "text-embedding-004": 0.001,\n    "text-embedding-3-large": 0.065,\n    "text-embedding-3-small": 0.01,\n    "text-embedding-ada-002": 0.05,\n    "text-embedding-v1": 0.05,\n    "text-moderation-latest": 0.1,\n    "text-moderation-stable": 0.1,\n    "text-search-ada-doc-001": 10,\n    "tts-1": 7.5,\n    "tts-1-1106": 7.5,\n    "tts-1-hd": 15,\n    "tts-1-hd-1106": 15,\n    "whisper-1": 15,\n    "yi-34b-chat-0205": 0.18,\n    "yi-34b-chat-200k": 0.864,\n    "yi-large": 1.36986301369863,\n    "yi-large-preview": 1.36986301369863,\n    "yi-large-rag": 1.7123287671232876,\n    "yi-large-rag-preview": 1.7123287671232876,\n    "yi-large-turbo": 0.821917808219178,\n    "yi-medium": 0.17123287671232876,\n    "yi-medium-200k": 0.821917808219178,\n    "yi-spark": 0.0684931506849315,\n    "yi-vision": 0.410958904109589,\n    "yi-vl-plus": 0.432,\n    "zai-org/GLM-4.5-FP8": 0.8,\n    "z-ai/glm4.7": 0.8,\n    "claude-sonnet-4-5": 0.8,\n    "minimaxai/minimax-m2.1": 0.8,\n    "deepseek-ai/deepseek-r1-distill-qwen-32b": 0.8,\n    "deepseek-ai/deepseek-coder-6.7b-instruct": 0.8,\n    "zai-glm-4.7": 0.8,\n    "llama3.1-8b": 0.8,\n    "llama-3.3-70b": 0.8,\n    "gpt-oss-120b": 0.8,\n    "qwen-3-235b-a22b-instruct-2507": 0.8,\n    "qwen-3-32b": 0.8\n}
LinuxDOOAuthEnabled	true
Footer	加客服微信入群：liuliang520550
checkin_setting.max_quota	1000000
checkin_setting.min_quota	10000000
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
45	1	liuliang	qwen-3-32b	1769655600	25	1	20
44	1	liuliang	zai-glm-4.7	1769655600	35087	4	28068
20	27	github_27	claude-sonnet-4-5	1769461200	1221829	12	987248
21	27	github_27	z-ai/glm4.7	1769461200	235326	2	188261
22	32	github_32	claude-sonnet-4-5	1769482800	69	1	119
23	1	liuliang	claude-sonnet-4-5	1769482800	67	1	172
43	1	liuliang	claude-sonnet-4-5-20250929	1769655600	37244	3	56838
46	1	liuliang	zai-glm-4.7	1769659200	35250	3	42023
47	1	liuliang	claude-sonnet-4-5-20250929	1769659200	35269	2	53983
48	1	liuliang	claude-sonnet-4-5-20250929	1769680800	818	3	3789
49	46	github_46	claude-sonnet-4-5-20250929	1769684400	275	2	1271
57	51	github_51	claude-sonnet-4-5-20250929	1769760000	65254	4	100088
56	50	github_50	claude-sonnet-4-5-20250929	1769756400	68	2	114
28	1	liuliang	llama3.1-8b	1769508000	236	5	189
24	1	liuliang	llama-3.3-70b	1769508000	239	5	192
25	1	liuliang	qwen-3-235b-a22b-instruct-2507	1769508000	84	4	68
29	1	liuliang	qwen-3-32b	1769508000	100	4	80
26	1	liuliang	zai-glm-4.7	1769508000	1824	8	1462
27	1	liuliang	gpt-oss-120b	1769508000	336	4	320
30	1	liuliang	claude-sonnet-4-5	1769508000	943	8	3409
31	4	github_4	claude-sonnet-4-5	1769518800	27	1	37
33	37	github_37	claude-sonnet-4-5	1769522400	73455	5	105180
32	4	github_4	claude-sonnet-4-5	1769522400	49398	7	55003
34	27	github_27	claude-sonnet-4-5	1769536800	85733	3	85230
35	40	github_40	llama-3.3-70b	1769540400	94	1	75
36	28	github_28	claude-sonnet-4-5	1769547600	161775	3	139449
37	28	github_28	z-ai/glm4.7	1769547600	126155	1	100924
38	4	github_4	claude-sonnet-4-5	1769598000	70	2	88
39	1	liuliang	llama-3.3-70b	1769655600	46	1	37
40	1	liuliang	gpt-oss-120b	1769655600	84	1	80
41	1	liuliang	llama3.1-8b	1769655600	44	1	35
42	1	liuliang	qwen-3-235b-a22b-instruct-2507	1769655600	21	1	17
51	47	github_47	claude-sonnet-4-5-20250929	1769702400	8206172	105	12465602
52	47	github_47	claude-sonnet-4-5-20250929	1769706000	601356	6	905812
50	47	github_47	claude-sonnet-4-5-20250929	1769698800	1075743	25	1659927
54	39	github_39	claude-sonnet-4-5-20250929	1769756400	2158625	40	3289346
59	50	github_50	claude-sonnet-4-5-20250929	1769760000	34	1	57
60	52	github_52	claude-sonnet-4-5-20250929	1769763600	19646	3	54832
53	39	github_39	claude-sonnet-4-5-20250929	1769752800	1824251	37	2794014
61	1	liuliang	zai-glm-4.7	1769767200	844	3	674
62	50	github_50	claude-sonnet-4-5-20250929	1769770800	6433373	103	9891704
55	1	liuliang	zai-glm-4.7	1769756400	1006670	57	1518836
63	20	github_20	llama-3.3-70b	1769774400	204	3	162
58	52	github_52	claude-sonnet-4-5-20250929	1769760000	16412	2	40231
65	53	github_53	claude-sonnet-4-5-20250929	1769778000	117049	7	189388
66	37	github_37	claude-sonnet-4-5	1769778000	98408	11	78755
64	20	github_20	llama-3.3-70b	1769778000	404	6	323
67	37	github_37	claude-sonnet-4-5-20250929	1769778000	514181	17	799022
69	54	github_54	claude-sonnet-4-5-20250929	1769781600	55129	4	83845
68	54	github_54	claude-sonnet-4-5-20250929	1769778000	33011	2	50644
70	20	github_20	llama-3.3-70b	1769781600	408	6	324
71	20	github_20	llama-3.3-70b	1769785200	408	6	324
73	27	github_27	claude-sonnet-4-5-20250929	1769846400	32909	1	60356
72	27	github_27	claude-sonnet-4-5	1769846400	171864	5	262595
74	59	github_59	claude-sonnet-4-5	1769864400	35005	2	28848
75	60	github_60	claude-sonnet-4-5	1769868000	34	1	30
76	59	github_59	claude-sonnet-4-5	1769868000	34	1	30
78	60	github_60	claude-sonnet-4-5-20250929	1769871600	32375	2	52858
77	60	github_60	claude-sonnet-4-5	1769871600	1185348	70	1007304
88	60	github_60	claude-sonnet-4-5	1769929200	15918	7	18417
89	60	github_60	claude-sonnet-4-5-20250929	1769929200	3429727	43	5250773
90	47	github_47	claude-sonnet-4-5-20250929	1769936400	48827	3	75514
79	60	github_60	claude-sonnet-4-5	1769875200	1090670	23	1088720
80	61	github_61	claude-sonnet-4-5-20250929	1769882400	7059	1	13439
81	61	github_61	claude-sonnet-4-5	1769882400	2141804	44	1763611
82	61	github_61	claude-sonnet-4-5	1769886000	679459	23	578295
83	61	github_61	claude-sonnet-4-5-20250929	1769886000	1181908	28	1817208
94	4	github_4	claude-sonnet-4-5	1769943600	33757	4	29513
93	4	github_4	claude-sonnet-4-5-20250929	1769943600	2376468	39	3658650
91	60	github_60	claude-sonnet-4-5	1769943600	147364	14	127504
92	60	github_60	claude-sonnet-4-5-20250929	1769943600	602740	29	972735
95	37	github_37	claude-sonnet-4-5	1769943600	34	1	30
84	61	github_61	claude-sonnet-4-5-20250929	1769889600	3787214	60	5739931
85	60	github_60	claude-sonnet-4-5	1769922000	385176	9	319446
96	60	github_60	claude-sonnet-4-5-20250929	1769947200	279877	13	446975
97	47	github_47	claude-sonnet-4-5-20250929	1769950800	97325	6	149784
98	65	github_65	llama-3.3-70b	1769972400	95	1	76
99	50	github_50	claude-sonnet-4-5-20250929	1769994000	1598	4	4623
100	4	github_4	z-ai/glm4.7	1769997600	716	4	572
101	4	github_4	zai-glm-4.7	1769997600	440	2	351
102	4	github_4	claude-sonnet-4-5-20250929	1769997600	386	2	1406
86	60	github_60	claude-sonnet-4-5	1769925600	27986	7	24731
87	60	github_60	claude-sonnet-4-5-20250929	1769925600	1526128	26	2374331
\.


--
-- Data for Name: redemptions; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.redemptions (id, user_id, key, status, name, quota, created_time, redeemed_time, used_user_id, deleted_at, expired_time) FROM stdin;
1	1	734a1885f76c4e788f88aa3729dc8930	3	11111	50000000	1769502993	1769686129	46	2026-01-30 07:53:16.584769+00	1801298167
2	1	802c7143649d4beb9019b121ccf8302f	3	11111	50000000	1769502993	1769686118	46	2026-01-30 07:53:16.584769+00	1801298167
3	1	79c44b49007245159c3765575d0e47df	3	11111	50000000	1769502993	1769686105	46	2026-01-30 07:53:16.584769+00	1801298167
4	1	ee620d046892445eaaca2233dfa87a7b	3	11111	50000000	1769502993	1769686092	46	2026-01-30 07:53:16.584769+00	1801298167
5	1	e64f669fbb5d45b5b8950ac4c0df0431	3	11111	50000000	1769502993	1769686077	46	2026-01-30 07:53:16.584769+00	1801298167
6	1	ad788de21819480397956d66247969a6	3	11111	50000000	1769502993	1769686062	46	2026-01-30 07:53:16.584769+00	1801298167
7	1	bf340aaddaa3413cb6986d95bc5bdfdf	3	11111	50000000	1769502993	1769686050	46	2026-01-30 07:53:16.584769+00	1801298167
8	1	1d03c6e0cd764ecba89dfc018c3ed419	3	11111	50000000	1769502993	1769686035	46	2026-01-30 07:53:16.584769+00	1801298167
9	1	cf130c9bc9bb4fa4aae44ca58e4ede81	3	11111	50000000	1769502993	1769686019	46	2026-01-30 07:53:16.584769+00	1801298167
10	1	4cdea8a6f807407a8e5102719b486f9c	3	11111	50000000	1769502993	1769686004	46	2026-01-30 07:53:16.584769+00	1801298167
11	1	6c31b7de94874583902705affd715035	3	222	500000	1769688428	1769700949	47	2026-01-30 07:53:16.584769+00	1777550803
12	1	c60c0a0d18f64f82b082fc28ed2a7c72	3	222	500000	1769688428	1769700965	47	2026-01-30 07:53:16.584769+00	1777550803
13	1	bd06cd24eff74db1bfba4827c690ac85	3	222	500000	1769688428	1769700977	47	2026-01-30 07:53:16.584769+00	1777550803
14	1	8b6fc844aaa4407583360d1e624dfe92	3	222	500000	1769688428	1769700990	47	2026-01-30 07:53:16.584769+00	1777550803
15	1	30f535334d164d8f8a546786e7f4f38a	3	222	500000	1769688428	1769701006	47	2026-01-30 07:53:16.584769+00	1777550803
16	1	102167c88f774f1289795f19ff5756da	3	222	500000	1769688428	1769701024	47	2026-01-30 07:53:16.584769+00	1777550803
17	1	d328efceb4c54f1593dceda25ee1be74	3	222	500000	1769688428	1769701035	47	2026-01-30 07:53:16.584769+00	1777550803
18	1	57793c207cf6440ea69e3efc0a6200cb	3	222	500000	1769688428	1769701044	47	2026-01-30 07:53:16.584769+00	1777550803
19	1	cdb7c1aec7464085a7035d36f511f5d8	3	222	500000	1769688428	1769701054	47	2026-01-30 07:53:16.584769+00	1777550803
20	1	a91557204d85438bb69513ebfe9aee08	3	222	500000	1769688428	1769701061	47	2026-01-30 07:53:16.584769+00	1777550803
21	1	593620fdafea40fdb0e66d4b87cfd841	1	11	1000000	1769759627	0	0	\N	1801382002
22	1	c9bd7eeba8764d2e8886729deb5b8542	1	11	1000000	1769759627	0	0	\N	1801382002
23	1	80da4581102f489c9149bd5da5c17b00	1	11	1000000	1769759627	0	0	\N	1801382002
24	1	529d545e6a8e4ea48a027617defa11d3	1	11	1000000	1769759627	0	0	\N	1801382002
25	1	2a08906a95924d498d064443ff8bceac	1	11	1000000	1769759627	0	0	\N	1801382002
26	1	05bc72ac2fd94f5c8e0da1fafb11fd30	1	11	1000000	1769759627	0	0	\N	1801382002
27	1	80f86cdcf9254f648241c7fc72bf0607	1	11	1000000	1769759627	0	0	\N	1801382002
28	1	bc9f049a6b7e4bbda83b90f746898ff9	1	11	1000000	1769759627	0	0	\N	1801382002
29	1	feb76026c40f46fea89f63dbdb42614a	1	11	1000000	1769759627	0	0	\N	1801382002
30	1	f315bef01ac542f49f2e9978717e806c	1	11	1000000	1769759627	0	0	\N	1801382002
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
6	21	Sr3xPdk48ILcAg3gIWVLJH9HOJpKsaM1SMdE1mzASNYQ5ykF	1	分为	1769407279	1769407279	-1	0	t	f			0		f	\N
7	24	SjP7mVKC8Yf7EnJepLtX5Fsq2r82opXnDa9gtMCJBvAAwHuf	1	wps	1769412434	1769412434	-1	0	t	t	claude-sonnet-4-5		0		f	\N
12	28	75dSUYWSLJHssOSjeOW5Wij0H7wtmP7Na4iADYw4oJI44H9N	1	hhh	1769459362	1769549093	-1	-276023	t	f			276023	default	f	\N
20	33	0Y4S1a5FBRlDcXyphpfxI3DsllQJBHfpWKliNncmXqGAGuvQ	1	cloud	1769569466	1769569466	-1	0	t	f			0	vip	f	\N
11	28	wY7pJewIgionbzXlZRZpUpxLkkQ8NLMDTgQUtJj36lbemHDn	1	hhh	1769459121	1769459121	-1	0	t	f			0	vip	f	\N
36	47	LnOc7IgPKHivwLhUOSIRPfOHobyXXZK76BOqdUj2P4TIi92k	1	gpt	1769933386	1769933386	-1	0	t	t	gpt-oss-120b		0		f	\N
8	1	ifzkEOo0PDnugj3zvOyFWq0YnuMrDRK9AkgDpCJpyTFhriLr	1	11	1769432560	1769770185	-1	-181568	t	f			181568		f	\N
16	4	CmmIFKjIVsAY5lh7uwVfbBBD9kAVqvtEeTBOWF3lVRWZ5j44	1	test	1769520843	1769601552	-1	444872	f	t	claude-sonnet-4-5		55128	default	f	\N
1	3	JQzWJH7sFx1kvUP0LievOg76YSJQT5SYmAqW5CgjnPYd1lmf	1	11	1769401452	1769432968	-1	-30826	t	f			30826		f	\N
9	29	DxqEXu9395rCFWiiqf8wDsutc8NgQVe8pmMGx2oEgDQRwk5n	1	aa	1769437191	1769437191	-1	0	t	f			0	vip	f	\N
34	60	BwdyJt7y6aYDomnFLTL2bt5Yg7PdngIF77v5qXEWF9y3rFwY	1	test	1769871136	1769947857	-1	-11683824	t	f			11683824		f	\N
23	47	RVb8pKr2DcXh8UW7SXq1QvPbarpNdn1UNYUw0UFFW42E8tAy	1	6c31b7de94874583902705affd715035	1769699740	1769953998	-1	-15256639	t	f			15256639		f	\N
31	54	9Eg5RInxMNHzDUoc0wa5fBLKOdKCWcN4TxGHJzKfFQq0n0JI	1	claude	1769781176	1769781745	-1	-134489	t	f			134489	default	f	\N
18	26	B9zYZOjtPlpIJgV6B5T43u9iT9lYNu3GLVWyTqnhIYNf5qSr	1	base	1769537012	1769537012	-1	0	t	f			0		f	\N
24	48	XRgAq2z54uP8CQQ0ysxIbJfHMISBT7Dtjz80PHEnyaZFdy2R	1	striker	1769744410	1769744410	-1	0	t	f			0	default	f	\N
22	3	YVlI5oBd3B2kywY05dbP72AKy5yOojhJu1YNH5PLEfjT7RrC	1	55555	1769658791	1769658791	-1	0	t	f			0	default	f	\N
33	59	3yMcHthMmQRSvtBDc4PxC7GjfeEOoY36YJTnEo6f3VNgzOIx	1	test260131	1769863810	1769871532	-1	-28878	t	f			28878		f	\N
19	40	IGqWyE3t9hZsvMxkrhR5OQr2LtHgDHnzyaXQRU90qEi3pA1E	1	CC	1769542688	1769542688	-1	0	t	f			0	default	f	\N
21	39	jIwvbQHMrZychnJxNwFRNSLkaSYaO8yIdzuXCjFTCwN156Nm	1	自用	1769586352	1769758166	-1	-6083360	t	f			6083360		f	\N
28	51	UyAJYcBZpXRHIFHEgOrejZZjNDYYyEsrp2hUsf4RBOgW67ah	1	123	1769760570	1769762778	-1	-100088	t	f			100088		f	\N
13	30	juEeg1juX49FaCsYFbQdJoNPsCyIMCbeLpqAAfvTrfRLfOly	1	demo	1769478730	1769478730	-1	0	t	f			0		f	\N
14	31	I9xfqlPcXQlq3iA9LElpctV4Ct1oOEHQqArH85i5BIkvTvwo	1	1	1769481727	1769481727	-1	0	t	f			0	default	f	\N
10	27	ascX4MdCYF3Y6ZRR8C3yMEoTDsDnWrJRb901q9TwIeigp27r	1	hhh	1769440865	1769849310	-1	-3523895	t	f			3523895	default	f	\N
38	64	rKkqunA5xeO22FFYwldEvIxOiUuOuQXnZEyZheeaiNIl1IAe	1	默认	1769994953	1769994953	-1	0	t	f			0		f	\N
25	4	jTC4dDPdOlytqFEWA2PjcralcYRuKl340EpEF9ArNGt4W5xm	1	A513	1769755709	1770000545	-1	21309508	f	f			3690492	default	f	\N
32	58	ArieiSKZERui3Zz5q0kwAtdg61YXjJoQuDPEBncxfg6hoxwM	1	1	1769857153	1769857153	-1	0	t	f			0		f	\N
29	52	RlsK8hsJjgj8ndXsv5HM9uDikFUJbHKFXxbJt7BglXKEEfqk	1	cc	1769761097	1769766014	-1	-95063	t	f			95063	default	f	\N
27	1	J0BZM7bvhP0DjWcB2FCoeY6T4P3KsBFHpmycbQdjajCECslu	1	自用	1769757418	1769759867	-1	-1518800	t	f			1518800	vip	f	\N
5	20	I2WLzwN088fZbkUC1lDO6ZC6Tq9m4gRudlVaVQ0ujYDJnpd9	1	分为	1769407210	1769788267	-1	-1133	t	f			1133		f	\N
30	53	GSN2HZ5HZVCgaF8ZVMW8NFtHAEf98ul4Wtmv9yQnV2sWovgr	1	的话当回事	1769777756	1769778364	-1	-189388	t	f			189388	default	f	\N
17	37	2L3ZVSHTS5Kkyw8tatl9pWL10m19cljKXOHKRVFcPim7XS97	1	1	1769521700	1769947141	-1	-982987	t	f			982987	default	f	\N
35	61	IZQmqbRhhz9sjcmF2w0cNc72ngitgJFUWRC9F345m0TDx5fV	1	KV	1769884760	1769892026	-1	-9912484	t	f			9912484		f	\N
26	50	WFcsOfRug5SXoHVosHpWsqqIXTqQu4DKmdnRnxtitPaI9qWU	1	claude	1769757379	1769996603	-1	-9896498	t	f			9896498	default	f	\N
37	63	8ghZiNddUoPP5IoEjDQgaukafO0Z0b7gWXADWEy0JDeoyhwy	1	CC-CLAUDE	1769947856	1769947856	-1	0	t	f			0	vip	f	\N
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
6	github_6		keggin	1	1		keggin-CHN					\N	2000000	0	0	default	C95h	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
10	github_10		GitHub User	1	1		shuffleJie					\N	2000000	0	0	default	CrE3	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
3	github_3		liuliangzheng	1	1		liuliang520500					\N	9974218	31057	17	default	Uyzg	25	1114000000	1114000000	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
14	github_14		GitHub User	1	1		yzh886306-lgtm					\N	3000000	0	0	default	s5FR	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
7	github_7		LDXW	1	1	19166155754@163.com	End-Huang					zbU7hN5jlQbcexIsX5CNVioPZP1QaYU=	54000000	0	0	default	J0Lv	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
13	github_13		GitHub User	1	1		DrewXM30					\N	2000000	0	0	default	fLGw	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
9	github_9		GitHub User	1	1		shanzhongxue1					\N	3000000	0	0	default	vKyU	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
11	github_11		GitHub User	1	1		BruceLQX					\N	2000000	0	0	default	6lPp	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
15	github_15		SilenceShine	1	1		SilenceShine					\N	3000000	0	0	default	Dwqr	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
1	liuliang	$2a$10$8FVdTgOYPTyZt8fmAnEQbuOF63AjzSTupUysoiQ1M1x432mfkVgK.	Root User	100	1							\N	100290852	1709148	83	default	08no	14	140000000	140000000	0	\N				
16	github_16		浪子	1	1	jkjoy@live.cn	jkjoy					\N	2000000	0	0	default	SsKO	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
12	github_12		GitHub User	1	1		Kakezh					bZXnGqi/lMHvH3zCdyVA+iNewDhB    	34000000	0	0	default	Fl6F	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
5	github_5		XiaoYang	1	1		3351163616					\N	4000000	0	0	default	b5uQ	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
8	github_8		GitHub User	1	1		maroubao					wNLYsdmX6dUpHdNV0y9Nulrd88fT    	54000000	0	0	default	yJc7	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
4	github_4		GitHub User	1	1		xiaopenghuang					\N	101254380	3745620	61	default	SqrH	5	0	50000000	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
17	github_17		GitHub User	1	1		bibc123456					\N	2000000	0	0	default	m8dq	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
18	github_18		GitHub User	1	1		mochen125435					\N	1000000	0	0	default	HwMg	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
24	github_24		GitHub User	1	1		javasec2025-afk					\N	20009971	2837	3	default	wZHa	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
19	github_19		GitHub User	1	1		meer12347					TZuXnS5QP7hIGYm8CqU/qCvSDcklqw==	2000000	0	0	default	ZPSO	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
23	github_23		NetLops	1	1		NetLops					\N	3000000	0	0	default	8P0V	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
28	github_28		GitHub User	1	1		realc0unterki1lls-dev					\N	21723977	276023	7	default	6YMW	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
22	github_22		Yinghong Chen	1	1		335812350					\N	2000000	0	0	default	WynK	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
21	github_21		GitHub User	1	1		sonlia					LKX4Cu7yVEIOsFcSaqx8x6eipPl0i5c=	54000000	0	0	default	EWo7	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
27	github_27		GitHub User	1	1		Tipner					\N	47476105	3523895	75	default	6SaD	1	0	10000000	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
20	github_20		GitHub User	1	1		meerlov					PH5zaH/8HqldL9snYBsCL92GAyeLz7LM	53998867	1133	21	default	Nesd	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
25	github_25		GitHub User	1	1		czc7874					\N	23000000	0	0	default	02TB	1	10000000	10000000	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
29	github_29		zzw	1	1	zxwxiao@hotmail.com	skyooo					\N	19999241	759	1	default	Fsiq	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
30	github_30		PayNeXC	1	1		paynexss					\N	21000000	0	0	default	Tndt	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
31	github_31		mwdotzom	1	1		mwdotzom					\N	42000000	0	0	default	VVwM	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
26	github_26		你算哪根聪	1	1		ZhcChen					\N	23000000	0	0	default	bpFN	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
32	github_32		zrg042@163.com 	1	1	zrg042@163.com	zhu-042					\N	20999881	119	1	default	lBo2	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
33	github_33		云深	1	1		lkj194886					\N	10000000	0	0	default	p50k	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
38	github_38		HanJuNan	1	1		HanjuNan					\N	20000000	0	0	default	gkVi	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
34	github_34		JinMing Guo	1	1	tdouguo@gmail.com	tdouguo					\N	21000000	0	0	default	ApXz	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
35	github_35		GitHub User	1	1		liangmaoq					\N	20000000	0	0	default	tAHC	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
42	github_42		GitHub User	1	1		Emqo					\N	10000000	0	0	default	MHJA	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
36	github_36		Leeco	1	1	leeco1917@gmail.com	leecobaby					\N	20000000	0	0	default	OoPe	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
37	github_37		GitHub User	1	1		winab-a11y					\N	70017013	982987	34	default	GIP4	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
44	github_44		GitHub User	1	1		xubin123xubin					\N	20000000	0	0	default	htWL	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
40	github_40		GitHub User	1	1		17268838402					\N	19999925	75	1	default	ywIB	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
43	github_43		GitHub User	1	1		h-28huasheng					\N	30000000	0	0	default	KGlz	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
41	github_41		GitHub User	1	1		951284748					\N	20000000	0	0	default	rFGC	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
45	github_45		GitHub User	1	1		caowFeng					\N	30000000	0	0	default	oC5p	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
46	github_46		GitHub User	1	1		liugang5208					\N	529998729	1271	2	default	llgk	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
47	github_47		GitHub User	1	1		xiang20120525					\N	29743361	15256639	145	default	bnzg	0	0	0	0	\N		{"notify_type":"email","quota_warning_threshold":1000000,"notification_email":"xiangshaoj2023@qq.com","gotify_priority":0}		
39	github_39		GitHub User	1	1		shanegys					\N	43916640	6083360	77	default	AYzm	1	0	10000000	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
49	github_49		GitHub User	1	1		God-Devil-Angel					\N	20000000	0	0	default	ZkHa	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
56	github_56		GitHub User	1	1		yorbelinparce285-cmyk					\N	50000000	0	0	default	5o2f	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
51	github_51		Zixuan Pan	1	1		robin0505					\N	19899912	100088	4	default	TU6m	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
61	github_61		GitHub User	1	1		adhksosne					\N	10087516	9912484	156	default	DUhu	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
52	github_52		GitHub User	1	1		shisanliu22-cmd					\N	19904937	95063	5	default	m1Tz	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
53	github_53		GitHub User	1	1		13844028604					\N	19810612	189388	7	default	kGVW	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
58	github_58		Xiao Yuxin 	1	1	1926592153@qq.com	FloyFrancis					\N	30000000	0	0	default	9Nki	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
55	github_55		Xun_寻	1	1		xc94188					\N	30000000	0	0	default	QQF8	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
57	github_57		GitHub User	1	1		ck328					\N	20000000	0	0	default	ogCk	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
54	github_54		GitHub User	1	1		shizuku-cn					\N	29865511	134489	6	default	sEdr	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
62	github_62		GitHub User	1	1		mick839					\N	10000000	0	0	default	TkQc	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
59	github_59		GitHub User	1	1		helloe365					1DpdihGlw9Zs9NF9kpBHOAaLsqwY    	29971122	28878	3	default	HqFP	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
60	github_60		GitHub User	1	1		CikeSeven					\N	8316176	11683824	244	default	cYCI	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
48	github_48		GitHub User	1	1		boomzalk					\N	30000000	0	0	default	CTR4	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
63	github_63		GitHub User	1	1		Jchase0126					\N	30000000	0	0	default	16H4	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
50	github_50		彭于晏	1	1		ZT1314888					\N	103502	9896498	110	default	aIQl	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
68	github_68		GitHub User	1	1		shuang880917					\N	20000000	0	0	default	F2JE	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
65	github_65		GitHub User	1	1		919888410					\N	29999924	76	1	default	le9G	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
64	github_64		Myan	1	1		moyanislth					\N	40000000	0	0	default	nnuL	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
66	github_66		GitHub User	1	1		DNAsss1					\N	10000000	0	0	default	C5zW	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
67	github_67		GitHub User	1	1		45072yy980					\N	20000000	0	0	default	zDdM	0	0	0	0	\N		{"gotify_priority":0,"sidebar_modules":"{\\"chat\\":{\\"chat\\":true,\\"enabled\\":true,\\"playground\\":true},\\"console\\":{\\"detail\\":true,\\"enabled\\":true,\\"log\\":true,\\"midjourney\\":true,\\"task\\":true,\\"token\\":true},\\"personal\\":{\\"enabled\\":true,\\"personal\\":true,\\"topup\\":true}}"}		
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

SELECT pg_catalog.setval('public.channels_id_seq', 8, true);


--
-- Name: checkins_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.checkins_id_seq', 106, true);


--
-- Name: logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.logs_id_seq', 2269, true);


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

SELECT pg_catalog.setval('public.quota_data_id_seq', 102, true);


--
-- Name: redemptions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.redemptions_id_seq', 30, true);


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

SELECT pg_catalog.setval('public.tokens_id_seq', 38, true);


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

SELECT pg_catalog.setval('public.users_id_seq', 68, true);


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

\unrestrict bBTsJhoUkV3IxPapVCXCBegFlUQOclstIGFWIVLc3euLg5bEkV5joegWPzgpp6h

