CREATE DATABASE Sports_Venue_Directory;
GO

USE Sports_Venue_Directory;
GO

CREATE TABLE venues (
    venue_id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    name NVARCHAR (255) NOT NULL,
    description TEXT,
    phone VARCHAR(50) DEFAULT -1,
    email VARCHAR(255) DEFAULT -1,
    website VARCHAR(255),
    address_line NVARCHAR(255) NOT NULL DEFAULT -1,
    city NVARCHAR(100) NOT NULL DEFAULT -1,
    capacity INT
);

CREATE TABLE venue_hours (
    id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    venue_id UNIQUEIDENTIFIER NOT NULL REFERENCES venues(venue_id) ON DELETE CASCADE,
    day_of_week INT NOT NULL CHECK (day_of_week BETWEEN 0 AND 6), -- 0 = Sunday
    open_time TIME ,
    close_time TIME ,
    CONSTRAINT UQ_venue_day UNIQUE(venue_id, day_of_week)
);

CREATE TABLE courts (
    courts_id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    venue_id UNIQUEIDENTIFIER NOT NULL REFERENCES venues(venue_id) ON DELETE CASCADE,
    name NVARCHAR(100),           
    sport NVARCHAR(50),
    surface_material NVARCHAR(50),          
    is_indoor BIT NOT NULL DEFAULT 0,
    organizer NVARCHAR(100),
    hourly_rate DECIMAL(12,3), 
    max_player SMALLINT
);

CREATE TABLE court_occupancy (
    court_occupancy_id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    court_id UNIQUEIDENTIFIER NOT NULL REFERENCES courts(courts_id) ON DELETE CASCADE,
    date_occupied DATETIME NOT NULL DEFAULT -1,
    start_from  TIME,
    until TIME,
    crowd_number INT
    CONSTRAINT UQ_court_slot   UNIQUE(court_id, date_occupied, start_from),
    CONSTRAINT CHK_time_order CHECK (until > start_from)
);

CREATE TABLE amenities (
    id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    venue_id UNIQUEIDENTIFIER NOT NULL REFERENCES venues(venue_id) ON DELETE CASCADE,
    name NVARCHAR(100) NOT NULL,
    category NVARCHAR(50),
);
-- Create non-clustered indexes for performance
CREATE NONCLUSTERED INDEX idx_venues_city ON venues(city);
CREATE NONCLUSTERED INDEX idx_courts_venue_id ON courts(venue_id);
CREATE NONCLUSTERED INDEX idx_courts_sport ON courts(sport);
CREATE NONCLUSTERED INDEX idx_court_occupancy_date ON court_occupancy(date_occupied);
CREATE NONCLUSTERED INDEX idx_occupancy_court ON court_occupancy(court_id, date_occupied);