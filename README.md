# project-4
# IMDb SQL + Python Project

## 1) Overview
**Goal:** Explore IMDb data with a relational schema and SQL + Python to answer:
- **RQ1:** Which **genres** achieve the highest **average IMDb ratings** (n ≥ 50)?
- **RQ2:** Which **directors** consistently produce **highly rated** movies (n ≥ 5)?
- **RQ3 (extra):** Do **age certificates** (PG / PG-13 / R …) or **runtime** relate to ratings?

**Hypothesis**  
1) Certain genres (e.g., Drama/Documentary) and well-regarded directors tend to have higher average ratings.  
2) Audience preferences correlate with **certificate** (content restrictions) and **runtime** (format length).

**Stack:** MySQL (schema + queries), Python (Pandas, SQLAlchemy, Matplotlib).

---

## 2) Data Sources
- **Primary CSVs:**  
  `movies.csv`, `genres.csv`, `directors.csv`, `stars.csv`,  
  `movie_genres.csv`, `movie_directors.csv`, `movie_stars.csv`
- **(Optional) Secondary:** `financials.csv` (budget / revenue / release_year), loaded to a `financials` table for extended analysis.

---

## 3) Project Structure
/project
├─ 00_schema_safe.sql
├─ 01_sanity_checks.sql
├─ 02_ratings_analysis.sql
├─ 03_cert_runtime_analysis.sql
├─ 04_views.sql (optional)
├─ load_to_mysql.py (loads CSVs only; no DROP/CREATE)
├─ movies.csv genres.csv directors.csv stars.csv
├─ movie_genres.csv movie_directors.csv movie_stars.csv
├─ plots/ (saved charts)
└─ README.md (this file)

pgsql
Copy code

> **Expected row counts after load (approx):**  
> movies ≈ **115,988** | genres = **28** | directors ≈ **39,519** | stars ≈ **197,864**  
> movie_genres ≈ **281,691** | movie_directors ≈ **86,361** | movie_stars ≈ **462,111**

---

## 4) Setup

### 4.1 MySQL (safe schema)
Run **`00_schema_safe.sql`** (uses `CREATE TABLE IF NOT EXISTS`; **does not** drop tables):

