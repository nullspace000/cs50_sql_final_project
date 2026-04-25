-- users
CREATE TEMP TABLE "temp" ("email" TEXT, "password" TEXT);
.mode csv
.import --skip 1 seeding/users_seed.csv temp
INSERT INTO "users" ("email", "password")
SELECT "email", "password" FROM "temp";
DROP TABLE "temp";

-- players
CREATE TEMP TABLE "temp" ("user_id" INT, "first_name" TEXT, "last_name" TEXT, "birth_country" TEXT, "birth_state" TEXT, "birth_year" INT);
.mode csv
.import --skip 1 seeding/players_seed.csv temp
INSERT INTO "players" ("user_id", "first_name", "last_name", "birth_country", "birth_state", "birth_year")
SELECT "user_id", "first_name", "last_name", "birth_country", "birth_state", "birth_year" FROM "temp";
DROP TABLE "temp";

-- trainers
CREATE TEMP TABLE "temp" ("user_id" INT, "first_name" TEXT, "last_name" TEXT, "birth_country" TEXT, "birth_state" TEXT, "birth_year" INT);
.mode csv
.import --skip 1 seeding/trainers_seed.csv temp
INSERT INTO "trainers" ("user_id", "first_name", "last_name", "birth_country", "birth_state", "birth_year")
SELECT "user_id", "first_name", "last_name", "birth_country", "birth_state", "birth_year" FROM "temp";
DROP TABLE "temp";

-- referees
CREATE TEMP TABLE "temp" ("user_id" INT, "first_name" TEXT, "last_name" TEXT, "birth_country" TEXT, "birth_state" TEXT, "birth_year" INT);
.mode csv
.import --skip 1 seeding/referees_seed.csv temp
INSERT INTO "referees" ("user_id", "first_name", "last_name", "birth_country", "birth_state", "birth_year")
SELECT "user_id", "first_name", "last_name", "birth_country", "birth_state", "birth_year" FROM "temp";
DROP TABLE "temp";

--Teams
CREATE TEMP TABLE "temp" ("name" TEXT, "bio" TEXT, "foundation_year" INT, "primary_color" TEXT, "secondary_color" TEXT);
.mode csv
.import --skip 1 seeding/teams_seed.csv temp
INSERT INTO "teams" ("name", "bio", "foundation_year", "primary_color", "secondary_color")
SELECT * FROM "temp";
DROP TABLE "temp";

--teams_players
CREATE TEMP TABLE "temp" ("player_id" INTEGER, "team_id" INTEGER, "shirt_number" INTEGER, "position" TEXT);
.mode csv
.import --skip 1 seeding/teams_players_seed.csv temp
INSERT INTO "teams_players" ("player_id", "team_id", "shirt_number", "position")
SELECT * FROM "temp";
DROP TABLE "temp";

--teams_trainers
CREATE TEMP TABLE "temp" ("trainer_id" INTEGER, "team_id" INTEGER);
.mode csv
.import --skip 1 seeding/teams_trainers_seed.csv temp
INSERT INTO "teams_trainers" ("trainer_id", "team_id")
SELECT * FROM "temp";
DROP TABLE "temp";

--teams_admins
CREATE TEMP TABLE "temp" ("user_id" INTEGER, "team_id" INTEGER);
.mode csv
.import --skip 1 seeding/teams_admins_seed.csv temp
INSERT INTO "teams_admins" ("user_id", "team_id")
SELECT * FROM "temp";
DROP TABLE "temp";

-- leagues
CREATE TEMP TABLE "temp" ("name" TEXT, "description" TEXT, "location_general" TEXT);
.mode csv
.import --skip 1 seeding/leagues_seed.csv temp
INSERT INTO "leagues" ("name", "description", "location_general")
SELECT * FROM "temp";
DROP TABLE "temp";

-- leagues_admins
CREATE TEMP TABLE "temp" ("user_id" INTEGER, "league_id" INTEGER);
.mode csv
.import --skip 1 seeding/leagues_admins_seed.csv temp
INSERT INTO "leagues_admins" ("user_id", "league_id")
SELECT * FROM "temp";
DROP TABLE "temp";

-- tournaments
CREATE TEMP TABLE "temp" ("league_id" INTEGER, "name" TEXT, "status" TEXT, "season" INTEGER, "format" TEXT, "start_date" NUMERIC, "end_date" NUMERIC, "half_time" INTEGER, "max_teams" INTEGER, "entry_fee" NUMERIC, "points_per_win" INTEGER, "points_per_draw" INTEGER, "points_per_loss" INTEGER);
.mode csv
.import --skip 1 seeding/tournaments_seed.csv temp
INSERT INTO "tournaments" ("league_id", "name", "status", "season", "format", "start_date", "end_date", "half_time", "max_teams", "entry_fee", "points_per_win", "points_per_draw", "points_per_loss")
SELECT * FROM "temp";
DROP TABLE "temp";

-- tournament-teams
CREATE TEMP TABLE "temp" ("tournament_id" INTEGER, "team_id" INTEGER);
.mode csv
.import --skip 1 seeding/tournament_teams_seed.csv temp
INSERT INTO "tournaments" ("tournament_id",
"team_id")
SELECT * FROM "temp";
DROP TABLE "temp";