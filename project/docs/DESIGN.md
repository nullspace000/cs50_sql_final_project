# Design Document

By Diego Couto

Video overview: <URL HERE> !@#$%!$#%wjfq;wo\

## Scope

* What is the purpose of your database?
  - I'm not a soccer fan myself, but I have this Idea for an app: To represent football leagues. It would allow users to keep track of tournaments, create their own team, publish match location and so on.

* Which people, places, things, etc. are you including in the scope of your database?
  - Leagues
  - Tournaments
  - Matches
  - Match events
  - Teams
  - Players
  - Trainers
  - Referees
  - Users

* Which people, places, things, etc. are *outside* the scope of your database?
  - Venues 
  - Player specific performance metrics.

## Functional Requirements

In this section you should answer the following questions:

* What should a user be able to do with your database?
  - Create their user account.
  - Register themselves as a player.
  - Create a team (automatically adds themselves to the team_admins table).
  - Add other players to their team.
  - Remove players from their team.
  - Add trainers to their team.
  - Add other administrators to their team.
  - Create a league (automatically adds themselves to the leagues_admins table).
  - Create a tournament.
  - Add teams to the tournament.
  - Create a match.
  - Add referees to the match through the matches_referees table.
  - Register a goal in the match_events table (updates the score on the matches table).

* What's beyond the scope of what a user should be able to do with your database?
  - Representing player specific performance metrics.
  - Keeping track of entry fee payments (this would be a good feature in the app).
  - Google maps links for the venues/soccer fields.
  - Profile photos for the players, trainers and referees.
  - Banners and logos for the teams page.

## Representation

Entities are captured in SQLite tables with the following schema...

### Entities

This database includes the following entities:

#### Users
 
The `users` table includes:
 
* `id`, which specifies the unique ID for the user as an `INTEGER`. This column thus has the `PRIMARY KEY` constraint applied.
* `email`, which specifies the user's email as `TEXT`. A `UNIQUE` constraint ensures no two users share the same email, and a `NOT NULL` constraint ensures it is always provided.
* `password`, which stores the user's password as `TEXT`. A `CHECK` constraint enforces a minimum length of 10 characters, and `NOT NULL` ensures it is always provided.
* `creation_timestamp`, which specifies when the user account was created, stored as `NUMERIC` per SQLite's timestamp conventions. It defaults to the current timestamp via `DEFAULT CURRENT_TIMESTAMP`.
* `banned`, which indicates whether the user has been banned, stored as `TEXT`. A `CHECK` constraint restricts its value to either `'true'` or `'false'`, and it defaults to `'false'`.

#### Players
 
The `players` table includes:
 
* `id`, which specifies the unique ID for the player as an `INTEGER`. This column thus has the `PRIMARY KEY` constraint applied.
* `user_id`, which is the ID of the associated user account as an `INTEGER`. This column has a `FOREIGN KEY` constraint referencing the `id` column in the `users` table, and a `UNIQUE` constraint ensures each user account is linked to at most one player profile.
* `first_name`, which specifies the player's first name as `TEXT NOT NULL`.
* `last_name`, which specifies the player's last name as `TEXT NOT NULL`.
* `birth_country`, which specifies the country where the player was born as `TEXT NOT NULL`.
* `birth_state`, which specifies the state where the player was born as `TEXT NOT NULL`.
* `birth_year`, which specifies the year the player was born as `INTEGER NOT NULL`.
* `last_game`, which stores the ID of the last game the player participated in as an `INTEGER`. This column is nullable, as a player may not have played any games yet.
* `creation_timestamp`, which specifies when the player profile was created, stored as `NUMERIC` and defaulting to the current timestamp.

#### Trainers
 
The `trainers` table includes:
 
