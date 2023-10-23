
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

CREATE EXTENSION IF NOT EXISTS "pgsodium" WITH SCHEMA "pgsodium";

CREATE EXTENSION IF NOT EXISTS "pg_graphql" WITH SCHEMA "graphql";

CREATE EXTENSION IF NOT EXISTS "pg_stat_statements" WITH SCHEMA "extensions";

CREATE EXTENSION IF NOT EXISTS "pgcrypto" WITH SCHEMA "extensions";

CREATE EXTENSION IF NOT EXISTS "pgjwt" WITH SCHEMA "extensions";

CREATE EXTENSION IF NOT EXISTS "supabase_vault" WITH SCHEMA "vault";

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA "extensions";

CREATE TYPE "public"."fightOutcomeMethodEnum" AS ENUM (
    'draw',
    'no_contest',
    'decision',
    'knockout',
    'submission',
    'disqualification'
);

ALTER TYPE "public"."fightOutcomeMethodEnum" OWNER TO "postgres";

CREATE TYPE "public"."fighterSex" AS ENUM (
    'male',
    'female'
);

ALTER TYPE "public"."fighterSex" OWNER TO "postgres";

CREATE TYPE "public"."leagueJoinRequestStatusEnum" AS ENUM (
    'pending',
    'rejected',
    'accepted'
);

ALTER TYPE "public"."leagueJoinRequestStatusEnum" OWNER TO "postgres";

CREATE TYPE "public"."leaguePlayerRoleEnum" AS ENUM (
    'admin',
    'player'
);

ALTER TYPE "public"."leaguePlayerRoleEnum" OWNER TO "postgres";

CREATE TYPE "public"."playerRoleEnum" AS ENUM (
    'admin',
    'player'
);

ALTER TYPE "public"."playerRoleEnum" OWNER TO "postgres";

SET default_tablespace = '';

SET default_table_access_method = "heap";

CREATE TABLE IF NOT EXISTS "public"."fight" (
    "id" bigint NOT NULL,
    "fighter1Id" bigint NOT NULL,
    "fighter2Id" bigint NOT NULL,
    "rounds" smallint DEFAULT 3 NOT NULL,
    "sex" "text" NOT NULL,
    "weight" smallint NOT NULL,
    "isCanceled" boolean DEFAULT false NOT NULL,
    "createdAt" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "createdBy" bigint NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "fightCardId" bigint NOT NULL
);

ALTER TABLE "public"."fight" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "public"."fightCard" (
    "id" bigint NOT NULL,
    "mainCardStartsAt" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "name" bigint NOT NULL,
    "createdAt" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "createdBy" bigint NOT NULL
);

ALTER TABLE "public"."fightCard" OWNER TO "postgres";

ALTER TABLE "public"."fightCard" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."fightCard_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

CREATE TABLE IF NOT EXISTS "public"."fightOutcome" (
    "id" bigint NOT NULL,
    "method" "public"."fightOutcomeMethodEnum" NOT NULL,
    "round" smallint
);

ALTER TABLE "public"."fightOutcome" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "public"."fightOutcomeScore" (
    "id" bigint NOT NULL,
    "actFightOutcomeId" bigint NOT NULL,
    "predictedFightOutcomeId" bigint,
    "score" smallint NOT NULL
);

ALTER TABLE "public"."fightOutcomeScore" OWNER TO "postgres";

ALTER TABLE "public"."fightOutcomeScore" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."fightOutcomeScore_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE "public"."fightOutcome" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."fightOutcome_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

CREATE TABLE IF NOT EXISTS "public"."fightPick" (
    "id" bigint NOT NULL,
    "fightId" bigint NOT NULL,
    "winningFighterId" bigint NOT NULL,
    "fightOutcomeId" bigint NOT NULL,
    "playerId" bigint NOT NULL,
    "confidence" smallint NOT NULL,
    "createdAt" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "createdBy" bigint NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "updatedBy" bigint NOT NULL
);

ALTER TABLE "public"."fightPick" OWNER TO "postgres";

ALTER TABLE "public"."fightPick" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."fightPick_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

