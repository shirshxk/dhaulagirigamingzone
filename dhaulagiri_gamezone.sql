
-- ========================================
-- DATABASE CREATION -- shirshak shrestha
-- ========================================

CREATE DATABASE dhaulagiri_gamezone;
USE dhaulagiri_gamezone;

-- ========================================
-- CUSTOMER & MEMBERSHIP TABLES
-- ========================================

-- Create dh_customer table
CREATE TABLE dh_customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL
);

-- Insert customer data
INSERT INTO dh_customer (first_name, last_name) VALUES
('Saanvi', 'Bhatta'),
('Bill', 'Gates'),
('Elon', 'Musk'),
('Jack', 'Ma'),
('Kamala', 'Harris'),
('Rishi', 'Sunak');
-- shirshak shrestha

-- Create dh_membership_type table
CREATE TABLE dh_membership_type (
    membership_type_id INT AUTO_INCREMENT PRIMARY KEY,
    membership_name VARCHAR(50) NOT NULL,
    membership_cost DECIMAL(10, 2) NOT NULL
);

-- Insert membership types
INSERT INTO dh_membership_type (membership_name, membership_cost) VALUES
('Standard', 1500.00),
('Premium', 20000.00);

-- Create dh_membership_brief table
CREATE TABLE dh_membership_brief (
    membership_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    membership_type_id INT,
    signup_date DATE,
    location VARCHAR(100),
    dob DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES dh_customer(customer_id),
    FOREIGN KEY (membership_type_id) REFERENCES dh_membership_type(membership_type_id)
);
-- shirshak shrestha

-- Insert membership details
INSERT INTO dh_membership_brief (customer_id, membership_type_id, signup_date, location, dob) VALUES
(1, 2, '2024-01-01', 'Baneshwor, Kathmandu', '2015-03-01'),
(3, 1, '2024-03-28', 'Putalisadak, Kathmandu', '2003-07-20'),
(5, 2, '2024-02-15', 'Kapan, Kathmandu', '1973-05-01'),
(6, 1, '2024-05-05', 'Lazimpat, Kathmandu', '1980-11-11');

-- ========================================
-- SESSION & BOOKING TABLES
-- ========================================

-- Create dh_session table
CREATE TABLE dh_session (
    session_id INT AUTO_INCREMENT PRIMARY KEY,
    day VARCHAR(20) NOT NULL,
    session_type VARCHAR(50) NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    floor INT NOT NULL,
    session_fee DECIMAL(10, 2) NOT NULL
);

-- Insert session data
INSERT INTO dh_session (day, session_type, start_time, end_time, floor, session_fee) VALUES
('Sunday', 'Free', '09:00:00', '21:00:00', 1, 1500.00),
('Sunday', 'Free', '09:00:00', '21:00:00', 2, 1000.00),
('Saturday', 'Free', '09:00:00', '21:00:00', 1, 1500.00),
('Friday', 'Special', '18:00:00', '22:00:00', 2, 1000.00);

-- Create dh_booking table
CREATE TABLE dh_booking (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    session_id INT NOT NULL,
    customer_id INT NOT NULL,
    booking_date DATE NOT NULL,
    is_paid_advance BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (session_id) REFERENCES dh_session(session_id),
    FOREIGN KEY (customer_id) REFERENCES dh_customer(customer_id)
);
-- shirshak shrestha

-- Insert booking data
INSERT INTO dh_booking (session_id, customer_id, booking_date, is_paid_advance) VALUES
(1, 1, '2024-07-22', FALSE),
(1, 2, '2024-07-22', FALSE),
(1, 3, '2024-07-22', TRUE),
(1, 4, '2024-08-25', FALSE),
(2, 5, '2024-07-22', FALSE),
(4, 6, '2024-07-05', TRUE);

-- ========================================
-- STAFF MANAGEMENT TABLES
-- ========================================

-- Create dh_staff table
CREATE TABLE dh_staff (
    staff_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL
);

-- Create dh_staff_role table
CREATE TABLE dh_staff_role (
    role_id INT AUTO_INCREMENT PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL
);

-- Create dh_session_staff table
CREATE TABLE dh_session_staff (
    session_staff_id INT AUTO_INCREMENT PRIMARY KEY,
    session_id INT NOT NULL,
    staff_id INT NOT NULL,
    role_id INT NOT NULL,
    FOREIGN KEY (session_id) REFERENCES dh_session(session_id),
    FOREIGN KEY (staff_id) REFERENCES dh_staff(staff_id),
    FOREIGN KEY (role_id) REFERENCES dh_staff_role(role_id)
);

