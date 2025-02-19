-- Initial SQLite setup
.open fittrackpro.sqlite
.mode column

-- Enable foreign key support

-- Class Scheduling Queries

-- 1. List all classes with their instructors
-- TODO: Write a query to list all classes with their instructors
SELECT c.class_id, c.class_name, i.first_name, i.last_name
FROM classes c
JOIN instructors i ON c.instructor_id = i.instructor_id;

-- 2. Find available classes for a specific date
-- TODO: Write a query to find available classes for a specific date
SELECT class_id, class_name
FROM classes
WHERE date = '2023-10-31'; -- Replace '2023-10-31' with the desired date.

-- 3. Register a member for a class
-- TODO: Write a query to register a member for a class
INSERT INTO registrations (registration_id, class_id, member_id)
VALUES (1, 101, 1); -- Replace '1', '101', '1' with appropriate registration_id, class_id, and member_id.

-- 4. Cancel a class registration
-- TODO: Write a query to cancel a class registration
DELETE FROM registrations
WHERE registration_id = 1; -- Replace '1' with the appropriate registration_id.

-- 5. List top 5 most popular classes
-- TODO: Write a query to list top 5 most popular classes
SELECT c.class_id, c.class_name, COUNT(r.registration_id) AS num_registrations
FROM classes c
JOIN registrations r ON c.class_id = r.class_id
GROUP BY c.class_id, c.class_name
ORDER BY num_registrations DESC
LIMIT 5;

-- 6. Calculate average number of classes per member
-- TODO: Write a query to calculate average number of classes per member
SELECT AVG(class_count) AS average_classes_per_member
FROM (
    SELECT COUNT(r.registration_id) AS class_count
    FROM members m
    LEFT JOIN registrations r ON m.member_id = r.member_id
    GROUP BY m.member_id
) AS member_class_counts;