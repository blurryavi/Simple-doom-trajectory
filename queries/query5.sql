SELECT 
    e.episode_id,
    e.name AS episode_name,
    m.map_id,
    m.name AS map_name,
    s.sector_id,
    s.sx,
    s.sy,
    COUNT(*) AS visits
FROM telemetry t
JOIN sector s ON t.sector_id = s.sector_id
JOIN map m ON s.map_id = m.map_id
JOIN episode e ON m.episode_id = e.episode_id
GROUP BY 
    e.episode_id,
    e.name,
    m.map_id,
    m.name,
    s.sector_id,
    s.sx,
    s.sy
ORDER BY 
    e.episode_id,
    m.map_id,
    visits DESC;
