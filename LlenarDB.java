import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class LlenarDB {
  public static void main(String[] args) {

    String url = "jdbc:postgresql://localhost:5432/trajectory_doom";
    String user = "postgres";
    String password = "";

    String filePath = args[0];

    if (args.length == 0) {
      System.out.println("Por favor, escriba el archivo del que quiere leer los datos");
    }

    try (FileReader fr = new FileReader(filePath)){
    } catch (IOException e){
      System.out.println("Por favor, ingrese un archivo valido");
      return;
    }

    // El nombre de usuario es el archivo sin la extensión
    String nickname = args[0].substring(0, args[0].lastIndexOf('.'));

    try {

      Class.forName("org.postgresql.Driver");
      Connection conn = DriverManager.getConnection(url, user, password);

      String sql_player = "INSERT INTO player (nickname) VALUES (?)";
      PreparedStatement ps_player = conn.prepareStatement(sql_player, Statement.RETURN_GENERATED_KEYS);

      ps_player.setString(1, nickname);
      ps_player.executeUpdate();

      ResultSet rs = ps_player.getGeneratedKeys();
      int player_id = 0;

      if (rs.next())
        player_id = rs.getInt(1);
      rs.close();
      ps_player.close();

      String sql_game = "INSERT INTO game (player_id, started) VALUES (?, ?)";
      PreparedStatement ps_game = conn.prepareStatement(sql_game, Statement.RETURN_GENERATED_KEYS);

      BufferedReader br = new BufferedReader(new FileReader(filePath));

      String line;
      boolean startReading = false;
      // int ticCounter = 0;
      String start_time = "";
      int episode = 0;
      int map = 0;

      while ((line = br.readLine()) != null) {
        if (line.startsWith("When:")) {
          String[] parts = line.split(" ");
          start_time = parts[1] + " " + parts[2];
          episode = Integer.parseInt(parts[4]);
          map = Integer.parseInt(parts[6]);
          break;
        }
      }

      ps_game.setInt(1, player_id);
      ps_game.setTimestamp(2, java.sql.Timestamp.valueOf(start_time));
      ps_game.executeUpdate();

      ResultSet rsg = ps_game.getGeneratedKeys();
      int game_id = 0;

      if (rsg.next())
        game_id = rsg.getInt(1);
      rsg.close();
      ps_game.close();

      String sql_game_episode = "INSERT INTO game_episode (game_id, episode_id, map_id) VALUES (?, ?, ?)";
      PreparedStatement ps_game_episode = conn.prepareStatement(sql_game_episode);

      ps_game_episode.setInt(1, game_id);
      ps_game_episode.setInt(2, episode);

      String sql_map = "SELECT map_id FROM Map WHERE episode_id = ? AND map_number = ?";
      PreparedStatement ps_map = conn.prepareStatement(sql_map);

      ps_map.setInt(1, episode);
      ps_map.setInt(2, map);
      int map_id = 0;

      ResultSet rsm = ps_map.executeQuery();
      if (rsm.next())
        map_id = rsm.getInt("map_id");

      ps_game_episode.setInt(3, map_id);
      ps_game_episode.executeUpdate();

      rsm.close();
      ps_map.close();
      ps_game_episode.close();

      String sql_tic = "INSERT INTO tic (game_id, time) VALUES (?, ?)";
      PreparedStatement ps_tic = conn.prepareStatement(sql_tic, Statement.RETURN_GENERATED_KEYS);

      String sql_telemetry = "INSERT INTO telemetry (x_axis, y_axis, z_axis, angle, momx, momy, tic_id) VALUES (?, ?, ?, ?, ?, ?, ?)";
      PreparedStatement ps_telemetry = conn.prepareStatement(sql_telemetry);

      while ((line = br.readLine()) != null) {

        if (line.startsWith("timestamp")) {
          startReading = true;
          continue;
        }

        if (!startReading)
          continue;

        String[] parts = line.trim().split("\\s+");

        if (parts.length < 9)
          continue;

        String timestamp = parts[0] + " " + parts[1];
        int x = Integer.parseInt(parts[2]);
        int y = Integer.parseInt(parts[3]);
        int z = Integer.parseInt(parts[4]);
        int angle = Integer.parseInt(parts[5]);
        double momx = Double.parseDouble(parts[6]);
        int momy = Integer.parseInt(parts[7]);

        ps_tic.setInt(1, game_id);
        ps_tic.setTimestamp(2, java.sql.Timestamp.valueOf(timestamp));
        ps_tic.executeUpdate();

        ResultSet rst = ps_tic.getGeneratedKeys();
        int tic_id = 0;

        if (rst.next())
          tic_id = rst.getInt(1);
        rst.close();
        // stmt.setInt(2, ticCounter);
        ps_telemetry.setInt(1, x);
        ps_telemetry.setInt(2, y);
        ps_telemetry.setInt(3, z);
        ps_telemetry.setInt(4, angle);
        ps_telemetry.setDouble(5, momx);
        ps_telemetry.setInt(6, momy);
        ps_telemetry.setInt(7, tic_id);
        ps_telemetry.executeUpdate();
        // ticCounter++;
      }

      ps_tic.close();
      ps_telemetry.close();
      br.close();
      System.out.println("✅ Datos insertados correctamente!");

    } catch (SQLException | IOException e) {
      e.printStackTrace();
    } catch (ClassNotFoundException c) {
      c.printStackTrace();
    }
  }
}
