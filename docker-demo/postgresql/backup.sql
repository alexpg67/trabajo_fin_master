--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2 (Debian 16.2-1.pgdg120+2)
-- Dumped by pg_dump version 16.2 (Debian 16.2-1.pgdg120+2)

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
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


ALTER TABLE public.admin_event_entity OWNER TO keycloak;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO keycloak;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO keycloak;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO keycloak;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO keycloak;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO keycloak;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO keycloak;

--
-- Name: client; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO keycloak;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.client_attributes OWNER TO keycloak;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO keycloak;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO keycloak;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO keycloak;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO keycloak;

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO keycloak;

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO keycloak;

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO keycloak;

--
-- Name: client_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


ALTER TABLE public.client_session OWNER TO keycloak;

--
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_auth_status OWNER TO keycloak;

--
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_note OWNER TO keycloak;

--
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_prot_mapper OWNER TO keycloak;

--
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_role OWNER TO keycloak;

--
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_user_session_note OWNER TO keycloak;

--
-- Name: component; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO keycloak;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.component_config OWNER TO keycloak;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO keycloak;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.credential OWNER TO keycloak;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO keycloak;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO keycloak;

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO keycloak;

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255),
    details_json_long_value text
);


ALTER TABLE public.event_entity OWNER TO keycloak;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024)
);


ALTER TABLE public.fed_user_attribute OWNER TO keycloak;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO keycloak;

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO keycloak;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO keycloak;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO keycloak;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO keycloak;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO keycloak;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO keycloak;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO keycloak;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO keycloak;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO keycloak;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL
);


ALTER TABLE public.identity_provider OWNER TO keycloak;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO keycloak;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO keycloak;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO keycloak;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36)
);


ALTER TABLE public.keycloak_group OWNER TO keycloak;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO keycloak;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO keycloak;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL
);


ALTER TABLE public.offline_client_session OWNER TO keycloak;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.offline_user_session OWNER TO keycloak;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO keycloak;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO keycloak;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO keycloak;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE public.realm OWNER TO keycloak;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO keycloak;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO keycloak;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO keycloak;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO keycloak;

--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO keycloak;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO keycloak;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO keycloak;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO keycloak;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO keycloak;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO keycloak;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO keycloak;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO keycloak;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO keycloak;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO keycloak;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode smallint NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO keycloak;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO keycloak;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy smallint,
    logic smallint,
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO keycloak;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO keycloak;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO keycloak;

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO keycloak;

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO keycloak;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO keycloak;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO keycloak;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL
);


ALTER TABLE public.user_attribute OWNER TO keycloak;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO keycloak;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO keycloak;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO keycloak;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO keycloak;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO keycloak;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO keycloak;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO keycloak;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO keycloak;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO keycloak;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO keycloak;

--
-- Name: user_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


ALTER TABLE public.user_session OWNER TO keycloak;

--
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


ALTER TABLE public.user_session_note OWNER TO keycloak;

