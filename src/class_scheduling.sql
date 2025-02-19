-- Initial SQLite setup
.open fittrackpro.sqlite
.mode column

-- Enable foreign key support

-- Class Scheduling Queries

-- 1. List all classes with their instructors
-- TODO: Write a query to list all classes with their instructors

SELECT
    c.class_id,
    c.name AS class_name,
    s.first_name || ' ' || s.last_name AS instructor_name --concatenates first and last name together
FROM
    classes c
JOIN
    class_schedule cs ON c.class_id = cs.class_id
JOIN
    staff s ON cs.staff_id = s.staff_id;


-- 2. Find available classes for a specific date
-- TODO: Write a query to find available classes for a specific date
-- SELECT class_id,
--             name
-- FROM classes
-- WHERE date = '2023-10-31'; -- Replace '2023-10-31' with the desired date.

SELECT
    c.class_id,
    c.name,
    cs.start_time,
    cs.end_time,
    (c.capacity - COUNT(ca.member_id)) AS available_spots
FROM
    classes c
JOIN
    class_schedule cs ON c.class_id = cs.class_id
LEFT JOIN
    class_attendance ca ON cs.schedule_id = ca.schedule_id
WHERE
    DATE(cs.start_time) = '2025-02-01'
GROUP BY
    c.class_id, cs.start_time, cs.end_time;
-- 3. Register a member for a class
-- TODO: Write a query to register a member for a class
INSERT INTO class_attendance (schedule_id, member_id, attendance_status)
VALUES ((SELECT schedule_id FROM class_schedule WHERE start_time LIKE '%2025-02-01%'), 11, 'Registered');

-- 4. Cancel a class registration
-- TODO: Write a query to cancel a class registration
DELETE FROM class_schedule
WHERE schedule_id = 1; -- Replace '1' with the appropriate registration_id.

-- 5. List top 5 most popular classes
-- TODO: Write a query to list top 5 most popular classes

SELECT
    c.class_id,
    c.name AS class_name,
    COUNT(ca.attendance_status) AS attended_count
FROM
    classes c
JOIN
    class_schedule cs ON c.class_id = cs.class_id
JOIN
    class_attendance ca ON cs.schedule_id = ca.schedule_id
WHERE
    ca.attendance_status = 'Attended'
GROUP BY
    c.class_id, c.name
ORDER BY
    attended_count DESC
LIMIT 3;

-- 6. Calculate average number of classes per member
-- TODO: Write a query to calculate average number of classes per member

SELECT
    COUNT(ca.member_id) * 1.0 / COUNT(DISTINCT m.member_id) AS average_classes_per_member
FROM
    members m
LEFT JOIN
    class_attendance ca ON m.member_id = ca.member_id;