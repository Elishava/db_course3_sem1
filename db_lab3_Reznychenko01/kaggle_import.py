import psycopg2
import matplotlib.pyplot as plt
import csv
import pandas as pd
import numpy as np


username = 'reznychenko01_labs'
password = '11111111'
database = 'reznychenko01_labs_DB'
host = 'localhost'
port = '5432'


query_0 = """
DELETE FROM Songs;
DELETE FROM Artists;
DELETE FROM Genres;
"""

query_artists = """
INSERT INTO Artists(artist_id, artist_name) VALUES ('%s', '%s')
"""

query_genres = """
INSERT INTO Genres(genre_id, genre_name) VALUES ('%s', '%s')
"""

query_songs = """
INSERT INTO Songs(song_id, song_name, song_length, song_popularity, artist_id, genre_id) 
VALUES ('%s', '%s', '%s', '%s', 
(SELECT artist_id FROM artists WHERE artist_name = '%s'), 
(SELECT genre_id FROM genres WHERE genre_name = '%s'))
"""


data = pd.read_csv(r'top50.csv', encoding="ISO-8859-1")

conn = psycopg2.connect(user=username, password=password, dbname=database)

with conn:
    cur = conn.cursor()
    cur.execute(query_0)

    df = pd.DataFrame(data, columns=['Track.Name', 'Artist.Name', 'Genre', 'Length.', 'Popularity'])

    cur1 = conn.cursor()
    a_name = df['Artist.Name'].tolist()

    unique_a_name = set(a_name)

    i = 0
    for el in unique_a_name:
        query = query_artists % (i, el)
        cur1.execute(query)
        i += 1
    conn.commit()


    cur2 = conn.cursor()
    g_name = df['Genre'].tolist()

    unique_g_name = set(g_name)

    i = 0
    for el in unique_g_name:
        query = query_genres % (i, el)
        cur2.execute(query)
        i += 1
    conn.commit()


    cur3 = conn.cursor()
    s_name = df['Track.Name'].tolist()
    s_length = df['Length.'].tolist()
    s_popularity = df['Popularity'].tolist()

    for i in range(len(s_name)):
        s_name[i] = s_name[i].replace('\'', '')
        query = query_songs % (i, s_name[i], s_length[i], s_popularity[i], a_name[i], g_name[i])
        cur3.execute(query)
    conn.commit()

