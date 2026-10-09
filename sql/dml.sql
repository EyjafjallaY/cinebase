BEGIN;

-- 1. users
INSERT INTO users (username, email, password_hash, account_status) VALUES
('alice_walker',   'alice@cinebase.com',   '$2b$12$aaa001', 'active'),
('bob_chen',       'bob@cinebase.com',     '$2b$12$aaa002', 'active'),
('carol_smith',    'carol@cinebase.com',   '$2b$12$aaa003', 'active'),
('david_kim',      'david@cinebase.com',   '$2b$12$aaa004', 'active'),
('emma_jones',     'emma@cinebase.com',    '$2b$12$aaa005', 'suspended'),
('frank_lee',      'frank@cinebase.com',   '$2b$12$aaa006', 'active'),
('grace_wong',     'grace@cinebase.com',   '$2b$12$aaa007', 'active'),
('henry_park',     'henry@cinebase.com',   '$2b$12$aaa008', 'active'),
('iris_chen',      'iris@cinebase.com',    '$2b$12$aaa009', 'active'),
('jack_taylor',    'jack@cinebase.com',    '$2b$12$aaa010', 'suspended'),
('karen_white',    'karen@cinebase.com',   '$2b$12$aaa011', 'active'),
('liam_brown',     'liam@cinebase.com',    '$2b$12$aaa012', 'active'),
('mia_davis',      'mia@cinebase.com',     '$2b$12$aaa013', 'active'),
('noah_wilson',    'noah@cinebase.com',    '$2b$12$aaa014', 'active'),
('olivia_moore',   'olivia@cinebase.com',  '$2b$12$aaa015', 'active');

-- 2. directors
INSERT INTO directors (first_name, last_name, nationality) VALUES
('Christopher', 'Nolan',      'British'),
('Greta',       'Gerwig',     'American'),
('Denis',       'Villeneuve', 'Canadian'),
('Bong',        'Joon-ho',    'South Korean'),
('Steven',      'Spielberg',  'American'),
('Ridley',      'Scott',      'British'),
('James',       'Cameron',    'Canadian'),
('Sofia',       'Coppola',    'American'),
('Park',        'Chan-wook',  'South Korean'),
('Quentin',     'Tarantino',  'American'),
('Martin',      'Scorsese',   'American'),
('Wes',         'Anderson',   'American'),
('Yorgos',      'Lanthimos',  'Greek'),
('Hirokazu',    'Kore-eda',   'Japanese'),
('Pedro',       'Almodovar',  'Spanish');

-- 3. movies
INSERT INTO movies (title, release_year, synopsis, director_id) VALUES
('Inception',             2010, 'A thief who steals corporate secrets through dream-sharing technology.',        1),
('The Dark Knight',       2008, 'Batman faces the Joker, a criminal mastermind who sows chaos in Gotham.',       1),
('Interstellar',          2014, 'Explorers travel through a wormhole in search of a new home for humanity.',     1),
('Barbie',                2023, 'Barbie and Ken go on a journey of self-discovery in the real world.',           2),
('Little Women',          2019, 'Four sisters navigate love, loss and independence in Civil War-era America.',   2),
('Dune',                  2021, 'A noble family becomes embroiled in a war for a desert planet.',                3),
('Blade Runner 2049',     2017, 'A new blade runner unearths a secret that could plunge society into chaos.',    3),
('Parasite',              2019, 'A poor family schemes to become employed by a wealthy household.',              4),
('Memories of Murder',    2003, 'Two detectives investigate South Korea''s first serial murders.',               4),
('Schindler''s List',     1993, 'In German-occupied Poland, a businessman saves the lives of Jewish refugees.',   5),
('Gladiator',             2000, 'A Roman general seeks revenge against the corrupt emperor who betrayed him.',    6),
('The Martian',           2015, 'An astronaut is left behind on Mars and must find a way to survive.',           6),
('Avatar',                2009, 'A paraplegic marine is dispatched to a moon where he falls in love.',           7),
('Titanic',               1997, 'A love story set against the backdrop of the Titanic disaster.',                7),
('Lost in Translation',   2003, 'Two lost souls meet in Tokyo and form an unlikely bond.',                       8);

