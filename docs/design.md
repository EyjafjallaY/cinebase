# Database design

## Scope

CineBase stores movie metadata and a small set of user interactions. The schema covers users, profiles, filmmakers, genres, ratings, reviews, actor credits, and watchlists. It is an educational relational design, with a small fixture of fixed relational records and import-time timestamps.

The public SQL is unchanged from the individual course implementation. Separating entities and many-to-many relationships follows normalization principles; it is not a claim that all production movie-platform requirements are modeled.

## Entities and keys

| Table | Primary key | Relationships and rules |
| --- | --- | --- |
| users | user_id | Unique username and email; status must be active, suspended, or deleted. |
| profiles | profile_id | Unique, non-null user_id references users; deleting a user cascades to its profile. |
| directors | director_id | A director can be referenced by multiple movies. |
| movies | movie_id | Exactly one non-null director_id; release_year must be at least 1888. |
| actors | actor_id | Actor records are connected to movies through movie_actors. |
| genres | genre_id | genre_name is unique; genres can have no associated movies. |
| ratings | rating_id | Non-null user_id and movie_id; score is 1–10; one rating per user–movie pair. |
| reviews | review_id | Non-null user_id and movie_id; multiple reviews per user–movie pair are permitted. |
| movie_genres | movie_id, genre_id | Composite key prevents duplicate movie–genre pairs. |
| movie_actors | movie_id, actor_id | Composite key prevents duplicate movie–actor pairs. |
| watchlist | user_id, movie_id | Composite key prevents duplicate entries; status is plan_to_watch, watching, or completed. |

The schema has 11 primary keys, 12 foreign keys, five additional UNIQUE constraints, four CHECK constraints, two PL/pgSQL trigger functions, and four deferred constraint triggers. SERIAL supplies eight surrogate-key sequences.

## Mandatory participation

Two rules require checks beyond ordinary child-to-parent foreign keys:

1. Every user must have exactly one profile. The profile foreign key and UNIQUE constraint enforce valid ownership and at most one profile; the deferred trigger adds the requirement that a profile actually exists.
2. Every movie must have at least one genre. The junction table's foreign keys and composite primary key enforce valid, unique associations; the deferred trigger adds the minimum association requirement.

The constraint triggers are DEFERRABLE INITIALLY DEFERRED and run after INSERT, UPDATE, or DELETE on the relevant parent and child tables. This allows the seed transaction to insert a parent first, add its required associations, and satisfy the rules when the transaction completes.

Each trigger function scans for missing participation across the corresponding tables. This favors a clear small-scale demonstration. It has not been benchmarked for bulk writes or concurrent transactions. TRUNCATE does not fire these row-level triggers.

## Deletion behavior

| Relationship | Foreign-key behavior |
| --- | --- |
| users → profiles | CASCADE |
| directors → movies | RESTRICT |
| users / movies → ratings | RESTRICT |
| users / movies → reviews | RESTRICT |
| movies / genres → movie_genres | CASCADE |
| movies / actors → movie_actors | CASCADE |
| users / movies → watchlist | CASCADE |

A user with ratings or reviews cannot simply be deleted because those foreign keys restrict deletion. Likewise, deleting a genre that leaves a movie with no remaining genre can fail the deferred participation check. These behaviors should be considered together rather than interpreting CASCADE as permission to delete every parent unconditionally.

## Query semantics

- Q1 groups at movie level. LEFT JOIN preserves unrated movies, AVG returns NULL for missing scores, and COUNT(rating_id) returns zero rather than counting the outer-join placeholder row.
- Q2 returns matching actor-credit associations. Actors without credits are omitted by its inner joins.
- Q3 returns watchlist entries. It does not imply that the user has watched every listed movie.
- Q4 groups at genre level, retaining unused genres. A movie can belong to several genres, so summing genre counts counts associations rather than distinct movies.
- Q4b uses the example filters title contains "dark", genre is "Action", year is at least 2000, and mean score is at least 7 or missing. Including unrated matches is an explicit behavior of its HAVING clause.
- Q5 is restricted to user_id = 1 and starts from ratings. Reviews without a corresponding rating are omitted. If a user has multiple reviews for the same rated movie, the query returns multiple matching rows.

Equal-score rows in Q1 and Q4b have no secondary ordering key, so their relative order is not guaranteed. The sample filters and user ID remain literals in the original SQL.

## Boundaries

The schema assigns one director to each movie and does not model co-directing. It does not enforce one review per user–movie pair or automatically update reviews.updated_at. It includes metadata fields for poster and avatar URLs but no image assets or retrieval service.

No additional indexes, execution-plan tuning, partitioning, concurrency controls, or authentication application were added to this review package.
