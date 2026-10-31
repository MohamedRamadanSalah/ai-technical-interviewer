# Onboarding: Query Performance at Acme

New backend engineers need to be able to reason about why a query is slow before
reaching for a fix. This covers what the team expects.

## What we expect people to know

- B-tree indexes: what they are ordered by, and what that implies for which
  queries they can serve.
- Composite indexes and column order.
- Why an index sometimes isn't used even though it "looks right".
- Reading EXPLAIN ANALYZE well enough to tell a planning problem from an
  execution problem.
- The write cost of indexes — we have tables with heavy insert traffic.

## Our environment

PostgreSQL 16. Largest tables are in the 50–200M row range. The orders table
takes ~8k inserts/sec at peak. Read queries have a 200ms p99 budget.

## Out of scope for this level

Replication, partitioning strategy, and connection pooling.
