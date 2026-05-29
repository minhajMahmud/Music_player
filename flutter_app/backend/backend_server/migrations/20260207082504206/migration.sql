BEGIN;
BEGIN;


--
--
-- Function: gen_random_uuid_v7()
-- Function: gen_random_uuid_v7()
-- Source: https://gist.github.com/kjmph/5bd772b2c2df145aa645b837da7eca74
-- Source: https://gist.github.com/kjmph/5bd772b2c2df145aa645b837da7eca74
-- License: MIT (copyright notice included on the generator source code).
-- License: MIT (copyright notice included on the generator source code).
--
--
create or replace function gen_random_uuid_v7()
create or replace function gen_random_uuid_v7()
returns uuid
returns uuid
as $$
as $$
begin
begin
  -- use random v4 uuid as starting point (which has the same variant we need)
  -- use random v4 uuid as starting point (which has the same variant we need)
  -- then overlay timestamp
  -- then overlay timestamp
  -- then set version 7 by flipping the 2 and 1 bit in the version 4 string
  -- then set version 7 by flipping the 2 and 1 bit in the version 4 string
  return encode(
  return encode(
    set_bit(
    set_bit(
      set_bit(
      set_bit(
        overlay(uuid_send(gen_random_uuid())
        overlay(uuid_send(gen_random_uuid())
                placing substring(int8send(floor(extract(epoch from clock_timestamp()) * 1000)::bigint) from 3)
                placing substring(int8send(floor(extract(epoch from clock_timestamp()) * 1000)::bigint) from 3)
                from 1 for 6
                from 1 for 6
        ),
        ),
        52, 1
        52, 1
      ),
      ),
      53, 1
      53, 1
    ),
    ),
    'hex')::uuid;
    'hex')::uuid;
end
end
$$
$$
language plpgsql
language plpgsql
volatile;
volatile;


--
--
-- ACTION CREATE TABLE
-- ACTION CREATE TABLE
--
--
CREATE TABLE IF NOT EXISTS "albums" (
CREATE TABLE IF NOT EXISTS "albums" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "title" text NOT NULL,
    "title" text NOT NULL,
    "artistId" uuid NOT NULL,
    "artistId" uuid NOT NULL,
    "releaseYear" bigint,
    "releaseYear" bigint,
    "coverUrl" text,
    "coverUrl" text,
    "trackCount" bigint NOT NULL,
    "trackCount" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
    "createdAt" timestamp without time zone NOT NULL
);
);


--
--
-- ACTION CREATE TABLE
-- ACTION CREATE TABLE
--
--
CREATE TABLE IF NOT EXISTS "artists" (
CREATE TABLE IF NOT EXISTS "artists" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "name" text NOT NULL,
    "name" text NOT NULL,
    "genre" text,
    "genre" text,
    "monthlyListeners" bigint NOT NULL,
    "monthlyListeners" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
    "createdAt" timestamp without time zone NOT NULL
);
);


--
--
-- ACTION CREATE TABLE
-- ACTION CREATE TABLE
--
--
CREATE TABLE IF NOT EXISTS "play_events" (
CREATE TABLE IF NOT EXISTS "play_events" (
    "id" bigserial PRIMARY KEY,
    "id" bigserial PRIMARY KEY,
    "userId" uuid,
    "userId" uuid,
    "songId" uuid NOT NULL,
    "songId" uuid NOT NULL,
    "playedAt" timestamp without time zone NOT NULL,
    "playedAt" timestamp without time zone NOT NULL,
    "secondsListened" bigint NOT NULL,
    "secondsListened" bigint NOT NULL,
    "device" text
    "device" text
);
);


--
--
-- ACTION CREATE TABLE
-- ACTION CREATE TABLE
--
--
CREATE TABLE IF NOT EXISTS "playlist_items" (
CREATE TABLE IF NOT EXISTS "playlist_items" (
    "id" bigserial PRIMARY KEY,
    "id" bigserial PRIMARY KEY,
    "playlistId" uuid NOT NULL,
    "playlistId" uuid NOT NULL,
    "songId" uuid NOT NULL,
    "songId" uuid NOT NULL,
    "position" bigint NOT NULL,
    "position" bigint NOT NULL,
    "addedAt" timestamp without time zone NOT NULL
    "addedAt" timestamp without time zone NOT NULL
);
);


--
--
-- ACTION CREATE TABLE
-- ACTION CREATE TABLE
--
--
CREATE TABLE IF NOT EXISTS "playlists" (
CREATE TABLE IF NOT EXISTS "playlists" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "name" text NOT NULL,
    "name" text NOT NULL,
    "description" text,
    "description" text,
    "coverUrl" text,
    "coverUrl" text,
    "gradient" text,
    "gradient" text,
    "ownerUserId" uuid,
    "ownerUserId" uuid,
    "isPublic" boolean NOT NULL,
    "isPublic" boolean NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
    "createdAt" timestamp without time zone NOT NULL
);
);


--
--
-- ACTION CREATE TABLE
-- ACTION CREATE TABLE
--
--
CREATE TABLE IF NOT EXISTS "songs" (
CREATE TABLE IF NOT EXISTS "songs" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "title" text NOT NULL,
    "title" text NOT NULL,
    "artistId" uuid NOT NULL,
    "artistId" uuid NOT NULL,
    "albumId" uuid,
    "albumId" uuid,
    "durationSec" bigint NOT NULL,
    "durationSec" bigint NOT NULL,
    "genre" text,
    "genre" text,
    "audioUrl" text,
    "audioUrl" text,
    "coverUrl" text,
    "coverUrl" text,
    "streams" bigint NOT NULL,
    "streams" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
    "createdAt" timestamp without time zone NOT NULL
);
);


