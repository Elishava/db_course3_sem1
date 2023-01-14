-- ПРОЦЕДУРА (додає нову пісню в таблицю)

DROP PROCEDURE add_new_song

CREATE OR REPLACE PROCEDURE add_new_song(s_name char(50), s_length int, s_popularity int, a_id int, g_id int)
LANGUAGE'plpgsql'
AS $$
   DECLARE 
      s_id songs.song_id%type;
   BEGIN
      SELECT (song_id+1) INTO s_id FROM songs ORDER BY song_id DESC LIMIT 1;
      INSERT INTO songs(song_id, song_name, song_length, song_popularity, artist_id, genre_id)
      VALUES(s_id, s_name, s_length, s_popularity, a_id, g_id);
   END;
$$


SELECT * FROM songs
CALL add_new_song('Hello World 1', 200, 100, 1, 1)
SELECT * FROM songs