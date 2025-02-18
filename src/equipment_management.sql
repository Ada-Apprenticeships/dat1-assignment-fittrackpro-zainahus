-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support

-- Equipment Management Queries

-- 1. Find equipment due for maintenance
-- TODO: Write a query to find equipment due for maintenanc

SELECT *
FROM Equipment
WHERE next_maintenance_date <= CURRENT_DATE;
-- 2. Count equipment types in stock
-- TODO: Write a query to count equipment types in stock

SELECT type, COUNT(*) AS count
FROM Equipment
GROUP BY type;
-- 3. Calculate average age of equipment by type (in days)
-- TODO: Write a query to calculate average age of equipment by type (in days)

SELECT type, AVG(DATEDIFF(CURRENT_DATE, purchase_date)) AS average_age_in_days
FROM Equipment
WHERE purchase_date IS NOT NULL
GROUP BY type;