--
--
-- ACTION CREATE TABLE
-- ACTION CREATE TABLE
--
--
CREATE TABLE IF NOT EXISTS "subscriptions" (
CREATE TABLE IF NOT EXISTS "subscriptions" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "userId" uuid NOT NULL,
    "userId" uuid NOT NULL,
    "plan" text NOT NULL,
    "plan" text NOT NULL,
    "status" text NOT NULL,
    "status" text NOT NULL,
    "renewsOn" timestamp without time zone NOT NULL,
    "renewsOn" timestamp without time zone NOT NULL,
    "startedAt" timestamp without time zone NOT NULL,
    "startedAt" timestamp without time zone NOT NULL,
    "canceledAt" timestamp without time zone
    "canceledAt" timestamp without time zone
);
);


--
--
-- ACTION CREATE TABLE
-- ACTION CREATE TABLE
--
--
CREATE TABLE IF NOT EXISTS "user_favorites" (
CREATE TABLE IF NOT EXISTS "user_favorites" (
    "id" bigserial PRIMARY KEY,
    "id" bigserial PRIMARY KEY,
    "userId" uuid NOT NULL,
    "userId" uuid NOT NULL,
    "songId" uuid NOT NULL,
    "songId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
    "createdAt" timestamp without time zone NOT NULL
);
);


--
--
-- ACTION CREATE TABLE
-- ACTION CREATE TABLE
--
--
CREATE TABLE IF NOT EXISTS "users" (
CREATE TABLE IF NOT EXISTS "users" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "firebaseId" text,
    "firebaseId" text,
    "name" text NOT NULL,
    "name" text NOT NULL,
    "email" text NOT NULL,
    "email" text NOT NULL,
    "role" text NOT NULL,
    "role" text NOT NULL,
    "active" boolean NOT NULL,
    "active" boolean NOT NULL,
    "joinedAt" timestamp without time zone NOT NULL
    "joinedAt" timestamp without time zone NOT NULL
);
);


--
--
-- ACTION CREATE TABLE
-- ACTION CREATE TABLE
--
--
CREATE TABLE IF NOT EXISTS "serverpod_cloud_storage" (
CREATE TABLE IF NOT EXISTS "serverpod_cloud_storage" (
    "id" bigserial PRIMARY KEY,
    "id" bigserial PRIMARY KEY,
    "storageId" text NOT NULL,
    "storageId" text NOT NULL,
    "path" text NOT NULL,
    "path" text NOT NULL,
    "addedTime" timestamp without time zone NOT NULL,
    "addedTime" timestamp without time zone NOT NULL,
    "expiration" timestamp without time zone,
    "expiration" timestamp without time zone,
    "byteData" bytea NOT NULL,
    "byteData" bytea NOT NULL,
    "verified" boolean NOT NULL
    "verified" boolean NOT NULL
);
);


-- Indexes
-- Indexes
CREATE UNIQUE INDEX "serverpod_cloud_storage_path_idx" ON "serverpod_cloud_storage" USING btree ("storageId", "path");
CREATE UNIQUE INDEX IF NOT EXISTS "serverpod_cloud_storage_path_idx" ON "serverpod_cloud_storage" USING btree ("storageId", "path");
CREATE INDEX IF NOT EXISTS "serverpod_cloud_storage_expiration" ON "serverpod_cloud_storage" USING btree ("expiration");
CREATE INDEX "serverpod_cloud_storage_expiration" ON "serverpod_cloud_storage" USING btree ("expiration");


--
--
-- ACTION CREATE TABLE
-- ACTION CREATE TABLE
--
--
CREATE TABLE IF NOT EXISTS "serverpod_cloud_storage_direct_upload" (
CREATE TABLE IF NOT EXISTS "serverpod_cloud_storage_direct_upload" (
    "id" bigserial PRIMARY KEY,
    "id" bigserial PRIMARY KEY,
    "storageId" text NOT NULL,
    "storageId" text NOT NULL,
    "path" text NOT NULL,
    "path" text NOT NULL,
    "expiration" timestamp without time zone NOT NULL,
    "expiration" timestamp without time zone NOT NULL,
    "authKey" text NOT NULL
    "authKey" text NOT NULL
);
);


-- Indexes
-- Indexes
CREATE UNIQUE INDEX "serverpod_cloud_storage_direct_upload_storage_path" ON "serverpod_cloud_storage_direct_upload" USING btree ("storageId", "path");
CREATE UNIQUE INDEX IF NOT EXISTS "serverpod_cloud_storage_direct_upload_storage_path" ON "serverpod_cloud_storage_direct_upload" USING btree ("storageId", "path");


--
--
-- ACTION CREATE TABLE
-- ACTION CREATE TABLE
--
--
CREATE TABLE IF NOT EXISTS "serverpod_future_call" (
CREATE TABLE IF NOT EXISTS "serverpod_future_call" (
    "id" bigserial PRIMARY KEY,
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "name" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "serializedObject" text,
    "serializedObject" text,
    "serverId" text NOT NULL,
    "serverId" text NOT NULL,
    "identifier" text
    "identifier" text
);
);


-- Indexes
-- Indexes
CREATE INDEX IF NOT EXISTS "serverpod_future_call_time_idx" ON "serverpod_future_call" USING btree ("time");
CREATE INDEX "serverpod_future_call_time_idx" ON "serverpod_future_call" USING btree ("time");
CREATE INDEX IF NOT EXISTS "serverpod_future_call_serverId_idx" ON "serverpod_future_call" USING btree ("serverId");
CREATE INDEX "serverpod_future_call_serverId_idx" ON "serverpod_future_call" USING btree ("serverId");
CREATE INDEX IF NOT EXISTS "serverpod_future_call_identifier_idx" ON "serverpod_future_call" USING btree ("identifier");
CREATE INDEX "serverpod_future_call_identifier_idx" ON "serverpod_future_call" USING btree ("identifier");


