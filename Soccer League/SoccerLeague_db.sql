DROP DATABASE IF EXISTS soccer_league_db;
CREATE DATABASE soccer_league_db;
\c soccer_league_db

CREATE TABLE "league" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "start_date" DATE NOT NULL,
    "end_date" DATE NOT NULL,
    CONSTRAINT "pk_league" PRIMARY KEY ("id")
);
CREATE TABLE "teams" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "league_id" INT NOT NULL,
    CONSTRAINT "pk_teams" PRIMARY KEY ("id"),
    CONSTRAINT "fk_teams_league_id" FOREIGN KEY("league_id") REFERENCES "league" ("id")
);
CREATE TABLE "players" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "team_id" INT NOT NULL,
    CONSTRAINT "pk_players" PRIMARY KEY ("id"),
    CONSTRAINT "fk_players_team_id" FOREIGN KEY("team_id") REFERENCES "teams" ("id")
);
CREATE TABLE "match" (
    "id" SERIAL NOT NULL,
    "home_id" INT NOT NULL,
    "guest_id" INT NOT NULL,
    "league_id" INT NOT NULL,
    CONSTRAINT "pk_match" PRIMARY KEY ("id"),
    CONSTRAINT "fk_match_home_id" FOREIGN KEY("home_id") REFERENCES "teams" ("id"),
    CONSTRAINT "fk_match_guest_id" FOREIGN KEY("guest_id") REFERENCES "teams" ("id"),
    CONSTRAINT "fk_match_league_id" FOREIGN KEY("league_id") REFERENCES "league" ("id")
);
CREATE TABLE "referee" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    CONSTRAINT "pk_referee" PRIMARY KEY ("id")
);
CREATE TABLE "match_referee" (
    "match_id" INT NOT NULL,
    "referee_id" INT NOT NULL,
    CONSTRAINT "fk_match_referee_match_id" FOREIGN KEY("match_id") REFERENCES "match" ("id"),
    CONSTRAINT "fk_match_referee_referee_id" FOREIGN KEY("referee_id") REFERENCES "referee" ("id")
);
CREATE TABLE "goal" (
    "id" SERIAL NOT NULL,
    "player_id" INT NOT NULL,
    "match_id" INT NOT NULL,
    CONSTRAINT "pk_goal" PRIMARY KEY ("id"),
    CONSTRAINT "fk_goal_player_id" FOREIGN KEY("player_id") REFERENCES "players" ("id"),
    CONSTRAINT "fk_goal_match_id" FOREIGN KEY("match_id") REFERENCES "match" ("id")
);