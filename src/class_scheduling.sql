-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support

-- Class Scheduling Queries

-- 1. List all classes with their instructors
-- TODO: Write a query to list all classes with their instructors

SELECT c.class_id, c.name AS class_name, i.instructor_id, i.name AS instructor_name
FROM Classes c
JOIN ClassInstructors ci ON c.class_id = ci.class_id
JOIN Instructors i ON ci.instructor_id = i.instructor_id;
-- 2. Find available classes for a specific date
-- TODO: Write a query to find available classes for a specific date

SELECT c.class_id, c.name, cs.schedule_date, c.capacity
FROM Classes c
JOIN ClassSchedules cs ON c.class_id = cs.class_id
WHERE cs.schedule_date = '2023-11-01';  -- Replace with the specific date

-- 3. Register a member for a class
-- TODO: Write a query to register a member for a class

INSERT INTO ClassRegistrations (registration_id, class_id, member_id, registration_date)
VALUES (1, 101, 123, CURRENT_DATE);  -- Use actual registration_id, class_id, member_id

-- 4. Cancel a class registration
-- TODO: Write a query to cancel a class registration

DELETE FROM ClassRegistrations
WHERE registration_id = 1;  -- Replace with the actual registration_id

-- 5. List top 5 most popular classes
-- TODO: Write a query to list top 5 most popular classes

SELECT c.class_id, c.name, COUNT(cr.registration_id) AS num_registrations
FROM Classes c
JOIN ClassRegistrations cr ON c.class_id = cr.class_id
GROUP BY c.class_id, c.name
ORDER BY num_registrations DESC
LIMIT 5;

-- 6. Calculate average number of classes per member
-- TODO: Write a query to calculate average number of classes per member

SELECT AVG(class_count) AS average_classes_per_member
FROM (
    SELECT member_id, COUNT(class_id) AS class_count
    FROM ClassRegistrations
    GROUP BY member_id
) AS subquery;