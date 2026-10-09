CREATE TABLE users (
    user_id         SERIAL PRIMARY KEY,
    username        VARCHAR(50)  NOT NULL UNIQUE,
    email           VARCHAR(100) NOT NULL UNIQUE,
    password_hash   VARCHAR(255) NOT NULL,
    account_status  VARCHAR(20)  NOT NULL DEFAULT 'active'
                    CHECK (account_status IN ('active', 'suspended', 'deleted')),
    registered_at   TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE profiles (
    profile_id      SERIAL PRIMARY KEY,
    user_id         INTEGER      NOT NULL UNIQUE
                    REFERENCES users(user_id) ON DELETE CASCADE,
    display_name    VARCHAR(100) NOT NULL,
    avatar_url      TEXT,
    bio             TEXT
);

CREATE TABLE directors (
    director_id     SERIAL PRIMARY KEY,
    first_name      VARCHAR(50)  NOT NULL,
    last_name       VARCHAR(50)  NOT NULL,
    nationality     VARCHAR(50)
);

CREATE TABLE movies (
    movie_id        SERIAL PRIMARY KEY,
    title           VARCHAR(255) NOT NULL,
    release_year    INTEGER      NOT NULL
                    CHECK (release_year >= 1888),
    synopsis        TEXT,
    poster_url      TEXT,
    director_id     INTEGER      NOT NULL
                    REFERENCES directors(director_id) ON DELETE RESTRICT
);

CREATE TABLE actors (
    actor_id        SERIAL PRIMARY KEY,
    first_name      VARCHAR(50)  NOT NULL,
    last_name       VARCHAR(50)  NOT NULL,
    birth_date      DATE,
    nationality     VARCHAR(50),
    biography       TEXT
);

CREATE TABLE genres (
    genre_id        SERIAL PRIMARY KEY,
    genre_name      VARCHAR(50)  NOT NULL UNIQUE,
    description     TEXT
);

CREATE TABLE ratings (
    rating_id       SERIAL PRIMARY KEY,
    score           SMALLINT     NOT NULL
                    CHECK (score BETWEEN 1 AND 10),
    rated_at        TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    movie_id        INTEGER      NOT NULL
                    REFERENCES movies(movie_id) ON DELETE RESTRICT,
    user_id         INTEGER      NOT NULL
                    REFERENCES users(user_id) ON DELETE RESTRICT,
    CONSTRAINT uq_user_movie_rating UNIQUE (user_id, movie_id)
);

CREATE TABLE reviews (
    review_id       SERIAL PRIMARY KEY,
    content         TEXT         NOT NULL,
    created_at      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP,
    movie_id        INTEGER      NOT NULL
                    REFERENCES movies(movie_id) ON DELETE RESTRICT,
    user_id         INTEGER      NOT NULL
                    REFERENCES users(user_id) ON DELETE RESTRICT
);

CREATE TABLE movie_genres (
    movie_id        INTEGER      NOT NULL
                    REFERENCES movies(movie_id) ON DELETE CASCADE,
    genre_id        INTEGER      NOT NULL
                    REFERENCES genres(genre_id) ON DELETE CASCADE,
    PRIMARY KEY (movie_id, genre_id)
);

CREATE TABLE movie_actors (
    movie_id        INTEGER      NOT NULL
                    REFERENCES movies(movie_id) ON DELETE CASCADE,
    actor_id        INTEGER      NOT NULL
                    REFERENCES actors(actor_id) ON DELETE CASCADE,
    PRIMARY KEY (movie_id, actor_id)
);

CREATE TABLE watchlist (
    user_id         INTEGER      NOT NULL
                    REFERENCES users(user_id) ON DELETE CASCADE,
    movie_id        INTEGER      NOT NULL
                    REFERENCES movies(movie_id) ON DELETE CASCADE,
    status          VARCHAR(20)  NOT NULL
                    CHECK (status IN ('plan_to_watch', 'watching', 'completed')),
    added_at        TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, movie_id)
);

-- ------------------------------------------------------------
-- Constraint Trigger 1:
-- Enforce that every user must have exactly one profile.
-- profiles.user_id NOT NULL + UNIQUE already ensures:
--   1. every profile belongs to one user;
--   2. each user can have at most one profile.
-- This trigger adds the missing rule:
--   3. every user must have a profile.
-- ------------------------------------------------------------

CREATE OR REPLACE FUNCTION check_every_user_has_profile()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM users u
        WHERE NOT EXISTS (
            SELECT 1
            FROM profiles p
            WHERE p.user_id = u.user_id
        )
    ) THEN
        RAISE EXCEPTION
            'Business rule violation: every user must have exactly one profile.';
    END IF;

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE CONSTRAINT TRIGGER trg_users_must_have_profile_from_users
AFTER INSERT OR UPDATE OR DELETE ON users
DEFERRABLE INITIALLY DEFERRED
FOR EACH ROW
EXECUTE FUNCTION check_every_user_has_profile();

CREATE CONSTRAINT TRIGGER trg_users_must_have_profile_from_profiles
AFTER INSERT OR UPDATE OR DELETE ON profiles
DEFERRABLE INITIALLY DEFERRED
FOR EACH ROW
EXECUTE FUNCTION check_every_user_has_profile();

-- ------------------------------------------------------------
-- Constraint Trigger 2:
-- Enforce that every movie must have at least one genre.
-- movie_genres already ensures valid and unique movie-genre pairs.
-- This trigger adds the missing parent-side minimum participation rule.
-- ------------------------------------------------------------

CREATE OR REPLACE FUNCTION check_every_movie_has_genre()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM movies m
        WHERE NOT EXISTS (
            SELECT 1
            FROM movie_genres mg
            WHERE mg.movie_id = m.movie_id
        )
    ) THEN
        RAISE EXCEPTION
            'Business rule violation: every movie must be associated with at least one genre.';
    END IF;

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE CONSTRAINT TRIGGER trg_movies_must_have_genre_from_movies
AFTER INSERT OR UPDATE OR DELETE ON movies
DEFERRABLE INITIALLY DEFERRED
FOR EACH ROW
EXECUTE FUNCTION check_every_movie_has_genre();

CREATE CONSTRAINT TRIGGER trg_movies_must_have_genre_from_movie_genres
AFTER INSERT OR UPDATE OR DELETE ON movie_genres
DEFERRABLE INITIALLY DEFERRED
FOR EACH ROW
EXECUTE FUNCTION check_every_movie_has_genre();

-- ============================================================
-- Optional table structure check
-- ============================================================

SELECT column_name,
       data_type,
       character_maximum_length,
       is_nullable,
       column_default
FROM information_schema.columns
WHERE table_name = 'watchlist'
ORDER BY ordinal_position;