--
--
-- ACTION CREATE TABLE
-- ACTION CREATE TABLE
--
--
CREATE TABLE IF NOT EXISTS "serverpod_health_connection_info" (
CREATE TABLE IF NOT EXISTS "serverpod_health_connection_info" (
    "id" bigserial PRIMARY KEY,
    "id" bigserial PRIMARY KEY,
    "serverId" text NOT NULL,
    "serverId" text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "active" bigint NOT NULL,
    "active" bigint NOT NULL,
    "closing" bigint NOT NULL,
    "closing" bigint NOT NULL,
    "idle" bigint NOT NULL,
    "idle" bigint NOT NULL,
    "granularity" bigint NOT NULL
    "granularity" bigint NOT NULL
);
);


-- Indexes
-- Indexes
CREATE UNIQUE INDEX "serverpod_health_connection_info_timestamp_idx" ON "serverpod_health_connection_info" USING btree ("timestamp", "serverId", "granularity");
CREATE UNIQUE INDEX IF NOT EXISTS "serverpod_health_connection_info_timestamp_idx" ON "serverpod_health_connection_info" USING btree ("timestamp", "serverId", "granularity");


--
--
-- ACTION CREATE TABLE
-- ACTION CREATE TABLE
--
--
CREATE TABLE IF NOT EXISTS "serverpod_health_metric" (
CREATE TABLE IF NOT EXISTS "serverpod_health_metric" (
    "id" bigserial PRIMARY KEY,
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "name" text NOT NULL,
    "serverId" text NOT NULL,
    "serverId" text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "isHealthy" boolean NOT NULL,
    "isHealthy" boolean NOT NULL,
    "value" double precision NOT NULL,
    "value" double precision NOT NULL,
    "granularity" bigint NOT NULL
    "granularity" bigint NOT NULL
);
);


-- Indexes
-- Indexes
CREATE UNIQUE INDEX "serverpod_health_metric_timestamp_idx" ON "serverpod_health_metric" USING btree ("timestamp", "serverId", "name", "granularity");
CREATE UNIQUE INDEX IF NOT EXISTS "serverpod_health_metric_timestamp_idx" ON "serverpod_health_metric" USING btree ("timestamp", "serverId", "name", "granularity");


--
--
-- ACTION CREATE TABLE
-- ACTION CREATE TABLE
--
--
CREATE TABLE IF NOT EXISTS "serverpod_log" (
CREATE TABLE IF NOT EXISTS "serverpod_log" (
    "id" bigserial PRIMARY KEY,
    "id" bigserial PRIMARY KEY,
    "sessionLogId" bigint NOT NULL,
    "sessionLogId" bigint NOT NULL,
    "messageId" bigint,
    "messageId" bigint,
    "reference" text,
    "reference" text,
    "serverId" text NOT NULL,
    "serverId" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "logLevel" bigint NOT NULL,
    "logLevel" bigint NOT NULL,
    "message" text NOT NULL,
    "message" text NOT NULL,
    "error" text,
    "error" text,
    "stackTrace" text,
    "stackTrace" text,
    "order" bigint NOT NULL
    "order" bigint NOT NULL
);
);


-- Indexes
-- Indexes
CREATE INDEX IF NOT EXISTS "serverpod_log_sessionLogId_idx" ON "serverpod_log" USING btree ("sessionLogId");
CREATE INDEX "serverpod_log_sessionLogId_idx" ON "serverpod_log" USING btree ("sessionLogId");


--
--
-- ACTION CREATE TABLE
-- ACTION CREATE TABLE
--
--
CREATE TABLE IF NOT EXISTS "serverpod_message_log" (
CREATE TABLE IF NOT EXISTS "serverpod_message_log" (
    "id" bigserial PRIMARY KEY,
    "id" bigserial PRIMARY KEY,
    "sessionLogId" bigint NOT NULL,
    "sessionLogId" bigint NOT NULL,
    "serverId" text NOT NULL,
    "serverId" text NOT NULL,
    "messageId" bigint NOT NULL,
    "messageId" bigint NOT NULL,
    "endpoint" text NOT NULL,
    "endpoint" text NOT NULL,
    "messageName" text NOT NULL,
    "messageName" text NOT NULL,
    "duration" double precision NOT NULL,
    "duration" double precision NOT NULL,
    "error" text,
    "error" text,
    "stackTrace" text,
    "stackTrace" text,
    "slow" boolean NOT NULL,
    "slow" boolean NOT NULL,
    "order" bigint NOT NULL
    "order" bigint NOT NULL
);
);


--
--
-- ACTION CREATE TABLE
-- ACTION CREATE TABLE
--
--
CREATE TABLE IF NOT EXISTS "serverpod_method" (
CREATE TABLE IF NOT EXISTS "serverpod_method" (
    "id" bigserial PRIMARY KEY,
    "id" bigserial PRIMARY KEY,
    "endpoint" text NOT NULL,
    "endpoint" text NOT NULL,
    "method" text NOT NULL
    "method" text NOT NULL
);
);


-- Indexes
-- Indexes
CREATE UNIQUE INDEX "serverpod_method_endpoint_method_idx" ON "serverpod_method" USING btree ("endpoint", "method");
CREATE UNIQUE INDEX IF NOT EXISTS "serverpod_method_endpoint_method_idx" ON "serverpod_method" USING btree ("endpoint", "method");


