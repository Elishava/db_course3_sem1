-- ФУНКЦІЯ (знаходження найпопулярнішої пісні артиста)

DROP FUNCTION IF EXISTS most_populary;

CREATE OR REPLACE FUNCTION most_populary(art_name character(50))
RETURNS INTEGER
LANGUAGE 'plpgsql'
AS $$
   BEGIN
      RETURN (SELECT MAX(song_popularity) 
              FROM Artists, Songs 
              WHERE Artists.artist_name = art_name 
              AND Artists.artist_id = Songs.artist_id );
   END;
$$

SELECT artist_name, song_popularity 
FROM artists, songs
WHERE Artists.artist_id = Songs.artist_id

SELECT most_populary('Lil Tecca')
SELECT most_populary('DJ Snake')





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


-- ТРІГЕР (додає 10 до популярності новододаної пісні)

DROP TRIGGER IF EXISTS added_new_song ON songs;
DROP FUNCTION IF EXISTS new_data CASCADE;

CREATE FUNCTION new_data() RETURNS TRIGGER
LANGUAGE 'plpgsql'
AS
$$
   BEGIN 
      UPDATE Songs
      SET song_popularity = NEW.song_popularity + 10
      WHERE 
         songs.song_id = NEW.song_id;
      RETURN NULL;
   END;
$$;

CREATE TRIGGER added_new_song
AFTER INSERT ON Songs
FOR EACH ROW EXECUTE FUNCTION new_data();

SELECT * FROM songs
CALL add_new_song('Hello World 2', 200, 100, 1, 1)
SELECT * FROM songs



