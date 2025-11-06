CREATE DATABASE trajectory_doom;
CREATE TABLE telemetry (
  telemetry_id int NOT NULL,
  momentum numeric(5,2),
  -- stats
  x_axis numeric(5,2),
  y_axis numeric(5,2),
  z_axis numeric(5,2),
  health int,
  ammo int,
  armor int,
  player_id int,
  tic_id timestamp,
  FOREIGN KEY(player_id) REFERENCES player(player_id),
  FOREIGN KEY(tic_id) REFERENCES tic(time),
  PRIMARY KEY(telemetry_id)
);

CREATE TABLE tic (
  -- tic_id sera la resta entre el tiempo en el que se inicio la partida y el tiempo actual
  tic_id int,
  time timestamp,
  PRIMARY KEY(tic_id)
);

CREATE TABLE player(
  player_id int NOT NULL,
  nickname varchar(30),
  session_id int NOT NULL,
  user_id int,
  PRIMARY KEY(player_id),
  FOREIGN KEY(user_id) REFERENCES user(user_id)
);

CREATE TABLE game(
  game_id int NOT NULL,
  player_id int NOT NULL,
  started timestamp,
  ended timestamp,
  PRIMARY KEY(game_id),
  FOREIGN KEY(player_id) REFERENCES player(player_id)
);
CREATE TABLE user(
  user_id int NOT NULL,
  age int,
  name varchar(30),
  gender varchar(15),
  PRIMARY KEY(user_id) ---- no sé si meter una foreign key para que se conecte con player

);
CREATE TABLE UXResponse(
  response_id int NOT NULL,
  instrument_id int NOT NULL,
  user_id int NOT NULL,
  item_id int NOT NULL,
  answer         -- creo otra tabla para answer? porque un usuario tiene muchas respuestas
);
CREATE TABLE UXInstrument(
  instrument_id int NOT NULL,
  item_id int NOT NULL, -- Sería bueno añadir este atributo, ya que según el esquema un instrumento contiene un item, por lo tanto, se deben relacionar mediante una llave foránea
  num_item int,
  description varchar(100),
  type_instrument varchar(6),
  PRIMARY KEY(instrument_id),
  FOREIGN KEY(item_id) REFERENCES item(item_id)
);
CREATE TABLE Item (
  item_id int NOT NULL,
  instrument_id int NOT NULL,
  statement varchar(50),
  answer int, -- pero acá habría varias
  PRIMARY KEY(item_id),
  FOREIGN KEY (instrument_id) REFERENCES UXInstrument(instrument_id)
);

