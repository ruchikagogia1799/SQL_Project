-- Certification impact on ratings (top certs only)
SELECT certificate,
       ROUND(AVG(rating),2) AS avg_rating,
       COUNT(*) AS n_titles
FROM movies
WHERE rating IS NOT NULL AND certificate IS NOT NULL AND certificate <> ''
GROUP BY certificate
HAVING COUNT(*) >= 200
ORDER BY avg_rating DESC;

-- Long vs short: does runtime correlate with rating?
SELECT CASE 
         WHEN runtime_mins IS NULL THEN 'Unknown'
         WHEN runtime_mins < 90 THEN '<90'
         WHEN runtime_mins <= 120 THEN '90–120'
         WHEN runtime_mins <= 150 THEN '121–150'
         ELSE '>150'
       END AS runtime_bucket,
       ROUND(AVG(rating),2) AS avg_rating,
       COUNT(*) AS n_titles
FROM movies
WHERE rating IS NOT NULL
GROUP BY runtime_bucket
ORDER BY FIELD(runtime_bucket,'<90','90–120','121–150','>150','Unknown');
