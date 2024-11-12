-- 1. Получение списка всех фильмов с их жанрами и годом выпуска, отсортированных по году
SELECT primaryTitle AS MovieTitle, genres, startYear
FROM title_basics
WHERE titleType = 'movie'
ORDER BY startYear;

-- 2. Получение среднего рейтинга и количества голосов для каждого фильма, отсортированных по рейтингу
SELECT b.primaryTitle AS MovieTitle, r.averageRating AS AvgRating, r.numVotes AS VoteCount
FROM title_basics b
JOIN title_ratings r ON b.tconst = r.tconst
WHERE b.titleType = 'movie'
ORDER BY r.averageRating DESC, r.numVotes DESC;

-- 3. Поиск топ-10 фильмов с наивысшим рейтингом и минимумом в 1000 голосов
SELECT b.primaryTitle AS MovieTitle, r.averageRating AS AvgRating, r.numVotes AS VoteCount
FROM title_basics b
JOIN title_ratings r ON b.tconst = r.tconst
WHERE b.titleType = 'movie' AND r.numVotes >= 1000
ORDER BY r.averageRating DESC
LIMIT 10;

-- 4. Подсчет количества фильмов по жанрам
SELECT genres, COUNT(*) AS MovieCount
FROM title_basics
WHERE titleType = 'movie'
GROUP BY genres
ORDER BY MovieCount DESC;

-- 5. Извлечение информации об участниках (актеры, режиссеры) для определенного фильма
SELECT p.nconst AS PersonID, p.category AS Role, b.primaryTitle AS MovieTitle
FROM title_principals p
JOIN title_basics b ON p.tconst = b.tconst
WHERE b.primaryTitle = 'Inception' AND b.titleType = 'movie';

-- 6. Поиск топ-5 актеров, участвовавших в наибольшем количестве фильмов
SELECT p.nconst AS ActorID, COUNT(p.tconst) AS MovieCount
FROM title_principals p
JOIN title_basics b ON p.tconst = b.tconst
WHERE b.titleType = 'movie' AND p.category = 'actor'
GROUP BY p.nconst
ORDER BY MovieCount DESC
LIMIT 5;

-- 7. Анализ изменения среднего рейтинга фильмов по годам
SELECT b.startYear AS Year, AVG(r.averageRating) AS AvgRating
FROM title_basics b
JOIN title_ratings r ON b.tconst = r.tconst
WHERE b.titleType = 'movie' AND b.startYear IS NOT NULL
GROUP BY b.startYear
ORDER BY Year;