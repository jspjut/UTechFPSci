WITH EventSequence AS (
SELECT Player_Action.target_id, COUNT(*) AS target_destroyed_count, Tasks.start_time, Tasks.end_time
FROM Player_Action, Tasks, Trials
WHERE Player_Action.event = "destroy"
AND Trials.session_id = "findTargets"
AND Player_Action.time BETWEEN Tasks.start_time AND Tasks.end_time
AND Trials.start_time BETWEEN Tasks.start_time AND Tasks.end_time
GROUP BY Tasks.start_time, Player_Action.target_id
)
SELECT 
  *,
  CASE 
    WHEN INSTR(target_id, 'move') > 0 THEN 'moving'
    ELSE 'static'
  END AS target_type
FROM EventSequence;