--
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE public.username_login_failure OWNER TO keycloak;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO keycloak;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
1e865488-2a35-4f52-983d-f750ddc8ca3f	\N	auth-cookie	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	f678937f-865b-4074-a754-82e213c80382	2	10	f	\N	\N
c19353ab-2c39-4552-b2b8-54ceada49985	\N	auth-spnego	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	f678937f-865b-4074-a754-82e213c80382	3	20	f	\N	\N
3d435892-f96d-4dfb-bea3-50b4a472cc28	\N	identity-provider-redirector	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	f678937f-865b-4074-a754-82e213c80382	2	25	f	\N	\N
fc9575a8-a340-4b1d-b4af-fd4b7dd245d1	\N	\N	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	f678937f-865b-4074-a754-82e213c80382	2	30	t	e9116fa4-b156-4a41-94ae-f774f8ba7183	\N
05e5515f-9bad-4ba6-b3c2-c55239ce6ad0	\N	auth-username-password-form	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	e9116fa4-b156-4a41-94ae-f774f8ba7183	0	10	f	\N	\N
5dce1981-b936-4f80-8edb-1ff9dde31075	\N	\N	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	e9116fa4-b156-4a41-94ae-f774f8ba7183	1	20	t	8f5fa309-b647-4296-a6c6-0bd8ec33c1db	\N
0b6cfbbb-6cc0-42aa-9948-cfce3697fcbc	\N	conditional-user-configured	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	8f5fa309-b647-4296-a6c6-0bd8ec33c1db	0	10	f	\N	\N
6a423fb1-7396-4bf8-88a3-9fde7189bf5e	\N	auth-otp-form	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	8f5fa309-b647-4296-a6c6-0bd8ec33c1db	0	20	f	\N	\N
ac6d934e-8598-458e-a9bf-e120d7c44053	\N	direct-grant-validate-username	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	d27189a6-9abb-4315-9e3e-045cf5fdd1ba	0	10	f	\N	\N
af406996-2f18-4b60-a907-2932417eadcb	\N	direct-grant-validate-password	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	d27189a6-9abb-4315-9e3e-045cf5fdd1ba	0	20	f	\N	\N
773d3211-7ddf-4b82-b333-e149a6abbbeb	\N	\N	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	d27189a6-9abb-4315-9e3e-045cf5fdd1ba	1	30	t	199e69a1-fbdf-43d4-adfb-b6a16793e0fe	\N
7b08b1f6-37cf-427b-ba73-5c1e24fdf79b	\N	conditional-user-configured	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	199e69a1-fbdf-43d4-adfb-b6a16793e0fe	0	10	f	\N	\N
3179221f-6cd3-4b76-bd84-62ac27f35e6d	\N	direct-grant-validate-otp	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	199e69a1-fbdf-43d4-adfb-b6a16793e0fe	0	20	f	\N	\N
e8bbe373-0ebc-404e-9faa-f92d4bf4088c	\N	registration-page-form	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	c1b94457-348a-47d7-8592-f5336e4a6581	0	10	t	76e41940-1bb8-4cb7-a13c-88d245d6743c	\N
ac5a2ce9-5bc5-461c-981d-111bfe0e7e4c	\N	registration-user-creation	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	76e41940-1bb8-4cb7-a13c-88d245d6743c	0	20	f	\N	\N
2f3590d7-0889-4e85-b363-da0799b408cf	\N	registration-password-action	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	76e41940-1bb8-4cb7-a13c-88d245d6743c	0	50	f	\N	\N
821fc2b1-674e-4e5b-8345-a25ef3252725	\N	registration-recaptcha-action	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	76e41940-1bb8-4cb7-a13c-88d245d6743c	3	60	f	\N	\N
d337138d-2479-4334-b9e1-940ec581b516	\N	registration-terms-and-conditions	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	76e41940-1bb8-4cb7-a13c-88d245d6743c	3	70	f	\N	\N
ec4edb6c-d2a3-40e5-a214-b6b86aa2c3d2	\N	reset-credentials-choose-user	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	8dbb758c-0b91-4fe9-a0d9-4450db534b6f	0	10	f	\N	\N
95091630-536d-4338-b864-c89f6a4e3d72	\N	reset-credential-email	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	8dbb758c-0b91-4fe9-a0d9-4450db534b6f	0	20	f	\N	\N
5e8f78f3-705c-44c2-a7e3-228f8ca8b1c0	\N	reset-password	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	8dbb758c-0b91-4fe9-a0d9-4450db534b6f	0	30	f	\N	\N
dcb71f5f-c8d8-4812-b0c0-a248a2739d5c	\N	\N	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	8dbb758c-0b91-4fe9-a0d9-4450db534b6f	1	40	t	48e61674-4323-4b23-8a08-210316fed275	\N
bc3357d5-1fdf-4b28-a8ac-5a580c0d1f39	\N	conditional-user-configured	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	48e61674-4323-4b23-8a08-210316fed275	0	10	f	\N	\N
d6ed358c-844a-4930-9952-7a48b6f90331	\N	reset-otp	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	48e61674-4323-4b23-8a08-210316fed275	0	20	f	\N	\N
c9885e6f-5999-43b5-a7b3-71df55d01dfa	\N	client-secret	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	109fdb68-0800-4ba4-9dfc-1a112d0fcbe8	2	10	f	\N	\N
83a33c9f-f79c-440c-b75f-cbc6a7e63940	\N	client-jwt	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	109fdb68-0800-4ba4-9dfc-1a112d0fcbe8	2	20	f	\N	\N
4ba52fc8-e82c-42ad-8ccc-3b88a67645b9	\N	client-secret-jwt	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	109fdb68-0800-4ba4-9dfc-1a112d0fcbe8	2	30	f	\N	\N
f8938257-94e5-4544-934e-eef1113592a7	\N	client-x509	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	109fdb68-0800-4ba4-9dfc-1a112d0fcbe8	2	40	f	\N	\N
85097b11-4109-4d6b-b3a1-c6d2302a36bf	\N	idp-review-profile	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	b18c24c3-9d49-47e3-bfde-90094b0027a9	0	10	f	\N	78371d75-1e83-438d-a986-9ef5959d5af9
df18cb36-4c66-4b18-aa97-ede06c2e1a15	\N	\N	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	b18c24c3-9d49-47e3-bfde-90094b0027a9	0	20	t	88e0965b-ee3b-4a31-9a24-42ec6df44624	\N
6df32c59-3400-484c-9699-d84bf9d45b8d	\N	idp-create-user-if-unique	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	88e0965b-ee3b-4a31-9a24-42ec6df44624	2	10	f	\N	b825b1ed-530e-4d38-bd79-399e0715b706
1b00e3a0-76e6-42ab-9c9b-e926806429c5	\N	\N	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	88e0965b-ee3b-4a31-9a24-42ec6df44624	2	20	t	93030258-90b8-4503-8852-a8bcb5cf3f98	\N
fc347c3e-0e38-4629-8245-8c6a1973a3cc	\N	idp-confirm-link	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	93030258-90b8-4503-8852-a8bcb5cf3f98	0	10	f	\N	\N
e94161d7-1d35-4ed9-961c-9bcf30f79e10	\N	\N	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	93030258-90b8-4503-8852-a8bcb5cf3f98	0	20	t	44c1266b-e339-4f12-98fa-406064f8b9c8	\N
1ae67dc4-dcaa-42ea-b542-ef6836963b16	\N	idp-email-verification	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	44c1266b-e339-4f12-98fa-406064f8b9c8	2	10	f	\N	\N
220366c3-0571-4964-b1a6-657cae43418c	\N	\N	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	44c1266b-e339-4f12-98fa-406064f8b9c8	2	20	t	64cd9eaa-e533-443b-a264-e53b751cf142	\N
34d77ce2-ce5c-422d-b4d0-4631f954565c	\N	idp-username-password-form	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	64cd9eaa-e533-443b-a264-e53b751cf142	0	10	f	\N	\N
a8ef392b-c862-477a-b07b-7a3298f625a2	\N	\N	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	64cd9eaa-e533-443b-a264-e53b751cf142	1	20	t	190fdddc-97ba-40f9-abcb-d983f43cec67	\N
df1cf19e-6d70-479a-9ec0-cb54c4fdff3c	\N	conditional-user-configured	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	190fdddc-97ba-40f9-abcb-d983f43cec67	0	10	f	\N	\N
9e6afc2a-8684-4a5b-b896-4a6b94c03bd2	\N	auth-otp-form	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	190fdddc-97ba-40f9-abcb-d983f43cec67	0	20	f	\N	\N
ab142ef2-effa-49e1-87c5-0e4ce0e41b1a	\N	http-basic-authenticator	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	eda6a6c2-7779-420b-b04e-100cdea29adc	0	10	f	\N	\N
0d65af0c-78ae-4a07-aea4-ddfb0325f03c	\N	docker-http-basic-authenticator	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	c8f544f4-973f-48a6-9b6a-639c8abd44c9	0	10	f	\N	\N
87bac022-adc7-42d8-a517-7df29118cb08	\N	auth-cookie	770ce898-e404-41ae-b791-ebab6d704c10	29345d10-e38a-46dc-b6ca-7d13aea63ad0	2	10	f	\N	\N
18585f5f-1a27-4a47-8f28-ebd401a240b8	\N	auth-spnego	770ce898-e404-41ae-b791-ebab6d704c10	29345d10-e38a-46dc-b6ca-7d13aea63ad0	3	20	f	\N	\N
c0b33cdb-6eee-4dc7-b619-552f653e67ef	\N	identity-provider-redirector	770ce898-e404-41ae-b791-ebab6d704c10	29345d10-e38a-46dc-b6ca-7d13aea63ad0	2	25	f	\N	\N
a7e22b49-0d91-4892-a814-7f6214c8495b	\N	\N	770ce898-e404-41ae-b791-ebab6d704c10	29345d10-e38a-46dc-b6ca-7d13aea63ad0	2	30	t	57c84697-b61d-4346-b5c6-12d6b94ff55a	\N
2f177da9-0e40-4648-a38a-c7024b933a9d	\N	auth-username-password-form	770ce898-e404-41ae-b791-ebab6d704c10	57c84697-b61d-4346-b5c6-12d6b94ff55a	0	10	f	\N	\N
20a0c80e-132e-4b39-bad9-00bf7ebf27c0	\N	\N	770ce898-e404-41ae-b791-ebab6d704c10	57c84697-b61d-4346-b5c6-12d6b94ff55a	1	20	t	94b84b99-232d-4105-8875-09361a2a9237	\N
ec7e8ea5-ef22-4453-b888-a26cbdf67f04	\N	conditional-user-configured	770ce898-e404-41ae-b791-ebab6d704c10	94b84b99-232d-4105-8875-09361a2a9237	0	10	f	\N	\N
7a642840-fa5a-466d-b3bf-4b4890098c97	\N	auth-otp-form	770ce898-e404-41ae-b791-ebab6d704c10	94b84b99-232d-4105-8875-09361a2a9237	0	20	f	\N	\N
85d98711-b2ac-4245-ad12-d83dbfe21d30	\N	direct-grant-validate-username	770ce898-e404-41ae-b791-ebab6d704c10	f3e3a417-892f-4fb4-a3da-d35b09fbbd01	0	10	f	\N	\N
f97912a4-1a5e-4445-9106-b218386c6ee3	\N	direct-grant-validate-password	770ce898-e404-41ae-b791-ebab6d704c10	f3e3a417-892f-4fb4-a3da-d35b09fbbd01	0	20	f	\N	\N
56b9f5e8-5a9e-40ec-9574-a27560d51492	\N	\N	770ce898-e404-41ae-b791-ebab6d704c10	f3e3a417-892f-4fb4-a3da-d35b09fbbd01	1	30	t	4805336b-3c48-402f-a3ce-372200c449d0	\N
0617c862-af2a-40cf-bcf7-3fa4839af7a4	\N	conditional-user-configured	770ce898-e404-41ae-b791-ebab6d704c10	4805336b-3c48-402f-a3ce-372200c449d0	0	10	f	\N	\N
3ab119b2-e21f-4e46-880b-23ea47805e43	\N	direct-grant-validate-otp	770ce898-e404-41ae-b791-ebab6d704c10	4805336b-3c48-402f-a3ce-372200c449d0	0	20	f	\N	\N
3ef372a7-ddad-4378-aca4-126a12ad7044	\N	registration-page-form	770ce898-e404-41ae-b791-ebab6d704c10	d35473c9-7d75-4b13-8e0f-e99d14d9d2ab	0	10	t	66cde11a-2f50-4ebf-a0f6-af3f2f7dd20a	\N
1934d841-da54-47d4-88bc-c18b4feacf0f	\N	registration-user-creation	770ce898-e404-41ae-b791-ebab6d704c10	66cde11a-2f50-4ebf-a0f6-af3f2f7dd20a	0	20	f	\N	\N
761b229e-411f-45f5-9571-decb76adc821	\N	registration-password-action	770ce898-e404-41ae-b791-ebab6d704c10	66cde11a-2f50-4ebf-a0f6-af3f2f7dd20a	0	50	f	\N	\N
9e3fafd3-fd14-454b-b732-1626419f3ed4	\N	registration-recaptcha-action	770ce898-e404-41ae-b791-ebab6d704c10	66cde11a-2f50-4ebf-a0f6-af3f2f7dd20a	3	60	f	\N	\N
70dc81dd-58e0-42a0-a165-1346757edb74	\N	reset-credentials-choose-user	770ce898-e404-41ae-b791-ebab6d704c10	c9e9ccc1-c1f2-4b24-bb9a-f0b750124abd	0	10	f	\N	\N
d7942c85-d5b3-4b42-b5e2-389be966df61	\N	reset-credential-email	770ce898-e404-41ae-b791-ebab6d704c10	c9e9ccc1-c1f2-4b24-bb9a-f0b750124abd	0	20	f	\N	\N
744eb3fa-bf2d-44d0-85b0-f374865ced12	\N	reset-password	770ce898-e404-41ae-b791-ebab6d704c10	c9e9ccc1-c1f2-4b24-bb9a-f0b750124abd	0	30	f	\N	\N
80b4a70a-7edf-4fa2-a4a3-bd3707035c4f	\N	\N	770ce898-e404-41ae-b791-ebab6d704c10	c9e9ccc1-c1f2-4b24-bb9a-f0b750124abd	1	40	t	29f7d4d8-2c32-4134-9e32-6f5d432accbf	\N
6fb14c54-8ee2-4803-83f3-5e4fa7fbd523	\N	conditional-user-configured	770ce898-e404-41ae-b791-ebab6d704c10	29f7d4d8-2c32-4134-9e32-6f5d432accbf	0	10	f	\N	\N
3561b895-e815-449a-933d-a185579d954a	\N	reset-otp	770ce898-e404-41ae-b791-ebab6d704c10	29f7d4d8-2c32-4134-9e32-6f5d432accbf	0	20	f	\N	\N
374ff71f-7486-4f62-a575-1e98ce28cd47	\N	client-secret	770ce898-e404-41ae-b791-ebab6d704c10	9c590b16-bf92-46d3-8a32-17856b4d6ded	2	10	f	\N	\N
33c9231a-b2ff-46e4-a74a-d93f01c4b63a	\N	client-jwt	770ce898-e404-41ae-b791-ebab6d704c10	9c590b16-bf92-46d3-8a32-17856b4d6ded	2	20	f	\N	\N
ea92c4f7-8add-4232-a0bf-2832a4908efa	\N	client-secret-jwt	770ce898-e404-41ae-b791-ebab6d704c10	9c590b16-bf92-46d3-8a32-17856b4d6ded	2	30	f	\N	\N
dd6c40f1-92d5-4e38-9d01-7a6ee3cbfb9f	\N	client-x509	770ce898-e404-41ae-b791-ebab6d704c10	9c590b16-bf92-46d3-8a32-17856b4d6ded	2	40	f	\N	\N
6603c12b-8a2b-48db-bb4d-8bcb94757f53	\N	idp-review-profile	770ce898-e404-41ae-b791-ebab6d704c10	4ca6d9a4-322d-4afd-bf0e-17f642ddfab5	0	10	f	\N	e568f296-b31c-4643-bd1a-9a7ba007ff9b
fef00f76-73f6-422c-aac6-1f2f96788c97	\N	\N	770ce898-e404-41ae-b791-ebab6d704c10	4ca6d9a4-322d-4afd-bf0e-17f642ddfab5	0	20	t	113009b0-b67c-45b0-b3d9-07e2ac37755b	\N
1e9971d2-f254-4e0f-beb8-888020a8ab18	\N	idp-create-user-if-unique	770ce898-e404-41ae-b791-ebab6d704c10	113009b0-b67c-45b0-b3d9-07e2ac37755b	2	10	f	\N	ab65bd37-ddaa-4abc-a3d9-03df7a1ce95d
aaf6e72a-abac-4a20-b22e-14a390a85a24	\N	\N	770ce898-e404-41ae-b791-ebab6d704c10	113009b0-b67c-45b0-b3d9-07e2ac37755b	2	20	t	1fff2cdb-1ca0-41d9-a2c8-1e68894863b1	\N
0c06f493-d303-401d-8cc1-4679ef7dac86	\N	idp-confirm-link	770ce898-e404-41ae-b791-ebab6d704c10	1fff2cdb-1ca0-41d9-a2c8-1e68894863b1	0	10	f	\N	\N
5101f3fc-ed24-4b3c-a1a6-be53b88a728c	\N	\N	770ce898-e404-41ae-b791-ebab6d704c10	1fff2cdb-1ca0-41d9-a2c8-1e68894863b1	0	20	t	8d17efcf-64c5-41c2-80d0-94e86db585e9	\N
6abbb516-3d5c-44be-9b9f-1e95d6d1c2e5	\N	idp-email-verification	770ce898-e404-41ae-b791-ebab6d704c10	8d17efcf-64c5-41c2-80d0-94e86db585e9	2	10	f	\N	\N
13c769c0-8394-4b12-8cbf-3e9d620b434a	\N	\N	770ce898-e404-41ae-b791-ebab6d704c10	8d17efcf-64c5-41c2-80d0-94e86db585e9	2	20	t	df4e8434-c16a-4310-9e51-6906452d11cb	\N
5492a30e-fe23-47fc-bb04-b706da383305	\N	idp-username-password-form	770ce898-e404-41ae-b791-ebab6d704c10	df4e8434-c16a-4310-9e51-6906452d11cb	0	10	f	\N	\N
73cc95af-c26f-4974-acf0-dfc19bc369c9	\N	\N	770ce898-e404-41ae-b791-ebab6d704c10	df4e8434-c16a-4310-9e51-6906452d11cb	1	20	t	a7b6acd1-057a-4c1b-a557-07dc08fd99b4	\N
2c867c7d-716b-4c58-9956-a99891dc7dae	\N	conditional-user-configured	770ce898-e404-41ae-b791-ebab6d704c10	a7b6acd1-057a-4c1b-a557-07dc08fd99b4	0	10	f	\N	\N
20166b05-f3ae-44a5-a41a-041288e8d500	\N	auth-otp-form	770ce898-e404-41ae-b791-ebab6d704c10	a7b6acd1-057a-4c1b-a557-07dc08fd99b4	0	20	f	\N	\N
8c8d6915-209e-40f9-a932-398c264db064	\N	http-basic-authenticator	770ce898-e404-41ae-b791-ebab6d704c10	a025221d-47b6-4136-8faa-bb50252b5e4f	0	10	f	\N	\N
9eaa1c0a-add9-4b6a-83a8-ac85518eea1f	\N	docker-http-basic-authenticator	770ce898-e404-41ae-b791-ebab6d704c10	58b48345-bde2-4a5b-b86c-ad4bc57e741c	0	10	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
f678937f-865b-4074-a754-82e213c80382	browser	browser based authentication	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	basic-flow	t	t
e9116fa4-b156-4a41-94ae-f774f8ba7183	forms	Username, password, otp and other auth forms.	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	basic-flow	f	t
8f5fa309-b647-4296-a6c6-0bd8ec33c1db	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	basic-flow	f	t
d27189a6-9abb-4315-9e3e-045cf5fdd1ba	direct grant	OpenID Connect Resource Owner Grant	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	basic-flow	t	t
199e69a1-fbdf-43d4-adfb-b6a16793e0fe	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	basic-flow	f	t
c1b94457-348a-47d7-8592-f5336e4a6581	registration	registration flow	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	basic-flow	t	t
76e41940-1bb8-4cb7-a13c-88d245d6743c	registration form	registration form	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	form-flow	f	t
8dbb758c-0b91-4fe9-a0d9-4450db534b6f	reset credentials	Reset credentials for a user if they forgot their password or something	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	basic-flow	t	t
48e61674-4323-4b23-8a08-210316fed275	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	basic-flow	f	t
109fdb68-0800-4ba4-9dfc-1a112d0fcbe8	clients	Base authentication for clients	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	client-flow	t	t
b18c24c3-9d49-47e3-bfde-90094b0027a9	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	basic-flow	t	t
88e0965b-ee3b-4a31-9a24-42ec6df44624	User creation or linking	Flow for the existing/non-existing user alternatives	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	basic-flow	f	t
93030258-90b8-4503-8852-a8bcb5cf3f98	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	basic-flow	f	t
44c1266b-e339-4f12-98fa-406064f8b9c8	Account verification options	Method with which to verity the existing account	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	basic-flow	f	t
64cd9eaa-e533-443b-a264-e53b751cf142	Verify Existing Account by Re-authentication	Reauthentication of existing account	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	basic-flow	f	t
190fdddc-97ba-40f9-abcb-d983f43cec67	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	basic-flow	f	t
eda6a6c2-7779-420b-b04e-100cdea29adc	saml ecp	SAML ECP Profile Authentication Flow	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	basic-flow	t	t
c8f544f4-973f-48a6-9b6a-639c8abd44c9	docker auth	Used by Docker clients to authenticate against the IDP	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	basic-flow	t	t
29345d10-e38a-46dc-b6ca-7d13aea63ad0	browser	browser based authentication	770ce898-e404-41ae-b791-ebab6d704c10	basic-flow	t	t
57c84697-b61d-4346-b5c6-12d6b94ff55a	forms	Username, password, otp and other auth forms.	770ce898-e404-41ae-b791-ebab6d704c10	basic-flow	f	t
94b84b99-232d-4105-8875-09361a2a9237	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	770ce898-e404-41ae-b791-ebab6d704c10	basic-flow	f	t
f3e3a417-892f-4fb4-a3da-d35b09fbbd01	direct grant	OpenID Connect Resource Owner Grant	770ce898-e404-41ae-b791-ebab6d704c10	basic-flow	t	t
4805336b-3c48-402f-a3ce-372200c449d0	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	770ce898-e404-41ae-b791-ebab6d704c10	basic-flow	f	t
d35473c9-7d75-4b13-8e0f-e99d14d9d2ab	registration	registration flow	770ce898-e404-41ae-b791-ebab6d704c10	basic-flow	t	t
66cde11a-2f50-4ebf-a0f6-af3f2f7dd20a	registration form	registration form	770ce898-e404-41ae-b791-ebab6d704c10	form-flow	f	t
c9e9ccc1-c1f2-4b24-bb9a-f0b750124abd	reset credentials	Reset credentials for a user if they forgot their password or something	770ce898-e404-41ae-b791-ebab6d704c10	basic-flow	t	t
29f7d4d8-2c32-4134-9e32-6f5d432accbf	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	770ce898-e404-41ae-b791-ebab6d704c10	basic-flow	f	t
9c590b16-bf92-46d3-8a32-17856b4d6ded	clients	Base authentication for clients	770ce898-e404-41ae-b791-ebab6d704c10	client-flow	t	t
4ca6d9a4-322d-4afd-bf0e-17f642ddfab5	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	770ce898-e404-41ae-b791-ebab6d704c10	basic-flow	t	t
113009b0-b67c-45b0-b3d9-07e2ac37755b	User creation or linking	Flow for the existing/non-existing user alternatives	770ce898-e404-41ae-b791-ebab6d704c10	basic-flow	f	t
1fff2cdb-1ca0-41d9-a2c8-1e68894863b1	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	770ce898-e404-41ae-b791-ebab6d704c10	basic-flow	f	t
8d17efcf-64c5-41c2-80d0-94e86db585e9	Account verification options	Method with which to verity the existing account	770ce898-e404-41ae-b791-ebab6d704c10	basic-flow	f	t
df4e8434-c16a-4310-9e51-6906452d11cb	Verify Existing Account by Re-authentication	Reauthentication of existing account	770ce898-e404-41ae-b791-ebab6d704c10	basic-flow	f	t
a7b6acd1-057a-4c1b-a557-07dc08fd99b4	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	770ce898-e404-41ae-b791-ebab6d704c10	basic-flow	f	t
a025221d-47b6-4136-8faa-bb50252b5e4f	saml ecp	SAML ECP Profile Authentication Flow	770ce898-e404-41ae-b791-ebab6d704c10	basic-flow	t	t
58b48345-bde2-4a5b-b86c-ad4bc57e741c	docker auth	Used by Docker clients to authenticate against the IDP	770ce898-e404-41ae-b791-ebab6d704c10	basic-flow	t	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
78371d75-1e83-438d-a986-9ef5959d5af9	review profile config	3c6fae4f-56d1-403c-bd4a-c40d238a11c6
b825b1ed-530e-4d38-bd79-399e0715b706	create unique user config	3c6fae4f-56d1-403c-bd4a-c40d238a11c6
e568f296-b31c-4643-bd1a-9a7ba007ff9b	review profile config	770ce898-e404-41ae-b791-ebab6d704c10
ab65bd37-ddaa-4abc-a3d9-03df7a1ce95d	create unique user config	770ce898-e404-41ae-b791-ebab6d704c10
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
78371d75-1e83-438d-a986-9ef5959d5af9	missing	update.profile.on.first.login
b825b1ed-530e-4d38-bd79-399e0715b706	false	require.password.update.after.registration
ab65bd37-ddaa-4abc-a3d9-03df7a1ce95d	false	require.password.update.after.registration
e568f296-b31c-4643-bd1a-9a7ba007ff9b	missing	update.profile.on.first.login
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
426ae130-9585-4285-a441-53a1324072e1	t	f	master-realm	0	f	\N	\N	t	\N	f	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
ecdf389d-bd04-468c-8335-78947724ba88	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
12498f03-3e07-4cd1-b487-a273d83f3eab	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
02ab83e5-64e4-44d6-a02d-12d2f9412492	t	f	broker	0	f	\N	\N	t	\N	f	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
93beb22d-1ff6-4d50-82e6-ef0da73e38fc	t	f	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
0b54550e-52f6-487a-bcbf-1beaa43ae5e6	t	f	admin-cli	0	t	\N	\N	f	\N	f	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
996850a3-73fb-4987-9a88-9c59ca8f0622	t	f	Test-realm	0	f	\N	\N	t	\N	f	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	\N	0	f	f	Test Realm	f	client-secret	\N	\N	\N	t	f	f	f
d4ea4781-4a6c-4f38-b0c0-8eb810dadb4f	t	f	realm-management	0	f	\N	\N	t	\N	f	770ce898-e404-41ae-b791-ebab6d704c10	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
451405e8-0990-4be8-82f7-d58ca59a526a	t	f	account	0	t	\N	/realms/Test/account/	f	\N	f	770ce898-e404-41ae-b791-ebab6d704c10	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
93da7221-98b3-48e8-bb4a-6af01719939d	t	f	account-console	0	t	\N	/realms/Test/account/	f	\N	f	770ce898-e404-41ae-b791-ebab6d704c10	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
8f9c30d9-585a-43b7-886d-5cac5bee3723	t	f	broker	0	f	\N	\N	t	\N	f	770ce898-e404-41ae-b791-ebab6d704c10	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
38dbec92-9c98-47c0-bde7-ec544a99c850	t	f	security-admin-console	0	t	\N	/admin/Test/console/	f	\N	f	770ce898-e404-41ae-b791-ebab6d704c10	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
17c0d683-36e4-4620-9719-58c39ea62639	t	f	admin-cli	0	t	\N	\N	f	\N	f	770ce898-e404-41ae-b791-ebab6d704c10	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
15850342-cc1c-460f-b0d6-23700ebc0190	t	t	prueba	0	f	1JsLTnYN3PicBWEZwcY702I8vlAaeyNs		f		f	770ce898-e404-41ae-b791-ebab6d704c10	openid-connect	-1	t	f	prueba	t	client-secret			\N	t	f	t	f
361bd82d-af62-49ef-9c67-cfa4dc361754	t	t	kong	0	f	S7RbZwIsZPJ6vedhbb81pro8rrKqV5Lp		f		f	770ce898-e404-41ae-b791-ebab6d704c10	openid-connect	-1	t	f	Kong Client	f	client-jwt		Kong client for client credentials flow	\N	t	f	t	t
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_attributes (client_id, name, value) FROM stdin;
ecdf389d-bd04-468c-8335-78947724ba88	post.logout.redirect.uris	+
12498f03-3e07-4cd1-b487-a273d83f3eab	post.logout.redirect.uris	+
12498f03-3e07-4cd1-b487-a273d83f3eab	pkce.code.challenge.method	S256
93beb22d-1ff6-4d50-82e6-ef0da73e38fc	post.logout.redirect.uris	+
93beb22d-1ff6-4d50-82e6-ef0da73e38fc	pkce.code.challenge.method	S256
451405e8-0990-4be8-82f7-d58ca59a526a	post.logout.redirect.uris	+
93da7221-98b3-48e8-bb4a-6af01719939d	post.logout.redirect.uris	+
93da7221-98b3-48e8-bb4a-6af01719939d	pkce.code.challenge.method	S256
38dbec92-9c98-47c0-bde7-ec544a99c850	post.logout.redirect.uris	+
38dbec92-9c98-47c0-bde7-ec544a99c850	pkce.code.challenge.method	S256
15850342-cc1c-460f-b0d6-23700ebc0190	client.secret.creation.time	1710789331
15850342-cc1c-460f-b0d6-23700ebc0190	oauth2.device.authorization.grant.enabled	false
15850342-cc1c-460f-b0d6-23700ebc0190	oidc.ciba.grant.enabled	false
15850342-cc1c-460f-b0d6-23700ebc0190	backchannel.logout.session.required	true
15850342-cc1c-460f-b0d6-23700ebc0190	backchannel.logout.revoke.offline.tokens	false
15850342-cc1c-460f-b0d6-23700ebc0190	display.on.consent.screen	false
15850342-cc1c-460f-b0d6-23700ebc0190	login_theme	keycloak
15850342-cc1c-460f-b0d6-23700ebc0190	use.refresh.tokens	true
15850342-cc1c-460f-b0d6-23700ebc0190	client_credentials.use_refresh_token	false
15850342-cc1c-460f-b0d6-23700ebc0190	token.response.type.bearer.lower-case	false
15850342-cc1c-460f-b0d6-23700ebc0190	tls.client.certificate.bound.access.tokens	false
15850342-cc1c-460f-b0d6-23700ebc0190	require.pushed.authorization.requests	false
15850342-cc1c-460f-b0d6-23700ebc0190	acr.loa.map	{}
361bd82d-af62-49ef-9c67-cfa4dc361754	client.secret.creation.time	1711020579
361bd82d-af62-49ef-9c67-cfa4dc361754	oauth2.device.authorization.grant.enabled	false
361bd82d-af62-49ef-9c67-cfa4dc361754	oidc.ciba.grant.enabled	false
361bd82d-af62-49ef-9c67-cfa4dc361754	backchannel.logout.session.required	true
361bd82d-af62-49ef-9c67-cfa4dc361754	backchannel.logout.revoke.offline.tokens	false
361bd82d-af62-49ef-9c67-cfa4dc361754	display.on.consent.screen	false
361bd82d-af62-49ef-9c67-cfa4dc361754	use.refresh.tokens	true
361bd82d-af62-49ef-9c67-cfa4dc361754	client_credentials.use_refresh_token	false
361bd82d-af62-49ef-9c67-cfa4dc361754	token.response.type.bearer.lower-case	false
361bd82d-af62-49ef-9c67-cfa4dc361754	tls.client.certificate.bound.access.tokens	false
361bd82d-af62-49ef-9c67-cfa4dc361754	require.pushed.authorization.requests	false
361bd82d-af62-49ef-9c67-cfa4dc361754	acr.loa.map	{}
361bd82d-af62-49ef-9c67-cfa4dc361754	use.jwks.url	true
361bd82d-af62-49ef-9c67-cfa4dc361754	jwks.url	http://kong.test:8101/openid-connects/jwks
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
f9842426-768c-4fab-bdfc-ee1a349328a4	offline_access	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	OpenID Connect built-in scope: offline_access	openid-connect
dbb27ed8-759e-4ece-b515-3fb4cd3782c8	role_list	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	SAML role list	saml
446284bb-3156-4069-85c7-427094d889bb	profile	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	OpenID Connect built-in scope: profile	openid-connect
f2f81c2e-37bb-4298-870c-5836474d0546	email	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	OpenID Connect built-in scope: email	openid-connect
00b5e17e-cd87-4f68-823c-88b1ebcf2368	address	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	OpenID Connect built-in scope: address	openid-connect
6e6bce90-6d50-4495-8b2b-01223ba19f34	phone	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	OpenID Connect built-in scope: phone	openid-connect
e8f95349-3b51-4494-8b17-ed5dbbd742d6	roles	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	OpenID Connect scope for add user roles to the access token	openid-connect
8dbc724d-80b4-423f-aa3f-ac249cba002a	web-origins	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	OpenID Connect scope for add allowed web origins to the access token	openid-connect
796f251f-4b2a-49c7-886b-816d07963fca	microprofile-jwt	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	Microprofile - JWT built-in scope	openid-connect
72f40971-939d-4144-9467-0dea9a21737b	acr	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
1e742a50-5cf9-453a-a20d-b5417a6fcc8b	offline_access	770ce898-e404-41ae-b791-ebab6d704c10	OpenID Connect built-in scope: offline_access	openid-connect
83063235-df62-4617-8735-13c2af58d906	role_list	770ce898-e404-41ae-b791-ebab6d704c10	SAML role list	saml
b01dc004-c6b3-43b1-ae12-a2af4991a88d	profile	770ce898-e404-41ae-b791-ebab6d704c10	OpenID Connect built-in scope: profile	openid-connect
bcc895ad-1a0e-408b-a359-1b774e18eca7	email	770ce898-e404-41ae-b791-ebab6d704c10	OpenID Connect built-in scope: email	openid-connect
502364c7-4f14-401b-815c-2e11595af00d	address	770ce898-e404-41ae-b791-ebab6d704c10	OpenID Connect built-in scope: address	openid-connect
540a6682-df80-4340-a6dc-a66af8cfbe61	phone	770ce898-e404-41ae-b791-ebab6d704c10	OpenID Connect built-in scope: phone	openid-connect
47230b50-eb33-4814-9ea0-5cc25ee6eb1f	roles	770ce898-e404-41ae-b791-ebab6d704c10	OpenID Connect scope for add user roles to the access token	openid-connect
4af760a8-c5fb-4c59-a041-98bc24956bab	web-origins	770ce898-e404-41ae-b791-ebab6d704c10	OpenID Connect scope for add allowed web origins to the access token	openid-connect
182e9196-0aee-4835-8972-fa87d4265a67	microprofile-jwt	770ce898-e404-41ae-b791-ebab6d704c10	Microprofile - JWT built-in scope	openid-connect
4a6cad40-c778-4fed-ac30-cc24e06d7748	acr	770ce898-e404-41ae-b791-ebab6d704c10	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
f9842426-768c-4fab-bdfc-ee1a349328a4	true	display.on.consent.screen
f9842426-768c-4fab-bdfc-ee1a349328a4	${offlineAccessScopeConsentText}	consent.screen.text
dbb27ed8-759e-4ece-b515-3fb4cd3782c8	true	display.on.consent.screen
dbb27ed8-759e-4ece-b515-3fb4cd3782c8	${samlRoleListScopeConsentText}	consent.screen.text
446284bb-3156-4069-85c7-427094d889bb	true	display.on.consent.screen
446284bb-3156-4069-85c7-427094d889bb	${profileScopeConsentText}	consent.screen.text
446284bb-3156-4069-85c7-427094d889bb	true	include.in.token.scope
f2f81c2e-37bb-4298-870c-5836474d0546	true	display.on.consent.screen
f2f81c2e-37bb-4298-870c-5836474d0546	${emailScopeConsentText}	consent.screen.text
f2f81c2e-37bb-4298-870c-5836474d0546	true	include.in.token.scope
00b5e17e-cd87-4f68-823c-88b1ebcf2368	true	display.on.consent.screen
00b5e17e-cd87-4f68-823c-88b1ebcf2368	${addressScopeConsentText}	consent.screen.text
00b5e17e-cd87-4f68-823c-88b1ebcf2368	true	include.in.token.scope
6e6bce90-6d50-4495-8b2b-01223ba19f34	true	display.on.consent.screen
6e6bce90-6d50-4495-8b2b-01223ba19f34	${phoneScopeConsentText}	consent.screen.text
6e6bce90-6d50-4495-8b2b-01223ba19f34	true	include.in.token.scope
e8f95349-3b51-4494-8b17-ed5dbbd742d6	true	display.on.consent.screen
e8f95349-3b51-4494-8b17-ed5dbbd742d6	${rolesScopeConsentText}	consent.screen.text
e8f95349-3b51-4494-8b17-ed5dbbd742d6	false	include.in.token.scope
8dbc724d-80b4-423f-aa3f-ac249cba002a	false	display.on.consent.screen
8dbc724d-80b4-423f-aa3f-ac249cba002a		consent.screen.text
8dbc724d-80b4-423f-aa3f-ac249cba002a	false	include.in.token.scope
796f251f-4b2a-49c7-886b-816d07963fca	false	display.on.consent.screen
796f251f-4b2a-49c7-886b-816d07963fca	true	include.in.token.scope
72f40971-939d-4144-9467-0dea9a21737b	false	display.on.consent.screen
72f40971-939d-4144-9467-0dea9a21737b	false	include.in.token.scope
1e742a50-5cf9-453a-a20d-b5417a6fcc8b	true	display.on.consent.screen
1e742a50-5cf9-453a-a20d-b5417a6fcc8b	${offlineAccessScopeConsentText}	consent.screen.text
83063235-df62-4617-8735-13c2af58d906	true	display.on.consent.screen
83063235-df62-4617-8735-13c2af58d906	${samlRoleListScopeConsentText}	consent.screen.text
b01dc004-c6b3-43b1-ae12-a2af4991a88d	true	display.on.consent.screen
b01dc004-c6b3-43b1-ae12-a2af4991a88d	${profileScopeConsentText}	consent.screen.text
b01dc004-c6b3-43b1-ae12-a2af4991a88d	true	include.in.token.scope
bcc895ad-1a0e-408b-a359-1b774e18eca7	true	display.on.consent.screen
bcc895ad-1a0e-408b-a359-1b774e18eca7	${emailScopeConsentText}	consent.screen.text
bcc895ad-1a0e-408b-a359-1b774e18eca7	true	include.in.token.scope
502364c7-4f14-401b-815c-2e11595af00d	true	display.on.consent.screen
502364c7-4f14-401b-815c-2e11595af00d	${addressScopeConsentText}	consent.screen.text
502364c7-4f14-401b-815c-2e11595af00d	true	include.in.token.scope
540a6682-df80-4340-a6dc-a66af8cfbe61	true	display.on.consent.screen
540a6682-df80-4340-a6dc-a66af8cfbe61	${phoneScopeConsentText}	consent.screen.text
540a6682-df80-4340-a6dc-a66af8cfbe61	true	include.in.token.scope
47230b50-eb33-4814-9ea0-5cc25ee6eb1f	true	display.on.consent.screen
47230b50-eb33-4814-9ea0-5cc25ee6eb1f	${rolesScopeConsentText}	consent.screen.text
47230b50-eb33-4814-9ea0-5cc25ee6eb1f	false	include.in.token.scope
4af760a8-c5fb-4c59-a041-98bc24956bab	false	display.on.consent.screen
4af760a8-c5fb-4c59-a041-98bc24956bab		consent.screen.text
4af760a8-c5fb-4c59-a041-98bc24956bab	false	include.in.token.scope
182e9196-0aee-4835-8972-fa87d4265a67	false	display.on.consent.screen
182e9196-0aee-4835-8972-fa87d4265a67	true	include.in.token.scope
4a6cad40-c778-4fed-ac30-cc24e06d7748	false	display.on.consent.screen
4a6cad40-c778-4fed-ac30-cc24e06d7748	false	include.in.token.scope
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
ecdf389d-bd04-468c-8335-78947724ba88	446284bb-3156-4069-85c7-427094d889bb	t
ecdf389d-bd04-468c-8335-78947724ba88	e8f95349-3b51-4494-8b17-ed5dbbd742d6	t
ecdf389d-bd04-468c-8335-78947724ba88	8dbc724d-80b4-423f-aa3f-ac249cba002a	t
ecdf389d-bd04-468c-8335-78947724ba88	72f40971-939d-4144-9467-0dea9a21737b	t
ecdf389d-bd04-468c-8335-78947724ba88	f2f81c2e-37bb-4298-870c-5836474d0546	t
ecdf389d-bd04-468c-8335-78947724ba88	f9842426-768c-4fab-bdfc-ee1a349328a4	f
ecdf389d-bd04-468c-8335-78947724ba88	00b5e17e-cd87-4f68-823c-88b1ebcf2368	f
ecdf389d-bd04-468c-8335-78947724ba88	796f251f-4b2a-49c7-886b-816d07963fca	f
ecdf389d-bd04-468c-8335-78947724ba88	6e6bce90-6d50-4495-8b2b-01223ba19f34	f
12498f03-3e07-4cd1-b487-a273d83f3eab	446284bb-3156-4069-85c7-427094d889bb	t
12498f03-3e07-4cd1-b487-a273d83f3eab	e8f95349-3b51-4494-8b17-ed5dbbd742d6	t
12498f03-3e07-4cd1-b487-a273d83f3eab	8dbc724d-80b4-423f-aa3f-ac249cba002a	t
12498f03-3e07-4cd1-b487-a273d83f3eab	72f40971-939d-4144-9467-0dea9a21737b	t
12498f03-3e07-4cd1-b487-a273d83f3eab	f2f81c2e-37bb-4298-870c-5836474d0546	t
12498f03-3e07-4cd1-b487-a273d83f3eab	f9842426-768c-4fab-bdfc-ee1a349328a4	f
12498f03-3e07-4cd1-b487-a273d83f3eab	00b5e17e-cd87-4f68-823c-88b1ebcf2368	f
12498f03-3e07-4cd1-b487-a273d83f3eab	796f251f-4b2a-49c7-886b-816d07963fca	f
12498f03-3e07-4cd1-b487-a273d83f3eab	6e6bce90-6d50-4495-8b2b-01223ba19f34	f
0b54550e-52f6-487a-bcbf-1beaa43ae5e6	446284bb-3156-4069-85c7-427094d889bb	t
0b54550e-52f6-487a-bcbf-1beaa43ae5e6	e8f95349-3b51-4494-8b17-ed5dbbd742d6	t
0b54550e-52f6-487a-bcbf-1beaa43ae5e6	8dbc724d-80b4-423f-aa3f-ac249cba002a	t
0b54550e-52f6-487a-bcbf-1beaa43ae5e6	72f40971-939d-4144-9467-0dea9a21737b	t
0b54550e-52f6-487a-bcbf-1beaa43ae5e6	f2f81c2e-37bb-4298-870c-5836474d0546	t
0b54550e-52f6-487a-bcbf-1beaa43ae5e6	f9842426-768c-4fab-bdfc-ee1a349328a4	f
0b54550e-52f6-487a-bcbf-1beaa43ae5e6	00b5e17e-cd87-4f68-823c-88b1ebcf2368	f
0b54550e-52f6-487a-bcbf-1beaa43ae5e6	796f251f-4b2a-49c7-886b-816d07963fca	f
0b54550e-52f6-487a-bcbf-1beaa43ae5e6	6e6bce90-6d50-4495-8b2b-01223ba19f34	f
02ab83e5-64e4-44d6-a02d-12d2f9412492	446284bb-3156-4069-85c7-427094d889bb	t
02ab83e5-64e4-44d6-a02d-12d2f9412492	e8f95349-3b51-4494-8b17-ed5dbbd742d6	t
02ab83e5-64e4-44d6-a02d-12d2f9412492	8dbc724d-80b4-423f-aa3f-ac249cba002a	t
02ab83e5-64e4-44d6-a02d-12d2f9412492	72f40971-939d-4144-9467-0dea9a21737b	t
02ab83e5-64e4-44d6-a02d-12d2f9412492	f2f81c2e-37bb-4298-870c-5836474d0546	t
02ab83e5-64e4-44d6-a02d-12d2f9412492	f9842426-768c-4fab-bdfc-ee1a349328a4	f
02ab83e5-64e4-44d6-a02d-12d2f9412492	00b5e17e-cd87-4f68-823c-88b1ebcf2368	f
02ab83e5-64e4-44d6-a02d-12d2f9412492	796f251f-4b2a-49c7-886b-816d07963fca	f
02ab83e5-64e4-44d6-a02d-12d2f9412492	6e6bce90-6d50-4495-8b2b-01223ba19f34	f
426ae130-9585-4285-a441-53a1324072e1	446284bb-3156-4069-85c7-427094d889bb	t
426ae130-9585-4285-a441-53a1324072e1	e8f95349-3b51-4494-8b17-ed5dbbd742d6	t
426ae130-9585-4285-a441-53a1324072e1	8dbc724d-80b4-423f-aa3f-ac249cba002a	t
426ae130-9585-4285-a441-53a1324072e1	72f40971-939d-4144-9467-0dea9a21737b	t
426ae130-9585-4285-a441-53a1324072e1	f2f81c2e-37bb-4298-870c-5836474d0546	t
426ae130-9585-4285-a441-53a1324072e1	f9842426-768c-4fab-bdfc-ee1a349328a4	f
426ae130-9585-4285-a441-53a1324072e1	00b5e17e-cd87-4f68-823c-88b1ebcf2368	f
426ae130-9585-4285-a441-53a1324072e1	796f251f-4b2a-49c7-886b-816d07963fca	f
426ae130-9585-4285-a441-53a1324072e1	6e6bce90-6d50-4495-8b2b-01223ba19f34	f
93beb22d-1ff6-4d50-82e6-ef0da73e38fc	446284bb-3156-4069-85c7-427094d889bb	t
93beb22d-1ff6-4d50-82e6-ef0da73e38fc	e8f95349-3b51-4494-8b17-ed5dbbd742d6	t
93beb22d-1ff6-4d50-82e6-ef0da73e38fc	8dbc724d-80b4-423f-aa3f-ac249cba002a	t
93beb22d-1ff6-4d50-82e6-ef0da73e38fc	72f40971-939d-4144-9467-0dea9a21737b	t
93beb22d-1ff6-4d50-82e6-ef0da73e38fc	f2f81c2e-37bb-4298-870c-5836474d0546	t
93beb22d-1ff6-4d50-82e6-ef0da73e38fc	f9842426-768c-4fab-bdfc-ee1a349328a4	f
93beb22d-1ff6-4d50-82e6-ef0da73e38fc	00b5e17e-cd87-4f68-823c-88b1ebcf2368	f
93beb22d-1ff6-4d50-82e6-ef0da73e38fc	796f251f-4b2a-49c7-886b-816d07963fca	f
93beb22d-1ff6-4d50-82e6-ef0da73e38fc	6e6bce90-6d50-4495-8b2b-01223ba19f34	f
451405e8-0990-4be8-82f7-d58ca59a526a	bcc895ad-1a0e-408b-a359-1b774e18eca7	t
451405e8-0990-4be8-82f7-d58ca59a526a	4af760a8-c5fb-4c59-a041-98bc24956bab	t
451405e8-0990-4be8-82f7-d58ca59a526a	4a6cad40-c778-4fed-ac30-cc24e06d7748	t
451405e8-0990-4be8-82f7-d58ca59a526a	47230b50-eb33-4814-9ea0-5cc25ee6eb1f	t
451405e8-0990-4be8-82f7-d58ca59a526a	b01dc004-c6b3-43b1-ae12-a2af4991a88d	t
451405e8-0990-4be8-82f7-d58ca59a526a	1e742a50-5cf9-453a-a20d-b5417a6fcc8b	f
451405e8-0990-4be8-82f7-d58ca59a526a	182e9196-0aee-4835-8972-fa87d4265a67	f
451405e8-0990-4be8-82f7-d58ca59a526a	540a6682-df80-4340-a6dc-a66af8cfbe61	f
451405e8-0990-4be8-82f7-d58ca59a526a	502364c7-4f14-401b-815c-2e11595af00d	f
93da7221-98b3-48e8-bb4a-6af01719939d	bcc895ad-1a0e-408b-a359-1b774e18eca7	t
93da7221-98b3-48e8-bb4a-6af01719939d	4af760a8-c5fb-4c59-a041-98bc24956bab	t
93da7221-98b3-48e8-bb4a-6af01719939d	4a6cad40-c778-4fed-ac30-cc24e06d7748	t
93da7221-98b3-48e8-bb4a-6af01719939d	47230b50-eb33-4814-9ea0-5cc25ee6eb1f	t
93da7221-98b3-48e8-bb4a-6af01719939d	b01dc004-c6b3-43b1-ae12-a2af4991a88d	t
93da7221-98b3-48e8-bb4a-6af01719939d	1e742a50-5cf9-453a-a20d-b5417a6fcc8b	f
93da7221-98b3-48e8-bb4a-6af01719939d	182e9196-0aee-4835-8972-fa87d4265a67	f
93da7221-98b3-48e8-bb4a-6af01719939d	540a6682-df80-4340-a6dc-a66af8cfbe61	f
93da7221-98b3-48e8-bb4a-6af01719939d	502364c7-4f14-401b-815c-2e11595af00d	f
17c0d683-36e4-4620-9719-58c39ea62639	bcc895ad-1a0e-408b-a359-1b774e18eca7	t
17c0d683-36e4-4620-9719-58c39ea62639	4af760a8-c5fb-4c59-a041-98bc24956bab	t
17c0d683-36e4-4620-9719-58c39ea62639	4a6cad40-c778-4fed-ac30-cc24e06d7748	t
17c0d683-36e4-4620-9719-58c39ea62639	47230b50-eb33-4814-9ea0-5cc25ee6eb1f	t
17c0d683-36e4-4620-9719-58c39ea62639	b01dc004-c6b3-43b1-ae12-a2af4991a88d	t
17c0d683-36e4-4620-9719-58c39ea62639	1e742a50-5cf9-453a-a20d-b5417a6fcc8b	f
17c0d683-36e4-4620-9719-58c39ea62639	182e9196-0aee-4835-8972-fa87d4265a67	f
17c0d683-36e4-4620-9719-58c39ea62639	540a6682-df80-4340-a6dc-a66af8cfbe61	f
17c0d683-36e4-4620-9719-58c39ea62639	502364c7-4f14-401b-815c-2e11595af00d	f
8f9c30d9-585a-43b7-886d-5cac5bee3723	bcc895ad-1a0e-408b-a359-1b774e18eca7	t
8f9c30d9-585a-43b7-886d-5cac5bee3723	4af760a8-c5fb-4c59-a041-98bc24956bab	t
8f9c30d9-585a-43b7-886d-5cac5bee3723	4a6cad40-c778-4fed-ac30-cc24e06d7748	t
8f9c30d9-585a-43b7-886d-5cac5bee3723	47230b50-eb33-4814-9ea0-5cc25ee6eb1f	t
8f9c30d9-585a-43b7-886d-5cac5bee3723	b01dc004-c6b3-43b1-ae12-a2af4991a88d	t
8f9c30d9-585a-43b7-886d-5cac5bee3723	1e742a50-5cf9-453a-a20d-b5417a6fcc8b	f
8f9c30d9-585a-43b7-886d-5cac5bee3723	182e9196-0aee-4835-8972-fa87d4265a67	f
8f9c30d9-585a-43b7-886d-5cac5bee3723	540a6682-df80-4340-a6dc-a66af8cfbe61	f
8f9c30d9-585a-43b7-886d-5cac5bee3723	502364c7-4f14-401b-815c-2e11595af00d	f
d4ea4781-4a6c-4f38-b0c0-8eb810dadb4f	bcc895ad-1a0e-408b-a359-1b774e18eca7	t
d4ea4781-4a6c-4f38-b0c0-8eb810dadb4f	4af760a8-c5fb-4c59-a041-98bc24956bab	t
d4ea4781-4a6c-4f38-b0c0-8eb810dadb4f	4a6cad40-c778-4fed-ac30-cc24e06d7748	t
d4ea4781-4a6c-4f38-b0c0-8eb810dadb4f	47230b50-eb33-4814-9ea0-5cc25ee6eb1f	t
d4ea4781-4a6c-4f38-b0c0-8eb810dadb4f	b01dc004-c6b3-43b1-ae12-a2af4991a88d	t
d4ea4781-4a6c-4f38-b0c0-8eb810dadb4f	1e742a50-5cf9-453a-a20d-b5417a6fcc8b	f
d4ea4781-4a6c-4f38-b0c0-8eb810dadb4f	182e9196-0aee-4835-8972-fa87d4265a67	f
d4ea4781-4a6c-4f38-b0c0-8eb810dadb4f	540a6682-df80-4340-a6dc-a66af8cfbe61	f
d4ea4781-4a6c-4f38-b0c0-8eb810dadb4f	502364c7-4f14-401b-815c-2e11595af00d	f
38dbec92-9c98-47c0-bde7-ec544a99c850	bcc895ad-1a0e-408b-a359-1b774e18eca7	t
38dbec92-9c98-47c0-bde7-ec544a99c850	4af760a8-c5fb-4c59-a041-98bc24956bab	t
38dbec92-9c98-47c0-bde7-ec544a99c850	4a6cad40-c778-4fed-ac30-cc24e06d7748	t
38dbec92-9c98-47c0-bde7-ec544a99c850	47230b50-eb33-4814-9ea0-5cc25ee6eb1f	t
38dbec92-9c98-47c0-bde7-ec544a99c850	b01dc004-c6b3-43b1-ae12-a2af4991a88d	t
38dbec92-9c98-47c0-bde7-ec544a99c850	1e742a50-5cf9-453a-a20d-b5417a6fcc8b	f
38dbec92-9c98-47c0-bde7-ec544a99c850	182e9196-0aee-4835-8972-fa87d4265a67	f
38dbec92-9c98-47c0-bde7-ec544a99c850	540a6682-df80-4340-a6dc-a66af8cfbe61	f
38dbec92-9c98-47c0-bde7-ec544a99c850	502364c7-4f14-401b-815c-2e11595af00d	f
15850342-cc1c-460f-b0d6-23700ebc0190	bcc895ad-1a0e-408b-a359-1b774e18eca7	t
15850342-cc1c-460f-b0d6-23700ebc0190	4af760a8-c5fb-4c59-a041-98bc24956bab	t
15850342-cc1c-460f-b0d6-23700ebc0190	4a6cad40-c778-4fed-ac30-cc24e06d7748	t
15850342-cc1c-460f-b0d6-23700ebc0190	47230b50-eb33-4814-9ea0-5cc25ee6eb1f	t
15850342-cc1c-460f-b0d6-23700ebc0190	b01dc004-c6b3-43b1-ae12-a2af4991a88d	t
15850342-cc1c-460f-b0d6-23700ebc0190	1e742a50-5cf9-453a-a20d-b5417a6fcc8b	f
15850342-cc1c-460f-b0d6-23700ebc0190	182e9196-0aee-4835-8972-fa87d4265a67	f
15850342-cc1c-460f-b0d6-23700ebc0190	540a6682-df80-4340-a6dc-a66af8cfbe61	f
15850342-cc1c-460f-b0d6-23700ebc0190	502364c7-4f14-401b-815c-2e11595af00d	f
361bd82d-af62-49ef-9c67-cfa4dc361754	bcc895ad-1a0e-408b-a359-1b774e18eca7	t
361bd82d-af62-49ef-9c67-cfa4dc361754	4af760a8-c5fb-4c59-a041-98bc24956bab	t
361bd82d-af62-49ef-9c67-cfa4dc361754	4a6cad40-c778-4fed-ac30-cc24e06d7748	t
361bd82d-af62-49ef-9c67-cfa4dc361754	47230b50-eb33-4814-9ea0-5cc25ee6eb1f	t
361bd82d-af62-49ef-9c67-cfa4dc361754	b01dc004-c6b3-43b1-ae12-a2af4991a88d	t
361bd82d-af62-49ef-9c67-cfa4dc361754	1e742a50-5cf9-453a-a20d-b5417a6fcc8b	f
361bd82d-af62-49ef-9c67-cfa4dc361754	182e9196-0aee-4835-8972-fa87d4265a67	f
361bd82d-af62-49ef-9c67-cfa4dc361754	540a6682-df80-4340-a6dc-a66af8cfbe61	f
361bd82d-af62-49ef-9c67-cfa4dc361754	502364c7-4f14-401b-815c-2e11595af00d	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
f9842426-768c-4fab-bdfc-ee1a349328a4	280ecf65-9097-42c8-956b-c519b987c9a9
1e742a50-5cf9-453a-a20d-b5417a6fcc8b	83884d76-a951-45ec-b800-6b5be8fe2f68
\.


