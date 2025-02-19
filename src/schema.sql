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
CREATE TABLE locations (
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
CREATE TABLE members (
    member_id INTEGER PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(255) NOT NULL,
    phone_number VARCHAR(15),
    date_of_birth  DATE  CHECK (date_of_birth GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]') NOT NULL, 
    join_date DATE DEFAULT CURRENT_DATE,
    emergency_contact_name VARCHAR(100),
    emergency_contact_phone VARCHAR(15)
    
 );
drop table if exists staff;
-- -- 3. staff
CREATE TABLE staff (
    staff_id INTEGER PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(255) NOT NULL,
    phone_number VARCHAR(15),
    position CHECK (position IN ('Trainer', 'Manager', 'Receptionist', 'Maintenance')) NOT NULL,
    hire_date CHECK (hire_date GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]') NOT NULL,
    location_id INTEGER,
    FOREIGN KEY (location_id) REFERENCES Locations(location_id) 
);
drop table if exists equipment;
-- 4. equipment
CREATE TABLE equipment (
    equipment_id INTEGER PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    type CHECK (type IN ('Cardio', 'Strength')) NOT NULL,
    purchase_date DATE CHECK (purchase_date GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]') NOT NULL,
    last_maintenance_date DATE CHECK (last_maintenance_date GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]') NOT NULL,
    next_maintenance_date DATE CHECK (next_maintenance_date GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]') NOT NULL,
    location_id INTEGER,
    FOREIGN KEY (location_id) REFERENCES Locations(location_id)
);
drop table if exists classes;
-- 5. classes
CREATE TABLE classes (
    class_id INTEGER PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    capacity INTEGER NOT NULL,
    duration INTEGER NOT NULL,  -- assuming duration is in minutes
    location_id INTEGER,
    FOREIGN KEY (location_id) REFERENCES Locations(location_id) 
);
-- -- 6. class_schedule
drop table if exists class_schedule;
CREATE TABLE class_schedule (
    schedule_id INTEGER PRIMARY KEY,
    class_id INTEGER NOT NULL,
    staff_id INTEGER NOT NULL,
    start_time DATETIME CHECK(start_time GLOB'[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9] [0-9][0-9]:[0-9][0-9]:[0-9][0-9]' )NOT NULL,
    end_time DATETIME CHECK (end_time GLOB'[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9] [0-9][0-9]:[0-9][0-9]:[0-9][0-9]')NOT NULL,
    FOREIGN KEY (class_id) REFERENCES Classes(class_id) ,
    FOREIGN KEY (staff_id) REFERENCES Staff(staff_id) 
);
drop table if exists memberships;
-- -- 7. memberships
CREATE TABLE memberships (
    membership_id INTEGER PRIMARY KEY,
    member_id INTEGER NOT NULL,
    type VARCHAR(50) NOT NULL,  -- You can replace the size based on your membership types
    start_date DATE CHECK (start_date GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]') NOT NULL,
    end_date DATE CHECK (end_date GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]') NOT NULL,
    status check(status in ('Active', 'Inactive')) NOT NULL,
    FOREIGN KEY (member_id) REFERENCES Members(member_id) 
);
drop table if exists attendance;
-- -- 8. attendance
CREATE TABLE attendance (
    attendance_id INTEGER PRIMARY KEY,
    member_id INTEGER NOT NULL,
    location_id INTEGER NOT NULL,
    check_in_time DATETIME CHECK(check_in_time GLOB'[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9] [0-9][0-9]:[0-9][0-9]:[0-9][0-9]') NOT NULL,
    check_out_time DATETIME CHECK(check_out_time GLOB'[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9] [0-9][0-9]:[0-9][0-9]:[0-9][0-9]') NOT NULL,
    FOREIGN KEY (member_id) REFERENCES members(member_id) ,
    FOREIGN KEY (location_id) REFERENCES locations(location_id) 
);
drop table if exists class_attendance;
-- -- 9. class_attendance
CREATE TABLE class_attendance (
    class_attendance_id INTEGER PRIMARY KEY,
    schedule_id INTEGER NOT NULL,
    member_id INTEGER NOT NULL,
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
    payment_date DATETIME  CHECK(payment_date GLOB'[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9] [0-9][0-9]:[0-9][0-9]:[0-9][0-9]' ) NOT NULL,
    payment_method check(payment_method in('Credit Card', 'Bank Transfer', 'PayPal', 'Cash')) NOT NULL,
    payment_type check(payment_type in ('Monthly membership fee', 'Day pass')) NOT NULL,
    FOREIGN KEY (member_id) REFERENCES Members(member_id) 
);
 drop table if exists personal_training_sessions;
-- -- 11. personal_training_sessions
CREATE TABLE personal_training_sessions (
    session_id INTEGER PRIMARY KEY,
    member_id INTEGER NOT NULL,
    staff_id INTEGER NOT NULL,
    session_date DATE CHECK (session_date GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]') NOT NULL,
    start_time VARCHAR(20) CHECK (start_time GLOB '[0-9][0-9]:[0-9][0-9]:[0-9][0-9]') NOT NULL,
    end_time VARCHAR(20) CHECK (end_time GLOB '[0-9][0-9]:[0-9][0-9]:[0-9][0-9]') NOT NULL,
    notes TEXT,
    FOREIGN KEY (member_id) REFERENCES Members(member_id) ,
    FOREIGN KEY (staff_id) REFERENCES Staff(staff_id) 
    );
 drop table if exists member_health_metrics;
-- -- 12. member_health_metrics
CREATE TABLE member_health_metrics (
    metric_id INTEGER PRIMARY KEY,
    member_id INTEGER NOT NULL,
    measurement_date DATE CHECK (measurement_date GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]') NOT NULL,
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
    equipment_id INTEGER NOT NULL,
    maintenance_date DATE CHECK (maintenance_date GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]') NOT NULL,
    description TEXT,
    staff_id INTEGER,
    FOREIGN KEY (equipment_id) REFERENCES Equipment(equipment_id) ON DELETE CASCADE,
    FOREIGN KEY (staff_id) REFERENCES Staff(staff_id) ON DELETE SET NULL
);

-- After creating the tables, you can import the sample data using:
-- `.read data/sample_data.sql` in a sql file or `npm run import` in the terminal