CREATE TABLE IF NOT EXISTS "public"."fightResult" (
    "id" bigint NOT NULL,
    "winningFighterId" bigint NOT NULL,
    "fightId" bigint NOT NULL,
    "fightOutcomeId" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "createdBy" bigint NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "updatedBy" bigint NOT NULL
);

ALTER TABLE "public"."fightResult" OWNER TO "postgres";

ALTER TABLE "public"."fightResult" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."fightResult_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE "public"."fight" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."fight_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

CREATE TABLE IF NOT EXISTS "public"."fighter" (
    "id" bigint NOT NULL,
    "name" "text" NOT NULL,
    "createdAt" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "createdBy" bigint NOT NULL
);

ALTER TABLE "public"."fighter" OWNER TO "postgres";

ALTER TABLE "public"."fighter" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."fighter_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

CREATE TABLE IF NOT EXISTS "public"."league" (
    "id" bigint NOT NULL,
    "name" "text" NOT NULL,
    "description" "text" NOT NULL,
    "createdAt" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "updatedBy" bigint NOT NULL,
    "createdBy" bigint NOT NULL
);

ALTER TABLE "public"."league" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "public"."leagueJoinRequest" (
    "id" bigint NOT NULL,
    "leagueId" bigint NOT NULL,
    "status" "public"."leagueJoinRequestStatusEnum" DEFAULT 'pending'::"public"."leagueJoinRequestStatusEnum" NOT NULL,
    "statusUpdatedAt" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "statusUpdatedBy" bigint NOT NULL,
    "createdAt" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "createdBy" bigint NOT NULL
);

ALTER TABLE "public"."leagueJoinRequest" OWNER TO "postgres";

ALTER TABLE "public"."leagueJoinRequest" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."leagueJoinRequest_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

CREATE TABLE IF NOT EXISTS "public"."leaguePlayer" (
    "id" bigint NOT NULL,
    "leagueId" bigint NOT NULL,
    "playerId" bigint NOT NULL,
    "role" "public"."leaguePlayerRoleEnum" NOT NULL,
    "createdAt" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "createdBy" bigint NOT NULL
);

ALTER TABLE "public"."leaguePlayer" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "public"."leaguePlayerHistory" (
    "id" bigint NOT NULL,
    "leaguePlayerId" bigint NOT NULL,
    "createdAt" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "createdBy" bigint NOT NULL,
    "type" "text" NOT NULL
);

ALTER TABLE "public"."leaguePlayerHistory" OWNER TO "postgres";

ALTER TABLE "public"."leaguePlayerHistory" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."leaguePlayerHistory_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE "public"."leaguePlayer" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."leaguePlayer_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE "public"."league" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."league_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

CREATE TABLE IF NOT EXISTS "public"."player" (
    "id" bigint NOT NULL,
    "uid" "text" NOT NULL,
    "displayName" "text" NOT NULL,
    "createdAt" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL
);

ALTER TABLE "public"."player" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "public"."playerRole" (
    "id" bigint NOT NULL,
    "playerId" bigint NOT NULL,
    "role" "public"."playerRoleEnum" NOT NULL,
    "createdAt" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "createdBy" bigint NOT NULL
);

ALTER TABLE "public"."playerRole" OWNER TO "postgres";

ALTER TABLE "public"."playerRole" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."playerRole_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE "public"."player" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."player_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY "public"."fightCard"
    ADD CONSTRAINT "fightCard_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."fightOutcomeScore"
    ADD CONSTRAINT "fightOutcomeScore_actFightOutcomeId_predictedFightOutcomeId_key" UNIQUE NULLS NOT DISTINCT ("actFightOutcomeId") INCLUDE ("predictedFightOutcomeId");

