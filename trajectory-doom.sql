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
INSERT INTO Map (map_id, map_number, name, episode_id) VALUES (2, 2, 'Nuclear Plant', 1); INSERT INTO Map (map_id, map_number, name, episode_id) VALUES (3, 3, 'Toxin Refinery', 1);
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
