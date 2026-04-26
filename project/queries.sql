-- Sample queries

-- ###################
-- User queries:
-- ###################

-- Create new user for Bob
INSERT INTO "users" ("email", "password")
VALUES ('bob@gmail.com', '0123456789');

-- Create new user for James
INSERT INTO "users" ("email", "password")
VALUES ('james@gmail.com', 'jamesistheman');

-- Read user credentials (maybe when loging in to compare with input credentials)
SELECT "email", "password" FROM "users" WHERE "id" = 1;

-- Ban user
UPDATE "users" SET "banned" = ('true')
WHERE "id" = 1;

-- Delete user
-- Delete all references to this user id
-- Delete all rows related to the user in the other tables
-- Delete row in users table


-- ###################
-- Players queries:
-- ###################

-- Create new player
INSERT INTO "players" ("user_id", "first_name", "last_name", "shirt_number", "position", "birth_country", "birth_state", "birth_year")
VALUES (1, 'Bob', 'Ross', 10, 'Midfield', 'United States', 'Florida', 1942);

-- Read player info
SELECT * FROM "players" WHERE "user_id" = 1;

-- Update position
UPDATE "players" SET "position" = ('Forward')
WHERE "user_id" = 1;

-- Update shirt number
UPDATE "players" SET "shirt_number" = 22
WHERE "user_id" = 1;

-- Update last game
/*UPDATE "players" SET "last_game" = (
SELECT MAX(creation_timestamp) FROM "matches"
WHERE ""
) WHERE "user_id" = 1;*/


-- ###################
-- Trainers queries:
-- ###################

-- Create new trainer
INSERT INTO "trainers" ("user_id", "first_name", "last_name", "birth_country", "birth_state", "birth_year")
VALUES (1, 'Bob', 'Ross', 'United States', 'Florida', 1942);


-- ###################
-- Referees queries:
-- ###################

-- Create new referee
INSERT INTO "referees" ("user_id", "first_name", "last_name", "birth_country", "birth_state", "birth_year")
VALUES (1, 'Bob', 'Ross', 'United States', 'Florida', 1942);

-- ###################
-- Teams queries:
-- ###################

-- Create new team
INSERT INTO "teams" ("name", "bio", "foundation_year", "primary_color", "secondary_color")
VALUES ('Bobs team', 'Team started by the legendary Bob Ross', 1960, 'Green', 'Blue');

-- ###################
-- Teams_players joining queries:
-- ###################

-- Add player to team
INSERT INTO "teams_players" ("player_id", "team_id")
VALUES (1, 1);

-- Show all players in a team
SELECT "team_id", "teams"."name", "player_id", "first_name", "last_name"
FROM "teams_players" 
JOIN "players" ON "players"."id" = "teams_players"."player_id"
JOIN "teams" ON "teams"."id" = "teams_players"."team_id"
WHERE "team_id" = 1;

-- Show all teams a player is in
SELECT "team_id", "teams"."name", "player_id", "first_name", "last_name"
FROM "teams_players" 
JOIN "players" ON "players"."id" = "teams_players"."player_id"
JOIN "teams" ON "teams"."id" = "teams_players"."team_id"
WHERE "player_id" = 1; 

-- Remove player from team
DELETE FROM "teams_players" 
WHERE "player_id" = 1 AND "team_id" = 1; 

-- ###################
-- Teams_trainers joining queries:
-- ###################

-- Add trainer to team
INSERT INTO "teams_trainers" ("trainer_id", "team_id")
VALUES (1, 1);

-- Show all trainers in a team
SELECT "team_id", "teams"."name", "trainer_id", "first_name", "last_name"
FROM "teams_trainers" 
JOIN "trainers" ON "trainers"."id" = "teams_trainers"."trainer_id"
JOIN "teams" ON "teams"."id" = "teams_trainers"."team_id"
WHERE "team_id" = 1;

-- Remove trainer from team
DELETE FROM "teams_trainers" 
WHERE "trainer_id" = 1 AND "team_id" = 1;

-- ###################
-- Teams_admins joining queries:
-- ###################

-- Add admin to team
INSERT INTO "teams_admins" ("user_id", "team_id")
VALUES (1, 1);

