SELECT task_id, task_index, destroyed_targets, CASE
        WHEN (task_id = 'go' AND destroyed_targets = 1) OR (task_id = 'nogo' AND destroyed_targets = 0) THEN 1
        ELSE 0
    END AS success
FROM Trials
WHERE (Trials.task_id = "go") OR (Trials.task_id = "nogo")