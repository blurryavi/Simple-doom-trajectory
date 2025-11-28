 CREATE TABLE IF NOT EXISTS user_game (
    user_id SERIAL PRIMARY KEY,
    age INT,
    name VARCHAR(100) UNIQUE,
    gender VARCHAR(15)
);

CREATE TABLE IF NOT EXISTS uxinstrument (
    instrument_id SERIAL PRIMARY KEY,
    num_item INT,
    description VARCHAR(200) UNIQUE,
    type_instrument VARCHAR(12)
);

CREATE TABLE IF NOT EXISTS item (
    item_id SERIAL PRIMARY KEY,
    instrument_id INT NOT NULL,
    statement VARCHAR(300),
    CONSTRAINT fk_item_instrument FOREIGN KEY (instrument_id) REFERENCES uxinstrument(instrument_id),
    CONSTRAINT uq_item_instrument_statement UNIQUE (instrument_id, statement)
);

CREATE TABLE IF NOT EXISTS uxresponse (
    response_id SERIAL PRIMARY KEY,
    instrument_id INT NOT NULL,
    user_id INT NOT NULL,
    CONSTRAINT fk_response_instrument FOREIGN KEY (instrument_id) REFERENCES uxinstrument(instrument_id),
    CONSTRAINT fk_response_user FOREIGN KEY (user_id) REFERENCES user_game(user_id),
    CONSTRAINT uq_response_instrument_user UNIQUE (instrument_id, user_id)
);

CREATE TABLE IF NOT EXISTS item_response (
    itemresponse_id SERIAL PRIMARY KEY,
    response INT CHECK (response BETWEEN 1 AND 7),
    response_id INT NOT NULL,
    item_id INT NOT NULL,
    CONSTRAINT fk_itemresponse_response FOREIGN KEY (response_id) REFERENCES uxresponse(response_id),
    CONSTRAINT fk_itemresponse_item FOREIGN KEY (item_id) REFERENCES item(item_id),
    CONSTRAINT uq_itemresponse_response_item UNIQUE (response_id, item_id)
);

CREATE TABLE IF NOT EXISTS player (
    player_id SERIAL PRIMARY KEY,
    nickname VARCHAR(60) UNIQUE,
    user_id INT,
    CONSTRAINT fk_player_user FOREIGN KEY (user_id) REFERENCES user_game(user_id)
);

CREATE TABLE IF NOT EXISTS game (
    game_id SERIAL PRIMARY KEY,
    player_id INT NOT NULL,
    started TIMESTAMP,
    ended TIMESTAMP,
    CONSTRAINT fk_game_player FOREIGN KEY (player_id) REFERENCES player(player_id)
);

CREATE TABLE IF NOT EXISTS tic (
    tic_id SERIAL PRIMARY KEY,
    game_id INT,
    time TIMESTAMP NOT NULL,
    CONSTRAINT fk_tic_game FOREIGN KEY (game_id) REFERENCES game(game_id)
);


