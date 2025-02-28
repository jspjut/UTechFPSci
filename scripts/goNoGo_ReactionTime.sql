SELECT Tasks.task_index,
(julianday(Trials.end_time) - julianday(Trials.start_time)) * 86400000 ReactionTimeMs,
(julianday(Trials.start_time) - julianday(p.time)) * 86400000 SpawnTimeMs,
(julianday(Tasks.end_time) - julianday(Trials.end_time)) * 86400000 TimeAfter
-- Tasks.start_time, Tasks.end_time,
-- Trials.start_time, Trials.end_time,
-- p.time,  target_id
FROM Player_Action p, Tasks, Trials
WHERE event = "destroy"
AND target_id = "reference"
AND p.time BETWEEN Tasks.start_time AND Tasks.end_time
AND Trials.start_time BETWEEN Tasks.start_time AND Tasks.end_time
AND Tasks.session_id = "oneHitGoNoGo"