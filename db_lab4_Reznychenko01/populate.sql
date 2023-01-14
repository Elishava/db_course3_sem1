--------------------------
-- Populate Artists table
--------------------------
INSERT INTO Artists(artist_id, artist_name) 
VALUES(1, 'Ariana Grande'),
(2, 'Ed Sheeran'),
(3, 'Lil Tecca'),
(4, 'Sam Smith'),
(5, 'Lil Nas X'),
(6, 'Bad Bunny'),
(7, 'DJ Snake');

--------------------------
-- Populate Genres table
--------------------------
INSERT INTO Genres(genre_id, genre_name) 
VALUES(1, 'pop'),
(2, 'country rap'),
(3, 'reggaeton'),
(4, 'latin'),
(5, 'boy band'),
(6, 'canadian hip hop');

--------------------------
-- Populate Songs table
--------------------------
INSERT INTO Songs(song_id, song_name, song_length, song_popularity, artist_id, genre_id) 
VALUES(1, 'boyfriend (with Social House)', 120, 88, 1, 1),
(2, 'Beautiful People (feat. Khalid)', 96, 70, 2, 2),
(3, 'I Dont Care (with Justin Bieber)', 155, 95, 3, 3),
(4, 'Ransom', 263, 70, 4, 3),
(5, 'How Do You Sleep?', 182, 62, 4, 2),
(6, 'Old Town Road - Remix', 111, 65, 5, 4),
(7, 'Callaita', 123, 78, 7, 5),
(8, 'Loco Contigo (feat. J. Balvin & Tyga)', 123, 79, 7, 6),
(9, 'Someone You Loved', 85, 84, 7, 6),
(10, 'Money In The Grave (Drake ft. Rick Ross)', 302, 93, 6, 2);
