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
    m.type,
    AVG(TIMESTAMPDIFF(MINUTE, a.check_in_time, a.check_out_time)) AS average_visit_duration
FROM 
    memberships m
JOIN 
    attendance a ON m.member_id = a.member_id
WHERE 
    a.check_out_time IS NOT NULL  -- Only consider sessions where check-out time is recorded
GROUP BY 
    m.type;
-- 3. Identify members with expiring memberships this year
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
    m.status = 'Active' AND
    YEAR(m.end_date) = YEAR(CURDATE()) 
    AND m.end_date IS NOT NULL;  -- Ensure there’s an end date