-- 4. actors
INSERT INTO actors (first_name, last_name, birth_date, nationality, biography) VALUES
('Leonardo',  'DiCaprio',  '1974-11-11', 'American',      'Academy Award-winning actor known for dramatic roles.'),
('Margot',    'Robbie',    '1990-07-02', 'Australian',    'Acclaimed actress known for versatile performances.'),
('Timothee',  'Chalamet',  '1995-12-27', 'American',      'Rising star of independent and blockbuster films.'),
('Cate',      'Blanchett', '1969-05-14', 'Australian',    'Two-time Academy Award winner.'),
('Tom',       'Hanks',     '1956-07-09', 'American',      'One of the most beloved actors in Hollywood.'),
('Scarlett',  'Johansson', '1984-11-22', 'American',      'Known for blockbuster and independent films alike.'),
('Ryan',      'Gosling',   '1980-11-12', 'Canadian',      'Known for La La Land and Drive.'),
('Zendaya',   'Coleman',   '1996-09-01', 'American',      'Actress and singer known for Euphoria and Dune.'),
('Christian', 'Bale',      '1974-01-30', 'British',       'Known for physical transformations for roles.'),
('Song',      'Kang-ho',   '1967-01-17', 'South Korean',  'Bong Joon-ho frequent collaborator.'),
('Matt',      'Damon',     '1970-10-08', 'American',      'Actor and screenwriter known for Good Will Hunting.'),
('Russell',   'Crowe',     '1964-04-07', 'New Zealander', 'Academy Award winner for Gladiator.'),
('Saoirse',   'Ronan',     '1994-04-12', 'Irish',         'Four-time Academy Award nominee.'),
('Bill',      'Murray',    '1950-09-21', 'American',      'Known for comedic and dramatic roles.'),
('Heath',     'Ledger',    '1979-04-04', 'Australian',    'Posthumous Academy Award winner for The Dark Knight.');

-- 5. genres
INSERT INTO genres (genre_name, description) VALUES
('Action',      'High-energy sequences, physical stunts and conflict.'),
('Drama',       'Character-driven narratives focused on emotional themes.'),
('Sci-Fi',      'Science-based speculative and futuristic fiction.'),
('Thriller',    'Suspenseful narratives designed to create tension.'),
('Comedy',      'Light-hearted narratives intended to entertain.'),
('Romance',     'Stories centred on love and relationships.'),
('Crime',       'Narratives involving criminal acts and investigations.'),
('Adventure',   'Stories involving journeys, exploration and risk.'),
('Horror',      'Designed to frighten, unsettle, or disturb.'),
('Animation',   'Stories told through animated visuals.'),
('Documentary', 'Non-fiction films presenting real events.'),
('Musical',     'Narratives driven by song and dance.'),
('Fantasy',     'Narratives involving magical or supernatural elements.'),
('Mystery',     'Plots centred on solving an unknown.'),
('War',         'Narratives set in or around armed conflict.');

-- 6. profiles
-- Every user has exactly one profile, satisfying the User-Profile rule.
INSERT INTO profiles (user_id, display_name, bio) VALUES
(1,  'Alice W',    'Film enthusiast based in London. Love sci-fi and indie films.'),
(2,  'Bob C',      'Horror and thriller addict from Shanghai.'),
(3,  'Carol S',    'Documentary lover and occasional film critic.'),
(4,  'David K',    'Action movie fan. Watches everything with explosions.'),
(5,  'Emma J',     'Classic Hollywood devotee. Black and white only.'),
(6,  'Frank L',    'Korean cinema enthusiast. Parasite changed my life.'),
(7,  'Grace W',    'Animation and family film fan based in Hong Kong.'),
(8,  'Henry P',    'Watches films for the cinematography, not the plot.'),
(9,  'Iris C',     'Film student at XJTLU. Writing my dissertation on Nolan.'),
(10, 'Jack T',     'Used to review films but now just watches them quietly.'),
(11, 'Karen W',    'Romance and drama fan. Cried at Titanic three times.'),
(12, 'Liam B',     'Sci-fi and fantasy. Currently reading Dune for the 4th time.'),
(13, 'Mia D',      'Award season tracker. Watches everything before the Oscars.'),
(14, 'Noah W',     'Director-focused viewer. Follows filmmakers, not franchises.'),
(15, 'Olivia M',   'New to film. Just getting started with the classics.');

-- 7. ratings
INSERT INTO ratings (score, movie_id, user_id) VALUES
(9,  1,  1),
(8,  1,  2),
(10, 2,  1),
(7,  2,  3),
(9,  3,  2),
(8,  3,  4),
(6,  4,  5),
(9,  4,  6),
(8,  5,  7),
(10, 6,  3),
(9,  7,  8),
(10, 8,  6),
(8,  9,  9),
(7,  10, 10),
(9,  11, 11);

-- 8. reviews
INSERT INTO reviews (content, movie_id, user_id) VALUES
('A mind-bending masterpiece. The dream layers are unforgettable.',          1,  1),
('Heath Ledger delivers one of cinema''s greatest performances.',            2,  2),
('Emotionally overwhelming. The ending still haunts me.',                   3,  3),
('A bold and funny deconstruction of the Barbie myth.',                     4,  6),
('Greta Gerwig brings warmth and intelligence to Alcott.',                  5,  7),
('Visually stunning. Villeneuve captures the scale of the novel perfectly.',6,  3),
('A slow burn that rewards patient viewers with a stunning conclusion.',     7,  8),
('Parasite is a perfect film. Every frame is intentional.',                 8,  6),
('A gripping procedural that reveals the limits of justice.',               9,  9),
('Spielberg''s most personal film. Devastating and beautiful.',             10, 10),
('Russell Crowe commands the screen in every scene.',                       11, 11),
('Smart, funny and surprisingly moving. Damon is at his best.',             12, 12),
('The world-building is extraordinary. A new benchmark for blockbusters.',  13, 13),
('Old-fashioned storytelling at its finest. I wept uncontrollably.',        14, 14),
('Quiet and melancholic. Murray and Johansson are perfect together.',       15, 15);

