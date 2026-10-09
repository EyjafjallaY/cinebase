# Query examples

The results below were produced by PostgreSQL 17.9 from the supplied fixture. SQL files and their original query labels remain unchanged.

NULL denotes a missing SQL value. Timestamp columns depend on the import time. Row order for tied averages is not guaranteed.

## Q1 — Movie scores and rating counts

| title | avg_rating | total_ratings |
| --- | --- | --- |
| Parasite | 10.0 | 1 |
| Dune | 10.0 | 1 |
| Blade Runner 2049 | 9.0 | 1 |
| Gladiator | 9.0 | 1 |
| The Dark Knight | 8.5 | 2 |
| Inception | 8.5 | 2 |
| Interstellar | 8.5 | 2 |
| Memories of Murder | 8.0 | 1 |
| Little Women | 8.0 | 1 |
| Barbie | 7.5 | 2 |
| Schindler's List | 7.0 | 1 |
| Titanic | NULL | 0 |
| Lost in Translation | NULL | 0 |
| Avatar | NULL | 0 |
| The Martian | NULL | 0 |

Unrated movies remain present with a NULL mean and a count of zero.

## Q2 — Actor filmography

The query returns 17 actor–movie associations. The following are the first five rows.

| actor_name | title | release_year |
| --- | --- | --- |
| Christian Bale | The Dark Knight | 2008 |
| Timothee Chalamet | Dune | 2021 |
| Zendaya Coleman | Dune | 2021 |
| Russell Crowe | Gladiator | 2000 |
| Matt Damon | Interstellar | 2014 |

## Q3 — User watchlists

The query returns 15 watchlist entries. These first five rows omit the volatile added_at column for readability; the original query also returns that timestamp.

| username | title | status |
| --- | --- | --- |
| alice_walker | Dune | completed |
| alice_walker | Barbie | plan_to_watch |
| bob_chen | Little Women | plan_to_watch |
| bob_chen | Interstellar | watching |
| carol_smith | Inception | completed |

## Q4 — Movies per genre

| genre_name | movie_count |
| --- | --- |
| Drama | 7 |
| Sci-Fi | 6 |
| Adventure | 3 |
| Crime | 3 |
| Romance | 3 |
| Action | 2 |
| Thriller | 2 |
| Comedy | 1 |
| Mystery | 1 |
| War | 1 |
| Animation | 0 |
| Documentary | 0 |
| Fantasy | 0 |
| Horror | 0 |
| Musical | 0 |

Five genres have no matching movies. The counts sum to 29 movie–genre associations, not 15 distinct movies, because movies can belong to multiple genres.

## Q4b — Combined movie filters

The original example uses title contains dark, genre Action, release year at least 2000, and average score at least 7 or no ratings.

| movie_id | title | release_year | genre_name | avg_rating |
| --- | --- | --- | --- | --- |
| 2 | The Dark Knight | 2008 | Action | 8.5 |

## Q5 — Ratings with matching reviews

The original example selects user_id = 1.

| username | title | score | review_content |
| --- | --- | --- | --- |
| alice_walker | Inception | 9 | A mind-bending masterpiece. The dream layers are unforgettable. |
| alice_walker | The Dark Knight | 10 | NULL |

The Dark Knight rating has no matching review from this user, so its review_content is NULL. A review from a different user does not match the join. Multiple matching reviews would produce multiple rows for the same rating.
