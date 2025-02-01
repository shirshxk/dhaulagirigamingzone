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
