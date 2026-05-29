-- =========================================
-- MUSIC APP DATABASE (REVISED FOR lib.zip)
-- PostgreSQL-friendly
-- =========================================

-- USERS
CREATE TABLE users (
id VARCHAR(64) PRIMARY KEY,
name VARCHAR(120) NOT NULL,
email VARCHAR(190) UNIQUE NOT NULL,
role VARCHAR(20) NOT NULL DEFAULT 'User', -- Admin / User
active BOOLEAN NOT NULL DEFAULT TRUE,
joined_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT chk_user_role CHECK (role IN ('Admin', 'User'))
);

-- ARTISTS
CREATE TABLE artists (
id VARCHAR(64) PRIMARY KEY,
name VARCHAR(160) NOT NULL,
genre VARCHAR(80) DEFAULT '',
monthly_listeners INT NOT NULL DEFAULT 0,
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT uq_artist_name UNIQUE (name)
);

-- ALBUMS
CREATE TABLE albums (
id VARCHAR(64) PRIMARY KEY,
title VARCHAR(160) NOT NULL,
artist_id VARCHAR(64) NOT NULL,
release_year INT,
cover_url TEXT,
track_count INT NOT NULL DEFAULT 0, -- matches Admin Album.tracks
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (artist_id) REFERENCES artists(id) ON DELETE RESTRICT
);

-- SONGS
CREATE TABLE songs (
id VARCHAR(64) PRIMARY KEY,
title VARCHAR(200) NOT NULL,
artist_id VARCHAR(64) NOT NULL,
album_id VARCHAR(64),
duration_sec INT NOT NULL DEFAULT 0,
genre VARCHAR(80) DEFAULT '',
audio_url TEXT, -- matches Song.audioUrl
cover_url TEXT, -- matches Song.cover
streams BIGINT NOT NULL DEFAULT 0,
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (artist_id) REFERENCES artists(id) ON DELETE RESTRICT,
FOREIGN KEY (album_id) REFERENCES albums(id) ON DELETE SET NULL
);

-- PLAYLISTS
CREATE TABLE playlists (
id VARCHAR(64) PRIMARY KEY,
name VARCHAR(160) NOT NULL,
description TEXT DEFAULT '',
cover_url TEXT,
gradient VARCHAR(80) DEFAULT 'from-purple-600 to-blue-600',
owner_user_id VARCHAR(64), -- NULL = system playlist
is_public BOOLEAN NOT NULL DEFAULT TRUE,
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (owner_user_id) REFERENCES users(id) ON DELETE SET NULL
);

-- PLAYLIST ITEMS (allows duplicates + ordering)
CREATE TABLE playlist_items (
id BIGSERIAL PRIMARY KEY,
playlist_id VARCHAR(64) NOT NULL,
song_id VARCHAR(64) NOT NULL,
position INT NOT NULL,
added_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (playlist_id) REFERENCES playlists(id) ON DELETE CASCADE,
FOREIGN KEY (song_id) REFERENCES songs(id) ON DELETE CASCADE,
CONSTRAINT uq_playlist_position UNIQUE (playlist_id, position)
);

-- USER FAVORITES
CREATE TABLE user_favorites (
user_id VARCHAR(64) NOT NULL,
song_id VARCHAR(64) NOT NULL,
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (user_id, song_id),
FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
FOREIGN KEY (song_id) REFERENCES songs(id) ON DELETE CASCADE
);

-- SUBSCRIPTIONS
CREATE TABLE subscriptions (
id VARCHAR(64) PRIMARY KEY,
user_id VARCHAR(64) NOT NULL,
plan VARCHAR(20) NOT NULL, -- Premium / Family / Student
status VARCHAR(20) NOT NULL, -- Active / Canceled / PastDue
renews_on DATE NOT NULL,
started_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
canceled_at TIMESTAMP,
FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
CONSTRAINT chk_plan CHECK (plan IN ('Premium', 'Family', 'Student')),
CONSTRAINT chk_sub_status CHECK (status IN ('Active', 'Canceled', 'PastDue'))
);

-- PLAY EVENTS (ANALYTICS)
CREATE TABLE play_events (
id BIGSERIAL PRIMARY KEY,
user_id VARCHAR(64),
song_id VARCHAR(64) NOT NULL,
played_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
seconds_listened INT NOT NULL DEFAULT 0,
device VARCHAR(60) DEFAULT '',
FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL,
FOREIGN KEY (song_id) REFERENCES songs(id) ON DELETE CASCADE
);

-- ==========================
-- INDEXES (PERFORMANCE)
-- ==========================
CREATE INDEX idx_songs_title ON songs(title);
CREATE INDEX idx_songs_artist ON songs(artist_id);
CREATE INDEX idx_songs_album ON songs(album_id);

CREATE INDEX idx_play_song_time ON play_events(song_id, played_at);
CREATE INDEX idx_play_user_time ON play_events(user_id, played_at);

CREATE INDEX idx_playlist_items_pid ON playlist_items(playlist_id);
CREATE INDEX idx_fav_user ON user_favorites(user_id);

-- ==========================
-- OPTIONAL: "APP-FRIENDLY" VIEWS
-- (gives you artistName / albumTitle like the Flutter models)
-- ==========================
CREATE VIEW v_songs AS
SELECT
s.id,
s.title,
a.name AS artist_name,
al.title AS album_title,
s.duration_sec,
s.genre,
s.streams,
s.audio_url,
s.cover_url,
s.created_at
FROM songs s
JOIN artists a ON a.id = s.artist_id
LEFT JOIN albums al ON al.id = s.album_id;

CREATE VIEW v_albums AS
SELECT
al.id,
al.title,
a.name AS artist_name,
al.release_year,
al.cover_url,
al.track_count,
al.created_at
FROM albums al
JOIN artists a ON a.id = al.artist_id;
