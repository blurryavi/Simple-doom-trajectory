CREATE TABLE user_game (
  user_id INT NOT NULL PRIMARY KEY,
  age INT,
  name VARCHAR(30),
  gender VARCHAR(15)
);

CREATE TABLE player (
  player_id INT NOT NULL PRIMARY KEY,
  nickname VARCHAR(30),
  session_id INT NOT NULL,
  user_id INT,
  FOREIGN KEY (user_id) REFERENCES user_game(user_id)
);

CREATE TABLE tic (
  tic_id INT PRIMARY KEY,
  game_id int,
  time TIMESTAMP NOT NULL,
  FOREIGN KEY(game_id) REFERENCES game(game_id)
);

CREATE TABLE telemetry (
  telemetry_id INT NOT NULL PRIMARY KEY,
  momentum NUMERIC(5,2),
  x_axis NUMERIC(5,2),
  y_axis NUMERIC(5,2),
  z_axis NUMERIC(5,2),
  health INT,
  ammo INT,
  armor INT,
  tic_id INT,
  FOREIGN KEY (tic_id) REFERENCES tic(tic_id)
);

CREATE TABLE game (
  game_id INT NOT NULL PRIMARY KEY,
  player_id INT NOT NULL,
  started TIMESTAMP,
  ended TIMESTAMP,
  FOREIGN KEY (player_id) REFERENCES player(player_id)
);

CREATE TABLE UXInstrument (
  instrument_id INT NOT NULL PRIMARY KEY,
  num_item INT,
  description VARCHAR(100),
  type_instrument VARCHAR(6)
);

CREATE TABLE Item (
  item_id INT NOT NULL PRIMARY KEY,
  instrument_id INT NOT NULL,
  statement VARCHAR(50),
  FOREIGN KEY (instrument_id) REFERENCES UXInstrument(instrument_id)
);

CREATE TABLE UXResponse (
  response_id INT NOT NULL PRIMARY KEY,
  instrument_id INT NOT NULL,
  user_id INT NOT NULL,
  FOREIGN KEY (instrument_id) REFERENCES UXInstrument(instrument_id),
  FOREIGN KEY (user_id) REFERENCES user_game(user_id)
);

CREATE TABLE Item_response (
  itemresponse_id INT NOT NULL PRIMARY KEY,
  response INT CHECK (response BETWEEN 1 AND 7),
  response_id INT NOT NULL,
  item_id INT NOT NULL,
  FOREIGN KEY (response_id) REFERENCES UXResponse(response_id),
  FOREIGN KEY (item_id) REFERENCES Item(item_id)
);

CREATE TABLE Map (
  map_id int NOT NULL PRIMARY KEY,
  name VARCHAR(30),
  game_id int,
  FOREIGN KEY(game_id) REFERENCES game(game_id)
);

CREATE TABLE Episode (
  episode_id int NOT NULL PRIMARY KEY,
  name VARCHAR(30),
  map_id int,
  FOREIGN KEY(map_id) REFERENCES Map(map_id)
);

CREATE TABLE Sector (
  sector_id int NOT NULL PRIMARY KEY,
  name VARCHAR(30),
  episode_id int,
  FOREIGN KEY(episode_id) REFERENCES Episode(episode_id)
);
