with EventSequence AS (SELECT Player_Action.time, Player_Action.state, Player_Action.event, Player_Action.target_id, Tasks.start_time, Tasks.end_time
FROM Player_Action, Tasks, Trials
WHERE Player_Action.event != "aim"
AND Trials.session_id = "findTargets"
AND Player_Action.time BETWEEN Tasks.start_time AND Tasks.end_time
AND Trials.start_time BETWEEN Tasks.start_time AND Tasks.end_time),
EventSequence1 AS(
SELECT 
  start_time, end_time,
  COUNT(CASE WHEN event= 'miss' THEN 1 END) AS count_misses,
  COUNT(CASE WHEN event = 'destroy' THEN 1 END) AS count_hits
FROM EventSequence
WHERE state != "referenceTarget"
GROUP BY start_time)
SELECT start_time, end_time, count_misses, count_hits, SUM(count_hits + count_misses) AS number_shots_taken
FROM EventSequence1
GROUP BY start_time
;

