# SQL verification

Verified on 2026-10-08 using PostgreSQL 17.9.

## Method

The unchanged ddl.sql, dml.sql, and dql.sql files were executed sequentially in a new, task-specific PostgreSQL data directory using offline single-user mode. No existing database was used and no network listener was started.

Private verification inputs and diagnostics are not part of this repository. For transport into single-user mode, empty separator lines were removed from the private input stream so a blank line inside a function body could not prematurely terminate a command. Public SQL files remained byte-for-byte unchanged.

## Results

| Table | Seed rows |
| --- | ---: |
| users | 15 |
| profiles | 15 |
| directors | 15 |
| movies | 15 |
| actors | 15 |
| genres | 15 |
| ratings | 15 |
| reviews | 15 |
| movie_genres | 29 |
| movie_actors | 17 |
| watchlist | 15 |
| **Total** | **181** |

| Query | Returned rows |
| --- | ---: |
| Q1 | 15 |
| Q2 | 17 |
| Q3 | 15 |
| Q4 | 15 |
| Q4b | 1 |
| Q5 | 2 |

Four movies had no ratings and remained in Q1 with NULL averages and zero counts. Five genres had no movies and remained in Q4 with zero counts. Q4b returned The Dark Knight with an average score of 8.50. Both missing-association checks in the seed file returned zero rows.

## Additional integrity probes

All 16 checks passed:

1. All seeded users have profiles.
2. All seeded movies have genre associations.
3. Score 0 is rejected.
4. Score 11 is rejected.
5. Score 1 is accepted.
6. Score 10 is accepted.
7. A duplicate user–movie rating is rejected.
8. A rating referencing an absent movie is rejected.
9. A duplicate movie–genre association is rejected.
10. A second profile for the same user is rejected.
11. An invalid watchlist status is rejected.
12. A release year below 1888 is rejected.
13. A new user without a profile is rejected when deferred constraints are checked.
14. A new movie without a genre is rejected when deferred constraints are checked.
15. Deleting a required profile is rejected when deferred constraints are checked.
16. Deleting a movie's remaining genre associations is rejected when deferred constraints are checked.

Negative probes checked the expected PostgreSQL error classes. Deferred failures were forced with SET CONSTRAINTS ALL IMMEDIATE; the original seed transaction also committed successfully with all required associations present. Probe changes were rolled back, and the fixture's row counts remained unchanged.

## What this establishes

The existing SQL executes against PostgreSQL 17.9 with the supplied fresh-database fixture, and the checked query and integrity behaviors match the documentation.

It does not establish psql client connectivity, multi-user concurrency, performance under load, production security, compatibility with other PostgreSQL versions, or application deployment.