--
--
-- ACTION CREATE TABLE
-- ACTION CREATE TABLE
--
--
CREATE TABLE IF NOT EXISTS "serverpod_migrations" (
CREATE TABLE IF NOT EXISTS "serverpod_migrations" (
    "id" bigserial PRIMARY KEY,
    "id" bigserial PRIMARY KEY,
    "module" text NOT NULL,
    "module" text NOT NULL,
    "version" text NOT NULL,
    "version" text NOT NULL,
    "timestamp" timestamp without time zone
    "timestamp" timestamp without time zone
);
);


-- Indexes
-- Indexes
CREATE UNIQUE INDEX "serverpod_migrations_ids" ON "serverpod_migrations" USING btree ("module");
CREATE UNIQUE INDEX IF NOT EXISTS "serverpod_migrations_ids" ON "serverpod_migrations" USING btree ("module");


--
--
-- ACTION CREATE TABLE
-- ACTION CREATE TABLE
--
--
CREATE TABLE IF NOT EXISTS "serverpod_query_log" (
CREATE TABLE IF NOT EXISTS "serverpod_query_log" (
    "id" bigserial PRIMARY KEY,
    "id" bigserial PRIMARY KEY,
    "serverId" text NOT NULL,
    "serverId" text NOT NULL,
    "sessionLogId" bigint NOT NULL,
    "sessionLogId" bigint NOT NULL,
    "messageId" bigint,
    "messageId" bigint,
    "query" text NOT NULL,
    "query" text NOT NULL,
    "duration" double precision NOT NULL,
    "duration" double precision NOT NULL,
    "numRows" bigint,
    "numRows" bigint,
    "error" text,
    "error" text,
    "stackTrace" text,
    "stackTrace" text,
    "slow" boolean NOT NULL,
    "slow" boolean NOT NULL,
    "order" bigint NOT NULL
    "order" bigint NOT NULL
);
);


-- Indexes
-- Indexes
CREATE INDEX IF NOT EXISTS "serverpod_query_log_sessionLogId_idx" ON "serverpod_query_log" USING btree ("sessionLogId");
CREATE INDEX "serverpod_query_log_sessionLogId_idx" ON "serverpod_query_log" USING btree ("sessionLogId");


--
--
-- ACTION CREATE TABLE
-- ACTION CREATE TABLE
--
--
CREATE TABLE IF NOT EXISTS "serverpod_readwrite_test" (
CREATE TABLE IF NOT EXISTS "serverpod_readwrite_test" (
    "id" bigserial PRIMARY KEY,
    "id" bigserial PRIMARY KEY,
    "number" bigint NOT NULL
    "number" bigint NOT NULL
);
);


--
--
-- ACTION CREATE TABLE
-- ACTION CREATE TABLE
--
--
CREATE TABLE IF NOT EXISTS "serverpod_runtime_settings" (
CREATE TABLE IF NOT EXISTS "serverpod_runtime_settings" (
    "id" bigserial PRIMARY KEY,
    "id" bigserial PRIMARY KEY,
    "logSettings" json NOT NULL,
    "logSettings" json NOT NULL,
    "logSettingsOverrides" json NOT NULL,
    "logSettingsOverrides" json NOT NULL,
    "logServiceCalls" boolean NOT NULL,
    "logServiceCalls" boolean NOT NULL,
    "logMalformedCalls" boolean NOT NULL
    "logMalformedCalls" boolean NOT NULL
);
);


--
--
-- ACTION CREATE TABLE
-- ACTION CREATE TABLE
--
--
CREATE TABLE IF NOT EXISTS "serverpod_session_log" (
CREATE TABLE IF NOT EXISTS "serverpod_session_log" (
    "id" bigserial PRIMARY KEY,
    "id" bigserial PRIMARY KEY,
    "serverId" text NOT NULL,
    "serverId" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "module" text,
    "module" text,
    "endpoint" text,
    "endpoint" text,
    "method" text,
    "method" text,
    "duration" double precision,
    "duration" double precision,
    "numQueries" bigint,
    "numQueries" bigint,
    "slow" boolean,
    "slow" boolean,
    "error" text,
    "error" text,
    "stackTrace" text,
    "stackTrace" text,
    "authenticatedUserId" bigint,
    "authenticatedUserId" bigint,
    "userId" text,
    "userId" text,
    "isOpen" boolean,
    "isOpen" boolean,
    "touched" timestamp without time zone NOT NULL
    "touched" timestamp without time zone NOT NULL
);
);


-- Indexes
-- Indexes
CREATE INDEX IF NOT EXISTS "serverpod_session_log_serverid_idx" ON "serverpod_session_log" USING btree ("serverId");
CREATE INDEX "serverpod_session_log_serverid_idx" ON "serverpod_session_log" USING btree ("serverId");
CREATE INDEX IF NOT EXISTS "serverpod_session_log_touched_idx" ON "serverpod_session_log" USING btree ("touched");
CREATE INDEX "serverpod_session_log_touched_idx" ON "serverpod_session_log" USING btree ("touched");
CREATE INDEX IF NOT EXISTS "serverpod_session_log_isopen_idx" ON "serverpod_session_log" USING btree ("isOpen");
CREATE INDEX "serverpod_session_log_isopen_idx" ON "serverpod_session_log" USING btree ("isOpen");


