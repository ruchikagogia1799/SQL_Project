USE imdb_project;

-- Q1: Average rating by genre (support >= 50)
SELECT g.genre_name,
       ROUND(AVG(m.rating),2) AS avg_rating,
       COUNT(*) AS n_movies
FROM movies m
JOIN movie_genres mg ON m.movie_id = mg.movie_id
JOIN genres g ON mg.genre_id = g.genre_id
WHERE m.rating IS NOT NULL
GROUP BY g.genre_name
HAVING COUNT(*) >= 50
ORDER BY avg_rating DESC;

-- Q2: Top 10 directors by average rating (min 5 rated movies)
SELECT d.director_name,
       ROUND(AVG(m.rating),2) AS avg_rating,
       COUNT(*) AS n_movies
FROM movies m
JOIN movie_directors md ON m.movie_id = md.movie_id
JOIN directors d ON md.director_id = d.director_id
WHERE m.rating IS NOT NULL
GROUP BY d.director_name
HAVING COUNT(*) >= 5
ORDER BY avg_rating DESC
LIMIT 10;
