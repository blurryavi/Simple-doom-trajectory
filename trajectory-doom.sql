CREATE TABLE user_game (
  -- serial para auto-incrementar
    user_id SERIAL PRIMARY KEY,
    age INT,
    name VARCHAR(30),
    gender VARCHAR(15)
);

-- Encuestas

CREATE TABLE UXInstrument (
  instrument_id SERIAL PRIMARY KEY,
  num_item INT,
  description VARCHAR(100),
  type_instrument VARCHAR(6)
);

CREATE TABLE Item (
  item_id SERIAL PRIMARY KEY,
  instrument_id INT NOT NULL,
  statement VARCHAR(50),
  FOREIGN KEY (instrument_id) REFERENCES UXInstrument(instrument_id)
);

CREATE TABLE UXResponse (
  response_id SERIAL PRIMARY KEY,
  instrument_id INT NOT NULL,
  user_id INT NOT NULL,
  FOREIGN KEY (instrument_id) REFERENCES UXInstrument(instrument_id),
  FOREIGN KEY (user_id) REFERENCES user_game(user_id)
);

CREATE TABLE Item_response (
  itemresponse_id SERIAL PRIMARY KEY,
  response INT CHECK (response BETWEEN 1 AND 7),
  response_id INT NOT NULL,
  item_id INT NOT NULL,
  FOREIGN KEY (response_id) REFERENCES UXResponse(response_id),
  FOREIGN KEY (item_id) REFERENCES Item(item_id)
);

-- juego

CREATE TABLE player (
    player_id SERIAL PRIMARY KEY,
    nickname VARCHAR(30),
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES user_game(user_id)
  );

CREATE TABLE game (
  game_id SERIAL PRIMARY KEY,
  player_id INT NOT NULL,
  started TIMESTAMP,
  ended TIMESTAMP,
  FOREIGN KEY (player_id) REFERENCES player(player_id)
);


CREATE TABLE tic (
  tic_id SERIAL PRIMARY KEY,
  game_id int,
  time TIMESTAMP NOT NULL,
  FOREIGN KEY(game_id) REFERENCES game(game_id)
);

CREATE TABLE telemetry (
    telemetry_id SERIAL PRIMARY KEY,
    x_axis int,
    y_axis int,
    z_axis int,
    angle int,
    momx numeric(5,2),
    momy int,
    health INT,
    ammo INT,
    armor INT,
    tic_id INT,
    FOREIGN KEY (tic_id) REFERENCES tic(tic_id)
);


CREATE TABLE Episode (
  episode_id int NOT NULL PRIMARY KEY,
  name VARCHAR(30)
);

CREATE TABLE Map (
  map_id int NOT NULL PRIMARY KEY,
  name VARCHAR(30),
  episode_id int,
  map_number int NOT NULL, -- relativo al episodio
  FOREIGN KEY(episode_id) REFERENCES episode(episode_id)
);

CREATE TABLE Sector (
  sector_id SERIAL PRIMARY KEY,
  name VARCHAR(30),
  episode_id int,
  FOREIGN KEY(episode_id) REFERENCES Episode(episode_id)
);

CREATE TABLE game_episode (
    game_episode_id SERIAL PRIMARY KEY,
    game_id INT REFERENCES game(game_id),
    started TIMESTAMP,
    episode_id INT REFERENCES episode(episode_id)
);

CREATE TABLE episode_map (
    episode_map_id SERIAL PRIMARY KEY,
    map_id INT REFERENCES map(map_id),
    started TIMESTAMP,
    game_episode_id INT REFERENCES game_episode(game_episode_id)
);

-- Episodes
INSERT INTO Episode (episode_id, name) VALUES (1, 'Knee-Deep in the Dead');
INSERT INTO Episode (episode_id, name) VALUES (2, 'The Shores of Hell');
INSERT INTO Episode (episode_id, name) VALUES (3, 'Inferno');
INSERT INTO Episode (episode_id, name) VALUES (4, 'Thy Flesh Consumed');

