CREATE DATABASE IF NOT EXISTS eventdb;

USE eventdb;


CREATE TABLE events (

    id INT AUTO_INCREMENT PRIMARY KEY,

    name VARCHAR(150) NOT NULL,

    description VARCHAR(255),

    event_date VARCHAR(100),

    location VARCHAR(100),

    price DECIMAL(10,2) NOT NULL

);


CREATE TABLE bookings (

    id INT AUTO_INCREMENT PRIMARY KEY,

    booking_id VARCHAR(50) UNIQUE NOT NULL,

    customer_name VARCHAR(100) NOT NULL,

    email VARCHAR(150) NOT NULL,

    phone VARCHAR(20) NOT NULL,

    event_name VARCHAR(150) NOT NULL,

    quantity INT NOT NULL,

    price DECIMAL(10,2) NOT NULL,

    total_amount DECIMAL(10,2) NOT NULL,

    booking_date TIMESTAMP
        DEFAULT CURRENT_TIMESTAMP

);


INSERT INTO events
(
    name,
    description,
    event_date,
    location,
    price
)

VALUES

(
    'Grand Party Night',
    'Music, dance and entertainment',
    '20 September 2026',
    'Hyderabad',
    499
),

(
    'Royal Wedding Event',
    'Traditional wedding celebration',
    '25 September 2026',
    'Chennai',
    999
),

(
    'Live Music Concert',
    'Live music experience',
    '02 October 2026',
    'Bangalore',
    799
),

(
    'Birthday Celebration',
    'Special birthday celebration',
    '10 October 2026',
    'Mumbai',
    399
),

(
    'Cultural Festival',
    'Traditional cultural event',
    '15 October 2026',
    'Delhi',
    299
),

(
    'Championship Match',
    'Live sports competition',
    '20 October 2026',
    'Pune',
    599
);
