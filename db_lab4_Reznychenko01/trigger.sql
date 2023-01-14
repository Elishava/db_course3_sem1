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