--
--
-- ACTION CREATE TABLE
-- ACTION CREATE TABLE
--
--
CREATE TABLE IF NOT EXISTS "serverpod_auth_idp_apple_account" (
CREATE TABLE IF NOT EXISTS "serverpod_auth_idp_apple_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "userIdentifier" text NOT NULL,
    "userIdentifier" text NOT NULL,
    "refreshToken" text NOT NULL,
    "refreshToken" text NOT NULL,
    "refreshTokenRequestedWithBundleIdentifier" boolean NOT NULL,
    "refreshTokenRequestedWithBundleIdentifier" boolean NOT NULL,
    "lastRefreshedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "lastRefreshedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "authUserId" uuid NOT NULL,
    "authUserId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "email" text,
    "email" text,
    "isEmailVerified" boolean,
    "isEmailVerified" boolean,
    "isPrivateEmail" boolean,
    "isPrivateEmail" boolean,
    "firstName" text,
    "firstName" text,
    "lastName" text
    "lastName" text
);
);


-- Indexes
-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_apple_account_identifier" ON "serverpod_auth_idp_apple_account" USING btree ("userIdentifier");
CREATE UNIQUE INDEX IF NOT EXISTS "serverpod_auth_apple_account_identifier" ON "serverpod_auth_idp_apple_account" USING btree ("userIdentifier");


--
--
-- ACTION CREATE TABLE
-- ACTION CREATE TABLE
--
--
CREATE TABLE IF NOT EXISTS "serverpod_auth_idp_email_account" (
CREATE TABLE IF NOT EXISTS "serverpod_auth_idp_email_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "authUserId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "email" text NOT NULL,
    "email" text NOT NULL,
    "passwordHash" text NOT NULL
    "passwordHash" text NOT NULL
);
);


-- Indexes
-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_idp_email_account_email" ON "serverpod_auth_idp_email_account" USING btree ("email");
CREATE UNIQUE INDEX IF NOT EXISTS "serverpod_auth_idp_email_account_email" ON "serverpod_auth_idp_email_account" USING btree ("email");


--
--
-- ACTION CREATE TABLE
-- ACTION CREATE TABLE
--
--
CREATE TABLE IF NOT EXISTS "serverpod_auth_idp_email_account_password_reset_request" (
CREATE TABLE IF NOT EXISTS "serverpod_auth_idp_email_account_password_reset_request" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "emailAccountId" uuid NOT NULL,
    "emailAccountId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "challengeId" uuid NOT NULL,
    "challengeId" uuid NOT NULL,
    "setPasswordChallengeId" uuid
    "setPasswordChallengeId" uuid
);
);


--
--
-- ACTION CREATE TABLE
-- ACTION CREATE TABLE
--
--
CREATE TABLE IF NOT EXISTS "serverpod_auth_idp_email_account_request" (
CREATE TABLE IF NOT EXISTS "serverpod_auth_idp_email_account_request" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "email" text NOT NULL,
    "email" text NOT NULL,
    "challengeId" uuid NOT NULL,
    "challengeId" uuid NOT NULL,
    "createAccountChallengeId" uuid
    "createAccountChallengeId" uuid
);
);


-- Indexes
-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_idp_email_account_request_email" ON "serverpod_auth_idp_email_account_request" USING btree ("email");
CREATE UNIQUE INDEX IF NOT EXISTS "serverpod_auth_idp_email_account_request_email" ON "serverpod_auth_idp_email_account_request" USING btree ("email");


--
--
-- ACTION CREATE TABLE
-- ACTION CREATE TABLE
--
--
CREATE TABLE IF NOT EXISTS "serverpod_auth_idp_google_account" (
CREATE TABLE IF NOT EXISTS "serverpod_auth_idp_google_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "authUserId" uuid NOT NULL,
    "created" timestamp without time zone NOT NULL,
    "created" timestamp without time zone NOT NULL,
    "email" text NOT NULL,
    "email" text NOT NULL,
    "userIdentifier" text NOT NULL
    "userIdentifier" text NOT NULL
);
);


-- Indexes
-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_google_account_user_identifier" ON "serverpod_auth_idp_google_account" USING btree ("userIdentifier");
CREATE UNIQUE INDEX IF NOT EXISTS "serverpod_auth_google_account_user_identifier" ON "serverpod_auth_idp_google_account" USING btree ("userIdentifier");


--
--
-- ACTION CREATE TABLE
-- ACTION CREATE TABLE
--
--
CREATE TABLE IF NOT EXISTS "serverpod_auth_idp_passkey_account" (
CREATE TABLE IF NOT EXISTS "serverpod_auth_idp_passkey_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "authUserId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "keyId" bytea NOT NULL,
    "keyId" bytea NOT NULL,
    "keyIdBase64" text NOT NULL,
    "keyIdBase64" text NOT NULL,
    "clientDataJSON" bytea NOT NULL,
    "clientDataJSON" bytea NOT NULL,
    "attestationObject" bytea NOT NULL,
    "attestationObject" bytea NOT NULL,
    "originalChallenge" bytea NOT NULL
    "originalChallenge" bytea NOT NULL
);
);


-- Indexes
-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_idp_passkey_account_key_id_base64" ON "serverpod_auth_idp_passkey_account" USING btree ("keyIdBase64");
CREATE UNIQUE INDEX IF NOT EXISTS "serverpod_auth_idp_passkey_account_key_id_base64" ON "serverpod_auth_idp_passkey_account" USING btree ("keyIdBase64");


--
--
-- ACTION CREATE TABLE
-- ACTION CREATE TABLE
--
--
CREATE TABLE IF NOT EXISTS "serverpod_auth_idp_passkey_challenge" (
CREATE TABLE IF NOT EXISTS "serverpod_auth_idp_passkey_challenge" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "createdAt" timestamp without time zone NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "challenge" bytea NOT NULL
    "challenge" bytea NOT NULL
);
);


