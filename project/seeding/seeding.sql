-- users table seeding:
-- sqlite> .import --csv seeding/users_seed.csv temp
INSERT INTO "users" ("email", "password")
SELECT "email", "password" FROM "temp";
DROP TABLE "temp";

-- players table seeding:
-- sqlite> .import --csv seeding/players_seed.csv temp
INSERT INTO "players" ("user_id", "first_name", "last_name", "birth_country", "birth_state", "birth_year")
SELECT "user_id", "first_name", "last_name", "birth_country", "birth_state", "birth_year" FROM "temp";
DROP TABLE "temp";

-- trainers table seeding:
-- sqlite> .import --csv seeding/trainers_seed.csv temp
INSERT INTO "trainers" ("user_id", "first_name", "last_name", "birth_country", "birth_state", "birth_year")
SELECT "user_id", "first_name", "last_name", "birth_country", "birth_state", "birth_year" FROM "temp";
DROP TABLE "temp";