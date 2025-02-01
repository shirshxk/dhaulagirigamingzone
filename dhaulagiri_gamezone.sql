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
-- shirshak shrestha

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

-- Insert membership details
INSERT INTO dh_membership_brief (customer_id, membership_type_id, signup_date, location, dob) VALUES
(1, 2, '2024-01-01', 'Baneshwor, Kathmandu', '2015-03-01'),
(3, 1, '2024-03-28', 'Putalisadak, Kathmandu', '2003-07-20'),
(5, 2, '2024-02-15', 'Kapan, Kathmandu', '1973-05-01'),
(6, 1, '2024-05-05', 'Lazimpat, Kathmandu', '1980-11-11');
-- shirshak shrestha

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

-- Insert booking data
INSERT INTO dh_booking (session_id, customer_id, booking_date, is_paid_advance) VALUES
(1, 1, '2024-07-22', FALSE),
(1, 2, '2024-07-22', FALSE),
(1, 3, '2024-07-22', TRUE),
(1, 4, '2024-08-25', FALSE),
(2, 5, '2024-07-22', FALSE),
(4, 6, '2024-07-05', TRUE);
-- shirshak shrestha

-- ========================================
-- STAFF MANAGEMENT TABLES
-- ========================================

-- Create dh_staff table
CREATE TABLE dh_staff (
    staff_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL
);

-- Insert staff data
INSERT INTO dh_staff (first_name, last_name) VALUES
('Sagar', 'Aryal'),
('Bikesh', 'Khagdi'),
('Saroj', 'Sapkota'),
('Jonathan', 'Shrestha'),
('Rohan', 'Chaudhary'),
('Rajeev', 'Karmacharya');

-- Create dh_staff_role table
CREATE TABLE dh_staff_role (
    role_id INT AUTO_INCREMENT PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL
);

-- Insert staff roles
INSERT INTO dh_staff_role (role_name) VALUES
('Cafe'),
('Counter'),
('Maintenance');

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

-- Insert session staff
INSERT INTO dh_session_staff (session_id, staff_id, role_id) VALUES
(1, 1, 1),
(1, 2, 3),
(1, 3, 2),
(2, 4, 2),
(2, 5, 3),
(2, 6, 1);
-- shirshak shrestha

-- ========================================
-- GAMES & ARCADE TABLES
-- ========================================

-- Create dh_game_type table
CREATE TABLE dh_game_type (
    type_id INT AUTO_INCREMENT PRIMARY KEY,
    type_name VARCHAR(50) NOT NULL
);

-- Insert game types
INSERT INTO dh_game_type (type_name) VALUES
('Arcade'),
('Console');

-- Create dh_games table
CREATE TABLE dh_games (
    game_id INT AUTO_INCREMENT PRIMARY KEY,
    game_name VARCHAR(100) NOT NULL,
    type_id INT NOT NULL,
    FOREIGN KEY (type_id) REFERENCES dh_game_type(type_id)
);

-- Insert games
INSERT INTO dh_games (game_name, type_id) VALUES
('Clash of Clans', 1),
('Grand Theft Auto', 1),
('Spiderman', 1),
('PUBG', 1),
('Elden Ring: Shadow of the ErdTree', 2),
('Final Fantasy VII Rebirth', 2),
('Destiny 2: The Final Shape', 2),
('Tekken 8', 2),
('Persona 3 Reload', 2),
('Cavern of Dreams', 2);

-- Create dh_arcade_machine table
CREATE TABLE dh_arcade_machine (
    machine_id INT AUTO_INCREMENT PRIMARY KEY,
    machine_number INT NOT NULL,
    game_id INT NOT NULL,
    floor INT NOT NULL,
    FOREIGN KEY (game_id) REFERENCES dh_games(game_id)
);

-- Insert arcade machines
INSERT INTO dh_arcade_machine (machine_number, game_id, floor) VALUES
(23, 1, 1),
(123, 2, 1),
(45, 3, 2),
(1234, 4, 1);

-- Create dh_session_arcade table
CREATE TABLE dh_session_arcade (
    session_arcade_id INT AUTO_INCREMENT PRIMARY KEY,
    session_id INT NOT NULL,
    machine_id INT NOT_NULL,
    FOREIGN KEY (session_id) REFERENCES dh_session(session_id),
    FOREIGN KEY (machine_id) REFERENCES dh_arcade_machine(machine_id)
);

-- Insert session arcade
INSERT INTO dh_session_arcade (session_id, machine_id) VALUES
(1, 1),
(1, 2),
(1, 4),
(2, 3),
(3, 1),
(3, 2),
(3, 4),
(4, 3);

-- Create dh_pegi table
CREATE TABLE dh_pegi (
    rating_id INT AUTO_INCREMENT PRIMARY KEY,
    game_id INT NOT NULL,
    pegi_rating VARCHAR(10) NOT NULL,
    FOREIGN KEY (game_id) REFERENCES dh_games(game_id)
);

-- shirshak shrestha
-- Insert pegi rating
INSERT INTO dh_pegi (game_id, pegi_rating) VALUES
(5, 'PG'),
(6, 'PG'),
(7, 'PG'),
(8, 'PG'),
(9, 'PG'),
(10, '15');

-- Create dh_release_year table
CREATE TABLE dh_release_year (
    year_id INT AUTO_INCREMENT PRIMARY KEY,
    game_id INT NOT NULL,
    release_year YEAR NOT NULL,
    FOREIGN KEY (game_id) REFERENCES dh_games(game_id)
);

-- shirshak shrestha
-- Insert release year
INSERT INTO dh_release_year (game_id, release_year) VALUES
(1, 2010),
(2, 2013),
(3, 2016),
(4, 2004);

-- ========================================
-- CONSOLES & SESSION TABLES
-- ========================================

-- Create dh_console table
CREATE TABLE dh_console (
    console_id INT AUTO_INCREMENT PRIMARY KEY,
    console_name VARCHAR(100) NOT NULL
);

-- Insert consoles
INSERT INTO dh_console (console_name) VALUES
('Xbox 360'),
('PS3'),
('PS2'),
('Nintendo 64'),
('Nintendo Switch');

-- Create dh_game_console table
CREATE TABLE dh_game_console (
    game_console_id INT AUTO_INCREMENT PRIMARY KEY,
    game_id INT NOT NULL,
    console_id INT NOT NULL,
    total_quantity INT NOT NULL,
    FOREIGN KEY (game_id) REFERENCES dh_games(game_id),
    FOREIGN_KEY (console_id) REFERENCES dh_console(console_id)
);

-- Insert game consoles
INSERT INTO dh_game_console (game_id, console_id, total_quantity) VALUES
(5, 1, 3),
(6, 2, 2),
(7, 3, 3),
(8, 2, 2),
(9, 4, 2),
(10, 5, 4);

-- Create dh_session_console table
CREATE TABLE dh_session_console (
    session_console_id INT AUTO_INCREMENT PRIMARY KEY,
    session_id INT NOT NULL,
    game_console_id INT NOT NULL,
    session_quantity INT NOT NULL,
    FOREIGN KEY (session_id) REFERENCES dh_session(session_id),
    FOREIGN KEY (game_console_id) REFERENCES dh_game_console(game_console_id)
);

-- Insert session console
INSERT INTO dh_session_console (session_id, game_console_id, session_quantity) VALUES
(1, 3, 2),
(2, 2, 2);