CREATE TABLE IF NOT EXISTS episode (
    episode_id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS map (
    map_id INT PRIMARY KEY,
    name VARCHAR(100),
    episode_id INT,
    map_number INT NOT NULL,
    CONSTRAINT fk_map_episode FOREIGN KEY (episode_id) REFERENCES episode(episode_id)
);

-- a tic is tied to a specific map

CREATE TABLE IF NOT EXISTS sector (
    sector_id SERIAL PRIMARY KEY,
    map_id INT NOT NULL REFERENCES map(map_id),
    sx INT NOT NULL,
    sy INT NOT NULL,
    x_min INT NOT NULL,
    x_max INT NOT NULL,
    y_min INT NOT NULL,
    y_max INT NOT NULL,
    CONSTRAINT uq_sector_map_sx_sy UNIQUE (map_id, sx, sy)
);

CREATE TABLE IF NOT EXISTS telemetry (
    telemetry_id SERIAL PRIMARY KEY,
    x_axis INT,
    y_axis INT,
    z_axis INT,
    angle INT,
    momx NUMERIC(7,2),
    momy INT,
    tic_id INT,
    sector_id INT,
    CONSTRAINT fk_telemetry_tic FOREIGN KEY (tic_id) REFERENCES tic(tic_id),
    CONSTRAINT fk_sector_id FOREIGN KEY (sector_id) REFERENCES sector(sector_id)
);

CREATE TABLE IF NOT EXISTS game_episode (
    game_episode_id SERIAL PRIMARY KEY,
    game_id INT REFERENCES game(game_id),
    started TIMESTAMP,
    episode_id INT REFERENCES episode(episode_id)
);

CREATE TABLE IF NOT EXISTS episode_map (
    episode_map_id SERIAL PRIMARY KEY,
    map_id INT REFERENCES map(map_id),
    started TIMESTAMP,
    game_episode_id INT REFERENCES game_episode(game_episode_id)
);

INSERT INTO episode (episode_id, name) VALUES
(1, 'Knee-Deep in the Dead'),
(2, 'The Shores of Hell'),
(3, 'Inferno'),
(4, 'Thy Flesh Consumed')
ON CONFLICT (episode_id) DO NOTHING;

INSERT INTO map (map_id, map_number, name, episode_id) VALUES
(1, 1, 'Hangar', 1),
(2, 2, 'Nuclear Plant', 1),
(3, 3, 'Toxin Refinery', 1),
(4, 4, 'Command Control', 1),
(5, 5, 'Phobos Lab', 1),
(6, 6, 'Central Processing', 1),
(7, 7, 'Computer Station', 1),
(8, 8, 'Phobos Anomaly', 1),
(9, 9, 'Military Base', 1),
(10, 1, 'Deimos Anomaly', 2),
(11, 2, 'Containment Area', 2),
(12, 3, 'Refinery', 2),
(13, 4, 'Deimos Lab', 2),
(14, 5, 'Command Center', 2),
(15, 6, 'Halls of the Damned', 2),
(16, 7, 'Spawning Vats', 2),
(17, 8, 'Tower of Babel', 2),
(18, 9, 'Fortress of Mystery', 2),
(19, 1, 'Hell Keep', 3),
(20, 2, 'Slough of Despair', 3),
(21, 3, 'Pandemonium', 3),
(22, 4, 'House of Pain', 3),
(23, 5, 'Unholy Cathedral', 3),
(24, 6, 'Mt. Erebus', 3),
(25, 7, 'Limbo', 3),
(26, 8, 'Dis', 3),
(27, 9, 'Warped', 3),
(28, 1, 'Hell Beneath', 4),
(29, 2, 'Perfect Hatred', 4),
(30, 3, 'Sever The Wicked', 4),
(31, 4, 'Unruly Evil', 4),
(32, 5, 'They Will Repent', 4),
(33, 6, 'Against Thee Wickedly', 4),
(34, 7, 'And Hell Followed', 4),
(35, 8, 'Unto The Cruel', 4),
(36, 9, 'Fear', 4)
ON CONFLICT (map_id) DO NOTHING;

INSERT INTO uxinstrument (instrument_id, num_item, description, type_instrument) VALUES
(1, 18, 'Game User Experience Satisfaction Scale', 'GUESS')
ON CONFLICT (instrument_id) DO NOTHING;

INSERT INTO item (instrument_id, statement) VALUES
(1, 'I find the controls of the game to be straightforward.'),
(1, 'I find the games interface to be easy to navigate.'),
(1, 'I am captivated by the game''s story from the beginning.'),
(1, 'I enjoy the fantasy or story provided by the game.'),
(1, 'I feel detached from the outside world while playing the game.'),
(1, 'I do not care to check events that are happening in the real world during the game.'),
(1, 'I think the game is fun.'),
(1, 'I feel bored while playing the game.'),
(1, 'I feel the game allows me to be imaginative.'),
(1, 'I feel creative while playing the game.'),
(1, 'I enjoy the sound effects in the game.'),
(1, 'I feel the games audio (e.g., sound effects, music) enhances my gaming experience.'),
(1, 'I am very focused on my own performance while playing the game.'),
(1, 'I want to do as well as possible during the game.'),
(1, 'I find the game supports social interaction (e.g., chat) between players.'),
(1, 'I like to play this game with other players.'),
(1, 'I enjoy the games graphics.'),
(1, 'I think the game is visually appealing.')
ON CONFLICT ON CONSTRAINT uq_item_instrument_statement DO NOTHING;

INSERT INTO user_game (user_id, age, name, gender) VALUES
(1, 18, 'Salome Avila Torres', 'Female'),
(2, 19, 'Solon Losada', 'Male'),
(3, 20, 'Mateo Traslaviña', 'Male'),
(4, 20, 'Juan Pablo Peña', 'Male'),
(5, 20, 'Alejando Martinez Mesa', 'Male')
ON CONFLICT (user_id) DO NOTHING;

INSERT INTO uxresponse (response_id, instrument_id, user_id) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 3),
(4, 1, 4)
ON CONFLICT (response_id) DO NOTHING;

-- Bloque 1 (response_id = 1)
INSERT INTO item_response (response, response_id, item_id) VALUES
(7, 1, 1),
(6, 1, 2),
(7, 1, 3),
(6, 1, 4),
(6, 1, 5),
(5, 1, 6),
(7, 1, 7),
(2, 1, 8),
(6, 1, 9),
(6, 1, 10),
(7, 1, 11),
(7, 1, 12),
(6, 1, 13),
(7, 1, 14),
(5, 1, 15),
(6, 1, 16),
(7, 1, 17),
(7, 1, 18)
ON CONFLICT ON CONSTRAINT uq_itemresponse_response_item DO NOTHING;

INSERT INTO item_response (response, response_id, item_id) VALUES
(6, 2, 1),
(7, 2, 2),
(5, 2, 3),
(6, 2, 4),
(6, 2, 5),
(2, 2, 6),
(6, 2, 7),
(2, 2, 8),
(3, 2, 9),
(4, 2, 10),
(7, 2, 11),
(5, 2, 12),
(6, 2, 13),
(7, 2, 14),
(1, 2, 15),
(1, 2, 16),
(3, 2, 17),
(4, 2, 18)
ON CONFLICT ON CONSTRAINT uq_itemresponse_response_item DO NOTHING;

INSERT INTO item_response (response, response_id, item_id) VALUES
(6, 3, 1),
(7, 3, 2),
(7, 3, 3),
(7, 3, 4),
(6, 3, 5),
(6, 3, 6),
(7, 3, 7),
(2, 3, 8),
(7, 3, 9),
(7, 3, 10),
(7, 3, 11),
(7, 3, 12),
(7, 3, 13),
(7, 3, 14),
(6, 3, 15),
(7, 3, 16),
(7, 3, 17),
(7, 3, 18)
ON CONFLICT ON CONSTRAINT uq_itemresponse_response_item DO NOTHING;


INSERT INTO player (nickname, user_id) VALUES
('sal', 1),
('elpepe', 4),
('pepardo', 4),
('solonlosada2006', 2),
('pepardo2', 4),
('alejandro3', 5),
('pepito', 3)
ON CONFLICT (nickname) DO NOTHING;
