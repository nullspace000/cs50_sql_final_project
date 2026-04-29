-- Sample queries

-- To test queries, run: "rebuild_database.sh" beforehand to build and seed the database.

-- * Users should be able to:
-- Hypothetical: Bob Ross happeded to be an avid soccer player.

-- * Create their user account.
-- Example: Bob creates his user account.
INSERT INTO "users" ("email", "password")
VALUES ('bob@gmail.com', '0123456789');

-- * Register themselves as a player.
-- Example: Bob registers themselves as a player.
INSERT INTO "players" ("user_id", "first_name", "last_name", "birth_country", "birth_state", "birth_year")
VALUES (
    (SELECT "id" FROM "users" WHERE "email" = 'bob@gmail.com'), 
    'Bob', 'Ross', 'United States', 'Florida', 1942
    );

-- * Create a team.
-- Example: Bob creates a team called Bobs team.
INSERT INTO "teams" ("name", "bio", "foundation_year", "is_active", "primary_color", "secondary_color")
VALUES ('Bobs team', 'Team started by the legendary Bob Ross', 1960, 'true', 'Green', 'Blue');
-- Automatically adds the creator to the team_admins table.
INSERT INTO "teams_admins" ("user_id", "team_id")
VALUES (
    (SELECT "id" FROM "users" WHERE "email" = 'bob@gmail.com'),
    (SELECT "id" FROM "teams" WHERE "name" = 'Bobs team')
);

-- * Add other players to their team.
-- Example: Bob adds himself to Bobs team.
INSERT INTO "teams_players" ("player_id", "team_id", "shirt_number", "position")
VALUES (
    (SELECT "id" FROM "players" WHERE "first_name" = 'Bob'  AND "last_name" = 'Ross'),
    (SELECT "id" FROM "teams" WHERE "name" = 'Bobs team'),
    8,
    'Forward'
);

-- Example: Bob adds Rosa Becker to Bobs team.
INSERT INTO "teams_players" ("player_id", "team_id", "shirt_number", "position")
VALUES (
    (SELECT "id" FROM "players" WHERE "first_name" = 'Rosa'  AND "last_name" = 'Becker'),
    (SELECT "id" FROM "teams" WHERE "name" = 'Bobs team'),
    8,
    'Forward'
);

-- * Remove players from the team.
-- Example: Bob removes Rosa Becker from Bobs team.
DELETE FROM "teams_players" 
WHERE "player_id" = (SELECT "id" FROM "players" WHERE "first_name" = 'Rosa'  AND "last_name" = 'Becker')
AND "team_id" = (SELECT "id" FROM "teams" WHERE "name" = 'Bobs team');

-- * Add trainers to their team.
-- Example: Bob adds Kofi Mensah to his team as a trainer.
INSERT INTO "teams_trainers" ("trainer_id", "team_id")
VALUES (
    (SELECT "id" FROM "trainers" WHERE "first_name" = 'Kofi'  AND "last_name" = 'Mensah'),
    (SELECT "id" FROM "teams" WHERE "name" = 'Bobs team')
);

-- * Add other administrators to their team.
-- Example: Bob adds the user dmacellen3@freewebs.com to his team ad an admin.
INSERT INTO "teams_admins" ("user_id", "team_id")
VALUES (
    (SELECT "id" FROM "users" WHERE "email" = 'dmacellen3@freewebs.com'),
    (SELECT "id" FROM "teams" WHERE "name" = 'Bobs team')
);

-- * Create a league 
-- Example: Bob creates a league called Bobs Grand Florida League
INSERT INTO "leagues" ("name", "description", "location_general")
VALUES (
    'Bobs Grand Florida League', 'Open league for local teams in Florida', 'Florida'
);
-- Automatically adds the creator to the leagues_admins table.
INSERT INTO "leagues_admins" ("user_id", "league_id")
VALUES (
    (SELECT "id" FROM "users" WHERE "email" = 'bob@gmail.com'),
    (SELECT "id" FROM "leagues" WHERE "name" = 'Bobs Grand Florida League')
);

