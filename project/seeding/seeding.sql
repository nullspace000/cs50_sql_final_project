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
CREATE TEMP TABLE "temp" (name TEXT, "bio" TEXT, "foundation_year" INT, "primary_color" TEXT, "secondary_color" TEXT);
.mode csv
.import --skip 1 seeding/teams_seed.csv temp
INSERT INTO "teams" ("name", "bio", "foundation_year", "primary_color", "secondary_color")
SELECT * FROM "temp";
DROP TABLE "temp";
