SELECT Player_Action.time, Player_Action.position_x, Player_Action.position_y, Tasks.start_time, Tasks.end_time
FROM Player_Action, Tasks, Trials
WHERE Player_Action.state == "trialTask"
AND Trials.session_id = "findTargets"
AND Player_Action.time BETWEEN Tasks.start_time AND Tasks.end_time
AND Trials.start_time BETWEEN Tasks.start_time AND Tasks.end_time