-- 9. movie_genres
-- Every movie has at least one genre, satisfying the Movie-Genre rule.
INSERT INTO movie_genres (movie_id, genre_id) VALUES
(1,  3),   -- Inception → Sci-Fi
(1,  4),   -- Inception → Thriller
(2,  1),   -- The Dark Knight → Action
(2,  7),   -- The Dark Knight → Crime
(3,  3),   -- Interstellar → Sci-Fi
(3,  2),   -- Interstellar → Drama
(4,  5),   -- Barbie → Comedy
(4,  2),   -- Barbie → Drama
(5,  2),   -- Little Women → Drama
(5,  6),   -- Little Women → Romance
(6,  3),   -- Dune → Sci-Fi
(6,  8),   -- Dune → Adventure
(7,  3),   -- Blade Runner 2049 → Sci-Fi
(8,  7),   -- Parasite → Crime
(8,  4),   -- Parasite → Thriller
(9,  7),   -- Memories of Murder → Crime
(9,  14),  -- Memories of Murder → Mystery
(10, 15),  -- Schindler's List → War
(10, 2),   -- Schindler's List → Drama
(11, 1),   -- Gladiator → Action
(11, 2),   -- Gladiator → Drama
(12, 3),   -- The Martian → Sci-Fi
(12, 8),   -- The Martian → Adventure
(13, 3),   -- Avatar → Sci-Fi
(13, 8),   -- Avatar → Adventure
(14, 2),   -- Titanic → Drama
(14, 6),   -- Titanic → Romance
(15, 2),   -- Lost in Translation → Drama
(15, 6);   -- Lost in Translation → Romance

-- 10. movie_actors
INSERT INTO movie_actors (movie_id, actor_id) VALUES
(1,  1),   -- Inception → Leonardo DiCaprio
(2,  9),   -- The Dark Knight → Christian Bale
(2,  15),  -- The Dark Knight → Heath Ledger
(3,  11),  -- Interstellar → Matt Damon
(4,  2),   -- Barbie → Margot Robbie
(4,  7),   -- Barbie → Ryan Gosling
(5,  13),  -- Little Women → Saoirse Ronan
(6,  3),   -- Dune → Timothee Chalamet
(6,  8),   -- Dune → Zendaya
(7,  7),   -- Blade Runner 2049 → Ryan Gosling
(8,  10),  -- Parasite → Song Kang-ho
(9,  10),  -- Memories of Murder → Song Kang-ho
(11, 12),  -- Gladiator → Russell Crowe
(12, 11),  -- The Martian → Matt Damon
(14, 1),   -- Titanic → Leonardo DiCaprio
(15, 14),  -- Lost in Translation → Bill Murray
(15, 6);   -- Lost in Translation → Scarlett Johansson

-- 11. watchlist
INSERT INTO watchlist (user_id, movie_id, status) VALUES
(1,  4,  'plan_to_watch'),
(1,  6,  'completed'),
(2,  3,  'watching'),
(2,  5,  'plan_to_watch'),
(3,  1,  'completed'),
(3,  7,  'plan_to_watch'),
(4,  8,  'completed'),
(4,  2,  'watching'),
(5,  9,  'plan_to_watch'),
(6,  10, 'completed'),
(7,  11, 'watching'),
(8,  12, 'plan_to_watch'),
(9,  13, 'completed'),
(10, 14, 'watching'),
(11, 15, 'completed');

COMMIT;

-- ============================================================
-- Display all table contents
-- ============================================================

SELECT * FROM users;
SELECT * FROM profiles;
SELECT * FROM directors;
SELECT * FROM movies;
SELECT * FROM actors;
SELECT * FROM genres;
SELECT * FROM ratings;
SELECT * FROM reviews;
SELECT * FROM movie_genres;
SELECT * FROM movie_actors;
SELECT * FROM watchlist;

-- ============================================================
-- Validation checks for mandatory participation constraints
-- ============================================================

-- Check 1:
-- Should return 0 rows.
-- If any row appears, that user has no profile.
SELECT u.user_id,
       u.username
FROM users u
LEFT JOIN profiles p ON u.user_id = p.user_id
WHERE p.profile_id IS NULL;

-- Check 2:
-- Should return 0 rows.
-- If any row appears, that movie has no genre.
SELECT m.movie_id,
       m.title
FROM movies m
LEFT JOIN movie_genres mg ON m.movie_id = mg.movie_id
WHERE mg.genre_id IS NULL;