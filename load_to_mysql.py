#!/usr/bin/env python3
import pandas as pd
from sqlalchemy import create_engine, text
from urllib.parse import quote_plus

# === 1) MySQL credentials ===
MYSQL_USER = "root"
MYSQL_PASSWORD = "YOUR_PASSWORD"   # your real password
MYSQL_HOST = "127.0.0.1"
MYSQL_PORT = 3306
MYSQL_DB   = "imdb_project"

# URL-encode password (handles ! @ : / ? etc.)
ENC_PW = quote_plus(MYSQL_PASSWORD)

# === 2) Create engine ===
engine = create_engine(
    f"mysql+pymysql://{MYSQL_USER}:{ENC_PW}@{MYSQL_HOST}:{MYSQL_PORT}/{MYSQL_DB}?charset=utf8mb4",
    future=True
)

# === 3) Optional: truncate before load (set to False if you don't want this) ===
TRUNCATE_FIRST = True

if TRUNCATE_FIRST:
    with engine.begin() as conn:
        conn.execute(text("SET FOREIGN_KEY_CHECKS = 0"))
        for t in [
            "movie_stars",
            "movie_directors",
            "movie_genres",
            "stars",
            "directors",
            "genres",
            "movies",
        ]:
            try:
                conn.execute(text(f"TRUNCATE TABLE {t}"))
            except Exception:
                pass
        conn.execute(text("SET FOREIGN_KEY_CHECKS = 1"))

# === 4) CSV load order ===
tables = [
    ("movies.csv", "movies"),
    ("genres.csv", "genres"),
    ("directors.csv", "directors"),
    ("stars.csv", "stars"),                   # optional
    ("movie_genres.csv", "movie_genres"),
    ("movie_directors.csv", "movie_directors"),
    ("movie_stars.csv", "movie_stars"),       # optional
]

# === 5) Load CSVs ===
for csv_file, table in tables:
    try:
        df = pd.read_csv(csv_file)
        df.to_sql(table, con=engine, if_exists="append", index=False, chunksize=2000)
        print(f"✅ Loaded {len(df)} rows into {table}")
    except FileNotFoundError:
        print(f"⚠️ Skipped {csv_file} (file not found)")
    except Exception as e:
        print(f"❌ Error loading {csv_file} into {table}: {e}")

# === 6) Show row counts ===
with engine.connect() as conn:
    q = """
    SELECT 'movies'          AS table_name, COUNT(*) AS row_count FROM movies
    UNION ALL SELECT 'genres',           COUNT(*) FROM genres
    UNION ALL SELECT 'directors',        COUNT(*) FROM directors
    UNION ALL SELECT 'movie_genres',     COUNT(*) FROM movie_genres
    UNION ALL SELECT 'movie_directors',  COUNT(*) FROM movie_directors
    UNION ALL SELECT 'stars',            COUNT(*) FROM stars
    UNION ALL SELECT 'movie_stars',      COUNT(*) FROM movie_stars;
    """
    rows = conn.execute(text(q)).all()
    print("\n📊 Row counts:")
    for name, count in rows:
        print(f"- {name:15s} {count}")

print("\n🎉 All tables loaded successfully.")
