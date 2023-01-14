-- Довжина кожної пісні
SELECT TRIM(song_name) AS song_name, song_length FROM Songs 

-- Кількість пісень кожного жанру
SELECT TRIM(genre_name) AS genre_name, COUNT(*) FROM songs, genres
WHERE songs.genre_id = genres.genre_id
GROUP BY genres.genre_id

-- Сумарна популярність пісень автора
SELECT TRIM(artist_name) AS artist_name, SUM(song_popularity) FROM artists, songs
WHERE artists.artist_id = songs.artist_id
GROUP BY artists.artist_id
