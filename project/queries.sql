-- Sample queries

-- Seeding
-- run: rebuild_database.sh

-- Create their user account.
INSERT INTO "users" ("email", "password")
VALUES ('bob@gmail.com', '0123456789');

-- Register themselves as a player.
INSERT INTO "players" ("user_id", "first_name", "last_name", "birth_country", "birth_state", "birth_year")
VALUES (
    (SELECT "id" FROM "users" WHERE "email" = 'bob@gmail.com'), 
    'Bob', 'Ross', 'United States', 'Florida', 1942);

-- Create a team (automatically adds themselves to the team_admins table).
INSERT INTO "teams" ("name", "bio", "foundation_year", "is_active", "primary_color", "secondary_color")
VALUES ('Bobs team', 'Team started by the legendary Bob Ross', 1960, 'true', 'Green', 'Blue');

--INSERT INTO "teams_admins"

-- Add other players to their team.
-- Add trainers to their team.
-- Add other administrators to their team.
-- Create a league (automatically adds themselves to the leagues_admins table).
-- Create a tournament.
-- Add teams to the tournament.
-- Create a match.
-- Add referees to the match through the matches_referees table.
-- Register a goal in the match_events table (updates the score on the matches table)