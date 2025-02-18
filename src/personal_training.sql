-- Initial SQLite setup
.open fittrackpro.sqlite
.mode column

-- Enable foreign key support

-- Personal Training Queries

-- 1. List all personal training sessions for a specific trainer
-- TODO: Write a query to list all personal training sessions for a specific trainer
SELECT 
    pts.session_id,
    pts.member_id,
    m.first_name AS member_first_name,
    m.last_name AS member_last_name,
    pts.session_date,
    pts.start_time,
    pts.end_time,
    pts.notes
FROM 
    personal_training_sessions pts
JOIN 
    Members m ON pts.member_id = m.member_id
WHERE 
    pts.staff_id = 101;  -- Replace 101 with the actual staff_id of the trainer
