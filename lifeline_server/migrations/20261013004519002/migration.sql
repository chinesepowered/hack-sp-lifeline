BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "alert" (
    "id" bigserial PRIMARY KEY,
    "circleId" bigint NOT NULL,
    "checkInId" bigint,
    "kind" text NOT NULL,
    "level" text NOT NULL,
    "title" text NOT NULL,
    "detail" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "acknowledgedAt" timestamp without time zone,
    "acknowledgedByName" text,
    "resolvedAt" timestamp without time zone,
    "resolvedByName" text
);

-- Indexes
CREATE INDEX "alert_circle_idx" ON "alert" USING btree ("circleId", "resolvedAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "check_in" (
    "id" bigserial PRIMARY KEY,
    "circleId" bigint NOT NULL,
    "kind" text NOT NULL,
    "slotId" bigint,
    "scheduledFor" timestamp without time zone NOT NULL,
    "promptedAt" timestamp without time zone NOT NULL,
    "promptText" text NOT NULL,
    "status" text NOT NULL,
    "escalationStage" bigint NOT NULL DEFAULT 0,
    "respondedAt" timestamp without time zone,
    "responseMethod" text,
    "transcript" text,
    "triageLevel" text,
    "triageReasons" json
);

-- Indexes
CREATE INDEX "check_in_circle_prompted_idx" ON "check_in" USING btree ("circleId", "promptedAt");
CREATE UNIQUE INDEX "check_in_occurrence_idx" ON "check_in" USING btree ("circleId", "scheduledFor");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "check_in_slot" (
    "id" bigserial PRIMARY KEY,
    "circleId" bigint NOT NULL,
    "minuteOfDay" bigint NOT NULL,
    "label" text NOT NULL
);

-- Indexes
CREATE INDEX "check_in_slot_circle_idx" ON "check_in_slot" USING btree ("circleId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "circle" (
    "id" bigserial PRIMARY KEY,
    "lovedOneName" text NOT NULL,
    "voiceId" text NOT NULL,
    "utcOffsetMinutes" bigint NOT NULL,
    "graceSeconds" bigint NOT NULL,
    "secondGraceSeconds" bigint NOT NULL,
    "pairingCode" text NOT NULL,
    "inviteCode" text NOT NULL,
    "status" text NOT NULL DEFAULT 'quiet'::text,
    "statusChangedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "isDemo" boolean NOT NULL DEFAULT false,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "circle_pairing_code_idx" ON "circle" USING btree ("pairingCode");
CREATE UNIQUE INDEX "circle_invite_code_idx" ON "circle" USING btree ("inviteCode");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "circle_event" (
    "id" bigserial PRIMARY KEY,
    "circleId" bigint NOT NULL,
    "kind" text NOT NULL,
    "title" text NOT NULL,
    "detail" text,
    "actorName" text,
    "checkInId" bigint,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "circle_event_circle_idx" ON "circle_event" USING btree ("circleId", "createdAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "circle_member" (
    "id" bigserial PRIMARY KEY,
    "circleId" bigint NOT NULL,
    "userIdentifier" text,
    "displayName" text NOT NULL,
    "relationship" text,
    "role" text NOT NULL,
    "joinedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "circle_member_unique_idx" ON "circle_member" USING btree ("circleId", "userIdentifier");
CREATE INDEX "circle_member_user_idx" ON "circle_member" USING btree ("userIdentifier");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "companion_device" (
    "id" bigserial PRIMARY KEY,
    "circleId" bigint NOT NULL,
    "tokenHash" text,
    "label" text NOT NULL,
    "pairedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "lastSeenAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "companion_device_token_idx" ON "companion_device" USING btree ("tokenHash");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "utterance" (
    "id" bigserial PRIMARY KEY,
    "circleId" bigint NOT NULL,
    "kind" text NOT NULL,
    "text" text NOT NULL,
    "audioPath" text,
    "fromName" text,
    "checkInId" bigint,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "utterance_circle_idx" ON "utterance" USING btree ("circleId", "createdAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "voice_clip" (
    "id" bigserial PRIMARY KEY,
    "hash" text NOT NULL,
    "voiceId" text NOT NULL,
    "modelId" text NOT NULL,
    "text" text NOT NULL,
    "storagePath" text NOT NULL,
    "byteLength" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "voice_clip_hash_idx" ON "voice_clip" USING btree ("hash");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "alert"
    ADD CONSTRAINT "alert_fk_0"
    FOREIGN KEY("circleId")
    REFERENCES "circle"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "check_in"
    ADD CONSTRAINT "check_in_fk_0"
    FOREIGN KEY("circleId")
    REFERENCES "circle"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "check_in_slot"
    ADD CONSTRAINT "check_in_slot_fk_0"
    FOREIGN KEY("circleId")
    REFERENCES "circle"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "circle_event"
    ADD CONSTRAINT "circle_event_fk_0"
    FOREIGN KEY("circleId")
    REFERENCES "circle"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "circle_member"
    ADD CONSTRAINT "circle_member_fk_0"
    FOREIGN KEY("circleId")
    REFERENCES "circle"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "companion_device"
    ADD CONSTRAINT "companion_device_fk_0"
    FOREIGN KEY("circleId")
    REFERENCES "circle"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "utterance"
    ADD CONSTRAINT "utterance_fk_0"
    FOREIGN KEY("circleId")
    REFERENCES "circle"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR lifeline
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('lifeline', '20261013004519002', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261013004519002', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260824182259319', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182259319', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260924105404509', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260924105404509', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260924105232991', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260924105232991', "timestamp" = now();


COMMIT;
