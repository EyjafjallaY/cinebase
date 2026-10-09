
-- Q1:
-- Every movie's average rating and rating count.
-- Implements FR5.
-- LEFT JOIN ensures that unrated movies are still displayed.
SELECT m.title,
       ROUND(AVG(r.score), 2) AS avg_rating,
       COUNT(r.rating_id)     AS total_ratings
FROM movies m
LEFT JOIN ratings r ON m.movie_id = r.movie_id
GROUP BY m.movie_id, m.title
ORDER BY avg_rating DESC NULLS LAST;

-- Q2:
-- Query all movies in which each actor appears.
-- Implements FR7.
SELECT a.first_name || ' ' || a.last_name AS actor_name,
       m.title,
       m.release_year
FROM actors a
JOIN movie_actors ma ON a.actor_id = ma.actor_id
JOIN movies m        ON ma.movie_id = m.movie_id
ORDER BY a.last_name, a.first_name, m.release_year;

-- Q3:
-- Query each user's watchlist.
-- Implements FR6.
SELECT u.username,
       m.title,
       w.status,
       w.added_at
FROM watchlist w
JOIN users u  ON w.user_id  = u.user_id
JOIN movies m ON w.movie_id = m.movie_id
ORDER BY u.username, w.status, m.title;

-- Q4:
-- Count movies by genre.
-- Supports FR3 genre-based browsing/filtering.
SELECT g.genre_name,
       COUNT(mg.movie_id) AS movie_count
FROM genres g
LEFT JOIN movie_genres mg ON g.genre_id = mg.genre_id
GROUP BY g.genre_id, g.genre_name
ORDER BY movie_count DESC, g.genre_name;

-- Q4b:
-- Search and filter movie catalogue by title, genre, release year,
-- and aggregated rating.
-- Directly implements FR3.
SELECT m.movie_id,
       m.title,
       m.release_year,
       g.genre_name,
       ROUND(AVG(r.score), 2) AS avg_rating
FROM movies m
JOIN movie_genres mg ON m.movie_id = mg.movie_id
JOIN genres g        ON mg.genre_id = g.genre_id
LEFT JOIN ratings r  ON m.movie_id = r.movie_id
WHERE LOWER(m.title) LIKE LOWER('%dark%')
  AND g.genre_name = 'Action'
  AND m.release_year >= 2000
GROUP BY m.movie_id, m.title, m.release_year, g.genre_name
HAVING AVG(r.score) >= 7 OR AVG(r.score) IS NULL
ORDER BY avg_rating DESC NULLS LAST;

-- Q5:
-- Query one user's ratings and matching reviews.
-- Implements FR4.
SELECT u.username,
       m.title,
       r.score,
       rv.content AS review_content
FROM users u
JOIN ratings r      ON u.user_id  = r.user_id
JOIN movies m       ON r.movie_id = m.movie_id
LEFT JOIN reviews rv ON rv.user_id = u.user_id
                    AND rv.movie_id = m.movie_id
WHERE u.user_id = 1
ORDER BY m.title;