ALTER TABLE ONLY "public"."fightOutcomeScore"
    ADD CONSTRAINT "fightOutcomeScore_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."fightOutcome"
    ADD CONSTRAINT "fightOutcome_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."fightPick"
    ADD CONSTRAINT "fightPick_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."fightResult"
    ADD CONSTRAINT "fightResult_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."fight"
    ADD CONSTRAINT "fight_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."fighter"
    ADD CONSTRAINT "fighter_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."leagueJoinRequest"
    ADD CONSTRAINT "leagueJoinRequest_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."leaguePlayerHistory"
    ADD CONSTRAINT "leaguePlayerHistory_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."leaguePlayer"
    ADD CONSTRAINT "leaguePlayer_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."league"
    ADD CONSTRAINT "league_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."playerRole"
    ADD CONSTRAINT "playerRole_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."player"
    ADD CONSTRAINT "player_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."fightCard"
    ADD CONSTRAINT "fightCard_createdBy_fkey" FOREIGN KEY ("createdBy") REFERENCES "public"."player"("id");

ALTER TABLE ONLY "public"."fightOutcomeScore"
    ADD CONSTRAINT "fightOutcomeScore_actFightOutcomeId_fkey" FOREIGN KEY ("actFightOutcomeId") REFERENCES "public"."fightOutcome"("id");

ALTER TABLE ONLY "public"."fightOutcomeScore"
    ADD CONSTRAINT "fightOutcomeScore_predictedFightOutcomeId_fkey" FOREIGN KEY ("predictedFightOutcomeId") REFERENCES "public"."fightOutcome"("id");

ALTER TABLE ONLY "public"."fightPick"
    ADD CONSTRAINT "fightPick_createdBy_fkey" FOREIGN KEY ("createdBy") REFERENCES "public"."player"("id");

ALTER TABLE ONLY "public"."fightPick"
    ADD CONSTRAINT "fightPick_fightId_fkey" FOREIGN KEY ("fightId") REFERENCES "public"."fight"("id");

ALTER TABLE ONLY "public"."fightPick"
    ADD CONSTRAINT "fightPick_fightOutcomeId_fkey" FOREIGN KEY ("fightOutcomeId") REFERENCES "public"."fightOutcome"("id");

ALTER TABLE ONLY "public"."fightPick"
    ADD CONSTRAINT "fightPick_playerId_fkey" FOREIGN KEY ("playerId") REFERENCES "public"."player"("id");

ALTER TABLE ONLY "public"."fightPick"
    ADD CONSTRAINT "fightPick_updatedBy_fkey" FOREIGN KEY ("updatedBy") REFERENCES "public"."player"("id");

ALTER TABLE ONLY "public"."fightPick"
    ADD CONSTRAINT "fightPick_winningFighterId_fkey" FOREIGN KEY ("winningFighterId") REFERENCES "public"."fighter"("id");

ALTER TABLE ONLY "public"."fightResult"
    ADD CONSTRAINT "fightResult_createdBy_fkey" FOREIGN KEY ("createdBy") REFERENCES "public"."player"("id");

ALTER TABLE ONLY "public"."fightResult"
    ADD CONSTRAINT "fightResult_fightId_fkey" FOREIGN KEY ("fightId") REFERENCES "public"."fight"("id");

ALTER TABLE ONLY "public"."fightResult"
    ADD CONSTRAINT "fightResult_fightOutcomeId_fkey" FOREIGN KEY ("fightOutcomeId") REFERENCES "public"."fightOutcome"("id");

ALTER TABLE ONLY "public"."fightResult"
    ADD CONSTRAINT "fightResult_updatedBy_fkey" FOREIGN KEY ("updatedBy") REFERENCES "public"."player"("id");

ALTER TABLE ONLY "public"."fightResult"
    ADD CONSTRAINT "fightResult_winningFighterId_fkey" FOREIGN KEY ("winningFighterId") REFERENCES "public"."fighter"("id");

ALTER TABLE ONLY "public"."fight"
    ADD CONSTRAINT "fight_createdBy_fkey" FOREIGN KEY ("createdBy") REFERENCES "public"."player"("id");

ALTER TABLE ONLY "public"."fight"
    ADD CONSTRAINT "fight_fightCardId_fkey" FOREIGN KEY ("fightCardId") REFERENCES "public"."fightCard"("id");

ALTER TABLE ONLY "public"."fight"
    ADD CONSTRAINT "fight_fighter1Id_fkey" FOREIGN KEY ("fighter1Id") REFERENCES "public"."fighter"("id");

