USE imdb_project;

-- Row counts
SELECT 
  (SELECT COUNT(*) FROM movies) AS movies,
  (SELECT COUNT(*) FROM genres) AS genres,
  (SELECT COUNT(*) FROM directors) AS directors,
  (SELECT COUNT(*) FROM movie_genres) AS movie_genres,
  (SELECT COUNT(*) FROM movie_directors) AS movie_directors;

-- Spot-check a popular movie with its genres
SELECT 
    m.movie, 
    GROUP_CONCAT(g.genre_name ORDER BY g.genre_name) AS genres  
FROM movies m  
JOIN movie_genres mg ON m.movie_id = mg.movie_id  
JOIN genres g ON mg.genre_id = g.genre_id  
GROUP BY m.movie, m.votes_num
ORDER BY m.votes_num DESC  
LIMIT 5;
