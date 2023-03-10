-------------------------
-- Create Genres table
-------------------------
CREATE TABLE Genres
(
  genre_id      int        NOT NULL ,
  genre_name    char(50)  NOT NULL
);

--------------------------
-- Create Songs table
--------------------------
CREATE TABLE Songs
(
  song_id         int        NOT NULL ,
  song_name       char(200)  NOT NULL ,
  song_length     int        NULL ,
  song_popularity int        NULL ,
  artist_id       int        NOT NULL ,
  genre_id        int        NOT NULL 
);

--------------------------
-- Create Artists table
--------------------------
CREATE TABLE Artists
(
  artist_id      int       NOT NULL ,
  artist_name    char(100)  NOT NULL 
);


----------------------
-- Define primary keys
----------------------
ALTER TABLE Genres ADD CONSTRAINT PK_Genre PRIMARY KEY (genre_id);
ALTER TABLE Songs ADD CONSTRAINT PK_Songs PRIMARY KEY (song_id);
ALTER TABLE Artists ADD CONSTRAINT PK_Artists PRIMARY KEY (artist_id);

----------------------
-- Define foreign keys
----------------------
ALTER TABLE Songs ADD CONSTRAINT FK_Songs_Artists FOREIGN KEY (artist_id) REFERENCES Artists (artist_id);
ALTER TABLE Songs ADD CONSTRAINT FK_Songs_Genres FOREIGN KEY (genre_id) REFERENCES Genres (genre_id);