-- * Create a tournament.
-- * Bob creates the first tournament for his league.
INSERT INTO "tournaments" ("league_id", "name", "status", "season", "format", "start_date", "end_date", "max_teams", "entry_fee_per_team")
VALUES (
    (SELECT "id" FROM "leagues" WHERE "name" = 'Bobs Grand Florida League'),
    'Tournament #1',
    'Ongoing',
    '2026',
    'Knockout',
    '28.05',
    '28.08',
    20,
    '50$'
);

-- * Add teams to the tournament.
-- Example: Bob adds the Iron Vanguard team to Tournament #1
INSERT INTO "tournaments_teams" ("tournament_id", "team_id")
VALUES (
    (SELECT "id" FROM "tournaments" WHERE "name" = 'Tournament #1'),
    (SELECT "id" FROM "teams" WHERE "name" = 'Iron Vanguard')
);
-- Example: Bob adds his teams to his tournament.
INSERT INTO "tournaments_teams" ("tournament_id", "team_id")
VALUES (
    (SELECT "id" FROM "tournaments" WHERE "name" = 'Tournament #1'),
    (SELECT "id" FROM "teams" WHERE "name" = 'Bobs team')
);

-- * Create a match.
-- Example: Bob creates a match for Bobs teams and Iron Vanguard
INSERT INTO "matches" ("tournament_id", "team_a_id", "score_team_a", "team_b_id", "score_team_b","location", "date")
VALUES (
    (SELECT "id" FROM "tournaments" WHERE "name" = 'Tournament #1'), 
    (SELECT "id" FROM "teams" WHERE "name" = 'Bobs team'),
    0,
    (SELECT "id" FROM "teams" WHERE "name" = 'Iron Vanguard'), 
    0,
    'Iron Vanguard Soccer Gym', 03.05
);

-- * Add referees to the match through the matches_referees table.
-- Example: Bob adds Noah Bakker to the match as a referee
INSERT INTO "matches_referees" ("referee_id", "match_id")
VALUES (
    (SELECT "id" FROM "referees" WHERE "first_name" = 'Noah' AND "last_name" = 'Bakker'), 
    (
        SELECT "id" FROM "matches" 
        WHERE
            "team_a_id" = (SELECT "id" FROM "teams" WHERE "name" = 'Bobs team')
            AND "team_b_id" = (SELECT "id" FROM "teams" WHERE "name" = 'Iron Vanguard')
            AND "date" = 03.05
    )
);

-- * Start the match
UPDATE "matches" SET "status" = 'Ongoing'
WHERE "id" = (
    SELECT "id" FROM "matches" WHERE
        "team_a_id" = (SELECT "id" FROM "teams" WHERE "name" = 'Bobs team')
        AND "team_b_id" = (SELECT "id" FROM "teams" WHERE "name" = 'Iron Vanguard')
        AND "date" = 03.05
    );

-- * Register a goal in the match_events table (updates the score on the matches table)
-- Example: Marco Osei scored a goal
INSERT INTO "match_events" (
    "match_id", "player_id", "team_id", "event_type"
)
VALUES (
    (
        SELECT "id" FROM "matches" 
        WHERE
            "team_a_id" = (SELECT "id" FROM "teams" WHERE "name" = 'Bobs team')
            AND "team_b_id" = (SELECT "id" FROM "teams" WHERE "name" = 'Iron Vanguard')
            AND "date" = 03.05
    ), 
    (SELECT "id" FROM "players" WHERE "first_name" = 'Marco' AND "last_name" = 'Osei'),
    (SELECT "id" FROM "teams" WHERE "name" = 'Iron Vanguard'),
    'goal'   
);
-- Update matches table entry
UPDATE "matches" SET "score_team_b" = "score_team_b" + 1
WHERE "id" = (
        SELECT "id" FROM "matches" 
        WHERE
            "team_a_id" = (SELECT "id" FROM "teams" WHERE "name" = 'Bobs team')
            AND "team_b_id" = (SELECT "id" FROM "teams" WHERE "name" = 'Iron Vanguard')
            AND "date" = 03.05
    );