--
--
-- ACTION CREATE TABLE
-- ACTION CREATE TABLE
--
--
CREATE TABLE IF NOT EXISTS "serverpod_auth_idp_rate_limited_request_attempt" (
CREATE TABLE IF NOT EXISTS "serverpod_auth_idp_rate_limited_request_attempt" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "domain" text NOT NULL,
    "domain" text NOT NULL,
    "source" text NOT NULL,
    "source" text NOT NULL,
    "nonce" text NOT NULL,
    "nonce" text NOT NULL,
    "ipAddress" text,
    "ipAddress" text,
    "attemptedAt" timestamp without time zone NOT NULL,
    "attemptedAt" timestamp without time zone NOT NULL,
    "extraData" json
    "extraData" json
);
);


-- Indexes
-- Indexes
CREATE INDEX IF NOT EXISTS "serverpod_auth_idp_rate_limited_request_attempt_domain" ON "serverpod_auth_idp_rate_limited_request_attempt" USING btree ("domain");
CREATE INDEX "serverpod_auth_idp_rate_limited_request_attempt_domain" ON "serverpod_auth_idp_rate_limited_request_attempt" USING btree ("domain");
CREATE INDEX IF NOT EXISTS "serverpod_auth_idp_rate_limited_request_attempt_source" ON "serverpod_auth_idp_rate_limited_request_attempt" USING btree ("source");
CREATE INDEX "serverpod_auth_idp_rate_limited_request_attempt_source" ON "serverpod_auth_idp_rate_limited_request_attempt" USING btree ("source");
CREATE INDEX IF NOT EXISTS "serverpod_auth_idp_rate_limited_request_attempt_nonce" ON "serverpod_auth_idp_rate_limited_request_attempt" USING btree ("nonce");
CREATE INDEX "serverpod_auth_idp_rate_limited_request_attempt_nonce" ON "serverpod_auth_idp_rate_limited_request_attempt" USING btree ("nonce");


--
--
-- ACTION CREATE TABLE
-- ACTION CREATE TABLE
--
--
CREATE TABLE IF NOT EXISTS "serverpod_auth_idp_secret_challenge" (
CREATE TABLE IF NOT EXISTS "serverpod_auth_idp_secret_challenge" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "challengeCodeHash" text NOT NULL
    "challengeCodeHash" text NOT NULL
);
);


--
--
-- ACTION CREATE TABLE
-- ACTION CREATE TABLE
--
--
CREATE TABLE IF NOT EXISTS "serverpod_auth_core_jwt_refresh_token" (
CREATE TABLE IF NOT EXISTS "serverpod_auth_core_jwt_refresh_token" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "authUserId" uuid NOT NULL,
    "scopeNames" json NOT NULL,
    "scopeNames" json NOT NULL,
    "extraClaims" text,
    "extraClaims" text,
    "method" text NOT NULL,
    "method" text NOT NULL,
    "fixedSecret" bytea NOT NULL,
    "fixedSecret" bytea NOT NULL,
    "rotatingSecretHash" text NOT NULL,
    "rotatingSecretHash" text NOT NULL,
    "lastUpdatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "lastUpdatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);
);


-- Indexes
-- Indexes
CREATE INDEX IF NOT EXISTS "serverpod_auth_core_jwt_refresh_token_last_updated_at" ON "serverpod_auth_core_jwt_refresh_token" USING btree ("lastUpdatedAt");
CREATE INDEX "serverpod_auth_core_jwt_refresh_token_last_updated_at" ON "serverpod_auth_core_jwt_refresh_token" USING btree ("lastUpdatedAt");


--
--
-- ACTION CREATE TABLE
-- ACTION CREATE TABLE
--
--
CREATE TABLE IF NOT EXISTS "serverpod_auth_core_profile" (
CREATE TABLE IF NOT EXISTS "serverpod_auth_core_profile" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "authUserId" uuid NOT NULL,
    "userName" text,
    "userName" text,
    "fullName" text,
    "fullName" text,
    "email" text,
    "email" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "imageId" uuid
    "imageId" uuid
);
);


-- Indexes
-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_profile_user_profile_email_auth_user_id" ON "serverpod_auth_core_profile" USING btree ("authUserId");
CREATE UNIQUE INDEX IF NOT EXISTS "serverpod_auth_profile_user_profile_email_auth_user_id" ON "serverpod_auth_core_profile" USING btree ("authUserId");


--
--
-- ACTION CREATE TABLE
-- ACTION CREATE TABLE
--
--
CREATE TABLE IF NOT EXISTS "serverpod_auth_core_profile_image" (
CREATE TABLE IF NOT EXISTS "serverpod_auth_core_profile_image" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "userProfileId" uuid NOT NULL,
    "userProfileId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "storageId" text NOT NULL,
    "storageId" text NOT NULL,
    "path" text NOT NULL,
    "path" text NOT NULL,
    "url" text NOT NULL
    "url" text NOT NULL
);
);


--
--
-- ACTION CREATE TABLE
-- ACTION CREATE TABLE
--
--
CREATE TABLE IF NOT EXISTS "serverpod_auth_core_session" (
CREATE TABLE IF NOT EXISTS "serverpod_auth_core_session" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "authUserId" uuid NOT NULL,
    "scopeNames" json NOT NULL,
    "scopeNames" json NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "lastUsedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "lastUsedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expiresAt" timestamp without time zone,
    "expiresAt" timestamp without time zone,
    "expireAfterUnusedFor" bigint,
    "expireAfterUnusedFor" bigint,
    "sessionKeyHash" bytea NOT NULL,
    "sessionKeyHash" bytea NOT NULL,
    "sessionKeySalt" bytea NOT NULL,
    "sessionKeySalt" bytea NOT NULL,
    "method" text NOT NULL
    "method" text NOT NULL
);
);


