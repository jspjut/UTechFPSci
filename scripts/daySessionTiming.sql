SELECT subject_id, session_id, (julianday(end_time) - julianday(start_time)) * 24 * 60 as "duration(m)"
FROM Sessions