* `id`, which specifies the unique ID for the trainer as an `INTEGER`. This column thus has the `PRIMARY KEY` constraint applied.
* `user_id`, which is the ID of the associated user account as an `INTEGER`. A `FOREIGN KEY` constraint references the `id` column in the `users` table, and a `UNIQUE` constraint ensures each user account is linked to at most one trainer profile.
* `first_name`, which specifies the trainer's first name as `TEXT NOT NULL`.
* `last_name`, which specifies the trainer's last name as `TEXT NOT NULL`.
* `birth_country`, which specifies the country where the trainer was born as `TEXT NOT NULL`.
* `birth_state`, which specifies the state where the trainer was born as `TEXT NOT NULL`.
* `birth_year`, which specifies the year the trainer was born as `INTEGER NOT NULL`.
* `creation_timestamp`, which specifies when the trainer profile was created, stored as `NUMERIC` and defaulting to the current timestamp.

#### Referees
 
The `referees` table includes:
 
* `id`, which specifies the unique ID for the referee as an `INTEGER`. This column thus has the `PRIMARY KEY` constraint applied.
* `user_id`, which is the ID of the associated user account as an `INTEGER`. A `FOREIGN KEY` constraint references the `id` column in the `users` table.
* `first_name`, which specifies the referee's first name as `TEXT NOT NULL`.
* `last_name`, which specifies the referee's last name as `TEXT NOT NULL`.
* `birth_country`, which specifies the country where the referee was born as `TEXT NOT NULL`.
* `birth_state`, which specifies the state where the referee was born as `TEXT NOT NULL`.
* `birth_year`, which specifies the year the referee was born as `INTEGER NOT NULL`.
* `creation_timestamp`, which specifies when the referee profile was created, stored as `NUMERIC` and defaulting to the current timestamp.

#### Teams
 
The `teams` table includes:
 
* `id`, which specifies the unique ID for the team as an `INTEGER`. This column thus has the `PRIMARY KEY` constraint applied.
* `name`, which specifies the team's name as `TEXT`. A `UNIQUE` constraint ensures no two teams share the same name, and `NOT NULL` ensures it is always provided.
* `bio`, which is a short description of the team stored as `TEXT NOT NULL`.
* `foundation_year`, which specifies the year the team was founded, stored as `NUMERIC NOT NULL`.
* `is_active`, which indicates whether the team is currently active, stored as `TEXT`. A `CHECK` constraint restricts its value to `'true'` or `'false'`, and it defaults to `'true'`. As noted in the schema, this is intended to be automatically set to `'false'` after two years of inactivity.
* `primary_color`, which specifies the team's primary color as `TEXT NOT NULL`.
* `secondary_color`, which specifies the team's secondary color as `TEXT NOT NULL`.
* `creation_timestamp`, which specifies when the team record was created, stored as `NUMERIC` and defaulting to the current timestamp.

#### Matches
 
The `matches` table includes:
 
* `id`, which specifies the unique ID for the match as an `INTEGER`. This column thus has the `PRIMARY KEY` constraint applied.
* `tournament_id`, which is the ID of the tournament the match belongs to as an `INTEGER`. A `FOREIGN KEY` constraint references the `id` column in the `tournaments` table.
* `team_a_id`, which is the ID of the first team participating in the match as an `INTEGER NOT NULL`. A `FOREIGN KEY` constraint references the `id` column in the `teams` table.
* `score_team_a`, which stores the score of the first team as an `INTEGER`. This column is nullable, as the score may not yet be recorded for scheduled or ongoing matches.
* `team_b_id`, which is the ID of the second team participating in the match as an `INTEGER NOT NULL`. A `FOREIGN KEY` constraint references the `id` column in the `teams` table.
* `score_team_b`, which stores the score of the second team as an `INTEGER`, also nullable for the same reason as `score_team_a`.
* `location`, which specifies where the match is held as `TEXT NOT NULL`.
* `date`, which specifies the date of the match stored as `NUMERIC NOT NULL`.
* `status`, which specifies the current state of the match as `TEXT NOT NULL`. A `CHECK` constraint restricts its value to `'Scheduled'`, `'Ongoing'`, `'Finished'`, or `'Postponed'`, and it defaults to `'Scheduled'`.
* `creation_timestamp`, which specifies when the match record was created, stored as `NUMERIC` and defaulting to the current timestamp.