--
--
-- ACTION CREATE TABLE
-- ACTION CREATE TABLE
--
--
CREATE TABLE IF NOT EXISTS "serverpod_auth_core_user" (
CREATE TABLE IF NOT EXISTS "serverpod_auth_core_user" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "createdAt" timestamp without time zone NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "scopeNames" json NOT NULL,
    "scopeNames" json NOT NULL,
    "blocked" boolean NOT NULL
    "blocked" boolean NOT NULL
);
);


--
--
-- ACTION CREATE FOREIGN KEY
-- ACTION CREATE FOREIGN KEY
--
--
ALTER TABLE ONLY "serverpod_log"
ALTER TABLE ONLY "serverpod_log"
    ADD CONSTRAINT "serverpod_log_fk_0"
    ADD CONSTRAINT "serverpod_log_fk_0"
    FOREIGN KEY("sessionLogId")
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
    ON UPDATE NO ACTION;


--
--
-- ACTION CREATE FOREIGN KEY
-- ACTION CREATE FOREIGN KEY
--
--
ALTER TABLE ONLY "serverpod_message_log"
ALTER TABLE ONLY "serverpod_message_log"
    ADD CONSTRAINT "serverpod_message_log_fk_0"
    ADD CONSTRAINT "serverpod_message_log_fk_0"
    FOREIGN KEY("sessionLogId")
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
    ON UPDATE NO ACTION;


--
--
-- ACTION CREATE FOREIGN KEY
-- ACTION CREATE FOREIGN KEY
--
--
ALTER TABLE ONLY "serverpod_query_log"
ALTER TABLE ONLY "serverpod_query_log"
    ADD CONSTRAINT "serverpod_query_log_fk_0"
    ADD CONSTRAINT "serverpod_query_log_fk_0"
    FOREIGN KEY("sessionLogId")
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
    ON UPDATE NO ACTION;


--
--
-- ACTION CREATE FOREIGN KEY
-- ACTION CREATE FOREIGN KEY
--
--
ALTER TABLE ONLY "serverpod_auth_idp_apple_account"
ALTER TABLE ONLY "serverpod_auth_idp_apple_account"
    ADD CONSTRAINT "serverpod_auth_idp_apple_account_fk_0"
    ADD CONSTRAINT "serverpod_auth_idp_apple_account_fk_0"
    FOREIGN KEY("authUserId")
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
    ON UPDATE NO ACTION;


--
--
-- ACTION CREATE FOREIGN KEY
-- ACTION CREATE FOREIGN KEY
--
--
ALTER TABLE ONLY "serverpod_auth_idp_email_account"
ALTER TABLE ONLY "serverpod_auth_idp_email_account"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_fk_0"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_fk_0"
    FOREIGN KEY("authUserId")
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
    ON UPDATE NO ACTION;


--
--
-- ACTION CREATE FOREIGN KEY
-- ACTION CREATE FOREIGN KEY
--
--
ALTER TABLE ONLY "serverpod_auth_idp_email_account_password_reset_request"
ALTER TABLE ONLY "serverpod_auth_idp_email_account_password_reset_request"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_password_reset_request_fk_0"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_password_reset_request_fk_0"
    FOREIGN KEY("emailAccountId")
    FOREIGN KEY("emailAccountId")
    REFERENCES "serverpod_auth_idp_email_account"("id")
    REFERENCES "serverpod_auth_idp_email_account"("id")
    ON DELETE CASCADE
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "serverpod_auth_idp_email_account_password_reset_request"
ALTER TABLE ONLY "serverpod_auth_idp_email_account_password_reset_request"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_password_reset_request_fk_1"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_password_reset_request_fk_1"
    FOREIGN KEY("challengeId")
    FOREIGN KEY("challengeId")
    REFERENCES "serverpod_auth_idp_secret_challenge"("id")
    REFERENCES "serverpod_auth_idp_secret_challenge"("id")
    ON DELETE CASCADE
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "serverpod_auth_idp_email_account_password_reset_request"
ALTER TABLE ONLY "serverpod_auth_idp_email_account_password_reset_request"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_password_reset_request_fk_2"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_password_reset_request_fk_2"
    FOREIGN KEY("setPasswordChallengeId")
    FOREIGN KEY("setPasswordChallengeId")
    REFERENCES "serverpod_auth_idp_secret_challenge"("id")
    REFERENCES "serverpod_auth_idp_secret_challenge"("id")
    ON DELETE CASCADE
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
    ON UPDATE NO ACTION;


--
--
-- ACTION CREATE FOREIGN KEY
-- ACTION CREATE FOREIGN KEY
--
--
ALTER TABLE ONLY "serverpod_auth_idp_email_account_request"
ALTER TABLE ONLY "serverpod_auth_idp_email_account_request"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_request_fk_0"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_request_fk_0"
    FOREIGN KEY("challengeId")
    FOREIGN KEY("challengeId")
    REFERENCES "serverpod_auth_idp_secret_challenge"("id")
    REFERENCES "serverpod_auth_idp_secret_challenge"("id")
    ON DELETE CASCADE
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "serverpod_auth_idp_email_account_request"
ALTER TABLE ONLY "serverpod_auth_idp_email_account_request"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_request_fk_1"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_request_fk_1"
    FOREIGN KEY("createAccountChallengeId")
    FOREIGN KEY("createAccountChallengeId")
    REFERENCES "serverpod_auth_idp_secret_challenge"("id")
    REFERENCES "serverpod_auth_idp_secret_challenge"("id")
    ON DELETE CASCADE
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
    ON UPDATE NO ACTION;


