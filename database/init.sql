CREATE DATABASE IF NOT EXISTS eventdb;

USE eventdb;


CREATE TABLE IF NOT EXISTS events (

    id INT AUTO_INCREMENT PRIMARY KEY,

    name VARCHAR(255) NOT NULL,

    description TEXT,

    event_date DATE,

    location VARCHAR(255),

    price DECIMAL(10,2) NOT NULL
);


CREATE TABLE IF NOT EXISTS bookings (

    id INT AUTO_INCREMENT PRIMARY KEY,

    booking_id VARCHAR(50) UNIQUE NOT NULL,

    customer_name VARCHAR(255) NOT NULL,

    email VARCHAR(255) NOT NULL,

    phone VARCHAR(30) NOT NULL,

    event_name VARCHAR(255) NOT NULL,

    quantity INT NOT NULL,

    price DECIMAL(10,2) NOT NULL,

    total_amount DECIMAL(10,2) NOT NULL,

    booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


INSERT INTO events
(name, description, event_date, location, price)
VALUES

(
    'New Year Party',
    'Celebrate with music and entertainment',
    '2026-12-31',
    'Mumbai',
    999
),

(
    'Live Music Concert',
    'Enjoy an unforgettable live concert',
    '2026-10-15',
    'Bangalore',
    1499
),

(
    'Wedding Celebration',
    'Beautiful traditional wedding celebration',
    '2026-11-20',
    'Chennai',
    799
),

(
    'Birthday Bash',
    'Celebrate a special birthday',
    '2026-10-05',
    'Hyderabad',
    499
),

(
    'Cultural Festival',
    'Experience culture and performances',
    '2026-12-12',
    'Delhi',
    699
),

(
    'Football Championship',
    'Exciting football championship',
    '2026-10-10',
    'Pune',
    599
);
