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
 JOIN
    staff s ON s.staff_id = pts.staff_id

WHERE
    s.first_name = 'Ivy' AND s.last_name = 'Irwin'

    
