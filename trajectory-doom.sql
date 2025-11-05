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

);


