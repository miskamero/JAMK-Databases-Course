
-- Function to get organizer information
CREATE FUNCTION GetOrganizerInfo(org_id INT)
RETURNS TABLE (name VARCHAR(255), contact_info VARCHAR(255), email VARCHAR(255))
BEGIN
    RETURN SELECT name, contact_info, email FROM Organizers WHERE organizer_id = org_id;
END;

-- Function to get artist information
CREATE FUNCTION GetArtistInfo(artist_id INT)
RETURNS TABLE (name VARCHAR(255), fee DECIMAL(10, 2), description TEXT)
BEGIN
    RETURN SELECT name, fee, description FROM Artists WHERE artist_id = artist_id;
END;

-- Function to get event date
CREATE FUNCTION GetEventDate(event_id INT)
RETURNS DATE
BEGIN
    DECLARE event_date DATE;
    SELECT date INTO event_date FROM Events WHERE event_id = event_id;
    RETURN event_date;
END;

-- Function to get event schedule
CREATE FUNCTION GetEventSchedule(event_id INT)
RETURNS TEXT
BEGIN
    DECLARE schedule TEXT;
    SELECT schedule INTO schedule FROM Events WHERE event_id = event_id;
    RETURN schedule;
END;

-- Function to get location information
CREATE FUNCTION GetLocationInfo(location_id INT)
RETURNS TABLE (city VARCHAR(255), building VARCHAR(255), address VARCHAR(255), description TEXT)
BEGIN
    RETURN SELECT city, building, address, description FROM Locations WHERE location_id = location_id;
END;

-- Function to get ticket information
CREATE FUNCTION GetTicketInfo(event_id INT)
RETURNS TABLE (price DECIMAL(10, 2), is_free BOOLEAN)
BEGIN
    RETURN SELECT price, is_free FROM Tickets WHERE event_id = event_id;
END;

-- Function to get artist playlist
CREATE FUNCTION GetArtistPlaylist(artist_id INT)
RETURNS TABLE (song_title VARCHAR(255), duration TIME)
BEGIN
    RETURN SELECT song_title, duration FROM Artist_Playlist WHERE artist_id = artist_id;
END;

-- Procedure to add organizer
CREATE PROCEDURE AddOrganizer(
    IN org_name VARCHAR(255),
    IN contact_info VARCHAR(255),
    IN email VARCHAR(255)
)
BEGIN
    INSERT INTO Organizers (name, contact_info, email) 
    VALUES (org_name, contact_info, email);
END;

-- Procedure to add artist
CREATE PROCEDURE AddArtist(
    IN artist_name VARCHAR(255),
    IN fee DECIMAL(10, 2),
    IN description TEXT
)
BEGIN
    INSERT INTO Artists (name, fee, description) 
    VALUES (artist_name, fee, description);
END;

-- Procedure to add event
CREATE PROCEDURE AddEvent(
    IN organizer_id INT,
    IN event_date DATE,
    IN event_time TIME,
    IN schedule TEXT,
    IN location_id INT
)
BEGIN
    INSERT INTO Events (organizer_id, date, time, schedule, location_id) 
    VALUES (organizer_id, event_date, event_time, schedule, location_id);
END;

-- Procedure to add location
CREATE PROCEDURE AddLocation(
    IN city VARCHAR(255),
    IN building VARCHAR(255),
    IN address VARCHAR(255),
    IN description TEXT
)
BEGIN
    INSERT INTO Locations (city, building, address, description) 
    VALUES (city, building, address, description);
END;

-- Procedure to add ticket
CREATE PROCEDURE AddTicket(
    IN event_id INT,
    IN price DECIMAL(10, 2),
    IN is_free BOOLEAN
)
BEGIN
    INSERT INTO Tickets (event_id, price, is_free) 
    VALUES (event_id, price, is_free);
END;

-- Procedure to add song to artist playlist
CREATE PROCEDURE AddSongToPlaylist(
    IN artist_id INT,
    IN song_title VARCHAR(255),
    IN duration TIME
)
BEGIN
    INSERT INTO Artist_Playlist (artist_id, song_title, duration) 
    VALUES (artist_id, song_title, duration);
END;