-- Maps for Episode 1
INSERT INTO Map (map_id, map_number, name, episode_id) VALUES (1, 1, 'Hangar', 1);
INSERT INTO Map (map_id, map_number, name, episode_id) VALUES (2, 2, 'Nuclear Plant', 1); 
INSERT INTO Map (map_id, map_number, name, episode_id) VALUES (3, 3, 'Toxin Refinery', 1);
INSERT INTO Map (map_id, map_number, name, episode_id) VALUES (4, 4, 'Command Control', 1);
INSERT INTO Map (map_id, map_number, name, episode_id) VALUES (5, 5, 'Phobos Lab', 1);
INSERT INTO Map (map_id, map_number, name, episode_id) VALUES (6, 6, 'Central Processing', 1);
INSERT INTO Map (map_id, map_number, name, episode_id) VALUES (7, 7, 'Computer Station', 1);
INSERT INTO Map (map_id, map_number, name, episode_id) VALUES (8, 8, 'Phobos Anomaly', 1);
INSERT INTO Map (map_id, map_number, name, episode_id) VALUES (9, 9, 'Military Base', 1);

-- Maps for Episode 2
INSERT INTO Map (map_id, map_number, name, episode_id) VALUES (10, 1, 'Deimos Anomaly', 2);
INSERT INTO Map (map_id, map_number, name, episode_id) VALUES (11, 2, 'Containment Area', 2);
INSERT INTO Map (map_id, map_number, name, episode_id) VALUES (12, 3, 'Refinery', 2);
INSERT INTO Map (map_id, map_number, name, episode_id) VALUES (13, 4, 'Deimos Lab', 2);
INSERT INTO Map (map_id, map_number, name, episode_id) VALUES (14, 5, 'Command Center', 2);
INSERT INTO Map (map_id, map_number, name, episode_id) VALUES (15, 6, 'Halls of the Damned', 2);
INSERT INTO Map (map_id, map_number, name, episode_id) VALUES (16, 7, 'Spawning Vats', 2);
INSERT INTO Map (map_id, map_number, name, episode_id) VALUES (17, 8, 'Tower of Babel', 2);
INSERT INTO Map (map_id, map_number, name, episode_id) VALUES (18, 9, 'Fortress of Mystery', 2);

-- Maps for Episode 3
INSERT INTO Map (map_id, map_number, name, episode_id) VALUES (19, 1, 'Hell Keep', 3);
INSERT INTO Map (map_id, map_number, name, episode_id) VALUES (20, 2, 'Slough of Despair', 3);
INSERT INTO Map (map_id, map_number, name, episode_id) VALUES (21, 3, 'Pandemonium', 3);
INSERT INTO Map (map_id, map_number, name, episode_id) VALUES (22, 4, 'House of Pain', 3);
INSERT INTO Map (map_id, map_number, name, episode_id) VALUES (23, 5, 'Unholy Cathedral', 3);
INSERT INTO Map (map_id, map_number, name, episode_id) VALUES (24, 6, 'Mt. Erebus', 3);
INSERT INTO Map (map_id, map_number, name, episode_id) VALUES (25, 7, 'Limbo', 3);
INSERT INTO Map (map_id, map_number, name, episode_id) VALUES (26, 8, 'Dis', 3);
INSERT INTO Map (map_id, map_number, name, episode_id) VALUES (27, 9, 'Warped', 3);

-- Maps for Episode 4 (Thy Flesh Consumed)
INSERT INTO Map (map_id, map_number, name, episode_id) VALUES (28, 1, 'Hell Beneath', 4);
INSERT INTO Map (map_id, map_number, name, episode_id) VALUES (29, 2, 'Perfect Hatred', 4);
INSERT INTO Map (map_id, map_number, name, episode_id) VALUES (30, 3, 'Sever The Wicked', 4);
INSERT INTO Map (map_id, map_number, name, episode_id) VALUES (31, 4, 'Unruly Evil', 4);
INSERT INTO Map (map_id, map_number, name, episode_id) VALUES (32, 5, 'They Will Repent', 4);
INSERT INTO Map (map_id, map_number, name, episode_id) VALUES (33, 6, 'Against Thee Wickedly', 4);
INSERT INTO Map (map_id, map_number, name, episode_id) VALUES (34, 7, 'And Hell Followed', 4);
INSERT INTO Map (map_id, map_number, name, episode_id) VALUES (35, 8, 'Unto The Cruel', 4);
INSERT INTO Map (map_id, map_number, name, episode_id) VALUES (36, 9, 'Fear', 4);

ALTER TABLE player ADD CONSTRAINT unique_nickname UNIQUE (nickname);

INSERT INTO UXInstrument (instrument_id, num_item, description, type_instrument)
VALUES (1, 18, 'Game User Experience Satisfaction Scale', 'GUESS');

