-- SELECT * FROM artists

DO $$
DECLARE
    artist_id   artists.artist_id%TYPE;
    artist_name artists.artist_name%TYPE;

BEGIN
    artist_id := 0;
    artist_name := 'Name';
    FOR counter IN 1..5
        LOOP
            INSERT INTO artists(artist_id, artist_name)
            VALUES (artist_id + counter, artist_name || counter);
        END LOOP;
END;
$$
