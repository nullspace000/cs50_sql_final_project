-- In this SQL file, write (and comment!) the schema of your database, including the CREATE TABLE, CREATE INDEX, CREATE VIEW, etc. statements that compose it

-- Represents users
CREATE TABLE "users" (
    "id" INTEGER,
    "email" TEXT NOT NULL UNIQUE,
    "password" TEXT NOT NULL CHECK(LENGTH("password") >= 10),
    "creation_timestamp" NUMERIC NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "banned" TEXT NOT NULL CHECK("banned" IN ('true', 'false')) DEFAULT 'false',
    PRIMARY KEY("id")
);

-- Represents players
CREATE TABLE "players" (
    "id" INTEGER,
    "user_id" INTEGER UNIQUE,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "birth_country" TEXT NOT NULL,
    "birth_state" TEXT NOT NULL,
    "birth_year" INTEGER NOT NULL,
    "last_game" INTEGER,
    "creation_timestamp" NUMERIC NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY("id"),
    FOREIGN KEY("user_id") REFERENCES "users"("id")
);

-- Represents trainers
CREATE TABLE "trainers" (
    "id" INTEGER,
    "user_id" INTEGER UNIQUE,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "birth_country" TEXT NOT NULL,
    "birth_state" TEXT NOT NULL,
    "birth_year" INTEGER NOT NULL,
    "creation_timestamp" NUMERIC NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY("id"),
    FOREIGN KEY("user_id") REFERENCES "users"("id")
);

-- Represents referees
CREATE TABLE "referees" (
    "id" INTEGER,
    "user_id" INTEGER,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "birth_country" TEXT NOT NULL,
    "birth_state" TEXT NOT NULL,
    "birth_year" INTEGER NOT NULL,
    "creation_timestamp" NUMERIC NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY("id"),
    FOREIGN KEY("user_id") REFERENCES "users"("id")
);

-- Represents teams
CREATE TABLE "teams" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "bio" TEXT NOT NULL,
    "foundation_year" NUMERIC NOT NULL,
    -- is_active will automatically be set to 'false' after two years of inactivity
    "is_active" INTEGER  NOT NULL CHECK ("is_active" IN ('true', 'false')) DEFAULT 'true',
    "primary_color" TEXT NOT NULL,
    "secondary_color" TEXT NOT NULL,
    "creation_timestamp" NUMERIC NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY("id")
);

-- Players and teams joining table.
-- Because a player could be in multiple teams and teams have multiple players.
CREATE TABLE "teams_players" (
    "player_id" INTEGER,
    "team_id" INTEGER,
    "shirt_number" INTEGER NOT NULL,
    "position" TEXT NOT NULL CHECK("position" IN ('Goalkeeper', 'Defender', 'Midfielder', 'Forward')),
    -- "team_id" is first in the primary key so that the index is created for "team_id"
    PRIMARY KEY("team_id", "player_id"),
    FOREIGN KEY("player_id") REFERENCES "players"("id"),
    FOREIGN KEY("team_id") REFERENCES "teams"("id")
);

-- Trainers and teams joining table.
-- Because a trainer could be in multiple teams and teams can have multiple trainers
CREATE TABLE "teams_trainers" (
    "trainer_id" INTEGER,
    "team_id" INTEGER,
    PRIMARY KEY("team_id", "trainer_id"),
    FOREIGN KEY("trainer_id") REFERENCES "trainer"("id"),
    FOREIGN KEY("team_id") REFERENCES "teams"("id")
);

-- Teams and administrator accounts joining table
CREATE TABLE "teams_admins" (
    "user_id" INTEGER,
    "team_id" INTEGER,
    PRIMARY KEY("team_id", "user_id"),
    FOREIGN KEY("user_id") REFERENCES "users"("id"),
    FOREIGN KEY("team_id") REFERENCES "teams"("id")
);

-- Represents matches
CREATE TABLE "matches" (
    "id" INTEGER,
    "tournament_id" INTEGER,
    "team_a_id" INTEGER NOT NULL,
    "team_b_id" INTEGER NOT NULL,
    "location" TEXT NOT NULL,
    "date" NUMERIC NOT NULL,
    -- remember to set scores to 0 when match_status changes to 'Ongoing'
    "status" TEXT NOT NULL CHECK ("status" IN ('Scheduled', 'Ongoing', 'Finished', 'Postponed')) DEFAULT 'Scheduled',
    "score_team_a" INTEGER,
    "score_team_b" INTEGER,
    "creation_timestamp" NUMERIC NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY("id"),
    FOREIGN KEY("tournament_id") REFERENCES "tournaments"("id"),
    FOREIGN KEY("team_a_id") REFERENCES "teams"("id"),
    FOREIGN KEY("team_b_id") REFERENCES "teams"("id")
);

-- Represents match events
CREATE TABLE "match_events" (
    "id" INTEGER,
    "player_id" INTEGER,
    "team_id" INTEGER,
    "event_type" TEXT NOT NULL CHECK("event_type" IN ('goal', 'fault', 'yellow_card', 'red_card')),
    "creation_timestamp" NUMERIC NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY("id"),
    FOREIGN KEY("team_id") REFERENCES "teams"("id"),
    FOREIGN KEY("player_id") REFERENCES "players"("id")
);

