# Design Document

By Diego Couto

Video overview: <URL HERE> !@#$%!$#%wjfq;wo\

## Scope

In this section you should answer the following questions:

* What is the purpose of your database?
  - I'm not a soccer fan myself, but I have this Idea for an app: To represent football leagues. It would allow users to keep track of tournaments, create their own team, publish match location and so on.

* Which people, places, things, etc. are you including in the scope of your database?
  - Leagues, tournaments, matches, match events, teams, players, trainers, referees, and users.

* Which people, places, things, etc. are *outside* the scope of your database?
  - Venues and player specific performance metrics.

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
  - Banners and logos for the teams.

## Representation

### Entities

In this section you should answer the following questions:

* Which entities will you choose to represent in your database?
* What attributes will those entities have?
* Why did you choose the types you did?
* Why did you choose the constraints you did?

### Relationships

In this section you should include your entity relationship diagram and describe the relationships between the entities in your database.

## Optimizations

In this section you should answer the following questions:

* Which optimizations (e.g., indexes, views) did you create? Why?

## Limitations

In this section you should answer the following questions:

* What are the limitations of your design?
* What might your database not be able to represent very well?
