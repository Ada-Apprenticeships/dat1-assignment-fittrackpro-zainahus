-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support

-- Staff Management Queries

-- 1. List all staff members by role
-- TODO: Write a query to list all staff members by role

SELECT position, staff_id, first_name, last_name
FROM Staff
ORDER BY position, last_name, first_name;
-- 2. Find trainers with one or more personal training session in the next 30 days
-- TODO: Write a query to find trainers with one or more personal training session in the next 30 days

SELECT DISTINCT s.staff_id, s.first_name, s.last_name, s.email, s.phone_number
FROM Staff s
JOIN TrainingSessions ts ON s.staff_id = ts.trainer_id
WHERE s.position = 'Trainer'
AND ts.session_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, INTERVAL 30 DAY);