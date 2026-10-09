# CineBase

**English** | [简体中文](README.zh-CN.md)

A PostgreSQL database demonstration for a movie catalogue, ratings, reviews, and user watchlists. It contains 11 relational tables, sample records, and six business queries.

Author: **EyjafjallaY**

The SQL was developed as an individual course project and is preserved unchanged in this public review package. Documentation and diagrams describe the implementation that is actually present.

## Start here

- [Database structure and design decisions](docs/design.md)
- [Relationship diagram](docs/schema.svg)
- [Query examples and result semantics](docs/query_examples.md)
- [Verification scope and results](docs/verification.md)

## Files

| File | Role |
| --- | --- |
| [sql/ddl.sql](sql/ddl.sql) | Creates tables, keys, checks, PL/pgSQL functions, and deferred constraint triggers; ends with a watchlist-column inspection query. |
| [sql/dml.sql](sql/dml.sql) | Inserts the sample data in a transaction, displays all tables, and runs two missing-association checks. |
| [sql/dql.sql](sql/dql.sql) | Contains the six business queries, using the original labels Q1, Q2, Q3, Q4, Q4b, and Q5. |
| [docs/schema.mmd](docs/schema.mmd) | Editable Mermaid source for the relationships described by the schema. |
| [docs/schema.svg](docs/schema.svg) | Standalone relationship overview, generated from the same table and foreign-key map. |

## Run locally

Requirements: an existing PostgreSQL server, the createdb and psql client tools, and a database role allowed to create a database and its objects. PostgreSQL 17.9 was used for the SQL verification described below; other versions have not been tested.

Run these commands from this repository's root. Adjust the host, database role, and database name for your own environment.

~~~sh
createdb --host=localhost --username=postgres --template=template0 --encoding=UTF8 cinebase_demo
psql --host=localhost --username=postgres --dbname=cinebase_demo -X --set=ON_ERROR_STOP=1 --command="SET client_encoding TO 'UTF8';" --file=sql/ddl.sql --file=sql/dml.sql --file=sql/dql.sql
~~~

Use a newly created, empty database. The seed inserts rely on fresh SERIAL sequences assigning IDs starting at 1. If database creation fails because the name is already in use, choose a new name before running the SQL. Do not run these scripts against a database containing existing objects or records.

The execution order is ddl.sql, then dml.sql, then dql.sql. The seed file already contains BEGIN and COMMIT, including the records needed to satisfy deferred participation rules. It is not an idempotent update script: rerunning it on the populated database can violate unique constraints.

The seed script prints the 11 tables and then checks for users without profiles and movies without genres. Both missing-association queries should return zero rows.

## Business queries

| Label | Question |
| --- | --- |
| Q1 | What are each movie's average score and number of ratings, including unrated movies? |
| Q2 | Which movies are associated with each actor? |
| Q3 | Which movies are on each user's watchlist, and what is their status? |
| Q4 | How many movies are associated with each genre, including unused genres? |
| Q4b | Which movies match the example title, genre, release-year, and average-rating filters? |
| Q5 | What ratings and matching reviews are associated with the example user? |

## Sample data

The fixture contains 181 rows across 11 tables. User profiles, ratings, and reviews are demonstration records, not a production-user dataset. Movie titles and filmmaker names refer to real films and public figures; descriptive text is illustrative, not a verified film-data feed.

The original demonstration emails, usernames, placeholder password strings, and one fictional profile's school reference remain in the seed file. No email delivery, login, password verification, or account-management application is implemented. The password_hash values are placeholders, not usable password hashes.

## Verification and limitations

The three SQL files were executed with PostgreSQL 17.9 in a new, isolated data directory using offline single-user mode. All six business queries completed, the expected 181 fixture rows were present, and 16 additional integrity checks passed. See [verification details](docs/verification.md).

This is a database demonstration. It does not include a web application, recommendation model, ETL pipeline, or production authentication. The deferred trigger functions perform repeated global scans; concurrent access, large datasets, and performance have not been evaluated. The local SQL verification did not test the psql client connection commands above.

## License

Licensed under the [MIT License](LICENSE).

Copyright (c) 2026 EyjafjallaY.
