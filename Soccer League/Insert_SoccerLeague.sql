\c soccer_league_db

-- League Data
INSERT INTO league (name, start_date, end_date) VALUES
    ('2024 Premier League', '2024-02-01', '2024-09-30'),
    ('2024 Champions League', '2024-03-01', '2024-10-01');

-- Teams
INSERT INTO teams (name, league_id) VALUES
    ('Manchester United', 1), -- Team 1
    ('Chelsea FC', 1),        -- Team 2
    ('Liverpool FC', 1),      -- Team 3
    ('Real Madrid', 2),       -- Team 4
    ('Bayern Munich', 2),     -- Team 5
    ('Paris Saint-Germain', 2); -- Team 6

-- Players
INSERT INTO players (name, team_id) VALUES
    ('Marcus Rashford', 1), -- Player 1
    ('Bruno Fernandes', 1), -- Player 2
    ('Mason Mount', 2),     -- Player 3
    ('Raheem Sterling', 2), -- Player 4
    ('Mohamed Salah', 3),   -- Player 5
    ('Virgil van Dijk', 3), -- Player 6
    ('Karim Benzema', 4),   -- Player 7
    ('Vinícius Júnior', 4), -- Player 8
    ('Thomas Müller', 5),   -- Player 9
    ('Joshua Kimmich', 5),  -- Player 10
    ('Kylian Mbappé', 6),   -- Player 11
    ('Lionel Messi', 6);    -- Player 12

-- Referees
INSERT INTO referee (name) VALUES
    ('Michael Oliver'),     -- Referee 1
    ('Anthony Taylor'),     -- Referee 2
    ('Daniele Orsato'),     -- Referee 3
    ('Stephanie Frappart'); -- Referee 4

-- Matches for 2024 Premier League
INSERT INTO "match" (home_id, guest_id, league_id) VALUES
    (1, 2, 1), -- Match 1
    (2, 3, 1), -- Match 2
    (3, 1, 1), -- Match 3
    (1, 3, 1), -- Match 4
    (2, 3, 1); -- Match 5

-- Matches for 2024 Champions League
INSERT INTO "match" (home_id, guest_id, league_id) VALUES
    (4, 5, 2), -- Match 6
    (5, 6, 2), -- Match 7
    (6, 4, 2), -- Match 8
    (4, 6, 2), -- Match 9
    (5, 6, 2); -- Match 10

-- Match Referees
INSERT INTO match_referee (match_id, referee_id) VALUES
    (1, 1), -- Match 1, Michael Oliver
    (2, 2), -- Match 2, Anthony Taylor
    (3, 3), -- Match 3, Daniele Orsato
    (4, 4), -- Match 4, Stephanie Frappart
    (5, 1), -- Match 5, Michael Oliver
    (6, 2), -- Match 6, Anthony Taylor
    (7, 3), -- Match 7, Daniele Orsato
    (8, 4), -- Match 8, Stephanie Frappart
    (9, 1), -- Match 9, Michael Oliver
    (10, 2); -- Match 10, Anthony Taylor

-- Goals
INSERT INTO goal (player_id, match_id) VALUES
    -- Premier League Goals
    (1, 1), (2, 1), (5, 1), -- Match 1
    (3, 2), (6, 2), (6, 2),  -- Match 2
    (1, 3), (4, 3), (1, 3), -- Match 3
    (2, 4), (6, 4), (6, 4),  -- Match 4
    (5, 5), (3, 5), (3, 5), -- Match 5
    
    -- Champions League Goals
    (7, 6), (9, 6), (11, 6), -- Match 6
    (8, 7), (12, 7), (12, 7), -- Match 7
    (10, 8), (7, 8), (10, 8), -- Match 8
    (9, 9), (11, 9), (11, 9), -- Match 9
    (8, 10), (12, 10), (8, 10);  -- Match 10