--
--
-- ACTION CREATE FOREIGN KEY
-- ACTION CREATE FOREIGN KEY
--
--
ALTER TABLE ONLY "serverpod_auth_idp_google_account"
ALTER TABLE ONLY "serverpod_auth_idp_google_account"
    ADD CONSTRAINT "serverpod_auth_idp_google_account_fk_0"
    ADD CONSTRAINT "serverpod_auth_idp_google_account_fk_0"
    FOREIGN KEY("authUserId")
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
    ON UPDATE NO ACTION;


--
--
-- ACTION CREATE FOREIGN KEY
-- ACTION CREATE FOREIGN KEY
--
--
ALTER TABLE ONLY "serverpod_auth_idp_passkey_account"
ALTER TABLE ONLY "serverpod_auth_idp_passkey_account"
    ADD CONSTRAINT "serverpod_auth_idp_passkey_account_fk_0"
    ADD CONSTRAINT "serverpod_auth_idp_passkey_account_fk_0"
    FOREIGN KEY("authUserId")
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
    ON UPDATE NO ACTION;


--
--
-- ACTION CREATE FOREIGN KEY
-- ACTION CREATE FOREIGN KEY
--
--
ALTER TABLE ONLY "serverpod_auth_core_jwt_refresh_token"
ALTER TABLE ONLY "serverpod_auth_core_jwt_refresh_token"
    ADD CONSTRAINT "serverpod_auth_core_jwt_refresh_token_fk_0"
    ADD CONSTRAINT "serverpod_auth_core_jwt_refresh_token_fk_0"
    FOREIGN KEY("authUserId")
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
    ON UPDATE NO ACTION;


--
--
-- ACTION CREATE FOREIGN KEY
-- ACTION CREATE FOREIGN KEY
--
--
ALTER TABLE ONLY "serverpod_auth_core_profile"
ALTER TABLE ONLY "serverpod_auth_core_profile"
    ADD CONSTRAINT "serverpod_auth_core_profile_fk_0"
    ADD CONSTRAINT "serverpod_auth_core_profile_fk_0"
    FOREIGN KEY("authUserId")
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "serverpod_auth_core_profile"
ALTER TABLE ONLY "serverpod_auth_core_profile"
    ADD CONSTRAINT "serverpod_auth_core_profile_fk_1"
    ADD CONSTRAINT "serverpod_auth_core_profile_fk_1"
    FOREIGN KEY("imageId")
    FOREIGN KEY("imageId")
    REFERENCES "serverpod_auth_core_profile_image"("id")
    REFERENCES "serverpod_auth_core_profile_image"("id")
    ON DELETE NO ACTION
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
    ON UPDATE NO ACTION;


--
--
-- ACTION CREATE FOREIGN KEY
-- ACTION CREATE FOREIGN KEY
--
--
ALTER TABLE ONLY "serverpod_auth_core_profile_image"
ALTER TABLE ONLY "serverpod_auth_core_profile_image"
    ADD CONSTRAINT "serverpod_auth_core_profile_image_fk_0"
    ADD CONSTRAINT "serverpod_auth_core_profile_image_fk_0"
    FOREIGN KEY("userProfileId")
    FOREIGN KEY("userProfileId")
    REFERENCES "serverpod_auth_core_profile"("id")
    REFERENCES "serverpod_auth_core_profile"("id")
    ON DELETE CASCADE
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
    ON UPDATE NO ACTION;


--
--
-- ACTION CREATE FOREIGN KEY
-- ACTION CREATE FOREIGN KEY
--
--
ALTER TABLE ONLY "serverpod_auth_core_session"
ALTER TABLE ONLY "serverpod_auth_core_session"
    ADD CONSTRAINT "serverpod_auth_core_session_fk_0"
    ADD CONSTRAINT "serverpod_auth_core_session_fk_0"
    FOREIGN KEY("authUserId")
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
    ON UPDATE NO ACTION;




--
--
-- MIGRATION VERSION FOR backend
-- MIGRATION VERSION FOR backend
--
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('backend', '20260207082504206', now())
    VALUES ('backend', '20260207082504206', now())
    ON CONFLICT ("module")
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260207082504206', "timestamp" = now();
    DO UPDATE SET "version" = '20260207082504206', "timestamp" = now();


--
--
-- MIGRATION VERSION FOR serverpod
-- MIGRATION VERSION FOR serverpod
--
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20251208110333922-v3-0-0', now())
    VALUES ('serverpod', '20251208110333922-v3-0-0', now())
    ON CONFLICT ("module")
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251208110333922-v3-0-0', "timestamp" = now();
    DO UPDATE SET "version" = '20251208110333922-v3-0-0', "timestamp" = now();


--
--
-- MIGRATION VERSION FOR serverpod_auth_idp
-- MIGRATION VERSION FOR serverpod_auth_idp
--
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20251208110420531-v3-0-0', now())
    VALUES ('serverpod_auth_idp', '20251208110420531-v3-0-0', now())
    ON CONFLICT ("module")
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251208110420531-v3-0-0', "timestamp" = now();
    DO UPDATE SET "version" = '20251208110420531-v3-0-0', "timestamp" = now();


--
--
-- MIGRATION VERSION FOR serverpod_auth_core
-- MIGRATION VERSION FOR serverpod_auth_core
--
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20251208110412389-v3-0-0', now())
    VALUES ('serverpod_auth_core', '20251208110412389-v3-0-0', now())
    ON CONFLICT ("module")
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251208110412389-v3-0-0', "timestamp" = now();
    DO UPDATE SET "version" = '20251208110412389-v3-0-0', "timestamp" = now();




COMMIT;
COMMIT;