-- Represents tournaments
CREATE TABLE "tournaments" (
    "id" INTEGER,
    "league_id" INTEGER,
    "name" TEXT NOT NULL,
    "status" TEXT NOT NULL CHECK ("status" IN ('Scheduled', 'Ongoing', 'Finished', 'Postponed')) DEFAULT 'Scheduled',
    "season" INTEGER,
    "format" TEXT NOT NULL CHECK ("format" IN ('Knockout', 'Round Robin', 'Groups')) DEFAULT 'Knockout',
    "start_date" NUMERIC NOT NULL,
    "end_date" NUMERIC NOT NULL,
    "half_time" INTEGER NOT NULL DEFAULT 45,
    "max_teams" INTEGER NOT NULL,
    "entry_fee" NUMERIC,
    "points_per_win" INTEGER DEFAULT 3,
    "points_per_draw" INTEGER DEFAULT 1,
    "points_per_loss" INTEGER DEFAULT 0,
    "creation_timestamp" NUMERIC NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY("id"),
    FOREIGN KEY("league_id") REFERENCES "leagues"("id")
);

-- Leagues
CREATE TABLE "leagues" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "location_general" TEXT NOT NULL,
    "creation_timestamp" NUMERIC NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY("id")
);

-- Leagues and administrator accounts joining table
CREATE TABLE "leagues_admins" (
    "user_id" INTEGER,
    "league_id" INTEGER,
    PRIMARY KEY("league_id", "user_id"),
    FOREIGN KEY("user_id") REFERENCES "users"("id"),
    FOREIGN KEY("league_id") REFERENCES "leagues"("id")
);

-- Matches and referees joining table
CREATE TABLE "matches_referees" (
    "referee_id" INTEGER,
    "match_id" INTEGER,
    PRIMARY KEY("match_id", "referee_id"),
    FOREIGN KEY("referee_id") REFERENCES "referees"("id"),
    FOREIGN KEY("match_id") REFERENCES "matches"("id")
);

-- Tournaments and teams joining table
CREATE TABLE "tournaments_teams" (
    "tournament_id" INTEGER,
    "team_id" INTEGER,
    PRIMARY KEY("tournament_id", "team_id"),
    FOREIGN KEY("tournament_id") REFERENCES "tournaments"("id"),
    FOREIGN KEY("team_id") REFERENCES "teams"("id")
);

-- ################
-- # Views ########
-- ################

-- matches_referees_view
-- Joining "teams" - "matches" - "matches_referees" - "referees"
CREATE VIEW "matches_referees_view" AS
SELECT
    "matches"."team_a_id",
    "team_a"."name"        AS "team_A",
    "matches"."team_b_id",
    "team_b"."name"        AS "team_B",
    "matches"."date",
    "matches"."location",
    "matches"."status",
    "referees"."first_name",
    "referees"."last_name"
FROM "matches_referees"
JOIN "matches"  ON  "matches_referees"."match_id"   = "matches"."id"
JOIN "teams" AS "team_a" ON "matches"."team_a_id"   = "team_a"."id"
JOIN "teams" AS "team_b" ON "matches"."team_b_id"   = "team_b"."id"
JOIN "referees" ON "matches_referees"."referee_id"  = "referees"."id";

-- teams_players_view
-- Joing teams - teams_players - players
CREATE VIEW "teams_players_view" AS
SELECT "teams"."name", 
"shirt_number", "position",
"players"."first_name", "players"."last_name", "players"."birth_country", "players"."birth_year"
FROM "teams_players"
JOIN "teams" ON "teams_players"."team_id" = "teams"."id"
JOIN "players" ON "teams_players"."player_id" = "players"."id";

-- teams_trainers_view
-- Joing teams - teams_trainers - trainers
CREATE VIEW "teams_trainers_view" AS
SELECT "teams"."name", 
"trainers"."first_name", "trainers"."last_name", "trainers"."birth_country", "trainers"."birth_year"
FROM "teams_trainers"
JOIN "teams" ON "teams_trainers"."team_id" = "teams"."id"
JOIN "trainers" ON "teams_trainers"."trainer_id" = "trainers"."id";

-- teams_admins_view
-- Joining teams - teams_admins - users
CREATE VIEW "teams_admins_view" AS
SELECT "teams"."name", "users"."email"
FROM "teams_admins"
JOIN "teams" ON "teams_admins"."team_id" = "teams"."id"
JOIN "users" ON "teams_admins"."user_id" = "users"."id";

-- leagues_admins_view
-- Joining leagues - leagues_admins - users
CREATE VIEW "leagues_admins_view" AS
SELECT "leagues"."name", "users"."email"
FROM "leagues_admins"
JOIN "leagues" ON "leagues_admins"."league_id" = "leagues"."id"
JOIN "users" ON "leagues_admins"."user_id" = "users"."id";

-- tournaments_teams_view
-- Joining tournaments - tournaments_teams - teams
CREATE VIEW "tournaments_teams_view" AS
SELECT "tournaments"."name", "tournaments"."status", "tournaments"."season", "tournaments"."format", "tournaments"."start_date", "tournaments"."end_date", "tournaments"."max_teams",
"teams"."name", "teams"."foundation_year"
FROM "tournaments_teams"
JOIN "tournaments" ON "tournaments_teams"."tournament_id" = "tournaments"."id"
JOIN "teams" ON "tournaments_teams"."team_id" = "teams"."id";
 