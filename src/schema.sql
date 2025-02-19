-- FitTrack Pro Database Schema

-- Initial SQLite setup
.open fittrackpro.sqlite
.mode column

-- Enable foreign key support

-- Create your tables here
-- Example:
-- CREATE TABLE table_name (
--     column1 datatype,
--     column2 datatype,
--     ...
-- );

-- TODO: Create the following tables:
-- 1. locations
drop table if exists locations;
CREATE TABLE Locations (
    location_id INTEGER PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    address VARCHAR(255),
    phone_number VARCHAR(15),
    email VARCHAR(255),
    opening_hours VARCHAR(255)
);
--
-- );
drop table if exists members;
-- -- 2. members
CREATE TABLE Members (
    member_id INTEGER PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(255) NOT NULL,
    phone_number VARCHAR(15),
    date_of_birth DATE,
    join_date DATE DEFAULT CURRENT_DATE,
    emergency_contact_name VARCHAR(100),
    emergency_contact_phone VARCHAR(15)
 );
drop table if exists staff;
-- -- 3. staff
CREATE TABLE Staff (
    staff_id INTEGER PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(255) NOT NULL,
    phone_number VARCHAR(15),
    position check (position in ('Trainer', 'Manager', 'Receptionist', 'Maintenance')) NOT NULL,
    hire_date DATE,
    location_id INT,
    FOREIGN KEY (location_id) REFERENCES Locations(location_id) 
);
drop table if exists equipment;
-- 4. equipment
CREATE TABLE Equipment (
    equipment_id INTEGEER PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    type NOT NULL CHECK (type IN ('Cardio', 'Strength')),
    purchase_date DATE,
    last_maintenance_date DATE,
    next_maintenance_date DATE,
    location_id INT,
    FOREIGN KEY (location_id) REFERENCES Locations(location_id) 
);
drop table if exists classes;
-- 5. classes
CREATE TABLE Classes (
    class_id INTEGER PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    capacity INT NOT NULL,
    duration INT NOT NULL,  -- assuming duration is in minutes
    location_id INT,
    FOREIGN KEY (location_id) REFERENCES Locations(location_id) 
);
-- -- 6. class_schedule
drop table if exists class_schedule;
CREATE TABLE class_schedule (
    schedule_id INTEGER PRIMARY KEY,
    class_id INT NOT NULL,
    staff_id INT NOT NULL,
    start_time DATETIME NOT NULL,
    end_time DATETIME NOT NULL,
    FOREIGN KEY (class_id) REFERENCES Classes(class_id) ,
    FOREIGN KEY (staff_id) REFERENCES Staff(staff_id) 
);
drop table if exists memberships;
-- -- 7. memberships
CREATE TABLE memberships (
    membership_id INTEGER PRIMARY KEY,
    member_id INT NOT NULL,
    type VARCHAR(50) NOT NULL,  -- You can replace the size based on your membership types
    start_date DATE NOT NULL,
    end_date DATE,
    status check(status in ('Active', 'Inactive')) NOT NULL,
    FOREIGN KEY (member_id) REFERENCES Members(member_id) 
);
drop table if exists attendance;
-- -- 8. attendance
CREATE TABLE attendance (
    attendance_id INTEGER PRIMARY KEY,
    member_id INT NOT NULL,
    location_id INT NOT NULL,
    check_in_time DATETIME NOT NULL,
    check_out_time DATETIME,
    FOREIGN KEY (member_id) REFERENCES members(member_id) ,
    FOREIGN KEY (location_id) REFERENCES locations(location_id) 
);
drop table if exists class_attendance;
-- -- 9. class_attendance
CREATE TABLE class_attendance (
    class_attendance_id INTEGER PRIMARY KEY,
    schedule_id INT NOT NULL,
    member_id INT NOT NULL,
    attendance_status check(attendance_status in ('Registered', 'Attended', 'Unattended')) NOT NULL,
    FOREIGN KEY (schedule_id) REFERENCES class_schedule(schedule_id),
    FOREIGN KEY (member_id) REFERENCES Members(member_id) 
);
drop table if exists payments;
-- -- 10. payments
CREATE TABLE payments (
    payment_id INTEGER PRIMARY KEY,
    member_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,  -- Using DECIMAL for monetary values to avoid floating-point issues
    payment_date DATE NOT NULL,
    payment_method check(payment_method in('Credit Card', 'Bank Transfer', 'PayPal', 'Cash')) NOT NULL,
    payment_type check(payment_type in ('Monthly membership fee', 'Day pass')) NOT NULL,
    FOREIGN KEY (member_id) REFERENCES Members(member_id) 
);
 drop table if exists personal_training_sessions;
-- -- 11. personal_training_sessions
CREATE TABLE personal_training_sessions (
    session_id INTEGER PRIMARY KEY,
    member_id INT NOT NULL,
    staff_id INT NOT NULL,
    session_date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    notes TEXT,
    FOREIGN KEY (member_id) REFERENCES Members(member_id) ,
    FOREIGN KEY (staff_id) REFERENCES Staff(staff_id) 
    );
 drop table if exists member_health_metrics;
-- -- 12. member_health_metrics
CREATE TABLE member_health_metrics (
    metric_id INTEGER PRIMARY KEY,
    member_id INT NOT NULL,
    measurement_date DATE NOT NULL,
    weight DECIMAL(5, 2),  -- Assuming weight is recorded in kg with two decimal precision
    body_fat_percentage DECIMAL(5, 2),  -- Body fat percentage with two decimal precision
    muscle_mass DECIMAL(5, 2),  -- Muscle mass in kg with two decimal precision
    bmi DECIMAL(4, 2),  -- BMI with two decimal precision
    FOREIGN KEY (member_id) REFERENCES Members(member_id) ON DELETE CASCADE
);
drop table if exists equipment_maintenance_log;
-- -- 13. equipment_maintenance_log
CREATE TABLE equipment_maintenance_log (
    log_id INTEGER PRIMARY KEY,
    equipment_id INT NOT NULL,
    maintenance_date DATE NOT NULL,
    description TEXT,
    staff_id INT,
    FOREIGN KEY (equipment_id) REFERENCES Equipment(equipment_id) ON DELETE CASCADE,
    FOREIGN KEY (staff_id) REFERENCES Staff(staff_id) ON DELETE SET NULL
);

-- After creating the tables, you can import the sample data using:
-- `.read data/sample_data.sql` in a sql file or `npm run import` in the terminal