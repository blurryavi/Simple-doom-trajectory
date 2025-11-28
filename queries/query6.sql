SELECT 
    s1.map_id,
    t1.sector_id,
    s1.sx, 
    s1.sy,
    COUNT(DISTINCT tc1.time) AS overlapping_tics
FROM telemetry t1
JOIN telemetry t2 
      ON t1.telemetry_id < t2.telemetry_id          -- avoid duplicates
JOIN tic tc1 ON t1.tic_id = tc1.tic_id
JOIN tic tc2 ON t2.tic_id = tc2.tic_id
     AND tc1.time = tc2.time                        -- same time
JOIN sector s1 ON t1.sector_id = s1.sector_id
JOIN sector s2 ON t2.sector_id = s2.sector_id
     AND s1.map_id = s2.map_id
     AND s1.sx = s2.sx
     AND s1.sy = s2.sy
JOIN game g1 ON tc1.game_id = g1.game_id
JOIN game g2 ON tc2.game_id = g2.game_id
WHERE g1.player_id <> g2.player_id
GROUP BY s1.map_id, s1.sx, s1.sy, t1.sector_id
ORDER BY overlapping_tics DESC;
