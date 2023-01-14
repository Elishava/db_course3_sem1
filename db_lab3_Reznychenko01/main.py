import psycopg2
import matplotlib.pyplot as plt
import matplotlib.ticker as ticker


username = 'reznychenko01_labs'
password = '11111111'
database = 'reznychenko01_labs_DB'
host = 'localhost'
port = '5432'

query_1 = '''
CREATE VIEW SongLength AS
SELECT TRIM(song_name) AS song_name, song_length FROM Songs 
'''
query_2 = '''
CREATE VIEW GenreCount AS
SELECT TRIM(genre_name) AS genre_name, COUNT(*) FROM songs, genres
WHERE songs.genre_id = genres.genre_id
GROUP BY genres.genre_id
'''
query_3 = '''
CREATE VIEW ArtistPopularity AS
SELECT TRIM(artist_name) AS artist_name, SUM(song_popularity) FROM artists, songs
WHERE artists.artist_id = songs.artist_id
GROUP BY artists.artist_id
'''

conn = psycopg2.connect(user=username, password=password, dbname=database, host=host, port=port)
with conn:
    fig, (bar_ax, pie_ax, graph_ax) = plt.subplots(1, 3)

    cur = conn.cursor()

    cur.execute('DROP VIEW IF EXISTS SongLength')
    cur.execute(query_1)
    cur.execute('SELECT * FROM SongLength')
    song_name = []
    song_length = []

    for row in cur:
        song_name.append(row[0])
        song_length.append(row[1])

    # bar
    bar_ax.set_title('Довжина кожної пісні')
    bar_ax.set_xlabel('ім\'я пісні')
    bar_ax.set_ylabel('Довжина (с)')
    bar = bar_ax.bar(song_name, song_length)
    bar_ax.set_xticklabels(song_name, rotation=90, size=8)
    bar_ax.yaxis.set_major_locator(ticker.MultipleLocator(100))


    cur.execute('DROP VIEW IF EXISTS GenreCount')
    cur.execute(query_2)
    cur.execute('SELECT * FROM GenreCount')
    genre_name = []
    g_count = []

    for row in cur:
        genre_name.append(row[0])
        g_count.append(row[1])

    # pie
    pie_ax.pie(g_count, labels=genre_name, autopct='%1.1f%%', rotatelabels=True)
    pie_ax.set_title('Кількість пісень кожного жанру')


    cur.execute('DROP VIEW IF EXISTS ArtistPopularity')
    cur.execute(query_3)
    cur.execute('SELECT * FROM ArtistPopularity')
    artist_name = []
    song_popularity = []

    for row in cur:
        artist_name.append(row[0])
        song_popularity.append(row[1])

    # graph
    graph_ax.plot(artist_name, song_popularity, marker='o')
    graph_ax.set_xlabel('Автор')
    graph_ax.set_ylabel('Популярність пісень')
    graph_ax.set_title('Сумарна популярність пісень автора')
    for gnr, count in zip(artist_name, song_popularity):
        graph_ax.annotate(count, xy=(gnr, count), xytext=(7, 2), textcoords='offset points')
    graph_ax.yaxis.set_major_locator(ticker.MultipleLocator(50))
    graph_ax.set_xticklabels(artist_name, rotation=90, size=8)

plt.show()
