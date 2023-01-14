import psycopg2


username = 'reznychenko01_labs'
password = '11111111'
database = 'reznychenko01_labs_DB'
host = 'localhost'
port = '5432'

query_1 = '''
SELECT TRIM(song_name) AS song_name, song_length FROM Songs 
'''
query_2 = '''
SELECT TRIM(genre_name) AS genre_name, COUNT(*) FROM songs, genres
WHERE songs.genre_id = genres.genre_id
GROUP BY genres.genre_id
'''
query_3 = '''
SELECT TRIM(artist_name) AS artist_name, SUM(song_popularity) FROM artists, songs
WHERE artists.artist_id = songs.artist_id
GROUP BY artists.artist_id
'''

conn = psycopg2.connect(user=username, password=password, dbname=database, host=host, port=port)
with conn:
    cur = conn.cursor()
    print('Результат роботи програми main.py:')
    print('\nДовжина кожної пісні')
    cur.execute(query_1)
    for row in cur:
        print(f"{row[0]}: {row[1]}")

    print('\nКількість пісень кожного жанру')
    cur.execute(query_2)
    for row in cur:
        print(f"{row[0]}: {row[1]}")
    
    print('\nСумарна популярність пісень автора')
    cur.execute(query_3)
    for row in cur:
        print(f"{row[0]}: {row[1]}")
