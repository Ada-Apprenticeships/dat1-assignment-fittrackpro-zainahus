-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support

-- Attendance Tracking Queries

-- 1. Record a member's gym visit
-- TODO: Write a query to record a member's gym visit

INSERT INTO attendance (attendance_id, member_id, location_id, check_in_time)
VALUES (1, 123, 456, CURRENT_TIMESTAMP);  -- Use actual attendance_id, member_id, and location_id
-- 2. Retrieve a member's attendance history
-- TODO: Write a query to retrieve a member's attendance history

SELECT *
FROM attendance
WHERE member_id = 123;  -- Replace with the actual member_id
-- 3. Find the busiest day of the week based on gym visits
-- TODO: Write a query to find the busiest day of the week based on gym visits
SELECT DAYNAME(check_in_time) AS day_of_week, COUNT(*) AS num_visits
FROM attendance
GROUP BY day_of_week
ORDER BY num_visits DESC
LIMIT 1;

-- 4. Calculate the average daily attendance for each location
-- TODO: Write a query to calculate the average daily attendance for each location
SELECT location_id, AVG(daily_visits) AS average_daily_attendance
FROM (
    SELECT location_id, DATE(check_in_time) AS date, COUNT(*) AS daily_visits
    FROM attendance
    GROUP BY location_id, date
) AS daily_summary
GROUP BY location_id;