#### Match Events
 
The `match_events` table includes:
 
* `id`, which specifies the unique ID for the event as an `INTEGER`. This column thus has the `PRIMARY KEY` constraint applied.
* `match_id`, which is the ID of the match in which the event occurred as an `INTEGER`. A `FOREIGN KEY` constraint references the `id` column in the `matches` table.
* `player_id`, which is the ID of the player involved in the event as an `INTEGER`. A `FOREIGN KEY` constraint references the `id` column in the `players` table.
* `team_id`, which is the ID of the team associated with the event as an `INTEGER`. A `FOREIGN KEY` constraint references the `id` column in the `teams` table.
* `event_type`, which specifies the type of event as `TEXT NOT NULL`. A `CHECK` constraint restricts its value to `'goal'`, `'fault'`, `'yellow_card'`, or `'red_card'`.
* `creation_timestamp`, which specifies when the event was recorded, stored as `NUMERIC` and defaulting to the current timestamp.

#### Tournaments
 
The `tournaments` table includes:
 
* `id`, which specifies the unique ID for the tournament as an `INTEGER`. This column thus has the `PRIMARY KEY` constraint applied.
* `league_id`, which is the ID of the league the tournament belongs to as an `INTEGER`. A `FOREIGN KEY` constraint references the `id` column in the `leagues` table.
* `name`, which specifies the tournament's name as `TEXT NOT NULL`.
* `status`, which specifies the current state of the tournament as `TEXT NOT NULL`. A `CHECK` constraint restricts its value to `'Scheduled'`, `'Ongoing'`, `'Finished'`, or `'Postponed'`, and it defaults to `'Scheduled'`.
* `season`, which specifies the season the tournament belongs to as an `INTEGER`.
* `format`, which specifies the tournament format as `TEXT NOT NULL`. A `CHECK` constraint restricts its value to `'Knockout'`, `'Round Robin'`, or `'Groups'`, and it defaults to `'Knockout'`.
* `start_date`, which specifies the tournament's start date as `NUMERIC NOT NULL`.
* `end_date`, which specifies the tournament's end date as `NUMERIC NOT NULL`.
* `half_time`, which specifies the duration of each half in minutes as an `INTEGER NOT NULL`, defaulting to `45`.
* `max_teams`, which specifies the maximum number of teams allowed in the tournament as `INTEGER NOT NULL`.
* `entry_fee_per_team`, which specifies the entry fee charged per team as `NUMERIC`. This column is nullable, as some tournaments may have no entry fee.
* `points_per_win`, which specifies the number of points awarded for a win as an `INTEGER`, defaulting to `3`.
* `points_per_draw`, which specifies the number of points awarded for a draw as an `INTEGER`, defaulting to `1`.
* `points_per_loss`, which specifies the number of points awarded for a loss as an `INTEGER`, defaulting to `0`.
* `creation_timestamp`, which specifies when the tournament record was created, stored as `NUMERIC` and defaulting to the current timestamp.

#### Leagues
 
The `leagues` table includes:
 
* `id`, which specifies the unique ID for the league as an `INTEGER`. This column thus has the `PRIMARY KEY` constraint applied.
* `name`, which specifies the league's name as `TEXT NOT NULL`.
* `description`, which provides a description of the league as `TEXT NOT NULL`.
* `location_general`, which specifies the general geographic location of the league as `TEXT NOT NULL`.
* `creation_timestamp`, which specifies when the league record was created, stored as `NUMERIC` and defaulting to the current timestamp.

### Relationships

In this section you should include your entity relationship diagram and describe the relationships between the entities in your database.

## Optimizations

In this section you should answer the following questions:

* Which optimizations (e.g., indexes, views) did you create? Why?

## Limitations

In this section you should answer the following questions:

* What are the limitations of your design?
* What might your database not be able to represent very well?
