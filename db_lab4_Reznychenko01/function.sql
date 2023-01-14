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
