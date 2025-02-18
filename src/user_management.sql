-- Initial SQLite setup
.open fittrackpro.sqlite
.mode column

-- Enable foreign key support

-- User Management Queries

-- 1. Retrieve all members
-- TODO: Write a query to retrieve all members
SELECT * FROM Members;

-- 2. Update a member's contact information
-- TODO: Write a query to update a member's contact information
UPDATE Members
SET email = 'new_email@example.com', 
    phone_number = '1234567890'
WHERE member_id = 1;  -- Replace `1` with the actual member ID

-- 3. Count total number of members
-- TODO: Write a query to count the total number of members
SELECT COUNT(*) AS total_members FROM Members;

-- 4. Find member with the most class registrations
-- TODO: Write a query to find the member with the most class registrations
SELECT m.member_id, m.first_name, m.last_name, COUNT(cr.registration_id) AS registration_count
FROM Members m
JOIN ClassRegistrations cr ON m.member_id = cr.member_id
GROUP BY m.member_id, m.first_name, m.last_name
ORDER BY registration_count DESC
LIMIT 1;

-- 5. Find member with the least class registrations
-- TODO: Write a query to find the member with the least class registrations
SELECT m.member_id, m.first_name, m.last_name, COUNT(cr.registration_id) AS registration_count
FROM Members m
JOIN ClassRegistrations cr ON m.member_id = cr.member_id
GROUP BY m.member_id, m.first_name, m.last_name
ORDER BY registration_count ASC
LIMIT 1;

-- 6. Calculate the percentage of members who have attended at least one class
-- TODO: Write a query to calculate the percentage of members who have attended at least one class
SELECT 
    (COUNT(DISTINCT cr.member_id) * 100.0 / COUNT(DISTINCT m.member_id)) AS percentage_with_registrations
FROM Members m
LEFT JOIN ClassRegistrations cr ON m.member_id = cr.member_id
WHERE cr.registration_id IS NOT NULL;