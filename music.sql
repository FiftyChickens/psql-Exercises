-- from the terminal run:
-- psql < music.sql

DROP DATABASE IF EXISTS music;

CREATE DATABASE music;

\c music

CREATE TABLE artist (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE producer (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE album (
  id SERIAL PRIMARY KEY,
  title TEXT NOT NULL,
  release_date DATE NOT NULL,
  artist_id INT NOT NULL,
  producer_id INT,
  CONSTRAINT fk_album_artist FOREIGN KEY (artist_id) REFERENCES artist (id),
  CONSTRAINT fk_album_producer FOREIGN KEY (producer_id) REFERENCES producer (id)
);

CREATE TABLE songs
(
  id SERIAL PRIMARY KEY,
  title TEXT NOT NULL,
  duration_in_seconds INT NOT NULL,
  album_id INT,
  CONSTRAINT fk_songs_album_id FOREIGN KEY (album_id) REFERENCES album (id)
);

CREATE TABLE multiple_artist (
  song_id INT NOT NULL,
  artist_id INT NOT NULL,
  PRIMARY KEY (song_id, artist_id),
  CONSTRAINT fk_multiple_artist_songs FOREIGN KEY (song_id) REFERENCES songs(id),
  CONSTRAINT fk_multiple_artist_artist FOREIGN KEY (artist_id) REFERENCES artist(id)
);

CREATE TABLE multiple_producers (
  song_id INT NOT NULL,
  producer_id INT NOT NULL,
  PRIMARY KEY (song_id, producer_id),
  CONSTRAINT fk_multiple_producers_songs FOREIGN KEY (song_id) REFERENCES songs(id),
  CONSTRAINT fk_multiple_producers_producer FOREIGN KEY (producer_id) REFERENCES producer(id)
);

-- Inserting Artists
INSERT INTO artist (name)
VALUES 
    ('Hanson'),
    ('Queen'),
    ('Mariah Carey'),
    ('Boyz II Men'),
    ('Lady Gaga'),
    ('Bradley Cooper'),
    ('Nickelback'),
    ('Jay Z'),
    ('Alicia Keys'),
    ('Katy Perry'),
    ('Juicy J'),
    ('Maroon 5'),
    ('Christina Aguilera'),
    ('Avril Lavigne'),
    ('Destiny''s Child');

-- Inserting Producers
INSERT INTO producer (name)
VALUES 
    ('Dust Brothers'),
    ('Stephen Lironi'),
    ('Roy Thomas Baker'),
    ('Walter Afanasieff'),
    ('Benjamin Rice'),
    ('Rick Parashar'),
    ('Al Shux'),
    ('Max Martin'),
    ('Cirkut'),
    ('Shellback'),
    ('Benny Blanco'),
    ('The Matrix'),
    ('Darkchild');

-- Inserting Albums
INSERT INTO album (title, release_date, artist_id, producer_id)
VALUES
    ('Middle of Nowhere', '1997-04-15', 1, 1),
    ('A Night at the Opera', '1975-10-31', 2, 3),
    ('Daydream', '1995-11-14', 3, 4),
    ('A Star Is Born', '2018-09-27', 5, 5),
    ('Silver Side Up', '2001-08-21', 7, 6),
    ('The Blueprint 3', '2009-10-20', 8, 7),
    ('Prism', '2013-12-17', 10, 8),
    ('Hands All Over', '2011-06-21', 12, 9),
    ('Let Go', '2002-05-14', 13, 11),
    ('The Writing''s on the Wall', '1999-11-07', 14, 12);

-- Inserting Songs
INSERT INTO songs (title, duration_in_seconds, album_id)
VALUES
    ('MMMBop', 238, 1),
    ('Bohemian Rhapsody', 355, 2),
    ('One Sweet Day', 282, 3),
    ('Shallow', 216, 4),
    ('How You Remind Me', 223, 5),
    ('New York State of Mind', 276, 6),
    ('Dark Horse', 215, 7),
    ('Moves Like Jagger', 201, 8),
    ('Complicated', 244, 9),
    ('Say My Name', 240, 10);

-- Mapping Songs to Artists (Multiple Artists per Song)
INSERT INTO multiple_artist (song_id, artist_id)
VALUES
    (1, 1),  -- MMMBop - Hanson
    (2, 2),  -- Bohemian Rhapsody - Queen
    (3, 3),  -- One Sweet Day - Mariah Carey
    (3, 4),  -- One Sweet Day - Boyz II Men
    (4, 5),  -- Shallow - Lady Gaga
    (4, 6),  -- Shallow - Bradley Cooper
    (5, 7),  -- How You Remind Me - Nickelback
    (6, 8),  -- New York State of Mind - Jay Z
    (6, 9),  -- New York State of Mind - Alicia Keys
    (7, 10), -- Dark Horse - Katy Perry
    (7, 11), -- Dark Horse - Juicy J
    (8, 12), -- Moves Like Jagger - Maroon 5
    (8, 13), -- Moves Like Jagger - Christina Aguilera
    (9, 14), -- Complicated - Avril Lavigne
    (10, 15); -- Say My Name - Destiny's Child

-- Mapping Songs to Producers (Multiple Producers per Song)
INSERT INTO multiple_producers (song_id, producer_id)
VALUES
    (1, 1),  -- MMMBop - Dust Brothers
    (1, 2),  -- MMMBop - Stephen Lironi
    (2, 3),  -- Bohemian Rhapsody - Roy Thomas Baker
    (3, 4),  -- One Sweet Day - Walter Afanasieff
    (4, 5),  -- Shallow - Benjamin Rice
    (5, 6),  -- How You Remind Me - Rick Parashar
    (6, 7),  -- New York State of Mind - Al Shux
    (7, 8),  -- Dark Horse - Max Martin
    (7, 9),  -- Dark Horse - Cirkut
    (8, 10), -- Moves Like Jagger - Shellback
    (8, 11), -- Moves Like Jagger - Benny Blanco
    (9, 12), -- Complicated - The Matrix
    (10, 13); -- Say My Name - Darkchild




-- INSERT INTO songs
--   (title, duration_in_seconds, release_date, artists, album, producers)
-- VALUES
--   ('MMMBop', 238, '04-15-1997', '{"Hanson"}', 'Middle of Nowhere', '{"Dust Brothers", "Stephen Lironi"}'),
--   ('Bohemian Rhapsody', 355, '10-31-1975', '{"Queen"}', 'A Night at the Opera', '{"Roy Thomas Baker"}'),
--   ('One Sweet Day', 282, '11-14-1995', '{"Mariah Cary", "Boyz II Men"}', 'Daydream', '{"Walter Afanasieff"}'),
--   ('Shallow', 216, '09-27-2018', '{"Lady Gaga", "Bradley Cooper"}', 'A Star Is Born', '{"Benjamin Rice"}'),
--   ('How You Remind Me', 223, '08-21-2001', '{"Nickelback"}', 'Silver Side Up', '{"Rick Parashar"}'),
--   ('New York State of Mind', 276, '10-20-2009', '{"Jay Z", "Alicia Keys"}', 'The Blueprint 3', '{"Al Shux"}'),
--   ('Dark Horse', 215, '12-17-2013', '{"Katy Perry", "Juicy J"}', 'Prism', '{"Max Martin", "Cirkut"}'),
--   ('Moves Like Jagger', 201, '06-21-2011', '{"Maroon 5", "Christina Aguilera"}', 'Hands All Over', '{"Shellback", "Benny Blanco"}'),
--   ('Complicated', 244, '05-14-2002', '{"Avril Lavigne"}', 'Let Go', '{"The Matrix"}'),
--   ('Say My Name', 240, '11-07-1999', '{"Destiny''s Child"}', 'The Writing''s on the Wall', '{"Darkchild"}');