-- Insert into Item
INSERT INTO Item (item_id, instrument_id, statement) VALUES
(1, 1, 'I find the controls of the game to be straightforward.'),
(2, 1, 'I find the games interface to be easy to navigate.'),
(3, 1, 'I am captivated by the game''s story from the beginning.'),
(4, 1, 'I enjoy the fantasy or story provided by the game.'),
(5, 1, 'I feel detached from the outside world while playing the game.'),
(6, 1, 'I do not care to check events that are happening in the real world during the game.'),
(7, 1, 'I think the game is fun.'),
(8, 1, 'I feel bored while playing the game.'),
(9, 1, 'I feel the game allows me to be imaginative.'),
(10, 1, 'I feel creative while playing the game.'),
(11, 1, 'I enjoy the sound effects in the game.'),
(12, 1, 'I feel the games audio (e.g., sound effects, music) enhances my gaming experience.'),
(13, 1, 'I am very focused on my own performance while playing the game.'),
(14, 1, 'I want to do as well as possible during the game.'),
(15, 1, 'I find the game supports social interaction (e.g., chat) between players.'),
(16, 1, 'I like to play this game with other players.'),
(17, 1, 'I enjoy the games graphics.'),
(18, 1, 'I think the game is visually appealing.');

INSERT INTO user_game (user_id, age, name, gender) VALUES
(1, 18, 'Salome Avila Torres', 'Female'),
(2, 19, 'Solon Losada', 'Male'),
(3, 20, 'Mateo Tralaviña', 'Male'),
(4, 20, 'Juan Pablo Peña', 'Male');

INSERT INTO UXResponse (response_id, instrument_id, user_id) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 3);

INSERT INTO Item_response (itemresponse_id, response, response_id, item_id) VALUES
(1, 7, 1, 1),
(2, 6, 1, 2),
(3, 7, 1, 3),
(4, 6, 1, 4),
(5, 6, 1, 5),
(6, 5, 1, 6),
(7, 7, 1, 7),
(8, 2, 1, 8),
(9, 6, 1, 9),
(10, 6, 1, 10),
(11, 7, 1, 11),
(12, 7, 1, 12),
(13, 6, 1, 13),
(14, 7, 1, 14),
(15, 5, 1, 15),
(16, 6, 1, 16),
(17, 7, 1, 17),
(18, 7, 1, 18);

INSERT INTO Item_response (itemresponse_id, response, response_id, item_id) VALUES
(19, 6, 2, 1),
(20, 7, 2, 2),
(21, 5, 2, 3),
(22, 6, 2, 4),
(23, 6, 2, 5),
(24, 2, 2, 6),
(25, 6, 2, 7),
(26, 2, 2, 8),
(27, 3, 2, 9),
(28, 4, 2, 10),
(29, 7, 2, 11),
(30, 5, 2, 12),
(31, 6, 2, 13),
(32, 7, 2, 14),
(33, 1, 2, 15),
(34, 1, 2, 16),
(35, 3, 2, 17),
(36, 4, 2, 18);

-- Responses for user 3
INSERT INTO Item_response (itemresponse_id, response, response_id, item_id) VALUES
(37, 6, 3, 1),
(38, 7, 3, 2),
(39, 7, 3, 3),
(40, 7, 3, 4),
(41, 6, 3, 5),
(42, 6, 3, 6),
(43, 7, 3, 7),
(44, 2, 3, 8),
(45, 7, 3, 9),
(46, 7, 3, 10),
(47, 7, 3, 11),
(48, 7, 3, 12),
(49, 7, 3, 13),
(50, 7, 3, 14),
(51, 6, 3, 15),
(52, 7, 3, 16),
(53, 7, 3, 17),
(54, 7, 3, 18);

INSERT INTO Item_response (itemresponse_id, response, response_id, item_id) VALUES
(55, 6, 4, 1),
(56, 6, 4, 2),
(57, 5, 4, 3),
(58, 6, 4, 4),
(59, 5, 4, 5),
(60, 5, 4, 6),
(61, 6, 4, 7),
(62, 3, 4, 8),
(63, 6, 4, 9),
(64, 6, 4, 10),
(65, 7, 4, 11),
(66, 6, 4, 12),
(67, 6, 4, 13),
(68, 6, 4, 14),
(69, 5, 4, 15),
(70, 6, 4, 16),
(71, 7, 4, 17),
(72, 7, 4, 18);

INSERT INTO player (nickname, user_id) VALUES ('sal', 1);
INSERT INTO player (nickname, user_id) VALUES ('elpepe', 4);
INSERT INTO player (nickname, user_id) VALUES ('pepardo', 4);
INSERT INTO player (nickname, user_id) VALUES ('solonlosada2006', 2);

