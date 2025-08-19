
-- IMDb Project Schema (MySQL)
CREATE DATABASE IF NOT EXISTS imdb_project;
USE imdb_project;

DROP TABLE IF EXISTS movie_stars;
DROP TABLE IF EXISTS stars;
DROP TABLE IF EXISTS movie_directors;
DROP TABLE IF EXISTS directors;
DROP TABLE IF EXISTS movie_genres;
DROP TABLE IF EXISTS genres;
DROP TABLE IF EXISTS movies;

CREATE TABLE movies (
  movie_id INT UNSIGNED NOT NULL,
  movie VARCHAR(255) NOT NULL,
  runtime_mins SMALLINT UNSIGNED NULL,
  certificate VARCHAR(20) NULL,
  rating DECIMAL(3,1) NULL,
  votes_num INT UNSIGNED NULL,
  description TEXT NULL,
  PRIMARY KEY (movie_id),
  INDEX idx_movies_title (movie)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE genres (
  genre_id INT UNSIGNED NOT NULL,
  genre_name VARCHAR(50) NOT NULL,
  PRIMARY KEY (genre_id),
  UNIQUE KEY uk_genre_name (genre_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE movie_genres (
  movie_id INT UNSIGNED NOT NULL,
  genre_id INT UNSIGNED NOT NULL,
  PRIMARY KEY (movie_id, genre_id),
  CONSTRAINT fk_mg_movie FOREIGN KEY (movie_id) REFERENCES movies(movie_id) ON DELETE CASCADE,
  CONSTRAINT fk_mg_genre FOREIGN KEY (genre_id) REFERENCES genres(genre_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE directors (
  director_id INT UNSIGNED NOT NULL,
  director_name VARCHAR(200) NOT NULL,
  PRIMARY KEY (director_id),
  UNIQUE KEY uk_director_name (director_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE movie_directors (
  movie_id INT UNSIGNED NOT NULL,
  director_id INT UNSIGNED NOT NULL,
  PRIMARY KEY (movie_id, director_id),
  CONSTRAINT fk_md_movie FOREIGN KEY (movie_id) REFERENCES movies(movie_id) ON DELETE CASCADE,
  CONSTRAINT fk_md_director FOREIGN KEY (director_id) REFERENCES directors(director_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE stars (
  star_id INT UNSIGNED NOT NULL,
  star_name VARCHAR(200) NOT NULL,
  PRIMARY KEY (star_id),
  UNIQUE KEY uk_star_name (star_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE movie_stars (
  movie_id INT UNSIGNED NOT NULL,
  star_id INT UNSIGNED NOT NULL,
  PRIMARY KEY (movie_id, star_id),
  CONSTRAINT fk_ms_movie FOREIGN KEY (movie_id) REFERENCES movies(movie_id) ON DELETE CASCADE,
  CONSTRAINT fk_ms_star FOREIGN KEY (star_id) REFERENCES stars(star_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