ALTER TABLE ONLY "public"."fight"
    ADD CONSTRAINT "fight_fighter2Id_fkey" FOREIGN KEY ("fighter2Id") REFERENCES "public"."fighter"("id");

ALTER TABLE ONLY "public"."fighter"
    ADD CONSTRAINT "fighter_createdBy_fkey" FOREIGN KEY ("createdBy") REFERENCES "public"."player"("id");

ALTER TABLE ONLY "public"."leagueJoinRequest"
    ADD CONSTRAINT "leagueJoinRequest_createdBy_fkey" FOREIGN KEY ("createdBy") REFERENCES "public"."player"("id");

ALTER TABLE ONLY "public"."leagueJoinRequest"
    ADD CONSTRAINT "leagueJoinRequest_leagueId_fkey" FOREIGN KEY ("leagueId") REFERENCES "public"."league"("id");

ALTER TABLE ONLY "public"."leagueJoinRequest"
    ADD CONSTRAINT "leagueJoinRequest_statusUpdatedBy_fkey" FOREIGN KEY ("statusUpdatedBy") REFERENCES "public"."player"("id");

ALTER TABLE ONLY "public"."leaguePlayerHistory"
    ADD CONSTRAINT "leaguePlayerHistory_createdBy_fkey" FOREIGN KEY ("createdBy") REFERENCES "public"."player"("id");

ALTER TABLE ONLY "public"."leaguePlayerHistory"
    ADD CONSTRAINT "leaguePlayerHistory_leaguePlayerId_fkey" FOREIGN KEY ("leaguePlayerId") REFERENCES "public"."leaguePlayer"("id");

ALTER TABLE ONLY "public"."leaguePlayer"
    ADD CONSTRAINT "leaguePlayer_createdBy_fkey" FOREIGN KEY ("createdBy") REFERENCES "public"."player"("id");

ALTER TABLE ONLY "public"."leaguePlayer"
    ADD CONSTRAINT "leaguePlayer_leagueId_fkey" FOREIGN KEY ("leagueId") REFERENCES "public"."league"("id");

ALTER TABLE ONLY "public"."leaguePlayer"
    ADD CONSTRAINT "leaguePlayer_playerId_fkey" FOREIGN KEY ("playerId") REFERENCES "public"."player"("id");

ALTER TABLE ONLY "public"."league"
    ADD CONSTRAINT "league_createdBy_fkey" FOREIGN KEY ("createdBy") REFERENCES "public"."player"("id");

ALTER TABLE ONLY "public"."league"
    ADD CONSTRAINT "league_updatedBy_fkey" FOREIGN KEY ("updatedBy") REFERENCES "public"."player"("id");

ALTER TABLE ONLY "public"."playerRole"
    ADD CONSTRAINT "playerRole_createdBy_fkey" FOREIGN KEY ("createdBy") REFERENCES "public"."player"("id");

ALTER TABLE ONLY "public"."playerRole"
    ADD CONSTRAINT "playerRole_playerId_fkey" FOREIGN KEY ("playerId") REFERENCES "public"."player"("id");

REVOKE USAGE ON SCHEMA "public" FROM PUBLIC;
GRANT USAGE ON SCHEMA "public" TO "postgres";
GRANT USAGE ON SCHEMA "public" TO "anon";
GRANT USAGE ON SCHEMA "public" TO "authenticated";
GRANT USAGE ON SCHEMA "public" TO "service_role";

GRANT ALL ON TABLE "public"."fight" TO "anon";
GRANT ALL ON TABLE "public"."fight" TO "authenticated";
GRANT ALL ON TABLE "public"."fight" TO "service_role";

GRANT ALL ON TABLE "public"."fightCard" TO "anon";
GRANT ALL ON TABLE "public"."fightCard" TO "authenticated";
GRANT ALL ON TABLE "public"."fightCard" TO "service_role";

GRANT ALL ON SEQUENCE "public"."fightCard_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."fightCard_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."fightCard_id_seq" TO "service_role";

GRANT ALL ON TABLE "public"."fightOutcome" TO "anon";
GRANT ALL ON TABLE "public"."fightOutcome" TO "authenticated";
GRANT ALL ON TABLE "public"."fightOutcome" TO "service_role";

