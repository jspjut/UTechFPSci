SELECT Trials.destroyed_targets, Questions.response, Tasks.start_time, Tasks.end_time
FROM Tasks, Trials, Questions
WHERE Trials.session_id = "findTargets"
AND Questions.session_id = "findTargets"
AND Trials.start_time BETWEEN Tasks.start_time AND Tasks.end_time
AND Questions.time BETWEEN Tasks.start_time AND Tasks.end_time