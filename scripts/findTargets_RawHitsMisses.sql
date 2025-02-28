SELECT Player_Action.time, Player_Action.state, Player_Action.event, Player_Action.target_id, Tasks.start_time, Tasks.end_time
FROM Player_Action, Tasks, Trials
WHERE Player_Action.event != "aim"
AND Trials.session_id = "findTargets"
AND Player_Action.time BETWEEN Tasks.start_time AND Tasks.end_time
AND Trials.start_time BETWEEN Tasks.start_time AND Tasks.end_time