GRANT ALL ON TABLE "public"."fightOutcomeScore" TO "anon";
GRANT ALL ON TABLE "public"."fightOutcomeScore" TO "authenticated";
GRANT ALL ON TABLE "public"."fightOutcomeScore" TO "service_role";

GRANT ALL ON SEQUENCE "public"."fightOutcomeScore_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."fightOutcomeScore_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."fightOutcomeScore_id_seq" TO "service_role";

GRANT ALL ON SEQUENCE "public"."fightOutcome_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."fightOutcome_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."fightOutcome_id_seq" TO "service_role";

GRANT ALL ON TABLE "public"."fightPick" TO "anon";
GRANT ALL ON TABLE "public"."fightPick" TO "authenticated";
GRANT ALL ON TABLE "public"."fightPick" TO "service_role";

GRANT ALL ON SEQUENCE "public"."fightPick_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."fightPick_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."fightPick_id_seq" TO "service_role";

GRANT ALL ON TABLE "public"."fightResult" TO "anon";
GRANT ALL ON TABLE "public"."fightResult" TO "authenticated";
GRANT ALL ON TABLE "public"."fightResult" TO "service_role";

GRANT ALL ON SEQUENCE "public"."fightResult_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."fightResult_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."fightResult_id_seq" TO "service_role";

GRANT ALL ON SEQUENCE "public"."fight_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."fight_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."fight_id_seq" TO "service_role";

GRANT ALL ON TABLE "public"."fighter" TO "anon";
GRANT ALL ON TABLE "public"."fighter" TO "authenticated";
GRANT ALL ON TABLE "public"."fighter" TO "service_role";

GRANT ALL ON SEQUENCE "public"."fighter_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."fighter_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."fighter_id_seq" TO "service_role";

GRANT ALL ON TABLE "public"."league" TO "anon";
GRANT ALL ON TABLE "public"."league" TO "authenticated";
GRANT ALL ON TABLE "public"."league" TO "service_role";

GRANT ALL ON TABLE "public"."leagueJoinRequest" TO "anon";
GRANT ALL ON TABLE "public"."leagueJoinRequest" TO "authenticated";
GRANT ALL ON TABLE "public"."leagueJoinRequest" TO "service_role";

GRANT ALL ON SEQUENCE "public"."leagueJoinRequest_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."leagueJoinRequest_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."leagueJoinRequest_id_seq" TO "service_role";

GRANT ALL ON TABLE "public"."leaguePlayer" TO "anon";
GRANT ALL ON TABLE "public"."leaguePlayer" TO "authenticated";
GRANT ALL ON TABLE "public"."leaguePlayer" TO "service_role";

GRANT ALL ON TABLE "public"."leaguePlayerHistory" TO "anon";
GRANT ALL ON TABLE "public"."leaguePlayerHistory" TO "authenticated";
GRANT ALL ON TABLE "public"."leaguePlayerHistory" TO "service_role";

GRANT ALL ON SEQUENCE "public"."leaguePlayerHistory_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."leaguePlayerHistory_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."leaguePlayerHistory_id_seq" TO "service_role";

GRANT ALL ON SEQUENCE "public"."leaguePlayer_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."leaguePlayer_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."leaguePlayer_id_seq" TO "service_role";

GRANT ALL ON SEQUENCE "public"."league_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."league_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."league_id_seq" TO "service_role";

GRANT ALL ON TABLE "public"."player" TO "anon";
GRANT ALL ON TABLE "public"."player" TO "authenticated";
GRANT ALL ON TABLE "public"."player" TO "service_role";

GRANT ALL ON TABLE "public"."playerRole" TO "anon";
GRANT ALL ON TABLE "public"."playerRole" TO "authenticated";
GRANT ALL ON TABLE "public"."playerRole" TO "service_role";

GRANT ALL ON SEQUENCE "public"."playerRole_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."playerRole_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."playerRole_id_seq" TO "service_role";

GRANT ALL ON SEQUENCE "public"."player_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."player_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."player_id_seq" TO "service_role";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "service_role";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "service_role";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "service_role";

RESET ALL;
