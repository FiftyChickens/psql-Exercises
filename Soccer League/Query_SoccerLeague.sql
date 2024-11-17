\c soccer_league_db

-- All of the teams in the league
-- The standings/rankings of each team in the league (This doesn’t have to be its own table if the data can be captured somehow).
SELECT l.name AS league_name,
    t.name AS team_name,
    COUNT(g.id) AS goals_scored,
    RANK() OVER (
        PARTITION BY l.id
        ORDER BY COUNT(g.id) DESC
    ) AS team_rank
FROM teams t
    JOIN league l ON t.league_id = l.id
    LEFT JOIN players p ON t.id = p.team_id
    LEFT JOIN goal g ON p.id = g.player_id
GROUP BY l.id,
    l.name,
    t.id,
    t.name
ORDER BY l.id,
    team_rank;

-- All of the goals scored by every player for each game
SELECT p.name AS player_name,
    m.id AS match_id,
    l.name AS league,
    COUNT(g.id) AS goals_scored
FROM goal g
    JOIN players p ON g.player_id = p.id
    JOIN match m ON g.match_id = m.id
    JOIN league l ON m.league_id = l.id
GROUP BY p.name,
    m.id,
    l.name
ORDER BY m.id,
    p.name;

-- All of the players in the league and their corresponding teams
SELECT l.name AS league,
    pl.name AS player_name,
    t.name AS team_name
FROM players pl
    JOIN teams t ON pl.team_id = t.id
    JOIN league l ON t.league_id = l.id;

-- All of the referees who have been part of each game
SELECT m.id AS match_id,
    t1.name AS home_team,
    t2.name AS guest_team,
    r.name AS referee_name
FROM match m
    JOIN teams t1 ON m.home_id = t1.id
    JOIN teams t2 ON m.guest_id = t2.id
    JOIN match_referee mr ON m.id = mr.match_id
    JOIN referee r ON mr.referee_id = r.id
ORDER BY m.id;


-- All of the matches played between teams
SELECT m.id AS match_id,
    t1.name AS home_team,
    t2.name AS guest_team,
    l.name AS league_name
FROM match m
    JOIN teams t1 ON m.home_id = t1.id
    JOIN teams t2 ON m.guest_id = t2.id
    JOIN league l ON m.league_id = l.id;

-- All of the start and end dates for season that a league has
SELECT name AS league_name,
    start_date,
    end_date
FROM league
ORDER BY start_date;