-- ========================================
-- GAMES & ARCADE TABLES
-- ========================================
-- shirshak shrestha

-- Create dh_game_type table
CREATE TABLE dh_game_type (
    type_id INT AUTO_INCREMENT PRIMARY KEY,
    type_name VARCHAR(50) NOT NULL
);

-- Create dh_games table
CREATE TABLE dh_games (
    game_id INT AUTO_INCREMENT PRIMARY KEY,
    game_name VARCHAR(100) NOT NULL,
    type_id INT NOT NULL,
    FOREIGN KEY (type_id) REFERENCES dh_game_type(type_id)
);

-- Create dh_arcade_machine table
CREATE TABLE dh_arcade_machine (
    machine_id INT AUTO_INCREMENT PRIMARY KEY,
    machine_number INT NOT NULL,
    game_id INT NOT NULL,
    floor INT NOT NULL,
    FOREIGN KEY (game_id) REFERENCES dh_games(game_id)
);

-- Create dh_session_arcade table
CREATE TABLE dh_session_arcade (
    session_arcade_id INT AUTO_INCREMENT PRIMARY KEY,
    session_id INT NOT NULL,
    machine_id INT NOT NULL,
    FOREIGN KEY (session_id) REFERENCES dh_session(session_id),
    FOREIGN KEY (machine_id) REFERENCES dh_arcade_machine(machine_id)
);

-- ========================================
-- CONSOLES & SESSION TABLES
-- ========================================

-- Create dh_console table
CREATE TABLE dh_console (
    console_id INT AUTO_INCREMENT PRIMARY KEY,
    console_name VARCHAR(100) NOT NULL
);

-- Create dh_game_console table
CREATE TABLE dh_game_console (
    game_console_id INT AUTO_INCREMENT PRIMARY KEY,
    game_id INT NOT NULL,
    console_id INT NOT NULL,
    total_quantity INT NOT NULL,
    FOREIGN KEY (game_id) REFERENCES dh_games(game_id),
    FOREIGN KEY (console_id) REFERENCES dh_console(console_id)
);
-- shirshak shrestha

-- Create dh_session_console table
CREATE TABLE dh_session_console (
    session_console_id INT AUTO_INCREMENT PRIMARY KEY,
    session_id INT NOT NULL,
    game_console_id INT NOT NULL,
    session_quantity INT NOT NULL,
    FOREIGN KEY (session_id) REFERENCES dh_session(session_id),
    FOREIGN KEY (game_console_id) REFERENCES dh_game_console(game_console_id)
);

-- ========================================
-- FINAL QUERIES
-- ========================================

-- Fetch unpaid customers
SELECT c.first_name, c.last_name
FROM dh_customer c
JOIN dh_booking b ON c.customer_id = b.customer_id
WHERE b.session_id = 1 AND b.is_paid_advance = FALSE;

-- Sort by machine_number
SELECT *
FROM dh_arcade_machine
WHERE floor = 1
ORDER BY machine_number DESC;
-- shirshak shrestha

-- Count PS3
SELECT COUNT(*) AS total_console_games 
FROM dh_game_console gc
JOIN dh_console c ON gc.console_id = c.console_id
WHERE c.console_name = 'PS3';

-- Staff Working on Session 1 with Maintenance Role
SELECT s.first_name, s.last_name
FROM dh_staff s
JOIN dh_session_staff ss ON s.staff_id = ss.staff_id
JOIN dh_staff_role sr ON ss.role_id = sr.role_id
WHERE ss.session_id = 1 AND sr.role_name = 'Maintenance';
-- shirshak shrestha

-- Update PUBG floor
UPDATE dh_arcade_machine 
SET floor = 2 
WHERE game_id = (SELECT game_id FROM dh_games WHERE game_name = 'PUBG');

-- Delete GTA machine
DELETE FROM dh_session_arcade 
WHERE machine_id = (SELECT machine_id FROM dh_arcade_machine WHERE game_id = 
                   (SELECT game_id FROM dh_games WHERE game_name = 'Grand Theft Auto'));
DELETE FROM dh_arcade_machine 
WHERE game_id = (SELECT game_id FROM dh_games WHERE game_name = 'Grand Theft Auto');
