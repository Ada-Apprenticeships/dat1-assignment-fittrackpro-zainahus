-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support

-- Payment Management Queries

-- 1. Record a payment for a membership
-- TODO: Write a query to record a payment for a membership
INSERT INTO payments (payment_id, member_id, amount, payment_date, payment_method, payment_type)
VALUES (1, 123, 50.00, '2023-11-01', 'Credit Card', 'Monthly membership fee');

-- 2. Calculate total revenue from membership fees for each month of the last year
-- TODO: Write a query to calculate total revenue from membership fees for each month of the current year
SELECT 
    EXTRACT(YEAR FROM payment_date) AS year,
    EXTRACT(MONTH FROM payment_date) AS month,
    SUM(amount) AS total_revenue
FROM payments
WHERE payment_type = 'Monthly membership fee'
AND EXTRACT(YEAR FROM payment_date) = EXTRACT(YEAR FROM CURRENT_DATE)  -- Alternatively, use the actual year
GROUP BY year, month
ORDER BY year, month;

-- 3. Find all day pass purchases
-- TODO: Write a query to find all day pass purchases
SELECT *
FROM payments
WHERE payment_type = 'Day pass';