WITH EventSequence AS (
SELECT Player_Action.target_id, Tasks.start_time, Tasks.end_time, CASE
	WHEN (target_id= 'reference') THEN 0
     ELSE (julianday(Player_Action.time) - julianday(Trials.start_time)) * 86400000 
    END AS TimeDestroyedMS
FROM Player_Action, Tasks, Trials
WHERE Player_Action.event = "destroy"
AND Trials.session_id = "findTargets"
AND Player_Action.time BETWEEN Tasks.start_time AND Tasks.end_time
AND Trials.start_time BETWEEN Tasks.start_time AND Tasks.end_time
),
EventSequence1 AS(
SELECT 
  *, 
  TimeDestroyedMS - COALESCE(LAG(TimeDestroyedMS) OVER (ORDER BY start_time) , 0) AS  ReactionTimeMS
FROM EventSequence)
SELECT 
  *,
  CASE 
    WHEN INSTR(target_id, 'move') > 0 THEN 'moving'
    ELSE 'static'
  END AS target_type
FROM EventSequence1;
