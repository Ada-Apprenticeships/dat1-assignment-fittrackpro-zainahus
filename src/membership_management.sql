-- Initial SQLite setup
.open fittrackpro.sqlite

.mode column

-- Enable foreign key support

-- Membership Management Queries

-- 1. List all active memberships
-- TODO: Write a query to list all active memberships
SELECT 
    membership_id, 
    member_id, 
    type, 
    start_date, 
    end_date, 
    status
FROM 
    memberships
WHERE 
    status = 'Active';

-- 2. Calculate the average duration of gym visits for each membership type
-- TODO: Write a query to calculate the average duration of gym visits for each membership type

SELECT
    ms.type AS membership_type,
    AVG(julianday(a.check_out_time) - julianday(a.check_in_time)) * 24 * 60 AS avg_visit_duration_minutes
FROM
    memberships ms
JOIN
    members m ON ms.member_id = m.member_id
JOIN
    attendance a ON m.member_id = a.member_id
GROUP BY
    ms.type;-- 3. Identify members with expiring memberships this year
-- TODO: Write a query to identify members with expiring memberships this year
SELECT 
    m.membership_id, 
    m.member_id, 
    mem.first_name, 
    mem.last_name, 
    m.type, 
    m.end_date
FROM 
    memberships m
JOIN 
    Members mem ON m.member_id = mem.member_id
WHERE
    m.end_date BETWEEN '2025-01-01' AND '2025-12-31';