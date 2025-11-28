WITH em_with_next AS (
  SELECT
    em.*,
    LEAD(em.started) OVER (PARTITION BY em.game_episode_id ORDER BY em.started) AS next_started
  FROM episode_map em
)
SELECT
  em.map_id,
  m.name AS map_name,
  AVG(EXTRACT(EPOCH FROM (COALESCE(em.next_started, g.ended) - em.started))) AS avg_duration_seconds
FROM em_with_next em
JOIN game_episode ge ON em.game_episode_id = ge.game_episode_id
JOIN game g ON ge.game_id = g.game_id
JOIN map m ON em.map_id = m.map_id
GROUP BY em.map_id, m.name
ORDER BY em.map_id;
