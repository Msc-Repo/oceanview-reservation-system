



CREATE TABLE IF NOT EXISTS users (
id INT AUTO_INCREMENT PRIMARY KEY,
username VARCHAR(50) NOT NULL UNIQUE,
password_hash VARCHAR(255) NOT NULL,
role VARCHAR(30) NOT NULL DEFAULT 'STAFF'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Default admin account (password already hashed using SHA-256)
INSERT IGNORE INTO users (id, username, password_hash, role) VALUES
(1, 'admin', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9', 'ADMIN');



-- 1) Room Types (DB-driven categories + prices)
CREATE TABLE IF NOT EXISTS room_types (
id INT AUTO_INCREMENT PRIMARY KEY,
type_name VARCHAR(30) NOT NULL UNIQUE,
rate_per_night DECIMAL(10,2) NOT NULL
);

-- 2) Rooms (many rooms per type)
CREATE TABLE IF NOT EXISTS rooms (
id INT AUTO_INCREMENT PRIMARY KEY,
room_number VARCHAR(10) NOT NULL UNIQUE,
type_id INT NOT NULL,
floor INT DEFAULT NULL,
is_active TINYINT(1) NOT NULL DEFAULT 1,
CONSTRAINT fk_rooms_type FOREIGN KEY (type_id) REFERENCES room_types(id)
);

-- 3) Guests (normalized customer details)
CREATE TABLE IF NOT EXISTS guests (
id INT AUTO_INCREMENT PRIMARY KEY,
full_name VARCHAR(100) NOT NULL,
nic_passport VARCHAR(30) NOT NULL UNIQUE,
phone VARCHAR(20) NOT NULL,
email VARCHAR(100) DEFAULT NULL,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 4) Reservations (FK to guest + room)
CREATE TABLE IF NOT EXISTS reservations (
id INT AUTO_INCREMENT PRIMARY KEY,
guest_id INT NOT NULL,
room_id INT NOT NULL,
check_in DATE NOT NULL,
check_out DATE NOT NULL,
guests_count INT NOT NULL,
status VARCHAR(20) NOT NULL DEFAULT 'CONFIRMED',
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

CONSTRAINT fk_res_guest FOREIGN KEY (guest_id) REFERENCES guests(id),
CONSTRAINT fk_res_room FOREIGN KEY (room_id) REFERENCES rooms(id)
);


INSERT IGNORE INTO room_types(type_name, rate_per_night) VALUES
('STANDARD', 8000),
('DELUXE', 12000),
('SUITE', 20000);

-- Add rooms (example set)
INSERT IGNORE INTO rooms(room_number, type_id, floor) VALUES
('101', (SELECT id FROM room_types WHERE type_name='STANDARD'), 1),
('102', (SELECT id FROM room_types WHERE type_name='STANDARD'), 1),
('201', (SELECT id FROM room_types WHERE type_name='DELUXE'), 2),
('202', (SELECT id FROM room_types WHERE type_name='DELUXE'), 2),
('301', (SELECT id FROM room_types WHERE type_name='SUITE'), 3);


DELIMITER $$

CREATE TRIGGER trg_validate_reservation_before_insert
    BEFORE INSERT ON reservations
    FOR EACH ROW
BEGIN
    -- 1) Date validation
    IF NEW.check_out <= NEW.check_in THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Check-out date must be after check-in date.';
END IF;

-- 2) Prevent overlapping bookings for same room
IF EXISTS (
    SELECT 1 FROM reservations r
    WHERE r.room_id = NEW.room_id
      AND r.status <> 'CANCELLED'
      AND NOT (NEW.check_out <= r.check_in OR NEW.check_in >= r.check_out)
  ) THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Selected room is not available for the given dates.';
END IF;

  -- 3) Guests count validation
  IF NEW.guests_count <= 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Guests count must be greater than 0.';
END IF;
END $$

DELIMITER ;