--
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session (id, client_id, redirect_uri, state, "timestamp", session_id, auth_method, realm_id, auth_user_id, current_action) FROM stdin;
\.


--
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_auth_status (authenticator, status, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_prot_mapper (protocol_mapper_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_role (role_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_user_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
5d2f3da0-1ef2-46e2-8081-32afa71d8694	Trusted Hosts	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	anonymous
4a2cf894-634f-4b4c-a73b-c8f968e36836	Consent Required	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	anonymous
b51555a1-9987-443b-872b-ec7c0726ead3	Full Scope Disabled	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	anonymous
3693442c-ab86-47d6-9d76-79af7215e020	Max Clients Limit	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	anonymous
fc220557-444b-4524-883d-31800c1ad197	Allowed Protocol Mapper Types	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	anonymous
36899ba9-f4a9-4a8b-8d23-c348ab702286	Allowed Client Scopes	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	anonymous
0c50127b-ada2-4731-ae88-38e07c4393f5	Allowed Protocol Mapper Types	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	authenticated
b8ee219d-653e-417f-8b57-ac3e3f4a230f	Allowed Client Scopes	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	authenticated
8fe3f7e0-a974-404f-a73f-bbf051c0cac4	rsa-generated	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	rsa-generated	org.keycloak.keys.KeyProvider	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	\N
36abf9fc-dd5e-4c97-b8f4-516119ab2e7b	rsa-enc-generated	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	rsa-enc-generated	org.keycloak.keys.KeyProvider	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	\N
bbff72b2-e913-458c-976d-e9b5edb95b34	hmac-generated	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	hmac-generated	org.keycloak.keys.KeyProvider	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	\N
f98fb0c9-b051-49ca-9b21-4d5f96e61473	aes-generated	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	aes-generated	org.keycloak.keys.KeyProvider	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	\N
9797805d-8a83-4d2d-b235-2770b54b76af	rsa-generated	770ce898-e404-41ae-b791-ebab6d704c10	rsa-generated	org.keycloak.keys.KeyProvider	770ce898-e404-41ae-b791-ebab6d704c10	\N
af7ade93-b647-4326-8d61-455f0e97751b	rsa-enc-generated	770ce898-e404-41ae-b791-ebab6d704c10	rsa-enc-generated	org.keycloak.keys.KeyProvider	770ce898-e404-41ae-b791-ebab6d704c10	\N
6e8cbf34-dfe4-44cc-bae6-6bdc8f5452b5	hmac-generated	770ce898-e404-41ae-b791-ebab6d704c10	hmac-generated	org.keycloak.keys.KeyProvider	770ce898-e404-41ae-b791-ebab6d704c10	\N
9ed55afa-6491-495a-92c0-9c588ad04ee7	aes-generated	770ce898-e404-41ae-b791-ebab6d704c10	aes-generated	org.keycloak.keys.KeyProvider	770ce898-e404-41ae-b791-ebab6d704c10	\N
ee3b6133-2f7c-4300-bfbc-960d1a372d8d	Trusted Hosts	770ce898-e404-41ae-b791-ebab6d704c10	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	770ce898-e404-41ae-b791-ebab6d704c10	anonymous
616b82a4-8dbc-4e54-8941-3abf3236ac77	Consent Required	770ce898-e404-41ae-b791-ebab6d704c10	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	770ce898-e404-41ae-b791-ebab6d704c10	anonymous
1fc13d82-3ee4-4002-bdf7-00477dbf1ef6	Full Scope Disabled	770ce898-e404-41ae-b791-ebab6d704c10	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	770ce898-e404-41ae-b791-ebab6d704c10	anonymous
8b3a5d0e-0375-46f5-a9ef-cbc39dff6612	Max Clients Limit	770ce898-e404-41ae-b791-ebab6d704c10	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	770ce898-e404-41ae-b791-ebab6d704c10	anonymous
5cb98c67-125d-447b-9589-a4c21b900e82	Allowed Protocol Mapper Types	770ce898-e404-41ae-b791-ebab6d704c10	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	770ce898-e404-41ae-b791-ebab6d704c10	anonymous
e48abb67-f26e-4837-837e-0f2412cd4868	Allowed Client Scopes	770ce898-e404-41ae-b791-ebab6d704c10	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	770ce898-e404-41ae-b791-ebab6d704c10	anonymous
fed87e85-7fc5-45a9-b2de-095fd15e01ad	Allowed Protocol Mapper Types	770ce898-e404-41ae-b791-ebab6d704c10	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	770ce898-e404-41ae-b791-ebab6d704c10	authenticated
f952b80c-477f-4467-aa01-18748b6cfe25	Allowed Client Scopes	770ce898-e404-41ae-b791-ebab6d704c10	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	770ce898-e404-41ae-b791-ebab6d704c10	authenticated
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
f34a2d1c-64f5-46f9-88c1-8fa7775bac0d	3693442c-ab86-47d6-9d76-79af7215e020	max-clients	200
94952924-4689-4e2b-a2a4-60d98af97a52	0c50127b-ada2-4731-ae88-38e07c4393f5	allowed-protocol-mapper-types	saml-user-attribute-mapper
7660a3a0-b265-4442-bfc8-788a5d587c24	0c50127b-ada2-4731-ae88-38e07c4393f5	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
af4f0751-ed8f-49af-bf2b-d51c98031ece	0c50127b-ada2-4731-ae88-38e07c4393f5	allowed-protocol-mapper-types	oidc-full-name-mapper
084382ff-917a-4463-934f-6eaa8667ef83	0c50127b-ada2-4731-ae88-38e07c4393f5	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
d54706e6-f8ef-4eb6-ba47-ad7123e49117	0c50127b-ada2-4731-ae88-38e07c4393f5	allowed-protocol-mapper-types	saml-user-property-mapper
fdbf3c44-b14a-42ff-b317-2df34ae5a7e0	0c50127b-ada2-4731-ae88-38e07c4393f5	allowed-protocol-mapper-types	saml-role-list-mapper
920fe7bb-794a-45ee-897f-88d565ec2479	0c50127b-ada2-4731-ae88-38e07c4393f5	allowed-protocol-mapper-types	oidc-address-mapper
c1c43146-5129-412f-b30c-7804bb3f8b23	0c50127b-ada2-4731-ae88-38e07c4393f5	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
3a148ef9-3a5b-4d13-a2ed-d2a28a042a46	36899ba9-f4a9-4a8b-8d23-c348ab702286	allow-default-scopes	true
915ffac6-d92d-469c-b91b-990d0faa9d05	b8ee219d-653e-417f-8b57-ac3e3f4a230f	allow-default-scopes	true
84fd70f9-411b-446f-bb8d-a23c87c96147	5d2f3da0-1ef2-46e2-8081-32afa71d8694	client-uris-must-match	true
3c77a6db-4aae-4f80-829b-3865dba282d3	5d2f3da0-1ef2-46e2-8081-32afa71d8694	host-sending-registration-request-must-match	true
332c027e-919f-42fe-99b0-86e9baf3740d	fc220557-444b-4524-883d-31800c1ad197	allowed-protocol-mapper-types	saml-role-list-mapper
bf6b9000-5882-44ec-8460-f18fe0fea786	fc220557-444b-4524-883d-31800c1ad197	allowed-protocol-mapper-types	saml-user-property-mapper
ea39bf54-4a8a-401f-9e95-2fbd8080300c	fc220557-444b-4524-883d-31800c1ad197	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
8fc730f5-975b-4706-b0dd-c951298cf156	fc220557-444b-4524-883d-31800c1ad197	allowed-protocol-mapper-types	oidc-address-mapper
4269bf28-0980-44c1-9eda-4cfea1971346	fc220557-444b-4524-883d-31800c1ad197	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
56e8e68e-f440-43ef-bad5-778f36fab1af	fc220557-444b-4524-883d-31800c1ad197	allowed-protocol-mapper-types	oidc-full-name-mapper
2bf94295-197f-4d93-b6bc-439add04f962	fc220557-444b-4524-883d-31800c1ad197	allowed-protocol-mapper-types	saml-user-attribute-mapper
ea3c7024-d2d6-462f-b0f0-07adad1f6d9c	fc220557-444b-4524-883d-31800c1ad197	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
f699a646-be9b-4ebe-aae6-a7d4c8353728	f98fb0c9-b051-49ca-9b21-4d5f96e61473	priority	100
b5ff88fe-f49c-44b6-b116-3771a9618842	f98fb0c9-b051-49ca-9b21-4d5f96e61473	secret	jrNYoCUWK7cYqtc5dl2CUg
accf84ba-61e9-4105-aad9-5f0954ff5c30	f98fb0c9-b051-49ca-9b21-4d5f96e61473	kid	55aa246f-d870-4653-ae00-6cb51ce912f5
4bd6554a-8edf-4f6e-afd6-5867fcb2877b	36abf9fc-dd5e-4c97-b8f4-516119ab2e7b	privateKey	MIIEpAIBAAKCAQEAsjgbYraxs/zBKnhTqzE4ww8CQHJzE3n0siqAMxtGArHN9jvLEfEfdefZ9A/WwGMbsPb04jCeDfCC/xuNPA4OPEfO7HAjVnXdvM2oMDBBr6zJbEzWAApJ9sPnVcAsdZdWzLHgb/fjdffZokwZPNN2OrtWejlwUGxJXUDdAsvykWAAhBFC3TY/050kd30E0wbXy4dqLfzfGdq/LZaALnbiNXGNC0RBbcxVoyWFZ1KZ/4IvBOPQwG86I9MZJ2832Zdu+V8Yu4xjqwzG8E9emPzac3OYb/gYQL+ScySc8r2ED8vAo7VfySQ6nEhyuCLMnvJmRl3acBJZX91xYL+4/2Lf9wIDAQABAoIBAD0Z+WGlq1U/EecCrATkckaF7cq0snl59YfkBGIBNsaTuT5zj5LOLXAaFmKTz5fUItlQQfMOohG7ZN4bzxdI5l6KbAoqBCOPc39YrxIeaVbWkZQ8353R6TvePIDsyxFh2pOBZKZewbBfUlFPb9On2EAYnHR5HuWjyp9bLqrXy4lFYnEOMh3MlVYv8OmaNU793uzspcZRrAQHEsQ4kxBC/kUoyayweHmBosYUv5rqAu2g2K5r3gTaVSqew+onJ8aXDtluVNPTudO13NbT2ArZ5qcE8OSVWfk7YlII3qIyAsxHrlZwo1WpbuThqy7wd3bS3M/ploM0IUnnqSheV06obDkCgYEA7kJ4LvkdIC3PnLxhll11JGN9dS5e3yvZd8rswcdiSxpBX//FexI8/QUoQ6tcYFeAaCdBUdZ5GsMfMeU9vE7amoIdkliOJihdOESk7q3nbvf0N+O+p3STNxaNhF9vKfqG4aLa5UKXyyAfukkSC/PzAzXAe1asYKu2wkvOWzCybw0CgYEAv30wobp7L4tPUtMlYQYpZPzJG9nDUijrbbLERqLlQXWvl1FbvO9917QEsFt5j0JytJZrVb23b3lzPUHoXC25IintJz/Wg+INfYEOytpkk3OeL6QXRtE9Qi1lcm9dG0R9UZj3zthj+3kZZT4/liq/uXD/vOdxJ38O3u8fSSx+qhMCgYEAyq7C3HrQ2xn9fkEG50ozp7P2+uNqk4ES64Q16ha6OFdqe8bycOKv/TIQ8Zfp6o8lTfTu7TZ9KVYJyIFSBkoyTrQXgfJRYoZ93qsOf3hy44SNPapA+uUBgyBtXMluoJBdg77tZZBD3ulB9E/KyV5KQVXNm169HzOUMi8YqZyAflUCgYAPuDM505kxOfp1DihPYrYbODU6OBI0uG87PiWmttCjIwobHe6t/+sQvhJ0d83u2MGZ2Y9OJpjcadfv+20bxBUinNZ/FlqB0RjSaLnSJUOEZ0VhG9NdWOfyes+NKV83UdQH0srlDBaJGlPfX9DQfwnmK0STOVyspV2PJ4ol86UiSQKBgQCiFmwdI0+VWXdts6jOK5q7DxlFFIeeX1EaVPIRHZRqup4+T0NZyx9cLWxKQv+FDRF/g/0+BKrinla26n803A00lMMG/i6kmsPhc0F8cd6RHh5mzyA7pvQzFUzgOQGI8WzCK2gmdHQ1hjMHoMJJzSo0kUeKa/ww85tRLGfJxxMylg==
78d76c10-17aa-49cb-926a-3e34a8e3352d	36abf9fc-dd5e-4c97-b8f4-516119ab2e7b	priority	100
271a95d1-7ea9-4690-ac4b-9dc2aa28e8fe	36abf9fc-dd5e-4c97-b8f4-516119ab2e7b	certificate	MIICmzCCAYMCBgGOUvomAzANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjQwMzE4MTkxMDA5WhcNMzQwMzE4MTkxMTQ5WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCyOBtitrGz/MEqeFOrMTjDDwJAcnMTefSyKoAzG0YCsc32O8sR8R9159n0D9bAYxuw9vTiMJ4N8IL/G408Dg48R87scCNWdd28zagwMEGvrMlsTNYACkn2w+dVwCx1l1bMseBv9+N199miTBk803Y6u1Z6OXBQbEldQN0Cy/KRYACEEULdNj/TnSR3fQTTBtfLh2ot/N8Z2r8tloAuduI1cY0LREFtzFWjJYVnUpn/gi8E49DAbzoj0xknbzfZl275Xxi7jGOrDMbwT16Y/Npzc5hv+BhAv5JzJJzyvYQPy8CjtV/JJDqcSHK4Isye8mZGXdpwEllf3XFgv7j/Yt/3AgMBAAEwDQYJKoZIhvcNAQELBQADggEBALHllGXH+Gj5saHdN+Lryu7QoI30vqb0+MYGpz1TJ/x/uKAZjJS37pm8Zsw33MwE+Ggkg5ZC8YSEFEdA3KiLDn7/PMQG7YDkiuozoj72ly8cZx38SwcR25ybyIjNECVEnWl0CqBGfkPTOrXB3ZV9sBR/0/h5c66jPxmVi+E5Ti+Jd2ahDrbeACiRbGzUUXjQpl0lb0DiFzTaVV+5Wj2+Vxm4r9pLScoDKIxFu4SksL646G3c9mYqtZjR91wqixUNOxo58s6cTfkJQ/m8qBZqUAGN8hcVhkw87/MvXlfzP5SRHqTXFGWhR0CQ7H+z/eVOzR4gmUjEPMjZDtWVQtBczKg=
3e2b6934-2fe5-4165-a7ec-8066e1871fb7	36abf9fc-dd5e-4c97-b8f4-516119ab2e7b	keyUse	ENC
375a5c7f-e571-4516-aafe-178e6702dd6b	36abf9fc-dd5e-4c97-b8f4-516119ab2e7b	algorithm	RSA-OAEP
fe526a4f-247e-41de-8fd8-06d64d2af2ba	8fe3f7e0-a974-404f-a73f-bbf051c0cac4	certificate	MIICmzCCAYMCBgGOUvolxTANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjQwMzE4MTkxMDA5WhcNMzQwMzE4MTkxMTQ5WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDDiZkUzkJ26ZeFbDLCLZsw/5Ko79zKWVZS/7MuWXvwemBisd2hsYMZuOcRcUYjJ7m89qVY2XTpIfSXiXHA9OmiIWbOQGG2t50nprRDvYB10j9Qf7GWfjYRC0YWnffSFA3xxatBtb9LaYYL4t4gEbM6TOsH5eVyNP9L0Ya4sZKkOCKOr0T+29fhSjsAktaf9xBJUtLyF3hDiq7+ovr1g1/YtYxJ5+iI/QXU/q4Vn+1P1r2Je//Z0kSLm1BQKmyL5OZl0o0qhQD2TWHsyXiY1CpSShBK25vW/dywzWLqWoIqVNOKUxHXK/Wj89hhQcGAY5aOVVIX98l+tWFRgXcLe+CHAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAIstJkT2BHH2e/hjG9aLxl6BGH1oSDZ3nnTnvam/kx8nIJMm4xnrPMFvZozIX7MaHIT9UPE6PBKvPxhhVpWe250n8j1l1L0q1CoInp3vj8yro45/pGrzpDF/EzBUG6E6SPn3yRV9hTGwyi5RLEATBj5kZPLgvnEctx1g+bHO702YyY59QyY+sWsXmnhdPb67wm2qR/AGPq+000/rWdjvEvRaFnzY7+PPjmp5cdkR8n1+YV0xNpzUQS6vgr6+dsCT8f5gVHI6bFqQqTiD95TmWAkOW/4R4Z8S5i5ZTegYABfU0Z5+LP4nBUWzpicSlqJ2Jzvs2F/QpVUSKqCveeqd6u8=
1adbdb3f-25f9-463a-8f18-a8b78ab79f5e	8fe3f7e0-a974-404f-a73f-bbf051c0cac4	priority	100
8fba064d-8958-48b5-a152-af86644d6113	8fe3f7e0-a974-404f-a73f-bbf051c0cac4	privateKey	MIIEpAIBAAKCAQEAw4mZFM5CdumXhWwywi2bMP+SqO/cyllWUv+zLll78HpgYrHdobGDGbjnEXFGIye5vPalWNl06SH0l4lxwPTpoiFmzkBhtredJ6a0Q72AddI/UH+xln42EQtGFp330hQN8cWrQbW/S2mGC+LeIBGzOkzrB+XlcjT/S9GGuLGSpDgijq9E/tvX4Uo7AJLWn/cQSVLS8hd4Q4qu/qL69YNf2LWMSefoiP0F1P6uFZ/tT9a9iXv/2dJEi5tQUCpsi+TmZdKNKoUA9k1h7Ml4mNQqUkoQStub1v3csM1i6lqCKlTTilMR1yv1o/PYYUHBgGOWjlVSF/fJfrVhUYF3C3vghwIDAQABAoIBAE/RWyujBn6D29Ya1J1vAGp/6N4NC5ON5C79Mac5393KFo4zDMV0MI/PaoM0Oe0fyjHYfKZIHfEMa0twT370emo0OEL5BOoRCZWl9u+v60AtEqtJdLR50Jgkgfe5g++9P/PxPHcWOYAPEyjG8uUkVIT34PjYX1C/UXchkFzUH4foq1ZWJNGCqOrwmHw+R394k5SM84o7iq4jVzgCEaG6qdUDdGp/KOk/xOx/WlTddheDJlK/Dr7a5QArIpBgEbDLOqoWpAPsp4kqc5INKGn5i7mxNkdyx8gFn90i3QBGsHeoXWw6gI7uLBwTcc/jT4TT/5McW5jNpltqo7ylp/t0CAECgYEA6nx7v776+GtqMJ09ci+DZSbceKbvI32lJ7zYAAPLxCOk2B09FrIis1RL/KnBcjTTjC0oC1M6cf5VySvhXnMlLcd7RPCF4qq1d6EFfz3k5jE5ojMGuyw+j8HZ9dNnQabVYJJxeWE9YPRryR07dSuW2U4P4Bvnwl6X9lJtcguQUXkCgYEA1XpNShNnqb3mIdgXgAVGKmWE+U5hs01q/TI9ahDVgdW0IpYgOPR5HWjFnQRx+V+ronPa++UfcOo1RadShzLOncX75MHMe3vN11gB4irW3flI7Y0G87POOtcKJHxGE9JD1zYfBf9IqC+JJtASPxX9sT2N4PCk29yVdt6Ha5KjQf8CgYB+qmQGvlnAG/Yu8KGirvvhhk6Odk6z80ll3+MmjuZhu4dunszDF9Ma4Cxz/hdbZCHqlPIOvBTUQzmABE4nwTeSNTHnma4ZNXH1f2wCwiKGHo0tizbVoR7idSsSWfJrSn31PuZBVT/cwev/peTadIN2O27j9u8I1iRskTZB5vE8sQKBgQC8HNd6jPrt8m6WKCsdHoij122DmnQxYekDUIAZtNfPXxcq2wtt5M/NAIQSRtaAHrPJpTm0ekRoZZmn1Te99yFmmg3LmJKtxXyvY9fVClbop0CCQ6F6olj6NH+1guTlloU9YW2ZBUlrGuhKkVNiz+gLhOg+7Q74xrnWU2UVf9Po1QKBgQDi2QOYlDBt2UNTlC45VJmJ6UeOpv77qQBP6XLvL2WUHodh6Gpbk/AebY267pUoG942ySL1DAfl5TjmGKJOhLpNfmNQi0on0tHgTYz1HgTVGjZjyU3tHLKs6f+O2Wa7ddfDM/uzF50ENJsw9DpJNVPcO/txlU8G0gTgH+k0CzdZ5w==
93bfc0ae-6c85-44df-8662-864c4266481c	8fe3f7e0-a974-404f-a73f-bbf051c0cac4	keyUse	SIG
d3745035-6674-4d6b-8846-8f79235eaa66	bbff72b2-e913-458c-976d-e9b5edb95b34	priority	100
4d7feecb-6de0-49d8-9b34-375f1875895c	bbff72b2-e913-458c-976d-e9b5edb95b34	secret	Pfa4I4nB6P0WMQzVr7lrF55GzCSiYzA8qT3t15jLQ_yFqf1nQghBAeALKGuzsgYmrH5U2FQMwW8RG-oEe7qvRA
1ca4db2a-2385-4888-a857-ae98775133d1	bbff72b2-e913-458c-976d-e9b5edb95b34	kid	2ab8b0ae-3ca3-4337-9204-31fa5d150730
15fe5d30-7ebc-451f-87c1-6544d64a1a38	bbff72b2-e913-458c-976d-e9b5edb95b34	algorithm	HS256
8490db52-ee8a-4c28-bcc3-b01cf28ab57c	9797805d-8a83-4d2d-b235-2770b54b76af	privateKey	MIIEowIBAAKCAQEAsj+db9+r4kTV3Crm9af7expiSwdyfvA+dntb6c25rQccBUS2t6Sa6LIeJqYrNeGT9QRy0W2khp2xbXllCLs30LixRI3UHOgP6PkES2lRmGb6Ja9VgIwTB5JT+EnLmkZnfmQKMuri4GhUhdOYkbMMfGCb0jEwr2IXBEG/sA0GIYWUfOtN9PM+lpb4bdA1uijEXlzzL7xeZmhPAxScy3bmS8s+3xrdAqAociJywPvaVi9oxydh1sy5wOc5LrgnPu+HmwSt4i5L8GbK4dKmtRH6iKE9wtMfHyLDHTC58C9+J3JljuAkheFBR/Q7s6rx1qXLx/TknvRHNyqDmHCm43JjnwIDAQABAoIBAEnA0rbQmMFV9BtWURxCNmcYYqVi3ngxldbWchCKxBIZB/oSFXxlCofP83PQe76eqObPwWZwdIwSwbBnc2uqc4zUbtzLxoFzb+nY53MAj/d8XHKtWraGvvT6Ee6BMlKSYQ5F/IZW9CsgYCDDjbRznm30V2UgX2GiN53WSqdgrDG/7ipqo3vrHiYoUDB/3rDZo/QPkUl4v3y+TEGnI9zS7mynJ0ZgrRv+xcERyrT1ezLksKnjZRKDGXaWD3mtR7us58h/2HuvCf2SLfKDx7qaBx49FJGIXOc/1YWmLRRL0FNvKbnDc//yWgc2XKO/FhzqI8b2QIFuNoAEMWNtwGEwb+ECgYEA9xjre0UOZCinJiaRA0g/Ksh9e3up7W2Rlj6wSWyR/8ocqdpgrzi9BpBl5wKPvm6mE1Lg78tBt6bb8nyWJxZFZpsQIwKb/Vf/e+MWKVmzczqPvY7iSrZYa362dfJfnWha3GeTvoQEMI0VLCI/vH5T4GxKZQVZnv1aQH4n0rEPVG8CgYEAuKusiglgHj93R+jcBaSFMR5vcUYlS2TXR1uniaUWNMhDf5VWogO9fFfETuIAhdL5116xh7/1zNm2BvcKt19ZB7H9MxvYOhqAofsHWeKUVT+fVnhDR5GwfwKPWVUGaQTOUpZzNf0e/TYCrnYXRgkyOIimamsaP0NtSvOMam9FW9ECgYAbMRbY3eSTiRW70QqsPcsVvjJw4E723dPjoMptihEXAPrehjWVkrzaeBF+tn1zC2IjRj+So997glU5/hPYAU9p1y6Ta7oWyxRGYdsSediRmaQvzAWDC0X3rl4N5Lo47D7zekJ7+LMtVJk73hj9eTlpvQEC1O/j2yWPa1KekPWK6QKBgQCyIWac/84nXzC/vG3/Q2L2rlTw/qiawPqnalGBBC0XXNU/C941CUaN2lsRfA7lB0zX4g980j1XC+n5bfJ4TxChy55g3ksEQOwzUuEUYuqSEHyx++9p6a5F1UJQ+SLlyiz6nQUk3rQ1qxOLFX39oIFA5w8fN5Bp1bBmy+Z2BD7zAQKBgDCjzCIxlhM7zXq1NwZ7lQzTI7ZYAP5PrPTP7WTKTJq723X756xOyeYn1dd/9MGXhU0zlvph8eVNVb8SIgaMnIrGhWAaSYH5LOVrrQBAK+ZRwpUBgf939cPGTXdVxVr3ZUFG71R3hLqyasEgH0veDJGqLYRrsulsgeBS+Efn930l
1ac544b6-2d6b-43de-9222-dd458e784533	9797805d-8a83-4d2d-b235-2770b54b76af	keyUse	SIG
bc9df394-6279-439c-bd3f-d85ab5a697aa	9797805d-8a83-4d2d-b235-2770b54b76af	priority	100
8cd835f5-c0ee-4235-b18e-ff214cb8bc68	9797805d-8a83-4d2d-b235-2770b54b76af	certificate	MIIClzCCAX8CBgGOUvqhlDANBgkqhkiG9w0BAQsFADAPMQ0wCwYDVQQDDARUZXN0MB4XDTI0MDMxODE5MTA0MFoXDTM0MDMxODE5MTIyMFowDzENMAsGA1UEAwwEVGVzdDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALI/nW/fq+JE1dwq5vWn+3saYksHcn7wPnZ7W+nNua0HHAVEtrekmuiyHiamKzXhk/UEctFtpIadsW15ZQi7N9C4sUSN1BzoD+j5BEtpUZhm+iWvVYCMEweSU/hJy5pGZ35kCjLq4uBoVIXTmJGzDHxgm9IxMK9iFwRBv7ANBiGFlHzrTfTzPpaW+G3QNbooxF5c8y+8XmZoTwMUnMt25kvLPt8a3QKgKHIicsD72lYvaMcnYdbMucDnOS64Jz7vh5sEreIuS/BmyuHSprUR+oihPcLTHx8iwx0wufAvfidyZY7gJIXhQUf0O7Oq8daly8f05J70Rzcqg5hwpuNyY58CAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAp3RNlAxaw04QSz+FV/J7bjMqH5q38wlSQpoPOGy4XTmC7PVXSfaqBTLcM0SJQfOq4J3oGWRw4wEhovJVWP8PDVD3jwZD4W7F/B3J3D5CdKJN+K2hybj+S7aFVjM8eBOpSnSwHVW+EDg9SFD/axim3kVybNNoG+lux4Oeq17P/AxoEjKcwZHRfshR+KMJc+Ze0fCntl19P8yVx5KWRdc/byz5u8pmx6DUWYfWs1Fqp1qa3XPbFBQD7Mwpf9iKeA3aE7idEM7Ivo2Q8Ci7TRXzawdWuajW/oeTDgo0I/BneDHFPalQYlpHCl8AYho0IUsQZXd0SOfnu1M19F41sVGikw==
c7fc0ba2-6ff4-4837-a95b-304e54e77ab9	6e8cbf34-dfe4-44cc-bae6-6bdc8f5452b5	algorithm	HS256
1bb6830d-096e-4fde-b6b9-0b0e04111817	6e8cbf34-dfe4-44cc-bae6-6bdc8f5452b5	kid	c3036be6-e4e2-4b54-8972-74ae0983590e
88113413-623b-4667-9940-fa0498e27eb3	6e8cbf34-dfe4-44cc-bae6-6bdc8f5452b5	secret	PKUq9_zm2Ua5s1CEZOJ1WpabwWuFq1PgmI_Ge8c9HGUcpzJBKYFZYPFC4d3rCgS1ncPVyh_eXYYJMjT3yzHndQ
93bfca80-2576-453f-a492-b6f920ff08b1	6e8cbf34-dfe4-44cc-bae6-6bdc8f5452b5	priority	100
93a679b6-f333-4f64-b2ae-ab2598a45f76	af7ade93-b647-4326-8d61-455f0e97751b	priority	100
7da0cbf5-e762-4069-84f1-d4964b1f816c	af7ade93-b647-4326-8d61-455f0e97751b	privateKey	MIIEowIBAAKCAQEAvDbdm6IqLo5EF/BTBtVLBwKx1Xd4/Gl4swToEsQ2WX3s1iXEh3RZV1A3OCcAfXGA08GjBbel1JcnusJsYgyFwwFZToWD5Hz7kcNoRdCqjkOW0NSlFjXa0arqp0GP2oM+lMyuFa6huwW3K5qFvn+E4DCCAQpe1QUF+00nuzzJ5lD1gIbY1tTJGf6QPBfCr+k/d0wIDJ+zvMzucysJM/lyMZwZyCxxC5c2sAovSNds55Qq2iK9Kq1ZPu9Pr3sGN5fM9uB0+NeR25zkj+e6Sxbgme3A5/9D6AEjkYxgZZAsJnkBcdYWILYSoSISw+f6atM7yGCoPJwjJBieuqmZ75oibwIDAQABAoIBACG25Eh6KnsvccQmAQFi2K83TNqzrYDtdbj/ooCmFCRAudl8Z3FqJozM6i9NUTmnSM/lykl+ZZ6ouu2p4RdJLfbJ+ZDmusMFnly0d6u13q9gLRZYWQAbAoj3SFRQmq+mPeISrgZlQ0RImFCfu+BtYER2e/squ+UFotYqsnjIQVRXkipCSR3PNjCoLg/xfy5bwkXXCuMIww/MrOjR7uTt68rB3zJXNsn1ikvLwH6wu+spJZr9KLa46kle/4m2Y+aLHAUQLs+b4WCakjpqUSw7HlXf2ogbLeW0witVthPVvkXBpnvz+UP+M3DYMvrgXNui7lIRP+ppBn5Z2+/uMEQZ2K0CgYEA83yRoruLnieATIhfR41fJEJdTw/G+JT4ngUFJDPlW6QkDfNjlUkEb5a7z2iGOS7Kb0LCCr55xTchEER1er19w6+e3uM82f1lD0HtucSve+OYzr9kRQyQ4IUX4RjpyTi12eopf59V+kKPfRNWdHImCsrc8cBMqHakUyrUcIK5mDMCgYEAxeMba2DaXinGrgdnEuQbr2Gbi/zjELwWjCt9Afk5apeB4c4Uu2q6jDEKrhvuiP/SbYf8wJmAi3ymmBy/fP+ttcE9EzR6f8VFt4RULowLo+Lu76bXB4RWzibVOQ8X7oN6YVDG09kxF524yHRBJkiUuaRjjydXhF+TJTglJQOXgNUCgYB3/OMn9pQPFBg9ntaVRC2miK3C0FuVFJSQCplGBez5BCJgXZitcJYnB3j19ORwOYa43YUSFlubvFcm1RWvrsHTNTBtVj4ejqjGpA6qhSqVOsuK1vZqsI6UlgH2g3hyGOhEwwhARBzyfuqHEIiCSd5FY0MOP12Hhy/jbC/UYhdj0QKBgDgyBVBaAckpze0P1xqLQr1sV5LKbuUKtNB7bRWJY9+8RLsOHd8XMQCs0J6e+f9XvrcyHfnH3bQ+4sRhrZNevELYLHLuvTbZm7HA13McfBW/VSEjXP8aetgyOOzqN16ZYcCPAteYXxOYy6fJM9MeW3XYlBlMD9NcnNm99vZq7bQ9AoGBAOyKoxkZ/qopB0oEC/tS4hwGcLpUsVBAGVtNmw9Op0g3APUZLh6m/dfBLpClI1hrYsfw+dMFUujPE6MCcSZhS8YqMRNA2MpwnFlM7FY2A/Eer1KZ5OQKU3zId5Dog5KGqtB6np/KzkHhBFnIneWJsnplVN5KxegLSJ52BWP8gOYF
57dfc780-d9c6-46b7-b550-bfa54ed9a707	af7ade93-b647-4326-8d61-455f0e97751b	algorithm	RSA-OAEP
1b16cb39-e423-4ca6-a608-1629f8ccdf68	af7ade93-b647-4326-8d61-455f0e97751b	keyUse	ENC
19431ed8-6553-49b5-9493-d3155b7842eb	af7ade93-b647-4326-8d61-455f0e97751b	certificate	MIIClzCCAX8CBgGOUvqiazANBgkqhkiG9w0BAQsFADAPMQ0wCwYDVQQDDARUZXN0MB4XDTI0MDMxODE5MTA0MVoXDTM0MDMxODE5MTIyMVowDzENMAsGA1UEAwwEVGVzdDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALw23ZuiKi6ORBfwUwbVSwcCsdV3ePxpeLME6BLENll97NYlxId0WVdQNzgnAH1xgNPBowW3pdSXJ7rCbGIMhcMBWU6Fg+R8+5HDaEXQqo5DltDUpRY12tGq6qdBj9qDPpTMrhWuobsFtyuahb5/hOAwggEKXtUFBftNJ7s8yeZQ9YCG2NbUyRn+kDwXwq/pP3dMCAyfs7zM7nMrCTP5cjGcGcgscQuXNrAKL0jXbOeUKtoivSqtWT7vT697BjeXzPbgdPjXkduc5I/nuksW4JntwOf/Q+gBI5GMYGWQLCZ5AXHWFiC2EqEiEsPn+mrTO8hgqDycIyQYnrqpme+aIm8CAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAtuekaqaePyujofXO0mql2MFnE+HbaNGv+jJVtaqs1ZhGhGkLZHYJibWbF/E4vCgaKd/cW50nX1tjrjXElA0AEgChj90env5Rx6GifCT1Qs9FEHqqFqTyP03pRNxkUN52xPCOtruaC6q95SsIjl5+CvtEK3T3GtVOZ8vhgN5IxM6+6ruupl+FAuxEA+ClgViYmObm3PulGpTL28h7eKMJhveXWqK16wpXcTvsyBVe85pEaUHJoMGyhaZWPM5FrPRRqMveYJwuV/PbdkhYaOXS8vV/eZMJerh4Z01bgajdUjpn4Pv+AvlkIM2wh7JuKxG70kIWrguXO6HNWqeGu9BPbg==
8c89cd64-a279-4ca6-a550-84b5ad510ac9	9ed55afa-6491-495a-92c0-9c588ad04ee7	kid	6a04f176-2398-4251-bf56-763658365e15
47832934-5396-4b6c-a0d4-328b18d03ded	9ed55afa-6491-495a-92c0-9c588ad04ee7	secret	zrgGMnL8hSACKzQXJCLc3g
47b9cd8f-f279-49df-ab55-168a0d7e7fac	9ed55afa-6491-495a-92c0-9c588ad04ee7	priority	100
56aa73f6-e37f-44e9-a52e-4c48d5638374	f952b80c-477f-4467-aa01-18748b6cfe25	allow-default-scopes	true
e116db06-068a-4408-9bb6-16d91c19244d	ee3b6133-2f7c-4300-bfbc-960d1a372d8d	host-sending-registration-request-must-match	true
a3ca5d9d-2d08-4875-bb0a-61053d3d4131	ee3b6133-2f7c-4300-bfbc-960d1a372d8d	client-uris-must-match	true
29e6532f-362b-4963-ad32-b2014e140462	8b3a5d0e-0375-46f5-a9ef-cbc39dff6612	max-clients	200
0e2f1039-1e0f-469e-bd7c-36833f9b8589	5cb98c67-125d-447b-9589-a4c21b900e82	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
43245dd4-b26d-414b-80ea-cd082f87f2d2	5cb98c67-125d-447b-9589-a4c21b900e82	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
e6d8e785-de5c-46f4-adc7-1668421d8cfd	5cb98c67-125d-447b-9589-a4c21b900e82	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
4d43a245-b0b4-42c4-ab4f-ed2b2d18e4d2	5cb98c67-125d-447b-9589-a4c21b900e82	allowed-protocol-mapper-types	oidc-full-name-mapper
928124e5-4e94-4091-94d8-61e858ee8627	5cb98c67-125d-447b-9589-a4c21b900e82	allowed-protocol-mapper-types	oidc-address-mapper
2e0f9640-9710-4da2-ac56-3dd259f580e2	5cb98c67-125d-447b-9589-a4c21b900e82	allowed-protocol-mapper-types	saml-role-list-mapper
74789346-dcbe-4a7a-8d95-e9d04ed40966	5cb98c67-125d-447b-9589-a4c21b900e82	allowed-protocol-mapper-types	saml-user-attribute-mapper
8629b8c7-7eab-49f4-8730-2eb19537381a	5cb98c67-125d-447b-9589-a4c21b900e82	allowed-protocol-mapper-types	saml-user-property-mapper
d959e291-7270-48c0-b07f-7566e255f946	fed87e85-7fc5-45a9-b2de-095fd15e01ad	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
7aea7d2a-dc5f-44bd-b9de-cdcd83a16d09	fed87e85-7fc5-45a9-b2de-095fd15e01ad	allowed-protocol-mapper-types	oidc-address-mapper
0051e677-0337-46c2-aea6-59b8503c81d8	fed87e85-7fc5-45a9-b2de-095fd15e01ad	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
2a3d3637-946a-4206-b531-8dda4a8194c5	fed87e85-7fc5-45a9-b2de-095fd15e01ad	allowed-protocol-mapper-types	saml-user-attribute-mapper
0f6e43bb-b1a7-43cf-85f7-55936f296166	fed87e85-7fc5-45a9-b2de-095fd15e01ad	allowed-protocol-mapper-types	saml-user-property-mapper
2cd9cf60-e58d-4205-9365-9169e33b9258	fed87e85-7fc5-45a9-b2de-095fd15e01ad	allowed-protocol-mapper-types	oidc-full-name-mapper
f1fa1696-daaa-4248-8343-9efe9dc99d98	fed87e85-7fc5-45a9-b2de-095fd15e01ad	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
7a9da4d3-c108-429d-b431-fcbc7a4a20b6	fed87e85-7fc5-45a9-b2de-095fd15e01ad	allowed-protocol-mapper-types	saml-role-list-mapper
9e0062ee-f9a5-4745-a915-56c1055290ea	e48abb67-f26e-4837-837e-0f2412cd4868	allow-default-scopes	true
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.composite_role (composite, child_role) FROM stdin;
74c8ad55-f447-494f-b3ae-596b45ce9044	fde81e0b-a51b-44c2-bc18-36a3625c6220
74c8ad55-f447-494f-b3ae-596b45ce9044	ca1a102e-8b04-4f4f-87d1-28d27b321e5d
74c8ad55-f447-494f-b3ae-596b45ce9044	87852e06-872c-4cc6-8c25-44040c9479c8
74c8ad55-f447-494f-b3ae-596b45ce9044	6b87f242-5ccb-48f5-820a-acd01c2837a2
74c8ad55-f447-494f-b3ae-596b45ce9044	0ef0acee-2275-4932-9893-3898a9ecf878
74c8ad55-f447-494f-b3ae-596b45ce9044	87e01051-a0de-40e0-93ac-74c00e56e8fe
74c8ad55-f447-494f-b3ae-596b45ce9044	173f74bc-d1e9-44fd-9966-bfadab0f7f4c
74c8ad55-f447-494f-b3ae-596b45ce9044	e660ab05-eaca-492d-a9a7-b3ec616101be
74c8ad55-f447-494f-b3ae-596b45ce9044	9e43f2b4-1da8-457b-be9f-70cc516c1529
74c8ad55-f447-494f-b3ae-596b45ce9044	075bdcfb-84b1-49e9-989c-3f8053672644
74c8ad55-f447-494f-b3ae-596b45ce9044	59ed3a89-1b3d-439f-8072-cb0499f96dad
74c8ad55-f447-494f-b3ae-596b45ce9044	b1aa2389-601d-4544-a39c-70d938ca383a
74c8ad55-f447-494f-b3ae-596b45ce9044	965c0e03-e11a-42e1-bd6c-1cd3501d69fc
74c8ad55-f447-494f-b3ae-596b45ce9044	fe06d958-a587-4c3b-ba26-99bfb667856a
74c8ad55-f447-494f-b3ae-596b45ce9044	a081a78b-9158-4f9c-ae33-160ba5a7de56
74c8ad55-f447-494f-b3ae-596b45ce9044	f18dc984-9d38-451a-ad46-752abf139f94
74c8ad55-f447-494f-b3ae-596b45ce9044	8a45bdbe-9897-4585-a174-08917c90d17b
74c8ad55-f447-494f-b3ae-596b45ce9044	f90d9d4f-2dc7-4c83-a46f-4b0cf31bc577
0ef0acee-2275-4932-9893-3898a9ecf878	f18dc984-9d38-451a-ad46-752abf139f94
6b87f242-5ccb-48f5-820a-acd01c2837a2	f90d9d4f-2dc7-4c83-a46f-4b0cf31bc577
6b87f242-5ccb-48f5-820a-acd01c2837a2	a081a78b-9158-4f9c-ae33-160ba5a7de56
a2dc394f-34a6-4536-a75a-178a4fa662d6	f27fb9ce-4c42-4fd7-a19e-560b5a8532f1
a2dc394f-34a6-4536-a75a-178a4fa662d6	15207ed9-57ab-4b46-87bb-03da33559d2f
15207ed9-57ab-4b46-87bb-03da33559d2f	5e64c0d7-0c4c-4140-a569-da7c03cb650a
2c1f300b-32ab-474a-901d-4b3cda0e1c36	01401061-5139-4ffa-9688-8dec56c633c2
74c8ad55-f447-494f-b3ae-596b45ce9044	b508b4d6-8acd-4572-825e-2c42e05ef62c
a2dc394f-34a6-4536-a75a-178a4fa662d6	280ecf65-9097-42c8-956b-c519b987c9a9
a2dc394f-34a6-4536-a75a-178a4fa662d6	1c2ac667-62b2-49be-ad30-6958a51d3457
74c8ad55-f447-494f-b3ae-596b45ce9044	f5cde08a-a3af-4b97-8a04-101e83c7ab0b
74c8ad55-f447-494f-b3ae-596b45ce9044	b11d087e-1ef0-4480-a4c6-f0557ea439c3
74c8ad55-f447-494f-b3ae-596b45ce9044	f52a7060-819f-4ed3-b8f9-eb70b696f8da
74c8ad55-f447-494f-b3ae-596b45ce9044	40adf3af-4023-4765-8b2e-d603b28e949a
74c8ad55-f447-494f-b3ae-596b45ce9044	85af9a7a-37ae-4658-acce-923a6b933fc3
74c8ad55-f447-494f-b3ae-596b45ce9044	27f9b2c9-e8a5-4f6c-b102-214ecc566a90
74c8ad55-f447-494f-b3ae-596b45ce9044	c625f65f-1db9-492d-b4b2-744187d9fc4b
74c8ad55-f447-494f-b3ae-596b45ce9044	da99a5bc-e49e-47c9-94d6-0a36ae164747
74c8ad55-f447-494f-b3ae-596b45ce9044	bf8928ff-8b7d-4930-a02a-2bf9d6b3e5f4
74c8ad55-f447-494f-b3ae-596b45ce9044	3e0b22ad-dfa6-4626-83e3-8ade6e280a63
74c8ad55-f447-494f-b3ae-596b45ce9044	a9ce1e1c-6bbc-477f-bb42-32ff1561b581
74c8ad55-f447-494f-b3ae-596b45ce9044	c13d4897-f214-4979-8de6-80f562113d37
74c8ad55-f447-494f-b3ae-596b45ce9044	cc5c21f7-cb93-461e-8760-3e9f2b7512f4
74c8ad55-f447-494f-b3ae-596b45ce9044	572dc381-916b-40f3-a9ee-c2a48bb02e8b
74c8ad55-f447-494f-b3ae-596b45ce9044	9421ecbd-6611-4648-8ff2-2f245eabadfc
74c8ad55-f447-494f-b3ae-596b45ce9044	41aa5925-eb92-4456-9ff0-9a9e840e719a
74c8ad55-f447-494f-b3ae-596b45ce9044	750aedd2-b685-466d-86a7-724799874934
40adf3af-4023-4765-8b2e-d603b28e949a	9421ecbd-6611-4648-8ff2-2f245eabadfc
f52a7060-819f-4ed3-b8f9-eb70b696f8da	750aedd2-b685-466d-86a7-724799874934
f52a7060-819f-4ed3-b8f9-eb70b696f8da	572dc381-916b-40f3-a9ee-c2a48bb02e8b
9b82fbfa-308d-4384-9565-7bce5b0b83b0	ba815420-1970-4eec-bc82-5b69975ad127
9b82fbfa-308d-4384-9565-7bce5b0b83b0	5c09f6ff-ec9d-492c-bbe5-8c2310eeb4c7
9b82fbfa-308d-4384-9565-7bce5b0b83b0	c9eb7e52-67b4-40ff-b588-ce7984c5e1f0
9b82fbfa-308d-4384-9565-7bce5b0b83b0	37818233-dc21-4eb2-a6ce-a5834f9ca703
9b82fbfa-308d-4384-9565-7bce5b0b83b0	0699d122-99f4-4e08-bb53-eab65a42c77e
9b82fbfa-308d-4384-9565-7bce5b0b83b0	b725a384-a09a-4884-ab7e-03f7440a3abe
9b82fbfa-308d-4384-9565-7bce5b0b83b0	75880a84-ddee-48cd-9cdd-f18e9c1aab4a
9b82fbfa-308d-4384-9565-7bce5b0b83b0	8ad10a41-f143-48f1-82a3-cdd8d1a2e186
9b82fbfa-308d-4384-9565-7bce5b0b83b0	5554b516-0838-448c-97da-8243fafada21
9b82fbfa-308d-4384-9565-7bce5b0b83b0	624ff818-66c5-4c72-b3c3-cf5bbe398d96
9b82fbfa-308d-4384-9565-7bce5b0b83b0	390e71c3-a1ae-4567-a0b4-0c9e0ae1ffec
9b82fbfa-308d-4384-9565-7bce5b0b83b0	f03b8dc2-0a90-429f-83ef-b94cadcb2172
9b82fbfa-308d-4384-9565-7bce5b0b83b0	aa8d5cc6-4edf-4d48-bc04-9342268ef47a
9b82fbfa-308d-4384-9565-7bce5b0b83b0	ef250e50-36ce-459c-97f8-18d67bac5f9a
9b82fbfa-308d-4384-9565-7bce5b0b83b0	870d8840-8624-453d-88eb-805102b6049f
9b82fbfa-308d-4384-9565-7bce5b0b83b0	4530def5-1d0e-4d2e-bf6e-709d1e97faf0
9b82fbfa-308d-4384-9565-7bce5b0b83b0	344ee79e-4e28-49b0-a8bc-dbf1e18637bb
37818233-dc21-4eb2-a6ce-a5834f9ca703	870d8840-8624-453d-88eb-805102b6049f
ba5939f5-f725-4e63-af76-fd2de6ec1ba3	266f932b-c35c-4e8b-994c-73681ce57f80
c9eb7e52-67b4-40ff-b588-ce7984c5e1f0	ef250e50-36ce-459c-97f8-18d67bac5f9a
c9eb7e52-67b4-40ff-b588-ce7984c5e1f0	344ee79e-4e28-49b0-a8bc-dbf1e18637bb
ba5939f5-f725-4e63-af76-fd2de6ec1ba3	7e6a951c-9ab1-4576-9829-c966680d69e2
7e6a951c-9ab1-4576-9829-c966680d69e2	78d5f359-0379-4762-ad19-28eda36d6bf4
d3879bda-e2af-453b-afee-71f77e82bce3	e1b3bbc9-16c6-4ef3-a7b6-f89a586e60b6
74c8ad55-f447-494f-b3ae-596b45ce9044	f9400605-831f-4aea-8836-8c597ecb9435
9b82fbfa-308d-4384-9565-7bce5b0b83b0	8c2b1e20-c056-45c2-aded-fb3637ca0f46
ba5939f5-f725-4e63-af76-fd2de6ec1ba3	83884d76-a951-45ec-b800-6b5be8fe2f68
ba5939f5-f725-4e63-af76-fd2de6ec1ba3	c59d202c-e031-48fa-86f5-a30e37da75d8
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
020a4f84-dcc2-4a06-b86a-fcbecdacecc3	\N	password	8e767053-e259-4cbd-8e57-5594c870a2fb	1710789109611	\N	{"value":"cxvwlU1zl8HE7JBE1wa/wgSLTUgKVcB/ia9WwFcxHYM=","salt":"OPMd0lxKZZI2LiWiAH+Ubw==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
6fc910b6-52d8-4f24-9d1a-25eda257f01b	\N	password	92f34733-9a8b-433b-aa39-ef666217094b	1710789418378	My password	{"value":"w9boy0XMuE/cbQV7tuaiXiHMFniP+D/aEQaKG9VBQF4=","salt":"piLY9lR5puFlQFNQVYpCmw==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2024-03-18 19:11:47.413412	1	EXECUTED	9:6f1016664e21e16d26517a4418f5e3df	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.23.2	\N	\N	0789106951
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2024-03-18 19:11:47.4432	2	MARK_RAN	9:828775b1596a07d1200ba1d49e5e3941	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.23.2	\N	\N	0789106951
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2024-03-18 19:11:47.471257	3	EXECUTED	9:5f090e44a7d595883c1fb61f4b41fd38	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.23.2	\N	\N	0789106951
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2024-03-18 19:11:47.473774	4	EXECUTED	9:c07e577387a3d2c04d1adc9aaad8730e	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.23.2	\N	\N	0789106951
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2024-03-18 19:11:47.526627	5	EXECUTED	9:b68ce996c655922dbcd2fe6b6ae72686	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.23.2	\N	\N	0789106951
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2024-03-18 19:11:47.537656	6	MARK_RAN	9:543b5c9989f024fe35c6f6c5a97de88e	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.23.2	\N	\N	0789106951
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2024-03-18 19:11:47.584087	7	EXECUTED	9:765afebbe21cf5bbca048e632df38336	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.23.2	\N	\N	0789106951
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2024-03-18 19:11:47.596397	8	MARK_RAN	9:db4a145ba11a6fdaefb397f6dbf829a1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.23.2	\N	\N	0789106951
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2024-03-18 19:11:47.601176	9	EXECUTED	9:9d05c7be10cdb873f8bcb41bc3a8ab23	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.23.2	\N	\N	0789106951
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2024-03-18 19:11:47.648945	10	EXECUTED	9:18593702353128d53111f9b1ff0b82b8	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.23.2	\N	\N	0789106951
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2024-03-18 19:11:47.675125	11	EXECUTED	9:6122efe5f090e41a85c0f1c9e52cbb62	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.23.2	\N	\N	0789106951
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2024-03-18 19:11:47.679049	12	MARK_RAN	9:e1ff28bf7568451453f844c5d54bb0b5	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.23.2	\N	\N	0789106951
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2024-03-18 19:11:47.689231	13	EXECUTED	9:7af32cd8957fbc069f796b61217483fd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.23.2	\N	\N	0789106951
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2024-03-18 19:11:47.698888	14	EXECUTED	9:6005e15e84714cd83226bf7879f54190	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.23.2	\N	\N	0789106951
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2024-03-18 19:11:47.699931	15	MARK_RAN	9:bf656f5a2b055d07f314431cae76f06c	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.23.2	\N	\N	0789106951
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2024-03-18 19:11:47.701915	16	MARK_RAN	9:f8dadc9284440469dcf71e25ca6ab99b	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.23.2	\N	\N	0789106951
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2024-03-18 19:11:47.70363	17	EXECUTED	9:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.23.2	\N	\N	0789106951
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2024-03-18 19:11:47.728267	18	EXECUTED	9:3368ff0be4c2855ee2dd9ca813b38d8e	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.23.2	\N	\N	0789106951
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2024-03-18 19:11:47.757796	19	EXECUTED	9:8ac2fb5dd030b24c0570a763ed75ed20	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.23.2	\N	\N	0789106951
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2024-03-18 19:11:47.761005	20	EXECUTED	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.23.2	\N	\N	0789106951
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2024-03-18 19:11:47.76701	21	MARK_RAN	9:831e82914316dc8a57dc09d755f23c51	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.23.2	\N	\N	0789106951
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2024-03-18 19:11:47.769808	22	MARK_RAN	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.23.2	\N	\N	0789106951
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2024-03-18 19:11:47.781062	23	EXECUTED	9:bc3d0f9e823a69dc21e23e94c7a94bb1	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.23.2	\N	\N	0789106951
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2024-03-18 19:11:47.783946	24	EXECUTED	9:c9999da42f543575ab790e76439a2679	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.23.2	\N	\N	0789106951
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2024-03-18 19:11:47.785066	25	MARK_RAN	9:0d6c65c6f58732d81569e77b10ba301d	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.23.2	\N	\N	0789106951
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2024-03-18 19:11:47.802774	26	EXECUTED	9:fc576660fc016ae53d2d4778d84d86d0	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.23.2	\N	\N	0789106951
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2024-03-18 19:11:47.845422	27	EXECUTED	9:43ed6b0da89ff77206289e87eaa9c024	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.23.2	\N	\N	0789106951
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2024-03-18 19:11:47.847477	28	EXECUTED	9:44bae577f551b3738740281eceb4ea70	update tableName=RESOURCE_SERVER_POLICY		\N	4.23.2	\N	\N	0789106951
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2024-03-18 19:11:47.879699	29	EXECUTED	9:bd88e1f833df0420b01e114533aee5e8	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.23.2	\N	\N	0789106951
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2024-03-18 19:11:47.887928	30	EXECUTED	9:a7022af5267f019d020edfe316ef4371	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.23.2	\N	\N	0789106951
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2024-03-18 19:11:47.89654	31	EXECUTED	9:fc155c394040654d6a79227e56f5e25a	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.23.2	\N	\N	0789106951
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2024-03-18 19:11:47.899075	32	EXECUTED	9:eac4ffb2a14795e5dc7b426063e54d88	customChange		\N	4.23.2	\N	\N	0789106951
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2024-03-18 19:11:47.902057	33	EXECUTED	9:54937c05672568c4c64fc9524c1e9462	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.23.2	\N	\N	0789106951
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2024-03-18 19:11:47.904058	34	MARK_RAN	9:3a32bace77c84d7678d035a7f5a8084e	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.23.2	\N	\N	0789106951
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2024-03-18 19:11:47.919081	35	EXECUTED	9:33d72168746f81f98ae3a1e8e0ca3554	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.23.2	\N	\N	0789106951
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2024-03-18 19:11:47.921307	36	EXECUTED	9:61b6d3d7a4c0e0024b0c839da283da0c	addColumn tableName=REALM		\N	4.23.2	\N	\N	0789106951
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2024-03-18 19:11:47.924421	37	EXECUTED	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.23.2	\N	\N	0789106951
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2024-03-18 19:11:47.926484	38	EXECUTED	9:a2b870802540cb3faa72098db5388af3	addColumn tableName=FED_USER_CONSENT		\N	4.23.2	\N	\N	0789106951
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2024-03-18 19:11:47.928408	39	EXECUTED	9:132a67499ba24bcc54fb5cbdcfe7e4c0	addColumn tableName=IDENTITY_PROVIDER		\N	4.23.2	\N	\N	0789106951
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2024-03-18 19:11:47.929343	40	MARK_RAN	9:938f894c032f5430f2b0fafb1a243462	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.23.2	\N	\N	0789106951
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2024-03-18 19:11:47.93076	41	MARK_RAN	9:845c332ff1874dc5d35974b0babf3006	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.23.2	\N	\N	0789106951
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2024-03-18 19:11:47.933346	42	EXECUTED	9:fc86359c079781adc577c5a217e4d04c	customChange		\N	4.23.2	\N	\N	0789106951
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2024-03-18 19:11:48.008273	43	EXECUTED	9:59a64800e3c0d09b825f8a3b444fa8f4	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.23.2	\N	\N	0789106951
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2024-03-18 19:11:48.01146	44	EXECUTED	9:d48d6da5c6ccf667807f633fe489ce88	addColumn tableName=USER_ENTITY		\N	4.23.2	\N	\N	0789106951
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-03-18 19:11:48.013965	45	EXECUTED	9:dde36f7973e80d71fceee683bc5d2951	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.23.2	\N	\N	0789106951
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-03-18 19:11:48.016257	46	EXECUTED	9:b855e9b0a406b34fa323235a0cf4f640	customChange		\N	4.23.2	\N	\N	0789106951
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-03-18 19:11:48.017203	47	MARK_RAN	9:51abbacd7b416c50c4421a8cabf7927e	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.23.2	\N	\N	0789106951
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-03-18 19:11:48.038497	48	EXECUTED	9:bdc99e567b3398bac83263d375aad143	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.23.2	\N	\N	0789106951
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-03-18 19:11:48.041066	49	EXECUTED	9:d198654156881c46bfba39abd7769e69	addColumn tableName=REALM		\N	4.23.2	\N	\N	0789106951
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2024-03-18 19:11:48.069162	50	EXECUTED	9:cfdd8736332ccdd72c5256ccb42335db	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.23.2	\N	\N	0789106951
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2024-03-18 19:11:48.086329	51	EXECUTED	9:7c84de3d9bd84d7f077607c1a4dcb714	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.23.2	\N	\N	0789106951
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2024-03-18 19:11:48.088542	52	EXECUTED	9:5a6bb36cbefb6a9d6928452c0852af2d	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.23.2	\N	\N	0789106951
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2024-03-18 19:11:48.090079	53	EXECUTED	9:8f23e334dbc59f82e0a328373ca6ced0	update tableName=REALM		\N	4.23.2	\N	\N	0789106951
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2024-03-18 19:11:48.091472	54	EXECUTED	9:9156214268f09d970cdf0e1564d866af	update tableName=CLIENT		\N	4.23.2	\N	\N	0789106951
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2024-03-18 19:11:48.09486	55	EXECUTED	9:db806613b1ed154826c02610b7dbdf74	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.23.2	\N	\N	0789106951
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2024-03-18 19:11:48.097257	56	EXECUTED	9:229a041fb72d5beac76bb94a5fa709de	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.23.2	\N	\N	0789106951
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2024-03-18 19:11:48.10774	57	EXECUTED	9:079899dade9c1e683f26b2aa9ca6ff04	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.23.2	\N	\N	0789106951
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2024-03-18 19:11:48.159294	58	EXECUTED	9:139b79bcbbfe903bb1c2d2a4dbf001d9	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.23.2	\N	\N	0789106951
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2024-03-18 19:11:48.173004	59	EXECUTED	9:b55738ad889860c625ba2bf483495a04	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.23.2	\N	\N	0789106951
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2024-03-18 19:11:48.176239	60	EXECUTED	9:e0057eac39aa8fc8e09ac6cfa4ae15fe	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.23.2	\N	\N	0789106951
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2024-03-18 19:11:48.180628	61	EXECUTED	9:42a33806f3a0443fe0e7feeec821326c	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.23.2	\N	\N	0789106951
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2024-03-18 19:11:48.183632	62	EXECUTED	9:9968206fca46eecc1f51db9c024bfe56	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.23.2	\N	\N	0789106951
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2024-03-18 19:11:48.185528	63	EXECUTED	9:92143a6daea0a3f3b8f598c97ce55c3d	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.23.2	\N	\N	0789106951
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2024-03-18 19:11:48.18694	64	EXECUTED	9:82bab26a27195d889fb0429003b18f40	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.23.2	\N	\N	0789106951
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2024-03-18 19:11:48.188321	65	EXECUTED	9:e590c88ddc0b38b0ae4249bbfcb5abc3	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.23.2	\N	\N	0789106951
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2024-03-18 19:11:48.194915	66	EXECUTED	9:5c1f475536118dbdc38d5d7977950cc0	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.23.2	\N	\N	0789106951
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2024-03-18 19:11:48.198252	67	EXECUTED	9:e7c9f5f9c4d67ccbbcc215440c718a17	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.23.2	\N	\N	0789106951
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2024-03-18 19:11:48.200626	68	EXECUTED	9:88e0bfdda924690d6f4e430c53447dd5	addColumn tableName=REALM		\N	4.23.2	\N	\N	0789106951
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2024-03-18 19:11:48.206051	69	EXECUTED	9:f53177f137e1c46b6a88c59ec1cb5218	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.23.2	\N	\N	0789106951
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2024-03-18 19:11:48.208891	70	EXECUTED	9:a74d33da4dc42a37ec27121580d1459f	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.23.2	\N	\N	0789106951
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2024-03-18 19:11:48.21121	71	EXECUTED	9:fd4ade7b90c3b67fae0bfcfcb42dfb5f	addColumn tableName=RESOURCE_SERVER		\N	4.23.2	\N	\N	0789106951
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-03-18 19:11:48.214388	72	EXECUTED	9:aa072ad090bbba210d8f18781b8cebf4	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.23.2	\N	\N	0789106951
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-03-18 19:11:48.217726	73	EXECUTED	9:1ae6be29bab7c2aa376f6983b932be37	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.23.2	\N	\N	0789106951
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-03-18 19:11:48.219708	74	MARK_RAN	9:14706f286953fc9a25286dbd8fb30d97	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.23.2	\N	\N	0789106951
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-03-18 19:11:48.228904	75	EXECUTED	9:2b9cc12779be32c5b40e2e67711a218b	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.23.2	\N	\N	0789106951
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-03-18 19:11:48.232654	76	EXECUTED	9:91fa186ce7a5af127a2d7a91ee083cc5	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.23.2	\N	\N	0789106951
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2024-03-18 19:11:48.234496	77	EXECUTED	9:6335e5c94e83a2639ccd68dd24e2e5ad	addColumn tableName=CLIENT		\N	4.23.2	\N	\N	0789106951
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2024-03-18 19:11:48.235382	78	MARK_RAN	9:6bdb5658951e028bfe16fa0a8228b530	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.23.2	\N	\N	0789106951
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2024-03-18 19:11:48.244307	79	EXECUTED	9:d5bc15a64117ccad481ce8792d4c608f	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.23.2	\N	\N	0789106951
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2024-03-18 19:11:48.24671	80	MARK_RAN	9:077cba51999515f4d3e7ad5619ab592c	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.23.2	\N	\N	0789106951
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-03-18 19:11:48.250347	81	EXECUTED	9:be969f08a163bf47c6b9e9ead8ac2afb	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.23.2	\N	\N	0789106951
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-03-18 19:11:48.251155	82	MARK_RAN	9:6d3bb4408ba5a72f39bd8a0b301ec6e3	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.23.2	\N	\N	0789106951
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-03-18 19:11:48.253535	83	EXECUTED	9:966bda61e46bebf3cc39518fbed52fa7	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.23.2	\N	\N	0789106951
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-03-18 19:11:48.254531	84	MARK_RAN	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.23.2	\N	\N	0789106951
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-03-18 19:11:48.257519	85	EXECUTED	9:7d93d602352a30c0c317e6a609b56599	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.23.2	\N	\N	0789106951
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2024-03-18 19:11:48.259784	86	EXECUTED	9:71c5969e6cdd8d7b6f47cebc86d37627	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.23.2	\N	\N	0789106951
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2024-03-18 19:11:48.262829	87	EXECUTED	9:a9ba7d47f065f041b7da856a81762021	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.23.2	\N	\N	0789106951
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2024-03-18 19:11:48.267356	88	EXECUTED	9:fffabce2bc01e1a8f5110d5278500065	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.23.2	\N	\N	0789106951
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-03-18 19:11:48.270209	89	EXECUTED	9:fa8a5b5445e3857f4b010bafb5009957	addColumn tableName=REALM; customChange		\N	4.23.2	\N	\N	0789106951
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-03-18 19:11:48.273424	90	EXECUTED	9:67ac3241df9a8582d591c5ed87125f39	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.23.2	\N	\N	0789106951
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-03-18 19:11:48.276536	91	EXECUTED	9:ad1194d66c937e3ffc82386c050ba089	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.23.2	\N	\N	0789106951
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-03-18 19:11:48.280267	92	EXECUTED	9:d9be619d94af5a2f5d07b9f003543b91	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.23.2	\N	\N	0789106951
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-03-18 19:11:48.281283	93	MARK_RAN	9:544d201116a0fcc5a5da0925fbbc3bde	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.23.2	\N	\N	0789106951
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-03-18 19:11:48.285439	94	EXECUTED	9:43c0c1055b6761b4b3e89de76d612ccf	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.23.2	\N	\N	0789106951
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-03-18 19:11:48.286608	95	MARK_RAN	9:8bd711fd0330f4fe980494ca43ab1139	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.23.2	\N	\N	0789106951
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-03-18 19:11:48.289506	96	EXECUTED	9:e07d2bc0970c348bb06fb63b1f82ddbf	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.23.2	\N	\N	0789106951
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-03-18 19:11:48.295723	97	EXECUTED	9:24fb8611e97f29989bea412aa38d12b7	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.23.2	\N	\N	0789106951
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-03-18 19:11:48.296771	98	MARK_RAN	9:259f89014ce2506ee84740cbf7163aa7	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.23.2	\N	\N	0789106951
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-03-18 19:11:48.301453	99	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.23.2	\N	\N	0789106951
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-03-18 19:11:48.305036	100	EXECUTED	9:60ca84a0f8c94ec8c3504a5a3bc88ee8	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.23.2	\N	\N	0789106951
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-03-18 19:11:48.306106	101	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.23.2	\N	\N	0789106951
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-03-18 19:11:48.3094	102	EXECUTED	9:0b305d8d1277f3a89a0a53a659ad274c	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.23.2	\N	\N	0789106951
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-03-18 19:11:48.311459	103	EXECUTED	9:2c374ad2cdfe20e2905a84c8fac48460	customChange		\N	4.23.2	\N	\N	0789106951
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2024-03-18 19:11:48.314422	104	EXECUTED	9:47a760639ac597360a8219f5b768b4de	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.23.2	\N	\N	0789106951
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2024-03-18 19:11:48.317248	105	EXECUTED	9:a6272f0576727dd8cad2522335f5d99e	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.23.2	\N	\N	0789106951
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2024-03-18 19:11:48.320002	106	EXECUTED	9:015479dbd691d9cc8669282f4828c41d	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.23.2	\N	\N	0789106951
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2024-03-18 19:11:48.321884	107	EXECUTED	9:9518e495fdd22f78ad6425cc30630221	customChange		\N	4.23.2	\N	\N	0789106951
20.0.0-12964-supported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2024-03-18 19:11:48.324741	108	EXECUTED	9:e5f243877199fd96bcc842f27a1656ac	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.23.2	\N	\N	0789106951
20.0.0-12964-unsupported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2024-03-18 19:11:48.325747	109	MARK_RAN	9:1a6fcaa85e20bdeae0a9ce49b41946a5	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.23.2	\N	\N	0789106951
client-attributes-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-20.0.0.xml	2024-03-18 19:11:48.329034	110	EXECUTED	9:3f332e13e90739ed0c35b0b25b7822ca	addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES		\N	4.23.2	\N	\N	0789106951
21.0.2-17277	keycloak	META-INF/jpa-changelog-21.0.2.xml	2024-03-18 19:11:48.330997	111	EXECUTED	9:7ee1f7a3fb8f5588f171fb9a6ab623c0	customChange		\N	4.23.2	\N	\N	0789106951
21.1.0-19404	keycloak	META-INF/jpa-changelog-21.1.0.xml	2024-03-18 19:11:48.344183	112	EXECUTED	9:3d7e830b52f33676b9d64f7f2b2ea634	modifyDataType columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=LOGIC, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=POLICY_ENFORCE_MODE, tableName=RESOURCE_SERVER		\N	4.23.2	\N	\N	0789106951
21.1.0-19404-2	keycloak	META-INF/jpa-changelog-21.1.0.xml	2024-03-18 19:11:48.345752	113	MARK_RAN	9:627d032e3ef2c06c0e1f73d2ae25c26c	addColumn tableName=RESOURCE_SERVER_POLICY; update tableName=RESOURCE_SERVER_POLICY; dropColumn columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; renameColumn newColumnName=DECISION_STRATEGY, oldColumnName=DECISION_STRATEGY_NEW, tabl...		\N	4.23.2	\N	\N	0789106951
22.0.0-17484-updated	keycloak	META-INF/jpa-changelog-22.0.0.xml	2024-03-18 19:11:48.347894	114	EXECUTED	9:90af0bfd30cafc17b9f4d6eccd92b8b3	customChange		\N	4.23.2	\N	\N	0789106951
22.0.5-24031	keycloak	META-INF/jpa-changelog-22.0.0.xml	2024-03-18 19:11:48.348618	115	MARK_RAN	9:a60d2d7b315ec2d3eba9e2f145f9df28	customChange		\N	4.23.2	\N	\N	0789106951
23.0.0-12062	keycloak	META-INF/jpa-changelog-23.0.0.xml	2024-03-18 19:11:48.351959	116	EXECUTED	9:2168fbe728fec46ae9baf15bf80927b8	addColumn tableName=COMPONENT_CONFIG; update tableName=COMPONENT_CONFIG; dropColumn columnName=VALUE, tableName=COMPONENT_CONFIG; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=COMPONENT_CONFIG		\N	4.23.2	\N	\N	0789106951
23.0.0-17258	keycloak	META-INF/jpa-changelog-23.0.0.xml	2024-03-18 19:11:48.353867	117	EXECUTED	9:36506d679a83bbfda85a27ea1864dca8	addColumn tableName=EVENT_ENTITY		\N	4.23.2	\N	\N	0789106951
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
1001	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
3c6fae4f-56d1-403c-bd4a-c40d238a11c6	f9842426-768c-4fab-bdfc-ee1a349328a4	f
3c6fae4f-56d1-403c-bd4a-c40d238a11c6	dbb27ed8-759e-4ece-b515-3fb4cd3782c8	t
3c6fae4f-56d1-403c-bd4a-c40d238a11c6	446284bb-3156-4069-85c7-427094d889bb	t
3c6fae4f-56d1-403c-bd4a-c40d238a11c6	f2f81c2e-37bb-4298-870c-5836474d0546	t
3c6fae4f-56d1-403c-bd4a-c40d238a11c6	00b5e17e-cd87-4f68-823c-88b1ebcf2368	f
3c6fae4f-56d1-403c-bd4a-c40d238a11c6	6e6bce90-6d50-4495-8b2b-01223ba19f34	f
3c6fae4f-56d1-403c-bd4a-c40d238a11c6	e8f95349-3b51-4494-8b17-ed5dbbd742d6	t
3c6fae4f-56d1-403c-bd4a-c40d238a11c6	8dbc724d-80b4-423f-aa3f-ac249cba002a	t
3c6fae4f-56d1-403c-bd4a-c40d238a11c6	796f251f-4b2a-49c7-886b-816d07963fca	f
3c6fae4f-56d1-403c-bd4a-c40d238a11c6	72f40971-939d-4144-9467-0dea9a21737b	t
770ce898-e404-41ae-b791-ebab6d704c10	1e742a50-5cf9-453a-a20d-b5417a6fcc8b	f
770ce898-e404-41ae-b791-ebab6d704c10	83063235-df62-4617-8735-13c2af58d906	t
770ce898-e404-41ae-b791-ebab6d704c10	b01dc004-c6b3-43b1-ae12-a2af4991a88d	t
770ce898-e404-41ae-b791-ebab6d704c10	bcc895ad-1a0e-408b-a359-1b774e18eca7	t
770ce898-e404-41ae-b791-ebab6d704c10	502364c7-4f14-401b-815c-2e11595af00d	f
770ce898-e404-41ae-b791-ebab6d704c10	540a6682-df80-4340-a6dc-a66af8cfbe61	f
770ce898-e404-41ae-b791-ebab6d704c10	47230b50-eb33-4814-9ea0-5cc25ee6eb1f	t
770ce898-e404-41ae-b791-ebab6d704c10	4af760a8-c5fb-4c59-a041-98bc24956bab	t
770ce898-e404-41ae-b791-ebab6d704c10	182e9196-0aee-4835-8972-fa87d4265a67	f
770ce898-e404-41ae-b791-ebab6d704c10	4a6cad40-c778-4fed-ac30-cc24e06d7748	t
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id, details_json_long_value) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.keycloak_group (id, name, parent_group, realm_id) FROM stdin;
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
a2dc394f-34a6-4536-a75a-178a4fa662d6	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	f	${role_default-roles}	default-roles-master	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	\N	\N
74c8ad55-f447-494f-b3ae-596b45ce9044	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	f	${role_admin}	admin	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	\N	\N
fde81e0b-a51b-44c2-bc18-36a3625c6220	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	f	${role_create-realm}	create-realm	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	\N	\N
ca1a102e-8b04-4f4f-87d1-28d27b321e5d	426ae130-9585-4285-a441-53a1324072e1	t	${role_create-client}	create-client	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	426ae130-9585-4285-a441-53a1324072e1	\N
87852e06-872c-4cc6-8c25-44040c9479c8	426ae130-9585-4285-a441-53a1324072e1	t	${role_view-realm}	view-realm	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	426ae130-9585-4285-a441-53a1324072e1	\N
6b87f242-5ccb-48f5-820a-acd01c2837a2	426ae130-9585-4285-a441-53a1324072e1	t	${role_view-users}	view-users	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	426ae130-9585-4285-a441-53a1324072e1	\N
0ef0acee-2275-4932-9893-3898a9ecf878	426ae130-9585-4285-a441-53a1324072e1	t	${role_view-clients}	view-clients	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	426ae130-9585-4285-a441-53a1324072e1	\N
87e01051-a0de-40e0-93ac-74c00e56e8fe	426ae130-9585-4285-a441-53a1324072e1	t	${role_view-events}	view-events	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	426ae130-9585-4285-a441-53a1324072e1	\N
173f74bc-d1e9-44fd-9966-bfadab0f7f4c	426ae130-9585-4285-a441-53a1324072e1	t	${role_view-identity-providers}	view-identity-providers	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	426ae130-9585-4285-a441-53a1324072e1	\N
e660ab05-eaca-492d-a9a7-b3ec616101be	426ae130-9585-4285-a441-53a1324072e1	t	${role_view-authorization}	view-authorization	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	426ae130-9585-4285-a441-53a1324072e1	\N
9e43f2b4-1da8-457b-be9f-70cc516c1529	426ae130-9585-4285-a441-53a1324072e1	t	${role_manage-realm}	manage-realm	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	426ae130-9585-4285-a441-53a1324072e1	\N
075bdcfb-84b1-49e9-989c-3f8053672644	426ae130-9585-4285-a441-53a1324072e1	t	${role_manage-users}	manage-users	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	426ae130-9585-4285-a441-53a1324072e1	\N
59ed3a89-1b3d-439f-8072-cb0499f96dad	426ae130-9585-4285-a441-53a1324072e1	t	${role_manage-clients}	manage-clients	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	426ae130-9585-4285-a441-53a1324072e1	\N
b1aa2389-601d-4544-a39c-70d938ca383a	426ae130-9585-4285-a441-53a1324072e1	t	${role_manage-events}	manage-events	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	426ae130-9585-4285-a441-53a1324072e1	\N
965c0e03-e11a-42e1-bd6c-1cd3501d69fc	426ae130-9585-4285-a441-53a1324072e1	t	${role_manage-identity-providers}	manage-identity-providers	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	426ae130-9585-4285-a441-53a1324072e1	\N
fe06d958-a587-4c3b-ba26-99bfb667856a	426ae130-9585-4285-a441-53a1324072e1	t	${role_manage-authorization}	manage-authorization	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	426ae130-9585-4285-a441-53a1324072e1	\N
a081a78b-9158-4f9c-ae33-160ba5a7de56	426ae130-9585-4285-a441-53a1324072e1	t	${role_query-users}	query-users	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	426ae130-9585-4285-a441-53a1324072e1	\N
f18dc984-9d38-451a-ad46-752abf139f94	426ae130-9585-4285-a441-53a1324072e1	t	${role_query-clients}	query-clients	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	426ae130-9585-4285-a441-53a1324072e1	\N
8a45bdbe-9897-4585-a174-08917c90d17b	426ae130-9585-4285-a441-53a1324072e1	t	${role_query-realms}	query-realms	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	426ae130-9585-4285-a441-53a1324072e1	\N
f90d9d4f-2dc7-4c83-a46f-4b0cf31bc577	426ae130-9585-4285-a441-53a1324072e1	t	${role_query-groups}	query-groups	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	426ae130-9585-4285-a441-53a1324072e1	\N
f27fb9ce-4c42-4fd7-a19e-560b5a8532f1	ecdf389d-bd04-468c-8335-78947724ba88	t	${role_view-profile}	view-profile	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	ecdf389d-bd04-468c-8335-78947724ba88	\N
15207ed9-57ab-4b46-87bb-03da33559d2f	ecdf389d-bd04-468c-8335-78947724ba88	t	${role_manage-account}	manage-account	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	ecdf389d-bd04-468c-8335-78947724ba88	\N
5e64c0d7-0c4c-4140-a569-da7c03cb650a	ecdf389d-bd04-468c-8335-78947724ba88	t	${role_manage-account-links}	manage-account-links	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	ecdf389d-bd04-468c-8335-78947724ba88	\N
deb143a0-2229-41ca-85a7-3c15b8b271fc	ecdf389d-bd04-468c-8335-78947724ba88	t	${role_view-applications}	view-applications	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	ecdf389d-bd04-468c-8335-78947724ba88	\N
01401061-5139-4ffa-9688-8dec56c633c2	ecdf389d-bd04-468c-8335-78947724ba88	t	${role_view-consent}	view-consent	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	ecdf389d-bd04-468c-8335-78947724ba88	\N
2c1f300b-32ab-474a-901d-4b3cda0e1c36	ecdf389d-bd04-468c-8335-78947724ba88	t	${role_manage-consent}	manage-consent	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	ecdf389d-bd04-468c-8335-78947724ba88	\N
d55ebc2c-f0ae-4924-ada8-58ba25092656	ecdf389d-bd04-468c-8335-78947724ba88	t	${role_view-groups}	view-groups	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	ecdf389d-bd04-468c-8335-78947724ba88	\N
ad722e4f-86ab-405d-a66e-b351c74410d6	ecdf389d-bd04-468c-8335-78947724ba88	t	${role_delete-account}	delete-account	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	ecdf389d-bd04-468c-8335-78947724ba88	\N
855cc843-ea15-40e1-a0cf-8c0c76a296d3	02ab83e5-64e4-44d6-a02d-12d2f9412492	t	${role_read-token}	read-token	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	02ab83e5-64e4-44d6-a02d-12d2f9412492	\N
b508b4d6-8acd-4572-825e-2c42e05ef62c	426ae130-9585-4285-a441-53a1324072e1	t	${role_impersonation}	impersonation	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	426ae130-9585-4285-a441-53a1324072e1	\N
280ecf65-9097-42c8-956b-c519b987c9a9	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	f	${role_offline-access}	offline_access	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	\N	\N
1c2ac667-62b2-49be-ad30-6958a51d3457	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	f	${role_uma_authorization}	uma_authorization	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	\N	\N
ba5939f5-f725-4e63-af76-fd2de6ec1ba3	770ce898-e404-41ae-b791-ebab6d704c10	f	${role_default-roles}	default-roles-test	770ce898-e404-41ae-b791-ebab6d704c10	\N	\N
f5cde08a-a3af-4b97-8a04-101e83c7ab0b	996850a3-73fb-4987-9a88-9c59ca8f0622	t	${role_create-client}	create-client	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	996850a3-73fb-4987-9a88-9c59ca8f0622	\N
b11d087e-1ef0-4480-a4c6-f0557ea439c3	996850a3-73fb-4987-9a88-9c59ca8f0622	t	${role_view-realm}	view-realm	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	996850a3-73fb-4987-9a88-9c59ca8f0622	\N
f52a7060-819f-4ed3-b8f9-eb70b696f8da	996850a3-73fb-4987-9a88-9c59ca8f0622	t	${role_view-users}	view-users	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	996850a3-73fb-4987-9a88-9c59ca8f0622	\N
40adf3af-4023-4765-8b2e-d603b28e949a	996850a3-73fb-4987-9a88-9c59ca8f0622	t	${role_view-clients}	view-clients	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	996850a3-73fb-4987-9a88-9c59ca8f0622	\N
85af9a7a-37ae-4658-acce-923a6b933fc3	996850a3-73fb-4987-9a88-9c59ca8f0622	t	${role_view-events}	view-events	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	996850a3-73fb-4987-9a88-9c59ca8f0622	\N
27f9b2c9-e8a5-4f6c-b102-214ecc566a90	996850a3-73fb-4987-9a88-9c59ca8f0622	t	${role_view-identity-providers}	view-identity-providers	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	996850a3-73fb-4987-9a88-9c59ca8f0622	\N
c625f65f-1db9-492d-b4b2-744187d9fc4b	996850a3-73fb-4987-9a88-9c59ca8f0622	t	${role_view-authorization}	view-authorization	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	996850a3-73fb-4987-9a88-9c59ca8f0622	\N
da99a5bc-e49e-47c9-94d6-0a36ae164747	996850a3-73fb-4987-9a88-9c59ca8f0622	t	${role_manage-realm}	manage-realm	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	996850a3-73fb-4987-9a88-9c59ca8f0622	\N
bf8928ff-8b7d-4930-a02a-2bf9d6b3e5f4	996850a3-73fb-4987-9a88-9c59ca8f0622	t	${role_manage-users}	manage-users	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	996850a3-73fb-4987-9a88-9c59ca8f0622	\N
3e0b22ad-dfa6-4626-83e3-8ade6e280a63	996850a3-73fb-4987-9a88-9c59ca8f0622	t	${role_manage-clients}	manage-clients	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	996850a3-73fb-4987-9a88-9c59ca8f0622	\N
a9ce1e1c-6bbc-477f-bb42-32ff1561b581	996850a3-73fb-4987-9a88-9c59ca8f0622	t	${role_manage-events}	manage-events	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	996850a3-73fb-4987-9a88-9c59ca8f0622	\N
c13d4897-f214-4979-8de6-80f562113d37	996850a3-73fb-4987-9a88-9c59ca8f0622	t	${role_manage-identity-providers}	manage-identity-providers	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	996850a3-73fb-4987-9a88-9c59ca8f0622	\N
cc5c21f7-cb93-461e-8760-3e9f2b7512f4	996850a3-73fb-4987-9a88-9c59ca8f0622	t	${role_manage-authorization}	manage-authorization	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	996850a3-73fb-4987-9a88-9c59ca8f0622	\N
572dc381-916b-40f3-a9ee-c2a48bb02e8b	996850a3-73fb-4987-9a88-9c59ca8f0622	t	${role_query-users}	query-users	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	996850a3-73fb-4987-9a88-9c59ca8f0622	\N
9421ecbd-6611-4648-8ff2-2f245eabadfc	996850a3-73fb-4987-9a88-9c59ca8f0622	t	${role_query-clients}	query-clients	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	996850a3-73fb-4987-9a88-9c59ca8f0622	\N
41aa5925-eb92-4456-9ff0-9a9e840e719a	996850a3-73fb-4987-9a88-9c59ca8f0622	t	${role_query-realms}	query-realms	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	996850a3-73fb-4987-9a88-9c59ca8f0622	\N
750aedd2-b685-466d-86a7-724799874934	996850a3-73fb-4987-9a88-9c59ca8f0622	t	${role_query-groups}	query-groups	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	996850a3-73fb-4987-9a88-9c59ca8f0622	\N
9b82fbfa-308d-4384-9565-7bce5b0b83b0	d4ea4781-4a6c-4f38-b0c0-8eb810dadb4f	t	${role_realm-admin}	realm-admin	770ce898-e404-41ae-b791-ebab6d704c10	d4ea4781-4a6c-4f38-b0c0-8eb810dadb4f	\N
ba815420-1970-4eec-bc82-5b69975ad127	d4ea4781-4a6c-4f38-b0c0-8eb810dadb4f	t	${role_create-client}	create-client	770ce898-e404-41ae-b791-ebab6d704c10	d4ea4781-4a6c-4f38-b0c0-8eb810dadb4f	\N
5c09f6ff-ec9d-492c-bbe5-8c2310eeb4c7	d4ea4781-4a6c-4f38-b0c0-8eb810dadb4f	t	${role_view-realm}	view-realm	770ce898-e404-41ae-b791-ebab6d704c10	d4ea4781-4a6c-4f38-b0c0-8eb810dadb4f	\N
c9eb7e52-67b4-40ff-b588-ce7984c5e1f0	d4ea4781-4a6c-4f38-b0c0-8eb810dadb4f	t	${role_view-users}	view-users	770ce898-e404-41ae-b791-ebab6d704c10	d4ea4781-4a6c-4f38-b0c0-8eb810dadb4f	\N
37818233-dc21-4eb2-a6ce-a5834f9ca703	d4ea4781-4a6c-4f38-b0c0-8eb810dadb4f	t	${role_view-clients}	view-clients	770ce898-e404-41ae-b791-ebab6d704c10	d4ea4781-4a6c-4f38-b0c0-8eb810dadb4f	\N
0699d122-99f4-4e08-bb53-eab65a42c77e	d4ea4781-4a6c-4f38-b0c0-8eb810dadb4f	t	${role_view-events}	view-events	770ce898-e404-41ae-b791-ebab6d704c10	d4ea4781-4a6c-4f38-b0c0-8eb810dadb4f	\N
b725a384-a09a-4884-ab7e-03f7440a3abe	d4ea4781-4a6c-4f38-b0c0-8eb810dadb4f	t	${role_view-identity-providers}	view-identity-providers	770ce898-e404-41ae-b791-ebab6d704c10	d4ea4781-4a6c-4f38-b0c0-8eb810dadb4f	\N
75880a84-ddee-48cd-9cdd-f18e9c1aab4a	d4ea4781-4a6c-4f38-b0c0-8eb810dadb4f	t	${role_view-authorization}	view-authorization	770ce898-e404-41ae-b791-ebab6d704c10	d4ea4781-4a6c-4f38-b0c0-8eb810dadb4f	\N
8ad10a41-f143-48f1-82a3-cdd8d1a2e186	d4ea4781-4a6c-4f38-b0c0-8eb810dadb4f	t	${role_manage-realm}	manage-realm	770ce898-e404-41ae-b791-ebab6d704c10	d4ea4781-4a6c-4f38-b0c0-8eb810dadb4f	\N
5554b516-0838-448c-97da-8243fafada21	d4ea4781-4a6c-4f38-b0c0-8eb810dadb4f	t	${role_manage-users}	manage-users	770ce898-e404-41ae-b791-ebab6d704c10	d4ea4781-4a6c-4f38-b0c0-8eb810dadb4f	\N
624ff818-66c5-4c72-b3c3-cf5bbe398d96	d4ea4781-4a6c-4f38-b0c0-8eb810dadb4f	t	${role_manage-clients}	manage-clients	770ce898-e404-41ae-b791-ebab6d704c10	d4ea4781-4a6c-4f38-b0c0-8eb810dadb4f	\N
390e71c3-a1ae-4567-a0b4-0c9e0ae1ffec	d4ea4781-4a6c-4f38-b0c0-8eb810dadb4f	t	${role_manage-events}	manage-events	770ce898-e404-41ae-b791-ebab6d704c10	d4ea4781-4a6c-4f38-b0c0-8eb810dadb4f	\N
f03b8dc2-0a90-429f-83ef-b94cadcb2172	d4ea4781-4a6c-4f38-b0c0-8eb810dadb4f	t	${role_manage-identity-providers}	manage-identity-providers	770ce898-e404-41ae-b791-ebab6d704c10	d4ea4781-4a6c-4f38-b0c0-8eb810dadb4f	\N
aa8d5cc6-4edf-4d48-bc04-9342268ef47a	d4ea4781-4a6c-4f38-b0c0-8eb810dadb4f	t	${role_manage-authorization}	manage-authorization	770ce898-e404-41ae-b791-ebab6d704c10	d4ea4781-4a6c-4f38-b0c0-8eb810dadb4f	\N
ef250e50-36ce-459c-97f8-18d67bac5f9a	d4ea4781-4a6c-4f38-b0c0-8eb810dadb4f	t	${role_query-users}	query-users	770ce898-e404-41ae-b791-ebab6d704c10	d4ea4781-4a6c-4f38-b0c0-8eb810dadb4f	\N
870d8840-8624-453d-88eb-805102b6049f	d4ea4781-4a6c-4f38-b0c0-8eb810dadb4f	t	${role_query-clients}	query-clients	770ce898-e404-41ae-b791-ebab6d704c10	d4ea4781-4a6c-4f38-b0c0-8eb810dadb4f	\N
4530def5-1d0e-4d2e-bf6e-709d1e97faf0	d4ea4781-4a6c-4f38-b0c0-8eb810dadb4f	t	${role_query-realms}	query-realms	770ce898-e404-41ae-b791-ebab6d704c10	d4ea4781-4a6c-4f38-b0c0-8eb810dadb4f	\N
344ee79e-4e28-49b0-a8bc-dbf1e18637bb	d4ea4781-4a6c-4f38-b0c0-8eb810dadb4f	t	${role_query-groups}	query-groups	770ce898-e404-41ae-b791-ebab6d704c10	d4ea4781-4a6c-4f38-b0c0-8eb810dadb4f	\N
266f932b-c35c-4e8b-994c-73681ce57f80	451405e8-0990-4be8-82f7-d58ca59a526a	t	${role_view-profile}	view-profile	770ce898-e404-41ae-b791-ebab6d704c10	451405e8-0990-4be8-82f7-d58ca59a526a	\N
7e6a951c-9ab1-4576-9829-c966680d69e2	451405e8-0990-4be8-82f7-d58ca59a526a	t	${role_manage-account}	manage-account	770ce898-e404-41ae-b791-ebab6d704c10	451405e8-0990-4be8-82f7-d58ca59a526a	\N
78d5f359-0379-4762-ad19-28eda36d6bf4	451405e8-0990-4be8-82f7-d58ca59a526a	t	${role_manage-account-links}	manage-account-links	770ce898-e404-41ae-b791-ebab6d704c10	451405e8-0990-4be8-82f7-d58ca59a526a	\N
b8e12057-f2ae-4f86-b868-990e87a16c5f	451405e8-0990-4be8-82f7-d58ca59a526a	t	${role_view-applications}	view-applications	770ce898-e404-41ae-b791-ebab6d704c10	451405e8-0990-4be8-82f7-d58ca59a526a	\N
e1b3bbc9-16c6-4ef3-a7b6-f89a586e60b6	451405e8-0990-4be8-82f7-d58ca59a526a	t	${role_view-consent}	view-consent	770ce898-e404-41ae-b791-ebab6d704c10	451405e8-0990-4be8-82f7-d58ca59a526a	\N
d3879bda-e2af-453b-afee-71f77e82bce3	451405e8-0990-4be8-82f7-d58ca59a526a	t	${role_manage-consent}	manage-consent	770ce898-e404-41ae-b791-ebab6d704c10	451405e8-0990-4be8-82f7-d58ca59a526a	\N
37ca8e41-58df-4f3a-937e-8df47219e9de	451405e8-0990-4be8-82f7-d58ca59a526a	t	${role_view-groups}	view-groups	770ce898-e404-41ae-b791-ebab6d704c10	451405e8-0990-4be8-82f7-d58ca59a526a	\N
93ca9359-717c-4fde-9a28-254b2959d8fb	451405e8-0990-4be8-82f7-d58ca59a526a	t	${role_delete-account}	delete-account	770ce898-e404-41ae-b791-ebab6d704c10	451405e8-0990-4be8-82f7-d58ca59a526a	\N
f9400605-831f-4aea-8836-8c597ecb9435	996850a3-73fb-4987-9a88-9c59ca8f0622	t	${role_impersonation}	impersonation	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	996850a3-73fb-4987-9a88-9c59ca8f0622	\N
8c2b1e20-c056-45c2-aded-fb3637ca0f46	d4ea4781-4a6c-4f38-b0c0-8eb810dadb4f	t	${role_impersonation}	impersonation	770ce898-e404-41ae-b791-ebab6d704c10	d4ea4781-4a6c-4f38-b0c0-8eb810dadb4f	\N
65c439dc-dbf5-4f86-aba1-0ddddb168a97	8f9c30d9-585a-43b7-886d-5cac5bee3723	t	${role_read-token}	read-token	770ce898-e404-41ae-b791-ebab6d704c10	8f9c30d9-585a-43b7-886d-5cac5bee3723	\N
83884d76-a951-45ec-b800-6b5be8fe2f68	770ce898-e404-41ae-b791-ebab6d704c10	f	${role_offline-access}	offline_access	770ce898-e404-41ae-b791-ebab6d704c10	\N	\N
c59d202c-e031-48fa-86f5-a30e37da75d8	770ce898-e404-41ae-b791-ebab6d704c10	f	${role_uma_authorization}	uma_authorization	770ce898-e404-41ae-b791-ebab6d704c10	\N	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.migration_model (id, version, update_time) FROM stdin;
6efp6	23.0.7	1710789108
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id) FROM stdin;
c40ce968-627c-4a23-9aa6-b3501bd84a06	15850342-cc1c-460f-b0d6-23700ebc0190	1	1710789533	{"authMethod":"openid-connect","redirectUri":"http://localhost:8082/login/oauth2/code/external","notes":{"clientId":"15850342-cc1c-460f-b0d6-23700ebc0190","scope":"openid offline_access profile","SSO_AUTH":"true","userSessionStartedAt":"1710789444","iss":"http://localhost:8080/realms/Test","startedAt":"1710789444","response_type":"code","level-of-authentication":"-1","redirect_uri":"http://localhost:8082/login/oauth2/code/external","state":"N8vQDuW_LXmTegHnqguSgPtlbetYO1q71Jq-7j_sG3Q=","nonce":"WzPX-TbnUUgyocpVAJvOAbaJz62cFXy55nrHuPsw8rA"}}	local	local
c6ba0dbd-fc46-48cc-8819-60f6173c1779	15850342-cc1c-460f-b0d6-23700ebc0190	1	1711278016	{"authMethod":"openid-connect","redirectUri":"http://localhost:8082/login/oauth2/code/external","notes":{"clientId":"15850342-cc1c-460f-b0d6-23700ebc0190","scope":"openid offline_access profile","userSessionStartedAt":"1711278016","iss":"http://localhost:8080/realms/Test","startedAt":"1711278016","response_type":"code","level-of-authentication":"-1","redirect_uri":"http://localhost:8082/login/oauth2/code/external","state":"eFvLsK8-pnqXNuHte4LMUFyNEzRlCV_URRtqpHs7_vg=","nonce":"yxozeYo6HqSy5lQkR2W9Qi88chNOyFfQIGbDt-IUgpM"}}	local	local
c4e42be7-66cb-4da0-8050-ffa0564c153f	15850342-cc1c-460f-b0d6-23700ebc0190	1	1711282840	{"authMethod":"openid-connect","redirectUri":"http://localhost:8082/login/oauth2/code/external","notes":{"clientId":"15850342-cc1c-460f-b0d6-23700ebc0190","scope":"openid offline_access profile","userSessionStartedAt":"1711282840","iss":"http://localhost:8080/realms/Test","startedAt":"1711282840","response_type":"code","level-of-authentication":"-1","redirect_uri":"http://localhost:8082/login/oauth2/code/external","state":"d5JINy0PWffG3b7P-0ui9UZAGVF8vGe0OcVdvoTLiHI=","nonce":"hJeZ0mFcMhaJJa7a9ZPKj07kKD5y5iclzgvh-MUpqOg"}}	local	local
82ec2b5d-8d14-4f6c-a75c-8d3b34f8220b	15850342-cc1c-460f-b0d6-23700ebc0190	1	1711293838	{"authMethod":"openid-connect","redirectUri":"http://localhost:8082/login/oauth2/code/external","notes":{"clientId":"15850342-cc1c-460f-b0d6-23700ebc0190","scope":"openid offline_access profile","userSessionStartedAt":"1711293838","iss":"http://localhost:8080/realms/Test","startedAt":"1711293838","response_type":"code","level-of-authentication":"-1","redirect_uri":"http://localhost:8082/login/oauth2/code/external","state":"orhSu9AnqS7csRxeNou34tB8-X8kjoY6xdcu018-yuk=","nonce":"xKVizT9coozz-3dYYgy-O5Gk6ziDlpQG9fR0Te_Yaok"}}	local	local
acb352d9-957c-421f-954d-27db851ba024	15850342-cc1c-460f-b0d6-23700ebc0190	1	1711297260	{"authMethod":"openid-connect","redirectUri":"http://localhost:8082/login/oauth2/code/external","notes":{"clientId":"15850342-cc1c-460f-b0d6-23700ebc0190","scope":"openid offline_access profile","userSessionStartedAt":"1711297260","iss":"http://localhost:8080/realms/Test","startedAt":"1711297260","response_type":"code","level-of-authentication":"-1","redirect_uri":"http://localhost:8082/login/oauth2/code/external","state":"_IWqzVlJIEz2hEwKxOImcT3JcHz5kQc9QynoH5GyxrA=","nonce":"ahuj6ykrjVqD8QRe5Dveem-jXfoL3CSQIEBBjNs4iQo"}}	local	local
7c1ae402-ba0b-4f11-b6d9-757758a35538	15850342-cc1c-460f-b0d6-23700ebc0190	1	1711318006	{"authMethod":"openid-connect","redirectUri":"http://localhost:8082/login/oauth2/code/external","notes":{"clientId":"15850342-cc1c-460f-b0d6-23700ebc0190","scope":"openid offline_access profile","userSessionStartedAt":"1711318006","iss":"http://localhost:8080/realms/Test","startedAt":"1711318006","response_type":"code","level-of-authentication":"-1","redirect_uri":"http://localhost:8082/login/oauth2/code/external","state":"FgdzbEuhp5LHN2WqRRFIWRJg87ILFGnfK1HkD6GAQwg=","nonce":"uPBdAJ5-DYwqhJ-3mo69SkDMCHiwy1UBfFJdFjGGnqk"}}	local	local
08de9d8a-b816-43f3-a6de-425457b11ad8	15850342-cc1c-460f-b0d6-23700ebc0190	1	1711320990	{"authMethod":"openid-connect","redirectUri":"http://localhost:8082/login/oauth2/code/external","notes":{"clientId":"15850342-cc1c-460f-b0d6-23700ebc0190","scope":"openid offline_access profile","userSessionStartedAt":"1711320990","iss":"http://localhost:8080/realms/Test","startedAt":"1711320991","response_type":"code","level-of-authentication":"-1","redirect_uri":"http://localhost:8082/login/oauth2/code/external","state":"_odQ9bSARk_J6XTul1AzId2GxUN-IRgM68TvgjFoKeE=","nonce":"A_oBeA-5qv-YN-PSaxuWKjS-4gyX7YXxkf5pwRcU0ko"}}	local	local
093cb191-743e-4563-940d-f70f3a2b8ad4	15850342-cc1c-460f-b0d6-23700ebc0190	1	1711322118	{"authMethod":"openid-connect","redirectUri":"http://localhost:8082/login/oauth2/code/external","notes":{"clientId":"15850342-cc1c-460f-b0d6-23700ebc0190","scope":"openid offline_access profile","userSessionStartedAt":"1711322118","iss":"http://172.17.0.1:8080/realms/Test","startedAt":"1711322118","response_type":"code","level-of-authentication":"-1","redirect_uri":"http://localhost:8082/login/oauth2/code/external","state":"fVtoyXL2HnUqqDhtomvqZsvVyVy5vpCUw0-i-8HNRGw=","nonce":"rTh-RzhzkpdWbpzP0CpG-7N-iCR3OFx3mcb0a-vIr7o"}}	local	local
f0f2af55-424a-4abc-9768-a08d0d498ab3	15850342-cc1c-460f-b0d6-23700ebc0190	1	1711382787	{"authMethod":"openid-connect","redirectUri":"http://localhost:8082/login/oauth2/code/external","notes":{"clientId":"15850342-cc1c-460f-b0d6-23700ebc0190","scope":"openid offline_access profile","userSessionStartedAt":"1711382787","iss":"http://172.17.0.1:8080/realms/Test","startedAt":"1711382787","response_type":"code","level-of-authentication":"-1","redirect_uri":"http://localhost:8082/login/oauth2/code/external","state":"_Osqygll0tE0krE9wrh7IOUuQguw3VNNl_WTE6xaPqU=","nonce":"wWSY7UOKjUBIKf26o8HCtarlg3hArxZsCqiKyHeHEy4"}}	local	local
2ef343e9-d077-44db-89d3-023b3e67125c	15850342-cc1c-460f-b0d6-23700ebc0190	1	1711383447	{"authMethod":"openid-connect","redirectUri":"http://localhost:8082/login/oauth2/code/external","notes":{"clientId":"15850342-cc1c-460f-b0d6-23700ebc0190","scope":"openid offline_access profile","userSessionStartedAt":"1711383447","iss":"http://172.17.0.1:8080/realms/Test","startedAt":"1711383447","response_type":"code","level-of-authentication":"-1","redirect_uri":"http://localhost:8082/login/oauth2/code/external","state":"fxCe8_jNuUq2avkjs2NsLBlH6TZy7aM2yPkP9090Sl0=","nonce":"B_iahxTJvaawTokopKZPI6I5Y0lZ9Bd26PXOa-ILZsU"}}	local	local
88bcaf70-b8d4-4126-be7c-f232bef5d615	15850342-cc1c-460f-b0d6-23700ebc0190	1	1711389289	{"authMethod":"openid-connect","redirectUri":"http://localhost:8082/login/oauth2/code/external","notes":{"clientId":"15850342-cc1c-460f-b0d6-23700ebc0190","scope":"openid offline_access profile","userSessionStartedAt":"1711389289","iss":"http://172.17.0.1:8080/realms/Test","startedAt":"1711389290","response_type":"code","level-of-authentication":"-1","redirect_uri":"http://localhost:8082/login/oauth2/code/external","state":"6d5sX3dB3d2JV3z6yRiEKqDOUAlZOVJu9NeeWCWYYwg=","nonce":"Gn3gK1Bxj5xhSMUBFtuy-F2n1NuhXbl8voM0GG5xDaE"}}	local	local
480b9576-70d0-45dc-b00b-7a0f49089ad3	15850342-cc1c-460f-b0d6-23700ebc0190	1	1711389688	{"authMethod":"openid-connect","redirectUri":"http://localhost:8082/login/oauth2/code/external","notes":{"clientId":"15850342-cc1c-460f-b0d6-23700ebc0190","scope":"openid offline_access profile","userSessionStartedAt":"1711389688","iss":"http://172.17.0.1:8080/realms/Test","startedAt":"1711389688","response_type":"code","level-of-authentication":"-1","redirect_uri":"http://localhost:8082/login/oauth2/code/external","state":"jZuUK7Q6JkdmXIuh1c6u5r9XM4Xg6-t1tBPpdaY1qiI=","nonce":"_fj9tk8p12t3dTObO8pO48gkoXLxUAxyZAwS_FRHG1c"}}	local	local
2995556c-b1a4-4ddb-b0ba-15185a416a81	15850342-cc1c-460f-b0d6-23700ebc0190	1	1711390110	{"authMethod":"openid-connect","redirectUri":"http://localhost:8082/login/oauth2/code/external","notes":{"clientId":"15850342-cc1c-460f-b0d6-23700ebc0190","scope":"openid offline_access profile","userSessionStartedAt":"1711390110","iss":"http://172.17.0.1:8080/realms/Test","startedAt":"1711390110","response_type":"code","level-of-authentication":"-1","redirect_uri":"http://localhost:8082/login/oauth2/code/external","state":"2184H62wVU4VlGT_fv1qdLSlX_aEnG8em6XEbRzuny0=","nonce":"IfkPqOYWr5KzL_ezixiWsWeh-gG8I7GvdZfPVOp4Jv4"}}	local	local
2aed1d6f-0802-44d3-b7c6-9b0cdb700cfb	15850342-cc1c-460f-b0d6-23700ebc0190	1	1711390330	{"authMethod":"openid-connect","redirectUri":"http://localhost:8082/login/oauth2/code/external","notes":{"clientId":"15850342-cc1c-460f-b0d6-23700ebc0190","scope":"openid offline_access profile","userSessionStartedAt":"1711390330","iss":"http://172.17.0.1:8080/realms/Test","startedAt":"1711390330","response_type":"code","level-of-authentication":"-1","redirect_uri":"http://localhost:8082/login/oauth2/code/external","state":"x-dpLGIhoAhjVZ1nAlWJBvfcKRoavJIqKOLsZnfrS9k=","nonce":"odcDuYYbdqaiqEVWfv--X-VBxqlbz78qZpkOJLeY_xI"}}	local	local
8bf006e2-6bee-4cb4-9c9a-e83478310cc7	15850342-cc1c-460f-b0d6-23700ebc0190	1	1711392555	{"authMethod":"openid-connect","redirectUri":"http://172.17.0.1:8082/login/oauth2/code/external","notes":{"clientId":"15850342-cc1c-460f-b0d6-23700ebc0190","scope":"openid offline_access profile","userSessionStartedAt":"1711392555","iss":"http://172.17.0.1:8080/realms/Test","startedAt":"1711392555","response_type":"code","level-of-authentication":"-1","redirect_uri":"http://172.17.0.1:8082/login/oauth2/code/external","state":"215HWT3c1K50HIJH5hT7NDtS9Wv7dRD59JBCuYQucvE=","nonce":"158FPS3oYK8Erxf_6rIalOUQUIYaCFvXQ9zTtJ06fSA"}}	local	local
c4e06694-5dba-4878-9889-cfdbe69da54b	15850342-cc1c-460f-b0d6-23700ebc0190	1	1711395034	{"authMethod":"openid-connect","redirectUri":"http://172.17.0.1:8082/login/oauth2/code/external","notes":{"clientId":"15850342-cc1c-460f-b0d6-23700ebc0190","scope":"openid offline_access profile","userSessionStartedAt":"1711395034","iss":"http://172.17.0.1:8080/realms/Test","startedAt":"1711395034","response_type":"code","level-of-authentication":"-1","redirect_uri":"http://172.17.0.1:8082/login/oauth2/code/external","state":"BHhdOWEuobJWmK1ZVnqgHIay6CtIlRmGgrKJpn_9594=","nonce":"cainY6I5-XqmSCKqTySAFqIpnMEtslkFF27kWs6HxhE"}}	local	local
c3b54a6a-3f41-4d34-bfcd-d61b19b75ff3	15850342-cc1c-460f-b0d6-23700ebc0190	1	1711397984	{"authMethod":"openid-connect","redirectUri":"http://172.17.0.1:8082/login/oauth2/code/external","notes":{"clientId":"15850342-cc1c-460f-b0d6-23700ebc0190","scope":"openid offline_access profile","userSessionStartedAt":"1711397984","iss":"http://172.17.0.1:8080/realms/Test","startedAt":"1711397984","response_type":"code","level-of-authentication":"-1","redirect_uri":"http://172.17.0.1:8082/login/oauth2/code/external","state":"OpqmlKVZiBBirno61qQ6dJp5Xl09VoagfDoUik_Dvd0=","nonce":"hLeEZF2P-RlASfo4ee6O--XLAzdeE2hXa1NcuXWgtWA"}}	local	local
9d60642e-f269-4359-8a92-d16f39551d2f	15850342-cc1c-460f-b0d6-23700ebc0190	1	1711536228	{"authMethod":"openid-connect","redirectUri":"http://172.17.0.1:8082/login/oauth2/code/external","notes":{"clientId":"15850342-cc1c-460f-b0d6-23700ebc0190","scope":"openid offline_access profile","userSessionStartedAt":"1711536228","iss":"http://172.17.0.1:8080/realms/Test","startedAt":"1711536228","response_type":"code","level-of-authentication":"-1","redirect_uri":"http://172.17.0.1:8082/login/oauth2/code/external","state":"uVOugH5q4xCYdtbo5f6RmQg1mb029OFfBS9OmKPM6w8=","nonce":"nPbA5_2nvGo1UIcJxR8hk0b5PtDcrg1grGTywuXdZ-Y"}}	local	local
3fce18de-ba5d-427e-915a-48a4fcac0b19	15850342-cc1c-460f-b0d6-23700ebc0190	1	1711540054	{"authMethod":"openid-connect","redirectUri":"http://localhost:8082/login/oauth2/code/external","notes":{"clientId":"15850342-cc1c-460f-b0d6-23700ebc0190","scope":"openid offline_access profile","userSessionStartedAt":"1711540054","iss":"http://172.17.0.1:8080/realms/Test","startedAt":"1711540054","response_type":"code","level-of-authentication":"-1","redirect_uri":"http://localhost:8082/login/oauth2/code/external","state":"xJ5nG1IWok-jxZQtZQigIlokGLA1J4KcXTpA2Mr3VP4=","nonce":"DTvRb3xWi1iegbO805ZppLOpQ-6Nl7ywcZzpXMSioNg"}}	local	local
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh) FROM stdin;
c40ce968-627c-4a23-9aa6-b3501bd84a06	92f34733-9a8b-433b-aa39-ef666217094b	770ce898-e404-41ae-b791-ebab6d704c10	1710789444	1	{"ipAddress":"172.25.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMjUuMC4xIiwib3MiOiJVYnVudHUiLCJvc1ZlcnNpb24iOiJVbmtub3duIiwiYnJvd3NlciI6IkZpcmVmb3gvMTIzLjAiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1710789444"},"state":"LOGGED_IN"}	1710790798
c6ba0dbd-fc46-48cc-8819-60f6173c1779	92f34733-9a8b-433b-aa39-ef666217094b	770ce898-e404-41ae-b791-ebab6d704c10	1711278016	1	{"ipAddress":"172.21.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMjEuMC4xIiwib3MiOiJVYnVudHUiLCJvc1ZlcnNpb24iOiJVbmtub3duIiwiYnJvd3NlciI6IkZpcmVmb3gvMTIzLjAiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1711278016"},"state":"LOGGED_IN"}	1711278671
c4e42be7-66cb-4da0-8050-ffa0564c153f	92f34733-9a8b-433b-aa39-ef666217094b	770ce898-e404-41ae-b791-ebab6d704c10	1711282840	1	{"ipAddress":"172.21.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMjEuMC4xIiwib3MiOiJVYnVudHUiLCJvc1ZlcnNpb24iOiJVbmtub3duIiwiYnJvd3NlciI6IkZpcmVmb3gvMTIzLjAiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1711282840"},"state":"LOGGED_IN"}	1711285513
82ec2b5d-8d14-4f6c-a75c-8d3b34f8220b	92f34733-9a8b-433b-aa39-ef666217094b	770ce898-e404-41ae-b791-ebab6d704c10	1711293838	1	{"ipAddress":"172.21.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMjEuMC4xIiwib3MiOiJVYnVudHUiLCJvc1ZlcnNpb24iOiJVbmtub3duIiwiYnJvd3NlciI6IkZpcmVmb3gvMTIzLjAiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1711293838"},"state":"LOGGED_IN"}	1711293838
acb352d9-957c-421f-954d-27db851ba024	92f34733-9a8b-433b-aa39-ef666217094b	770ce898-e404-41ae-b791-ebab6d704c10	1711297260	1	{"ipAddress":"172.21.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMjEuMC4xIiwib3MiOiJVYnVudHUiLCJvc1ZlcnNpb24iOiJVbmtub3duIiwiYnJvd3NlciI6IkZpcmVmb3gvMTIzLjAiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1711297260"},"state":"LOGGED_IN"}	1711297260
7c1ae402-ba0b-4f11-b6d9-757758a35538	92f34733-9a8b-433b-aa39-ef666217094b	770ce898-e404-41ae-b791-ebab6d704c10	1711318006	1	{"ipAddress":"172.22.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMjIuMC4xIiwib3MiOiJVYnVudHUiLCJvc1ZlcnNpb24iOiJVbmtub3duIiwiYnJvd3NlciI6IkZpcmVmb3gvMTIzLjAiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1711318006"},"state":"LOGGED_IN"}	1711318006
08de9d8a-b816-43f3-a6de-425457b11ad8	92f34733-9a8b-433b-aa39-ef666217094b	770ce898-e404-41ae-b791-ebab6d704c10	1711320990	1	{"ipAddress":"172.22.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMjIuMC4xIiwib3MiOiJVYnVudHUiLCJvc1ZlcnNpb24iOiJVbmtub3duIiwiYnJvd3NlciI6IkZpcmVmb3gvMTIzLjAiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1711320991"},"state":"LOGGED_IN"}	1711320990
093cb191-743e-4563-940d-f70f3a2b8ad4	92f34733-9a8b-433b-aa39-ef666217094b	770ce898-e404-41ae-b791-ebab6d704c10	1711322118	1	{"ipAddress":"172.24.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMjQuMC4xIiwib3MiOiJVYnVudHUiLCJvc1ZlcnNpb24iOiJVbmtub3duIiwiYnJvd3NlciI6IkZpcmVmb3gvMTIzLjAiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1711322118"},"state":"LOGGED_IN"}	1711322118
f0f2af55-424a-4abc-9768-a08d0d498ab3	92f34733-9a8b-433b-aa39-ef666217094b	770ce898-e404-41ae-b791-ebab6d704c10	1711382787	1	{"ipAddress":"172.25.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMjUuMC4xIiwib3MiOiJVYnVudHUiLCJvc1ZlcnNpb24iOiJVbmtub3duIiwiYnJvd3NlciI6IkZpcmVmb3gvMTIzLjAiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1711382787"},"state":"LOGGED_IN"}	1711382787
2ef343e9-d077-44db-89d3-023b3e67125c	92f34733-9a8b-433b-aa39-ef666217094b	770ce898-e404-41ae-b791-ebab6d704c10	1711383447	1	{"ipAddress":"172.26.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMjYuMC4xIiwib3MiOiJVYnVudHUiLCJvc1ZlcnNpb24iOiJVbmtub3duIiwiYnJvd3NlciI6IkZpcmVmb3gvMTIzLjAiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1711383447"},"state":"LOGGED_IN"}	1711383447
88bcaf70-b8d4-4126-be7c-f232bef5d615	92f34733-9a8b-433b-aa39-ef666217094b	770ce898-e404-41ae-b791-ebab6d704c10	1711389289	1	{"ipAddress":"192.168.80.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjgwLjEiLCJvcyI6IlVidW50dSIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiRmlyZWZveC8xMjMuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1711389290"},"state":"LOGGED_IN"}	1711389289
480b9576-70d0-45dc-b00b-7a0f49089ad3	92f34733-9a8b-433b-aa39-ef666217094b	770ce898-e404-41ae-b791-ebab6d704c10	1711389688	1	{"ipAddress":"192.168.96.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxOTIuMTY4Ljk2LjEiLCJvcyI6IlVidW50dSIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiRmlyZWZveC8xMjMuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1711389688"},"state":"LOGGED_IN"}	1711389688
2995556c-b1a4-4ddb-b0ba-15185a416a81	92f34733-9a8b-433b-aa39-ef666217094b	770ce898-e404-41ae-b791-ebab6d704c10	1711390110	1	{"ipAddress":"192.168.112.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjExMi4xIiwib3MiOiJVYnVudHUiLCJvc1ZlcnNpb24iOiJVbmtub3duIiwiYnJvd3NlciI6IkZpcmVmb3gvMTIzLjAiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1711390110"},"state":"LOGGED_IN"}	1711390110
2aed1d6f-0802-44d3-b7c6-9b0cdb700cfb	92f34733-9a8b-433b-aa39-ef666217094b	770ce898-e404-41ae-b791-ebab6d704c10	1711390330	1	{"ipAddress":"192.168.128.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjEyOC4xIiwib3MiOiJVYnVudHUiLCJvc1ZlcnNpb24iOiJVbmtub3duIiwiYnJvd3NlciI6IkZpcmVmb3gvMTIzLjAiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1711390330"},"state":"LOGGED_IN"}	1711390330
8bf006e2-6bee-4cb4-9c9a-e83478310cc7	92f34733-9a8b-433b-aa39-ef666217094b	770ce898-e404-41ae-b791-ebab6d704c10	1711392555	1	{"ipAddress":"192.168.128.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjEyOC4xIiwib3MiOiJVYnVudHUiLCJvc1ZlcnNpb24iOiJVbmtub3duIiwiYnJvd3NlciI6IkZpcmVmb3gvMTIzLjAiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1711392555"},"state":"LOGGED_IN"}	1711392555
c4e06694-5dba-4878-9889-cfdbe69da54b	92f34733-9a8b-433b-aa39-ef666217094b	770ce898-e404-41ae-b791-ebab6d704c10	1711395034	1	{"ipAddress":"192.168.144.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjE0NC4xIiwib3MiOiJVYnVudHUiLCJvc1ZlcnNpb24iOiJVbmtub3duIiwiYnJvd3NlciI6IkZpcmVmb3gvMTIzLjAiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1711395034"},"state":"LOGGED_IN"}	1711395585
c3b54a6a-3f41-4d34-bfcd-d61b19b75ff3	92f34733-9a8b-433b-aa39-ef666217094b	770ce898-e404-41ae-b791-ebab6d704c10	1711397984	1	{"ipAddress":"192.168.160.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjE2MC4xIiwib3MiOiJVYnVudHUiLCJvc1ZlcnNpb24iOiJVbmtub3duIiwiYnJvd3NlciI6IkZpcmVmb3gvMTIzLjAiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1711397984"},"state":"LOGGED_IN"}	1711398128
9d60642e-f269-4359-8a92-d16f39551d2f	92f34733-9a8b-433b-aa39-ef666217094b	770ce898-e404-41ae-b791-ebab6d704c10	1711536228	1	{"ipAddress":"172.21.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMjEuMC4xIiwib3MiOiJVYnVudHUiLCJvc1ZlcnNpb24iOiJVbmtub3duIiwiYnJvd3NlciI6IkZpcmVmb3gvMTIzLjAiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1711536228"},"state":"LOGGED_IN"}	1711536324
3fce18de-ba5d-427e-915a-48a4fcac0b19	92f34733-9a8b-433b-aa39-ef666217094b	770ce898-e404-41ae-b791-ebab6d704c10	1711540054	1	{"ipAddress":"172.22.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMjIuMC4xIiwib3MiOiJVYnVudHUiLCJvc1ZlcnNpb24iOiJVbmtub3duIiwiYnJvd3NlciI6IkZpcmVmb3gvMTIzLjAiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1711540054"},"state":"LOGGED_IN"}	1711540054
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
3c03bacb-3339-499c-826d-0293aba0fbc6	audience resolve	openid-connect	oidc-audience-resolve-mapper	12498f03-3e07-4cd1-b487-a273d83f3eab	\N
8a3119a3-ba21-428e-abb2-7a2993f8601c	locale	openid-connect	oidc-usermodel-attribute-mapper	93beb22d-1ff6-4d50-82e6-ef0da73e38fc	\N
ada4c75a-8417-4870-a808-331ec4585824	role list	saml	saml-role-list-mapper	\N	dbb27ed8-759e-4ece-b515-3fb4cd3782c8
29fe24d2-c3af-4bf5-89ce-be9a660a2a5f	full name	openid-connect	oidc-full-name-mapper	\N	446284bb-3156-4069-85c7-427094d889bb
010edc2d-ac24-468c-9f1f-2cda684cbad5	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	446284bb-3156-4069-85c7-427094d889bb
b4759f62-ad52-42e8-9bc7-a75da49b5a0b	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	446284bb-3156-4069-85c7-427094d889bb
bda8004d-6ed8-425a-84bf-d1a0464873df	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	446284bb-3156-4069-85c7-427094d889bb
35deb00d-bd2e-49e3-96dc-75e5de8e0455	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	446284bb-3156-4069-85c7-427094d889bb
46b51324-0c5b-4ae9-ac42-83e279538a97	username	openid-connect	oidc-usermodel-attribute-mapper	\N	446284bb-3156-4069-85c7-427094d889bb
fc620d34-7ab7-47f1-b134-a951ac44cbbc	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	446284bb-3156-4069-85c7-427094d889bb
eb49ac57-1fda-4f25-bb15-139f5f43d7d4	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	446284bb-3156-4069-85c7-427094d889bb
aeb78ec4-1206-4f43-b82f-6aaf497c8bf1	website	openid-connect	oidc-usermodel-attribute-mapper	\N	446284bb-3156-4069-85c7-427094d889bb
13fc63ee-ecb3-486c-966a-b1c9e0680373	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	446284bb-3156-4069-85c7-427094d889bb
f1b24917-de34-40e5-91e7-e9f14d4fca23	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	446284bb-3156-4069-85c7-427094d889bb
1d9d0e19-f54c-486e-a156-93b680ecf4da	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	446284bb-3156-4069-85c7-427094d889bb
f4e4dec0-e741-4c06-a5e1-858dfc505c2b	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	446284bb-3156-4069-85c7-427094d889bb
e3f3dba3-ebf7-4023-b41a-2626758ecd1d	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	446284bb-3156-4069-85c7-427094d889bb
3a799757-9049-43fb-9861-01ce7b56cc23	email	openid-connect	oidc-usermodel-attribute-mapper	\N	f2f81c2e-37bb-4298-870c-5836474d0546
a7dabbd0-503d-4bd6-b9ec-68cdac737967	email verified	openid-connect	oidc-usermodel-property-mapper	\N	f2f81c2e-37bb-4298-870c-5836474d0546
da0169f9-0dc6-4b61-899a-3c6bc4623106	address	openid-connect	oidc-address-mapper	\N	00b5e17e-cd87-4f68-823c-88b1ebcf2368
2ea0f247-dd3a-4628-9f22-54ab44d84dab	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	6e6bce90-6d50-4495-8b2b-01223ba19f34
ee9dc728-105f-49c9-a055-73c43da120b7	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	6e6bce90-6d50-4495-8b2b-01223ba19f34
695cfb97-1f3b-4d00-ab1a-1825ceb771d8	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	e8f95349-3b51-4494-8b17-ed5dbbd742d6
deef81e1-f881-4167-976c-0421fb67ff75	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	e8f95349-3b51-4494-8b17-ed5dbbd742d6
7266e5fd-4e2c-4e50-b184-b66b92738730	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	e8f95349-3b51-4494-8b17-ed5dbbd742d6
ed36fea6-dbd0-4c6a-912f-1daae80e526a	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	8dbc724d-80b4-423f-aa3f-ac249cba002a
9fbe93ce-8cf0-44ab-9339-f692a7627b1c	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	796f251f-4b2a-49c7-886b-816d07963fca
d325e370-c364-490d-b390-b3721b07b5f0	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	796f251f-4b2a-49c7-886b-816d07963fca
df676ae5-25a2-414a-b57f-5e47d02cb0b2	acr loa level	openid-connect	oidc-acr-mapper	\N	72f40971-939d-4144-9467-0dea9a21737b
cddbb57a-b73e-4ebb-bcdb-44a70197113f	audience resolve	openid-connect	oidc-audience-resolve-mapper	93da7221-98b3-48e8-bb4a-6af01719939d	\N
3759da95-8120-4e77-bbfa-d7f2f254ffe0	role list	saml	saml-role-list-mapper	\N	83063235-df62-4617-8735-13c2af58d906
dfad1dba-bc3e-4cd2-bc8a-39b9e4d52d54	full name	openid-connect	oidc-full-name-mapper	\N	b01dc004-c6b3-43b1-ae12-a2af4991a88d
832be537-eac5-4535-845c-e2ab58c88514	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	b01dc004-c6b3-43b1-ae12-a2af4991a88d
b05d021e-4120-48b1-a3d0-a86b030c5dc4	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	b01dc004-c6b3-43b1-ae12-a2af4991a88d
94b1d2d0-ff63-477c-9b3c-37f4804c8fcd	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	b01dc004-c6b3-43b1-ae12-a2af4991a88d
c86234bd-70e8-4b10-8a3c-b024dc4d3fc8	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	b01dc004-c6b3-43b1-ae12-a2af4991a88d
a349d19d-cc89-4abf-bed3-b4e39b761827	username	openid-connect	oidc-usermodel-attribute-mapper	\N	b01dc004-c6b3-43b1-ae12-a2af4991a88d
aedef612-dfb7-4ee3-8593-c52fbfbbabed	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	b01dc004-c6b3-43b1-ae12-a2af4991a88d
559aa9ad-a8be-4561-8154-90984b06f459	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	b01dc004-c6b3-43b1-ae12-a2af4991a88d
3b96b397-a16a-4131-ba9c-867a87bb6492	website	openid-connect	oidc-usermodel-attribute-mapper	\N	b01dc004-c6b3-43b1-ae12-a2af4991a88d
9b8417d9-c46e-45a0-b9ea-474e58f86dc5	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	b01dc004-c6b3-43b1-ae12-a2af4991a88d
2ec5dfd3-093d-4e3f-aedc-9b10c1895dee	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	b01dc004-c6b3-43b1-ae12-a2af4991a88d
c2680dc6-8f36-42b8-abb6-038444713d5f	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	b01dc004-c6b3-43b1-ae12-a2af4991a88d
75ab4754-6ca5-451a-98bc-aec0fc050655	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	b01dc004-c6b3-43b1-ae12-a2af4991a88d
f4d66349-61f1-4a82-8d69-ff25d26693a4	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	b01dc004-c6b3-43b1-ae12-a2af4991a88d
22dbd81f-20bb-445d-a481-5a32fac1633e	email	openid-connect	oidc-usermodel-attribute-mapper	\N	bcc895ad-1a0e-408b-a359-1b774e18eca7
00e741d4-60c7-4b32-9ec5-14c95bd0a116	email verified	openid-connect	oidc-usermodel-property-mapper	\N	bcc895ad-1a0e-408b-a359-1b774e18eca7
b121259e-5b02-42fa-bca9-e82a1df70295	address	openid-connect	oidc-address-mapper	\N	502364c7-4f14-401b-815c-2e11595af00d
469d4b96-37cb-4754-a4ab-144ff327182d	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	540a6682-df80-4340-a6dc-a66af8cfbe61
e7090c30-83aa-4e59-a21f-714210afa542	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	540a6682-df80-4340-a6dc-a66af8cfbe61
b5bd6c97-a32a-40ab-aab8-0f6f43f1d158	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	47230b50-eb33-4814-9ea0-5cc25ee6eb1f
f72f53eb-ae99-4b86-88cd-7862edb7e8a9	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	47230b50-eb33-4814-9ea0-5cc25ee6eb1f
d00b3b0d-eea4-4e4e-b5e1-82ca6c2b8e46	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	47230b50-eb33-4814-9ea0-5cc25ee6eb1f
ee585a8e-d0bd-47c4-941a-9830d0c524eb	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	4af760a8-c5fb-4c59-a041-98bc24956bab
e5663b4e-95af-4767-9fdd-424aa69e0562	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	182e9196-0aee-4835-8972-fa87d4265a67
1e47c332-6852-4b9b-b96c-08102595671b	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	182e9196-0aee-4835-8972-fa87d4265a67
581d783f-7073-407f-9545-ac04c61db8a8	acr loa level	openid-connect	oidc-acr-mapper	\N	4a6cad40-c778-4fed-ac30-cc24e06d7748
ae8f2b1b-6549-40f4-b28c-197271f1f3d7	locale	openid-connect	oidc-usermodel-attribute-mapper	38dbec92-9c98-47c0-bde7-ec544a99c850	\N
7ef6a5dc-63bd-4866-be90-1517442c7848	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	15850342-cc1c-460f-b0d6-23700ebc0190	\N
51ddd6fb-6160-4b1d-add7-eb3b51d6f117	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	15850342-cc1c-460f-b0d6-23700ebc0190	\N
a4f29e2a-ef6b-40c7-bcc4-f7978f9ccad6	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	15850342-cc1c-460f-b0d6-23700ebc0190	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
8a3119a3-ba21-428e-abb2-7a2993f8601c	true	introspection.token.claim
8a3119a3-ba21-428e-abb2-7a2993f8601c	true	userinfo.token.claim
8a3119a3-ba21-428e-abb2-7a2993f8601c	locale	user.attribute
8a3119a3-ba21-428e-abb2-7a2993f8601c	true	id.token.claim
8a3119a3-ba21-428e-abb2-7a2993f8601c	true	access.token.claim
8a3119a3-ba21-428e-abb2-7a2993f8601c	locale	claim.name
8a3119a3-ba21-428e-abb2-7a2993f8601c	String	jsonType.label
ada4c75a-8417-4870-a808-331ec4585824	false	single
ada4c75a-8417-4870-a808-331ec4585824	Basic	attribute.nameformat
ada4c75a-8417-4870-a808-331ec4585824	Role	attribute.name
010edc2d-ac24-468c-9f1f-2cda684cbad5	true	introspection.token.claim
010edc2d-ac24-468c-9f1f-2cda684cbad5	true	userinfo.token.claim
010edc2d-ac24-468c-9f1f-2cda684cbad5	lastName	user.attribute
010edc2d-ac24-468c-9f1f-2cda684cbad5	true	id.token.claim
010edc2d-ac24-468c-9f1f-2cda684cbad5	true	access.token.claim
010edc2d-ac24-468c-9f1f-2cda684cbad5	family_name	claim.name
010edc2d-ac24-468c-9f1f-2cda684cbad5	String	jsonType.label
13fc63ee-ecb3-486c-966a-b1c9e0680373	true	introspection.token.claim
13fc63ee-ecb3-486c-966a-b1c9e0680373	true	userinfo.token.claim
13fc63ee-ecb3-486c-966a-b1c9e0680373	gender	user.attribute
13fc63ee-ecb3-486c-966a-b1c9e0680373	true	id.token.claim
13fc63ee-ecb3-486c-966a-b1c9e0680373	true	access.token.claim
13fc63ee-ecb3-486c-966a-b1c9e0680373	gender	claim.name
13fc63ee-ecb3-486c-966a-b1c9e0680373	String	jsonType.label
1d9d0e19-f54c-486e-a156-93b680ecf4da	true	introspection.token.claim
1d9d0e19-f54c-486e-a156-93b680ecf4da	true	userinfo.token.claim
1d9d0e19-f54c-486e-a156-93b680ecf4da	zoneinfo	user.attribute
1d9d0e19-f54c-486e-a156-93b680ecf4da	true	id.token.claim
1d9d0e19-f54c-486e-a156-93b680ecf4da	true	access.token.claim
1d9d0e19-f54c-486e-a156-93b680ecf4da	zoneinfo	claim.name
1d9d0e19-f54c-486e-a156-93b680ecf4da	String	jsonType.label
29fe24d2-c3af-4bf5-89ce-be9a660a2a5f	true	introspection.token.claim
29fe24d2-c3af-4bf5-89ce-be9a660a2a5f	true	userinfo.token.claim
29fe24d2-c3af-4bf5-89ce-be9a660a2a5f	true	id.token.claim
29fe24d2-c3af-4bf5-89ce-be9a660a2a5f	true	access.token.claim
35deb00d-bd2e-49e3-96dc-75e5de8e0455	true	introspection.token.claim
35deb00d-bd2e-49e3-96dc-75e5de8e0455	true	userinfo.token.claim
35deb00d-bd2e-49e3-96dc-75e5de8e0455	nickname	user.attribute
35deb00d-bd2e-49e3-96dc-75e5de8e0455	true	id.token.claim
35deb00d-bd2e-49e3-96dc-75e5de8e0455	true	access.token.claim
35deb00d-bd2e-49e3-96dc-75e5de8e0455	nickname	claim.name
35deb00d-bd2e-49e3-96dc-75e5de8e0455	String	jsonType.label
46b51324-0c5b-4ae9-ac42-83e279538a97	true	introspection.token.claim
46b51324-0c5b-4ae9-ac42-83e279538a97	true	userinfo.token.claim
46b51324-0c5b-4ae9-ac42-83e279538a97	username	user.attribute
46b51324-0c5b-4ae9-ac42-83e279538a97	true	id.token.claim
46b51324-0c5b-4ae9-ac42-83e279538a97	true	access.token.claim
46b51324-0c5b-4ae9-ac42-83e279538a97	preferred_username	claim.name
46b51324-0c5b-4ae9-ac42-83e279538a97	String	jsonType.label
aeb78ec4-1206-4f43-b82f-6aaf497c8bf1	true	introspection.token.claim
aeb78ec4-1206-4f43-b82f-6aaf497c8bf1	true	userinfo.token.claim
aeb78ec4-1206-4f43-b82f-6aaf497c8bf1	website	user.attribute
aeb78ec4-1206-4f43-b82f-6aaf497c8bf1	true	id.token.claim
aeb78ec4-1206-4f43-b82f-6aaf497c8bf1	true	access.token.claim
aeb78ec4-1206-4f43-b82f-6aaf497c8bf1	website	claim.name
aeb78ec4-1206-4f43-b82f-6aaf497c8bf1	String	jsonType.label
b4759f62-ad52-42e8-9bc7-a75da49b5a0b	true	introspection.token.claim
b4759f62-ad52-42e8-9bc7-a75da49b5a0b	true	userinfo.token.claim
b4759f62-ad52-42e8-9bc7-a75da49b5a0b	firstName	user.attribute
b4759f62-ad52-42e8-9bc7-a75da49b5a0b	true	id.token.claim
b4759f62-ad52-42e8-9bc7-a75da49b5a0b	true	access.token.claim
b4759f62-ad52-42e8-9bc7-a75da49b5a0b	given_name	claim.name
b4759f62-ad52-42e8-9bc7-a75da49b5a0b	String	jsonType.label
bda8004d-6ed8-425a-84bf-d1a0464873df	true	introspection.token.claim
bda8004d-6ed8-425a-84bf-d1a0464873df	true	userinfo.token.claim
bda8004d-6ed8-425a-84bf-d1a0464873df	middleName	user.attribute
bda8004d-6ed8-425a-84bf-d1a0464873df	true	id.token.claim
bda8004d-6ed8-425a-84bf-d1a0464873df	true	access.token.claim
bda8004d-6ed8-425a-84bf-d1a0464873df	middle_name	claim.name
bda8004d-6ed8-425a-84bf-d1a0464873df	String	jsonType.label
e3f3dba3-ebf7-4023-b41a-2626758ecd1d	true	introspection.token.claim
e3f3dba3-ebf7-4023-b41a-2626758ecd1d	true	userinfo.token.claim
e3f3dba3-ebf7-4023-b41a-2626758ecd1d	updatedAt	user.attribute
e3f3dba3-ebf7-4023-b41a-2626758ecd1d	true	id.token.claim
e3f3dba3-ebf7-4023-b41a-2626758ecd1d	true	access.token.claim
e3f3dba3-ebf7-4023-b41a-2626758ecd1d	updated_at	claim.name
e3f3dba3-ebf7-4023-b41a-2626758ecd1d	long	jsonType.label
eb49ac57-1fda-4f25-bb15-139f5f43d7d4	true	introspection.token.claim
eb49ac57-1fda-4f25-bb15-139f5f43d7d4	true	userinfo.token.claim
eb49ac57-1fda-4f25-bb15-139f5f43d7d4	picture	user.attribute
eb49ac57-1fda-4f25-bb15-139f5f43d7d4	true	id.token.claim
eb49ac57-1fda-4f25-bb15-139f5f43d7d4	true	access.token.claim
eb49ac57-1fda-4f25-bb15-139f5f43d7d4	picture	claim.name
eb49ac57-1fda-4f25-bb15-139f5f43d7d4	String	jsonType.label
f1b24917-de34-40e5-91e7-e9f14d4fca23	true	introspection.token.claim
f1b24917-de34-40e5-91e7-e9f14d4fca23	true	userinfo.token.claim
f1b24917-de34-40e5-91e7-e9f14d4fca23	birthdate	user.attribute
f1b24917-de34-40e5-91e7-e9f14d4fca23	true	id.token.claim
f1b24917-de34-40e5-91e7-e9f14d4fca23	true	access.token.claim
f1b24917-de34-40e5-91e7-e9f14d4fca23	birthdate	claim.name
f1b24917-de34-40e5-91e7-e9f14d4fca23	String	jsonType.label
f4e4dec0-e741-4c06-a5e1-858dfc505c2b	true	introspection.token.claim
f4e4dec0-e741-4c06-a5e1-858dfc505c2b	true	userinfo.token.claim
f4e4dec0-e741-4c06-a5e1-858dfc505c2b	locale	user.attribute
f4e4dec0-e741-4c06-a5e1-858dfc505c2b	true	id.token.claim
f4e4dec0-e741-4c06-a5e1-858dfc505c2b	true	access.token.claim
f4e4dec0-e741-4c06-a5e1-858dfc505c2b	locale	claim.name
f4e4dec0-e741-4c06-a5e1-858dfc505c2b	String	jsonType.label
fc620d34-7ab7-47f1-b134-a951ac44cbbc	true	introspection.token.claim
fc620d34-7ab7-47f1-b134-a951ac44cbbc	true	userinfo.token.claim
fc620d34-7ab7-47f1-b134-a951ac44cbbc	profile	user.attribute
fc620d34-7ab7-47f1-b134-a951ac44cbbc	true	id.token.claim
fc620d34-7ab7-47f1-b134-a951ac44cbbc	true	access.token.claim
fc620d34-7ab7-47f1-b134-a951ac44cbbc	profile	claim.name
fc620d34-7ab7-47f1-b134-a951ac44cbbc	String	jsonType.label
3a799757-9049-43fb-9861-01ce7b56cc23	true	introspection.token.claim
3a799757-9049-43fb-9861-01ce7b56cc23	true	userinfo.token.claim
3a799757-9049-43fb-9861-01ce7b56cc23	email	user.attribute
3a799757-9049-43fb-9861-01ce7b56cc23	true	id.token.claim
3a799757-9049-43fb-9861-01ce7b56cc23	true	access.token.claim
3a799757-9049-43fb-9861-01ce7b56cc23	email	claim.name
3a799757-9049-43fb-9861-01ce7b56cc23	String	jsonType.label
a7dabbd0-503d-4bd6-b9ec-68cdac737967	true	introspection.token.claim
a7dabbd0-503d-4bd6-b9ec-68cdac737967	true	userinfo.token.claim
a7dabbd0-503d-4bd6-b9ec-68cdac737967	emailVerified	user.attribute
a7dabbd0-503d-4bd6-b9ec-68cdac737967	true	id.token.claim
a7dabbd0-503d-4bd6-b9ec-68cdac737967	true	access.token.claim
a7dabbd0-503d-4bd6-b9ec-68cdac737967	email_verified	claim.name
a7dabbd0-503d-4bd6-b9ec-68cdac737967	boolean	jsonType.label
da0169f9-0dc6-4b61-899a-3c6bc4623106	formatted	user.attribute.formatted
da0169f9-0dc6-4b61-899a-3c6bc4623106	country	user.attribute.country
da0169f9-0dc6-4b61-899a-3c6bc4623106	true	introspection.token.claim
da0169f9-0dc6-4b61-899a-3c6bc4623106	postal_code	user.attribute.postal_code
da0169f9-0dc6-4b61-899a-3c6bc4623106	true	userinfo.token.claim
da0169f9-0dc6-4b61-899a-3c6bc4623106	street	user.attribute.street
da0169f9-0dc6-4b61-899a-3c6bc4623106	true	id.token.claim
da0169f9-0dc6-4b61-899a-3c6bc4623106	region	user.attribute.region
da0169f9-0dc6-4b61-899a-3c6bc4623106	true	access.token.claim
da0169f9-0dc6-4b61-899a-3c6bc4623106	locality	user.attribute.locality
2ea0f247-dd3a-4628-9f22-54ab44d84dab	true	introspection.token.claim
2ea0f247-dd3a-4628-9f22-54ab44d84dab	true	userinfo.token.claim
2ea0f247-dd3a-4628-9f22-54ab44d84dab	phoneNumber	user.attribute
2ea0f247-dd3a-4628-9f22-54ab44d84dab	true	id.token.claim
2ea0f247-dd3a-4628-9f22-54ab44d84dab	true	access.token.claim
2ea0f247-dd3a-4628-9f22-54ab44d84dab	phone_number	claim.name
2ea0f247-dd3a-4628-9f22-54ab44d84dab	String	jsonType.label
ee9dc728-105f-49c9-a055-73c43da120b7	true	introspection.token.claim
ee9dc728-105f-49c9-a055-73c43da120b7	true	userinfo.token.claim
ee9dc728-105f-49c9-a055-73c43da120b7	phoneNumberVerified	user.attribute
ee9dc728-105f-49c9-a055-73c43da120b7	true	id.token.claim
ee9dc728-105f-49c9-a055-73c43da120b7	true	access.token.claim
ee9dc728-105f-49c9-a055-73c43da120b7	phone_number_verified	claim.name
ee9dc728-105f-49c9-a055-73c43da120b7	boolean	jsonType.label
695cfb97-1f3b-4d00-ab1a-1825ceb771d8	true	introspection.token.claim
695cfb97-1f3b-4d00-ab1a-1825ceb771d8	true	multivalued
695cfb97-1f3b-4d00-ab1a-1825ceb771d8	foo	user.attribute
695cfb97-1f3b-4d00-ab1a-1825ceb771d8	true	access.token.claim
695cfb97-1f3b-4d00-ab1a-1825ceb771d8	realm_access.roles	claim.name
695cfb97-1f3b-4d00-ab1a-1825ceb771d8	String	jsonType.label
7266e5fd-4e2c-4e50-b184-b66b92738730	true	introspection.token.claim
7266e5fd-4e2c-4e50-b184-b66b92738730	true	access.token.claim
deef81e1-f881-4167-976c-0421fb67ff75	true	introspection.token.claim
deef81e1-f881-4167-976c-0421fb67ff75	true	multivalued
deef81e1-f881-4167-976c-0421fb67ff75	foo	user.attribute
deef81e1-f881-4167-976c-0421fb67ff75	true	access.token.claim
deef81e1-f881-4167-976c-0421fb67ff75	resource_access.${client_id}.roles	claim.name
deef81e1-f881-4167-976c-0421fb67ff75	String	jsonType.label
ed36fea6-dbd0-4c6a-912f-1daae80e526a	true	introspection.token.claim
ed36fea6-dbd0-4c6a-912f-1daae80e526a	true	access.token.claim
9fbe93ce-8cf0-44ab-9339-f692a7627b1c	true	introspection.token.claim
9fbe93ce-8cf0-44ab-9339-f692a7627b1c	true	userinfo.token.claim
9fbe93ce-8cf0-44ab-9339-f692a7627b1c	username	user.attribute
9fbe93ce-8cf0-44ab-9339-f692a7627b1c	true	id.token.claim
9fbe93ce-8cf0-44ab-9339-f692a7627b1c	true	access.token.claim
9fbe93ce-8cf0-44ab-9339-f692a7627b1c	upn	claim.name
9fbe93ce-8cf0-44ab-9339-f692a7627b1c	String	jsonType.label
d325e370-c364-490d-b390-b3721b07b5f0	true	introspection.token.claim
d325e370-c364-490d-b390-b3721b07b5f0	true	multivalued
d325e370-c364-490d-b390-b3721b07b5f0	foo	user.attribute
d325e370-c364-490d-b390-b3721b07b5f0	true	id.token.claim
d325e370-c364-490d-b390-b3721b07b5f0	true	access.token.claim
d325e370-c364-490d-b390-b3721b07b5f0	groups	claim.name
d325e370-c364-490d-b390-b3721b07b5f0	String	jsonType.label
df676ae5-25a2-414a-b57f-5e47d02cb0b2	true	introspection.token.claim
df676ae5-25a2-414a-b57f-5e47d02cb0b2	true	id.token.claim
df676ae5-25a2-414a-b57f-5e47d02cb0b2	true	access.token.claim
3759da95-8120-4e77-bbfa-d7f2f254ffe0	false	single
3759da95-8120-4e77-bbfa-d7f2f254ffe0	Basic	attribute.nameformat
3759da95-8120-4e77-bbfa-d7f2f254ffe0	Role	attribute.name
2ec5dfd3-093d-4e3f-aedc-9b10c1895dee	true	introspection.token.claim
2ec5dfd3-093d-4e3f-aedc-9b10c1895dee	true	userinfo.token.claim
2ec5dfd3-093d-4e3f-aedc-9b10c1895dee	birthdate	user.attribute
2ec5dfd3-093d-4e3f-aedc-9b10c1895dee	true	id.token.claim
2ec5dfd3-093d-4e3f-aedc-9b10c1895dee	true	access.token.claim
2ec5dfd3-093d-4e3f-aedc-9b10c1895dee	birthdate	claim.name
2ec5dfd3-093d-4e3f-aedc-9b10c1895dee	String	jsonType.label
3b96b397-a16a-4131-ba9c-867a87bb6492	true	introspection.token.claim
3b96b397-a16a-4131-ba9c-867a87bb6492	true	userinfo.token.claim
3b96b397-a16a-4131-ba9c-867a87bb6492	website	user.attribute
3b96b397-a16a-4131-ba9c-867a87bb6492	true	id.token.claim
3b96b397-a16a-4131-ba9c-867a87bb6492	true	access.token.claim
3b96b397-a16a-4131-ba9c-867a87bb6492	website	claim.name
3b96b397-a16a-4131-ba9c-867a87bb6492	String	jsonType.label
559aa9ad-a8be-4561-8154-90984b06f459	true	introspection.token.claim
559aa9ad-a8be-4561-8154-90984b06f459	true	userinfo.token.claim
559aa9ad-a8be-4561-8154-90984b06f459	picture	user.attribute
559aa9ad-a8be-4561-8154-90984b06f459	true	id.token.claim
559aa9ad-a8be-4561-8154-90984b06f459	true	access.token.claim
559aa9ad-a8be-4561-8154-90984b06f459	picture	claim.name
559aa9ad-a8be-4561-8154-90984b06f459	String	jsonType.label
75ab4754-6ca5-451a-98bc-aec0fc050655	true	introspection.token.claim
75ab4754-6ca5-451a-98bc-aec0fc050655	true	userinfo.token.claim
75ab4754-6ca5-451a-98bc-aec0fc050655	locale	user.attribute
75ab4754-6ca5-451a-98bc-aec0fc050655	true	id.token.claim
75ab4754-6ca5-451a-98bc-aec0fc050655	true	access.token.claim
75ab4754-6ca5-451a-98bc-aec0fc050655	locale	claim.name
75ab4754-6ca5-451a-98bc-aec0fc050655	String	jsonType.label
832be537-eac5-4535-845c-e2ab58c88514	true	introspection.token.claim
832be537-eac5-4535-845c-e2ab58c88514	true	userinfo.token.claim
832be537-eac5-4535-845c-e2ab58c88514	lastName	user.attribute
832be537-eac5-4535-845c-e2ab58c88514	true	id.token.claim
832be537-eac5-4535-845c-e2ab58c88514	true	access.token.claim
832be537-eac5-4535-845c-e2ab58c88514	family_name	claim.name
832be537-eac5-4535-845c-e2ab58c88514	String	jsonType.label
94b1d2d0-ff63-477c-9b3c-37f4804c8fcd	true	introspection.token.claim
94b1d2d0-ff63-477c-9b3c-37f4804c8fcd	true	userinfo.token.claim
94b1d2d0-ff63-477c-9b3c-37f4804c8fcd	middleName	user.attribute
94b1d2d0-ff63-477c-9b3c-37f4804c8fcd	true	id.token.claim
94b1d2d0-ff63-477c-9b3c-37f4804c8fcd	true	access.token.claim
94b1d2d0-ff63-477c-9b3c-37f4804c8fcd	middle_name	claim.name
94b1d2d0-ff63-477c-9b3c-37f4804c8fcd	String	jsonType.label
9b8417d9-c46e-45a0-b9ea-474e58f86dc5	true	introspection.token.claim
9b8417d9-c46e-45a0-b9ea-474e58f86dc5	true	userinfo.token.claim
9b8417d9-c46e-45a0-b9ea-474e58f86dc5	gender	user.attribute
9b8417d9-c46e-45a0-b9ea-474e58f86dc5	true	id.token.claim
9b8417d9-c46e-45a0-b9ea-474e58f86dc5	true	access.token.claim
9b8417d9-c46e-45a0-b9ea-474e58f86dc5	gender	claim.name
9b8417d9-c46e-45a0-b9ea-474e58f86dc5	String	jsonType.label
a349d19d-cc89-4abf-bed3-b4e39b761827	true	introspection.token.claim
a349d19d-cc89-4abf-bed3-b4e39b761827	true	userinfo.token.claim
a349d19d-cc89-4abf-bed3-b4e39b761827	username	user.attribute
a349d19d-cc89-4abf-bed3-b4e39b761827	true	id.token.claim
a349d19d-cc89-4abf-bed3-b4e39b761827	true	access.token.claim
a349d19d-cc89-4abf-bed3-b4e39b761827	preferred_username	claim.name
a349d19d-cc89-4abf-bed3-b4e39b761827	String	jsonType.label
aedef612-dfb7-4ee3-8593-c52fbfbbabed	true	introspection.token.claim
aedef612-dfb7-4ee3-8593-c52fbfbbabed	true	userinfo.token.claim
aedef612-dfb7-4ee3-8593-c52fbfbbabed	profile	user.attribute
aedef612-dfb7-4ee3-8593-c52fbfbbabed	true	id.token.claim
aedef612-dfb7-4ee3-8593-c52fbfbbabed	true	access.token.claim
aedef612-dfb7-4ee3-8593-c52fbfbbabed	profile	claim.name
aedef612-dfb7-4ee3-8593-c52fbfbbabed	String	jsonType.label
b05d021e-4120-48b1-a3d0-a86b030c5dc4	true	introspection.token.claim
b05d021e-4120-48b1-a3d0-a86b030c5dc4	true	userinfo.token.claim
b05d021e-4120-48b1-a3d0-a86b030c5dc4	firstName	user.attribute
b05d021e-4120-48b1-a3d0-a86b030c5dc4	true	id.token.claim
b05d021e-4120-48b1-a3d0-a86b030c5dc4	true	access.token.claim
b05d021e-4120-48b1-a3d0-a86b030c5dc4	given_name	claim.name
b05d021e-4120-48b1-a3d0-a86b030c5dc4	String	jsonType.label
c2680dc6-8f36-42b8-abb6-038444713d5f	true	introspection.token.claim
c2680dc6-8f36-42b8-abb6-038444713d5f	true	userinfo.token.claim
c2680dc6-8f36-42b8-abb6-038444713d5f	zoneinfo	user.attribute
c2680dc6-8f36-42b8-abb6-038444713d5f	true	id.token.claim
c2680dc6-8f36-42b8-abb6-038444713d5f	true	access.token.claim
c2680dc6-8f36-42b8-abb6-038444713d5f	zoneinfo	claim.name
c2680dc6-8f36-42b8-abb6-038444713d5f	String	jsonType.label
c86234bd-70e8-4b10-8a3c-b024dc4d3fc8	true	introspection.token.claim
c86234bd-70e8-4b10-8a3c-b024dc4d3fc8	true	userinfo.token.claim
c86234bd-70e8-4b10-8a3c-b024dc4d3fc8	nickname	user.attribute
c86234bd-70e8-4b10-8a3c-b024dc4d3fc8	true	id.token.claim
c86234bd-70e8-4b10-8a3c-b024dc4d3fc8	true	access.token.claim
c86234bd-70e8-4b10-8a3c-b024dc4d3fc8	nickname	claim.name
c86234bd-70e8-4b10-8a3c-b024dc4d3fc8	String	jsonType.label
dfad1dba-bc3e-4cd2-bc8a-39b9e4d52d54	true	introspection.token.claim
dfad1dba-bc3e-4cd2-bc8a-39b9e4d52d54	true	userinfo.token.claim
dfad1dba-bc3e-4cd2-bc8a-39b9e4d52d54	true	id.token.claim
dfad1dba-bc3e-4cd2-bc8a-39b9e4d52d54	true	access.token.claim
f4d66349-61f1-4a82-8d69-ff25d26693a4	true	introspection.token.claim
f4d66349-61f1-4a82-8d69-ff25d26693a4	true	userinfo.token.claim
f4d66349-61f1-4a82-8d69-ff25d26693a4	updatedAt	user.attribute
f4d66349-61f1-4a82-8d69-ff25d26693a4	true	id.token.claim
f4d66349-61f1-4a82-8d69-ff25d26693a4	true	access.token.claim
f4d66349-61f1-4a82-8d69-ff25d26693a4	updated_at	claim.name
f4d66349-61f1-4a82-8d69-ff25d26693a4	long	jsonType.label
00e741d4-60c7-4b32-9ec5-14c95bd0a116	true	introspection.token.claim
00e741d4-60c7-4b32-9ec5-14c95bd0a116	true	userinfo.token.claim
00e741d4-60c7-4b32-9ec5-14c95bd0a116	emailVerified	user.attribute
00e741d4-60c7-4b32-9ec5-14c95bd0a116	true	id.token.claim
00e741d4-60c7-4b32-9ec5-14c95bd0a116	true	access.token.claim
00e741d4-60c7-4b32-9ec5-14c95bd0a116	email_verified	claim.name
00e741d4-60c7-4b32-9ec5-14c95bd0a116	boolean	jsonType.label
22dbd81f-20bb-445d-a481-5a32fac1633e	true	introspection.token.claim
22dbd81f-20bb-445d-a481-5a32fac1633e	true	userinfo.token.claim
22dbd81f-20bb-445d-a481-5a32fac1633e	email	user.attribute
22dbd81f-20bb-445d-a481-5a32fac1633e	true	id.token.claim
22dbd81f-20bb-445d-a481-5a32fac1633e	true	access.token.claim
22dbd81f-20bb-445d-a481-5a32fac1633e	email	claim.name
22dbd81f-20bb-445d-a481-5a32fac1633e	String	jsonType.label
b121259e-5b02-42fa-bca9-e82a1df70295	formatted	user.attribute.formatted
b121259e-5b02-42fa-bca9-e82a1df70295	country	user.attribute.country
b121259e-5b02-42fa-bca9-e82a1df70295	true	introspection.token.claim
b121259e-5b02-42fa-bca9-e82a1df70295	postal_code	user.attribute.postal_code
b121259e-5b02-42fa-bca9-e82a1df70295	true	userinfo.token.claim
b121259e-5b02-42fa-bca9-e82a1df70295	street	user.attribute.street
b121259e-5b02-42fa-bca9-e82a1df70295	true	id.token.claim
b121259e-5b02-42fa-bca9-e82a1df70295	region	user.attribute.region
b121259e-5b02-42fa-bca9-e82a1df70295	true	access.token.claim
b121259e-5b02-42fa-bca9-e82a1df70295	locality	user.attribute.locality
469d4b96-37cb-4754-a4ab-144ff327182d	true	introspection.token.claim
469d4b96-37cb-4754-a4ab-144ff327182d	true	userinfo.token.claim
469d4b96-37cb-4754-a4ab-144ff327182d	phoneNumber	user.attribute
469d4b96-37cb-4754-a4ab-144ff327182d	true	id.token.claim
469d4b96-37cb-4754-a4ab-144ff327182d	true	access.token.claim
469d4b96-37cb-4754-a4ab-144ff327182d	phone_number	claim.name
469d4b96-37cb-4754-a4ab-144ff327182d	String	jsonType.label
e7090c30-83aa-4e59-a21f-714210afa542	true	introspection.token.claim
e7090c30-83aa-4e59-a21f-714210afa542	true	userinfo.token.claim
e7090c30-83aa-4e59-a21f-714210afa542	phoneNumberVerified	user.attribute
e7090c30-83aa-4e59-a21f-714210afa542	true	id.token.claim
e7090c30-83aa-4e59-a21f-714210afa542	true	access.token.claim
e7090c30-83aa-4e59-a21f-714210afa542	phone_number_verified	claim.name
e7090c30-83aa-4e59-a21f-714210afa542	boolean	jsonType.label
b5bd6c97-a32a-40ab-aab8-0f6f43f1d158	true	introspection.token.claim
b5bd6c97-a32a-40ab-aab8-0f6f43f1d158	true	multivalued
b5bd6c97-a32a-40ab-aab8-0f6f43f1d158	foo	user.attribute
b5bd6c97-a32a-40ab-aab8-0f6f43f1d158	true	access.token.claim
b5bd6c97-a32a-40ab-aab8-0f6f43f1d158	realm_access.roles	claim.name
b5bd6c97-a32a-40ab-aab8-0f6f43f1d158	String	jsonType.label
d00b3b0d-eea4-4e4e-b5e1-82ca6c2b8e46	true	introspection.token.claim
d00b3b0d-eea4-4e4e-b5e1-82ca6c2b8e46	true	access.token.claim
f72f53eb-ae99-4b86-88cd-7862edb7e8a9	true	introspection.token.claim
f72f53eb-ae99-4b86-88cd-7862edb7e8a9	true	multivalued
f72f53eb-ae99-4b86-88cd-7862edb7e8a9	foo	user.attribute
f72f53eb-ae99-4b86-88cd-7862edb7e8a9	true	access.token.claim
f72f53eb-ae99-4b86-88cd-7862edb7e8a9	resource_access.${client_id}.roles	claim.name
f72f53eb-ae99-4b86-88cd-7862edb7e8a9	String	jsonType.label
ee585a8e-d0bd-47c4-941a-9830d0c524eb	true	introspection.token.claim
ee585a8e-d0bd-47c4-941a-9830d0c524eb	true	access.token.claim
1e47c332-6852-4b9b-b96c-08102595671b	true	introspection.token.claim
1e47c332-6852-4b9b-b96c-08102595671b	true	multivalued
1e47c332-6852-4b9b-b96c-08102595671b	foo	user.attribute
1e47c332-6852-4b9b-b96c-08102595671b	true	id.token.claim
1e47c332-6852-4b9b-b96c-08102595671b	true	access.token.claim
1e47c332-6852-4b9b-b96c-08102595671b	groups	claim.name
1e47c332-6852-4b9b-b96c-08102595671b	String	jsonType.label
e5663b4e-95af-4767-9fdd-424aa69e0562	true	introspection.token.claim
e5663b4e-95af-4767-9fdd-424aa69e0562	true	userinfo.token.claim
e5663b4e-95af-4767-9fdd-424aa69e0562	username	user.attribute
e5663b4e-95af-4767-9fdd-424aa69e0562	true	id.token.claim
e5663b4e-95af-4767-9fdd-424aa69e0562	true	access.token.claim
e5663b4e-95af-4767-9fdd-424aa69e0562	upn	claim.name
e5663b4e-95af-4767-9fdd-424aa69e0562	String	jsonType.label
581d783f-7073-407f-9545-ac04c61db8a8	true	introspection.token.claim
581d783f-7073-407f-9545-ac04c61db8a8	true	id.token.claim
581d783f-7073-407f-9545-ac04c61db8a8	true	access.token.claim
ae8f2b1b-6549-40f4-b28c-197271f1f3d7	true	introspection.token.claim
ae8f2b1b-6549-40f4-b28c-197271f1f3d7	true	userinfo.token.claim
ae8f2b1b-6549-40f4-b28c-197271f1f3d7	locale	user.attribute
ae8f2b1b-6549-40f4-b28c-197271f1f3d7	true	id.token.claim
ae8f2b1b-6549-40f4-b28c-197271f1f3d7	true	access.token.claim
ae8f2b1b-6549-40f4-b28c-197271f1f3d7	locale	claim.name
ae8f2b1b-6549-40f4-b28c-197271f1f3d7	String	jsonType.label
51ddd6fb-6160-4b1d-add7-eb3b51d6f117	clientHost	user.session.note
51ddd6fb-6160-4b1d-add7-eb3b51d6f117	true	introspection.token.claim
51ddd6fb-6160-4b1d-add7-eb3b51d6f117	true	id.token.claim
51ddd6fb-6160-4b1d-add7-eb3b51d6f117	true	access.token.claim
51ddd6fb-6160-4b1d-add7-eb3b51d6f117	clientHost	claim.name
51ddd6fb-6160-4b1d-add7-eb3b51d6f117	String	jsonType.label
7ef6a5dc-63bd-4866-be90-1517442c7848	client_id	user.session.note
7ef6a5dc-63bd-4866-be90-1517442c7848	true	introspection.token.claim
7ef6a5dc-63bd-4866-be90-1517442c7848	true	id.token.claim
7ef6a5dc-63bd-4866-be90-1517442c7848	true	access.token.claim
7ef6a5dc-63bd-4866-be90-1517442c7848	client_id	claim.name
7ef6a5dc-63bd-4866-be90-1517442c7848	String	jsonType.label
a4f29e2a-ef6b-40c7-bcc4-f7978f9ccad6	clientAddress	user.session.note
a4f29e2a-ef6b-40c7-bcc4-f7978f9ccad6	true	introspection.token.claim
a4f29e2a-ef6b-40c7-bcc4-f7978f9ccad6	true	id.token.claim
a4f29e2a-ef6b-40c7-bcc4-f7978f9ccad6	true	access.token.claim
a4f29e2a-ef6b-40c7-bcc4-f7978f9ccad6	clientAddress	claim.name
a4f29e2a-ef6b-40c7-bcc4-f7978f9ccad6	String	jsonType.label
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
3c6fae4f-56d1-403c-bd4a-c40d238a11c6	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	426ae130-9585-4285-a441-53a1324072e1	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	f678937f-865b-4074-a754-82e213c80382	c1b94457-348a-47d7-8592-f5336e4a6581	d27189a6-9abb-4315-9e3e-045cf5fdd1ba	8dbb758c-0b91-4fe9-a0d9-4450db534b6f	109fdb68-0800-4ba4-9dfc-1a112d0fcbe8	2592000	f	900	t	f	c8f544f4-973f-48a6-9b6a-639c8abd44c9	0	f	0	0	a2dc394f-34a6-4536-a75a-178a4fa662d6
770ce898-e404-41ae-b791-ebab6d704c10	60	300	300	\N	\N	\N	t	f	0	\N	Test	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	996850a3-73fb-4987-9a88-9c59ca8f0622	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	29345d10-e38a-46dc-b6ca-7d13aea63ad0	d35473c9-7d75-4b13-8e0f-e99d14d9d2ab	f3e3a417-892f-4fb4-a3da-d35b09fbbd01	c9e9ccc1-c1f2-4b24-bb9a-f0b750124abd	9c590b16-bf92-46d3-8a32-17856b4d6ded	2592000	f	900	t	f	58b48345-bde2-4a5b-b86c-ad4bc57e741c	0	f	0	0	ba5939f5-f725-4e63-af76-fd2de6ec1ba3
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	
_browser_header.xContentTypeOptions	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	nosniff
_browser_header.referrerPolicy	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	no-referrer
_browser_header.xRobotsTag	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	none
_browser_header.xFrameOptions	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	SAMEORIGIN
_browser_header.contentSecurityPolicy	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	1; mode=block
_browser_header.strictTransportSecurity	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	max-age=31536000; includeSubDomains
bruteForceProtected	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	false
permanentLockout	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	false
maxFailureWaitSeconds	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	900
minimumQuickLoginWaitSeconds	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	60
waitIncrementSeconds	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	60
quickLoginCheckMilliSeconds	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	1000
maxDeltaTimeSeconds	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	43200
failureFactor	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	30
realmReusableOtpCode	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	false
displayName	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	Keycloak
displayNameHtml	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	RS256
offlineSessionMaxLifespanEnabled	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	false
offlineSessionMaxLifespan	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	5184000
_browser_header.contentSecurityPolicyReportOnly	770ce898-e404-41ae-b791-ebab6d704c10	
_browser_header.xContentTypeOptions	770ce898-e404-41ae-b791-ebab6d704c10	nosniff
_browser_header.referrerPolicy	770ce898-e404-41ae-b791-ebab6d704c10	no-referrer
_browser_header.xRobotsTag	770ce898-e404-41ae-b791-ebab6d704c10	none
_browser_header.xFrameOptions	770ce898-e404-41ae-b791-ebab6d704c10	SAMEORIGIN
_browser_header.contentSecurityPolicy	770ce898-e404-41ae-b791-ebab6d704c10	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	770ce898-e404-41ae-b791-ebab6d704c10	1; mode=block
_browser_header.strictTransportSecurity	770ce898-e404-41ae-b791-ebab6d704c10	max-age=31536000; includeSubDomains
bruteForceProtected	770ce898-e404-41ae-b791-ebab6d704c10	false
permanentLockout	770ce898-e404-41ae-b791-ebab6d704c10	false
maxFailureWaitSeconds	770ce898-e404-41ae-b791-ebab6d704c10	900
minimumQuickLoginWaitSeconds	770ce898-e404-41ae-b791-ebab6d704c10	60
waitIncrementSeconds	770ce898-e404-41ae-b791-ebab6d704c10	60
quickLoginCheckMilliSeconds	770ce898-e404-41ae-b791-ebab6d704c10	1000
maxDeltaTimeSeconds	770ce898-e404-41ae-b791-ebab6d704c10	43200
failureFactor	770ce898-e404-41ae-b791-ebab6d704c10	30
realmReusableOtpCode	770ce898-e404-41ae-b791-ebab6d704c10	false
defaultSignatureAlgorithm	770ce898-e404-41ae-b791-ebab6d704c10	RS256
offlineSessionMaxLifespanEnabled	770ce898-e404-41ae-b791-ebab6d704c10	false
offlineSessionMaxLifespan	770ce898-e404-41ae-b791-ebab6d704c10	5184000
actionTokenGeneratedByAdminLifespan	770ce898-e404-41ae-b791-ebab6d704c10	43200
actionTokenGeneratedByUserLifespan	770ce898-e404-41ae-b791-ebab6d704c10	300
oauth2DeviceCodeLifespan	770ce898-e404-41ae-b791-ebab6d704c10	600
oauth2DevicePollingInterval	770ce898-e404-41ae-b791-ebab6d704c10	5
webAuthnPolicyRpEntityName	770ce898-e404-41ae-b791-ebab6d704c10	keycloak
webAuthnPolicySignatureAlgorithms	770ce898-e404-41ae-b791-ebab6d704c10	ES256
webAuthnPolicyRpId	770ce898-e404-41ae-b791-ebab6d704c10	
webAuthnPolicyAttestationConveyancePreference	770ce898-e404-41ae-b791-ebab6d704c10	not specified
webAuthnPolicyAuthenticatorAttachment	770ce898-e404-41ae-b791-ebab6d704c10	not specified
webAuthnPolicyRequireResidentKey	770ce898-e404-41ae-b791-ebab6d704c10	not specified
webAuthnPolicyUserVerificationRequirement	770ce898-e404-41ae-b791-ebab6d704c10	not specified
webAuthnPolicyCreateTimeout	770ce898-e404-41ae-b791-ebab6d704c10	0
webAuthnPolicyAvoidSameAuthenticatorRegister	770ce898-e404-41ae-b791-ebab6d704c10	false
webAuthnPolicyRpEntityNamePasswordless	770ce898-e404-41ae-b791-ebab6d704c10	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	770ce898-e404-41ae-b791-ebab6d704c10	ES256
webAuthnPolicyRpIdPasswordless	770ce898-e404-41ae-b791-ebab6d704c10	
webAuthnPolicyAttestationConveyancePreferencePasswordless	770ce898-e404-41ae-b791-ebab6d704c10	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	770ce898-e404-41ae-b791-ebab6d704c10	not specified
webAuthnPolicyRequireResidentKeyPasswordless	770ce898-e404-41ae-b791-ebab6d704c10	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	770ce898-e404-41ae-b791-ebab6d704c10	not specified
webAuthnPolicyCreateTimeoutPasswordless	770ce898-e404-41ae-b791-ebab6d704c10	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	770ce898-e404-41ae-b791-ebab6d704c10	false
cibaBackchannelTokenDeliveryMode	770ce898-e404-41ae-b791-ebab6d704c10	poll
cibaExpiresIn	770ce898-e404-41ae-b791-ebab6d704c10	120
cibaInterval	770ce898-e404-41ae-b791-ebab6d704c10	5
cibaAuthRequestedUserHint	770ce898-e404-41ae-b791-ebab6d704c10	login_hint
parRequestUriLifespan	770ce898-e404-41ae-b791-ebab6d704c10	60
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
3c6fae4f-56d1-403c-bd4a-c40d238a11c6	jboss-logging
770ce898-e404-41ae-b791-ebab6d704c10	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	3c6fae4f-56d1-403c-bd4a-c40d238a11c6
password	password	t	t	770ce898-e404-41ae-b791-ebab6d704c10
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.redirect_uris (client_id, value) FROM stdin;
ecdf389d-bd04-468c-8335-78947724ba88	/realms/master/account/*
12498f03-3e07-4cd1-b487-a273d83f3eab	/realms/master/account/*
93beb22d-1ff6-4d50-82e6-ef0da73e38fc	/admin/master/console/*
451405e8-0990-4be8-82f7-d58ca59a526a	/realms/Test/account/*
93da7221-98b3-48e8-bb4a-6af01719939d	/realms/Test/account/*
38dbec92-9c98-47c0-bde7-ec544a99c850	/admin/Test/console/*
15850342-cc1c-460f-b0d6-23700ebc0190	*
361bd82d-af62-49ef-9c67-cfa4dc361754	*
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
f04a1c9a-3a8a-44b9-be13-7d533138f5bf	VERIFY_EMAIL	Verify Email	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	t	f	VERIFY_EMAIL	50
af7e2492-00a6-4ab4-8de0-2590d2421dd1	UPDATE_PROFILE	Update Profile	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	t	f	UPDATE_PROFILE	40
9071a1c8-0877-4bd5-baac-92b97c7f857c	CONFIGURE_TOTP	Configure OTP	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	t	f	CONFIGURE_TOTP	10
fdb67fac-49ff-4ec4-9c69-562f5059cf1f	UPDATE_PASSWORD	Update Password	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	t	f	UPDATE_PASSWORD	30
1fca8b84-f01e-4328-99ea-341ff329aa69	TERMS_AND_CONDITIONS	Terms and Conditions	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	f	f	TERMS_AND_CONDITIONS	20
1ca4e6d3-83d3-40d0-9c1b-9608d26a810f	delete_account	Delete Account	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	f	f	delete_account	60
ebe0918d-d4dc-4d73-95df-de0e73f6b5eb	update_user_locale	Update User Locale	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	t	f	update_user_locale	1000
d8cb7730-2e4a-4e20-a6f6-966998549ec2	webauthn-register	Webauthn Register	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	t	f	webauthn-register	70
d5528679-752a-4dcf-8c84-4dd3942de9fe	webauthn-register-passwordless	Webauthn Register Passwordless	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	t	f	webauthn-register-passwordless	80
0adc547e-e4e4-4f88-9936-81d84e7e75ed	VERIFY_EMAIL	Verify Email	770ce898-e404-41ae-b791-ebab6d704c10	t	f	VERIFY_EMAIL	50
6cca96c4-822b-4c69-86f4-65de6a704273	UPDATE_PROFILE	Update Profile	770ce898-e404-41ae-b791-ebab6d704c10	t	f	UPDATE_PROFILE	40
88813328-8f85-4447-ae1a-52eb6ae7906d	CONFIGURE_TOTP	Configure OTP	770ce898-e404-41ae-b791-ebab6d704c10	t	f	CONFIGURE_TOTP	10
0d738a6a-74f1-456c-ad72-f89d2cb91ac5	UPDATE_PASSWORD	Update Password	770ce898-e404-41ae-b791-ebab6d704c10	t	f	UPDATE_PASSWORD	30
d78711a4-4a4c-417c-b854-49aca073251f	TERMS_AND_CONDITIONS	Terms and Conditions	770ce898-e404-41ae-b791-ebab6d704c10	f	f	TERMS_AND_CONDITIONS	20
a031113a-70d5-4b01-ad28-dcbe33b73e65	delete_account	Delete Account	770ce898-e404-41ae-b791-ebab6d704c10	f	f	delete_account	60
93a2aa90-193f-4130-8372-237da9d1d01e	update_user_locale	Update User Locale	770ce898-e404-41ae-b791-ebab6d704c10	t	f	update_user_locale	1000
dcf534d6-9ba8-434f-9f22-39bcfaa37840	webauthn-register	Webauthn Register	770ce898-e404-41ae-b791-ebab6d704c10	t	f	webauthn-register	70
c633de09-25d2-40f4-8267-7ec61b4a7735	webauthn-register-passwordless	Webauthn Register Passwordless	770ce898-e404-41ae-b791-ebab6d704c10	t	f	webauthn-register-passwordless	80
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_uris (resource_id, value) FROM stdin;
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
12498f03-3e07-4cd1-b487-a273d83f3eab	15207ed9-57ab-4b46-87bb-03da33559d2f
12498f03-3e07-4cd1-b487-a273d83f3eab	d55ebc2c-f0ae-4924-ada8-58ba25092656
93da7221-98b3-48e8-bb4a-6af01719939d	37ca8e41-58df-4f3a-937e-8df47219e9de
93da7221-98b3-48e8-bb4a-6af01719939d	7e6a951c-9ab1-4576-9829-c966680d69e2
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_attribute (name, value, user_id, id) FROM stdin;
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
8e767053-e259-4cbd-8e57-5594c870a2fb	\N	5bfc5d1d-87a8-457e-a986-eefbae847fa2	f	t	\N	\N	\N	3c6fae4f-56d1-403c-bd4a-c40d238a11c6	alex	1710789109517	\N	0
e3b4722f-2be7-40ee-b790-897c3d89ed97	\N	8663cfbc-ecac-4c84-94d6-e5780b8c2864	f	t	\N	\N	\N	770ce898-e404-41ae-b791-ebab6d704c10	service-account-prueba	1710789331138	15850342-cc1c-460f-b0d6-23700ebc0190	0
92f34733-9a8b-433b-aa39-ef666217094b	\N	c3ccb55e-a8bd-488e-97b2-083cb8d48c84	f	t	\N	\N	\N	770ce898-e404-41ae-b791-ebab6d704c10	testuser	1710789407678	\N	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_group_membership (group_id, user_id) FROM stdin;
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
a2dc394f-34a6-4536-a75a-178a4fa662d6	8e767053-e259-4cbd-8e57-5594c870a2fb
74c8ad55-f447-494f-b3ae-596b45ce9044	8e767053-e259-4cbd-8e57-5594c870a2fb
f5cde08a-a3af-4b97-8a04-101e83c7ab0b	8e767053-e259-4cbd-8e57-5594c870a2fb
b11d087e-1ef0-4480-a4c6-f0557ea439c3	8e767053-e259-4cbd-8e57-5594c870a2fb
f52a7060-819f-4ed3-b8f9-eb70b696f8da	8e767053-e259-4cbd-8e57-5594c870a2fb
40adf3af-4023-4765-8b2e-d603b28e949a	8e767053-e259-4cbd-8e57-5594c870a2fb
85af9a7a-37ae-4658-acce-923a6b933fc3	8e767053-e259-4cbd-8e57-5594c870a2fb
27f9b2c9-e8a5-4f6c-b102-214ecc566a90	8e767053-e259-4cbd-8e57-5594c870a2fb
c625f65f-1db9-492d-b4b2-744187d9fc4b	8e767053-e259-4cbd-8e57-5594c870a2fb
da99a5bc-e49e-47c9-94d6-0a36ae164747	8e767053-e259-4cbd-8e57-5594c870a2fb
bf8928ff-8b7d-4930-a02a-2bf9d6b3e5f4	8e767053-e259-4cbd-8e57-5594c870a2fb
3e0b22ad-dfa6-4626-83e3-8ade6e280a63	8e767053-e259-4cbd-8e57-5594c870a2fb
a9ce1e1c-6bbc-477f-bb42-32ff1561b581	8e767053-e259-4cbd-8e57-5594c870a2fb
c13d4897-f214-4979-8de6-80f562113d37	8e767053-e259-4cbd-8e57-5594c870a2fb
cc5c21f7-cb93-461e-8760-3e9f2b7512f4	8e767053-e259-4cbd-8e57-5594c870a2fb
572dc381-916b-40f3-a9ee-c2a48bb02e8b	8e767053-e259-4cbd-8e57-5594c870a2fb
9421ecbd-6611-4648-8ff2-2f245eabadfc	8e767053-e259-4cbd-8e57-5594c870a2fb
41aa5925-eb92-4456-9ff0-9a9e840e719a	8e767053-e259-4cbd-8e57-5594c870a2fb
750aedd2-b685-466d-86a7-724799874934	8e767053-e259-4cbd-8e57-5594c870a2fb
ba5939f5-f725-4e63-af76-fd2de6ec1ba3	e3b4722f-2be7-40ee-b790-897c3d89ed97
ba5939f5-f725-4e63-af76-fd2de6ec1ba3	92f34733-9a8b-433b-aa39-ef666217094b
\.


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_session (id, auth_method, ip_address, last_session_refresh, login_username, realm_id, remember_me, started, user_id, user_session_state, broker_session_id, broker_user_id) FROM stdin;
\.


--
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_session_note (user_session, name, value) FROM stdin;
\.


--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.web_origins (client_id, value) FROM stdin;
93beb22d-1ff6-4d50-82e6-ef0da73e38fc	+
38dbec92-9c98-47c0-bde7-ec544a99c850	+
15850342-cc1c-460f-b0d6-23700ebc0190	*
361bd82d-af62-49ef-9c67-cfa4dc361754	*
\.


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, client_storage_provider, external_client_id, user_id);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: idx_admin_event_time; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_admin_event_time ON public.admin_event_entity USING btree (realm_id, admin_event_time);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_session_session ON public.client_session USING btree (session_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_att_by_name_value; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_att_by_name_value ON public.group_attribute USING btree (name, ((value)::character varying(250)));


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_css_preload; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_css_preload ON public.offline_client_session USING btree (client_id, offline_flag);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_offline_uss_by_usersess; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_by_usersess ON public.offline_user_session USING btree (realm_id, offline_flag, user_session_id);


--
-- Name: idx_offline_uss_createdon; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_createdon ON public.offline_user_session USING btree (created_on);


--
-- Name: idx_offline_uss_preload; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_preload ON public.offline_user_session USING btree (offline_flag, created_on, user_session_id);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON public.offline_client_session USING btree (user_session_id);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_user_service_account; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_service_account ON public.user_entity USING btree (realm_id, service_account_client_link);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES public.user_session(id);


--
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES public.user_session(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--

