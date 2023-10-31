-- 1. Database Creation
CREATE DATABASE EventsManagement;
\c EventsManagement;

-- 1. Create Events table
CREATE TABLE Events (
    Event_Id serial PRIMARY KEY,
    Event_Name text,
    Event_Date date,
    Event_Location text,
    Event_Description text
);

-- 1. Create Attendees table
CREATE TABLE Attendees (
    Attendee_Id serial PRIMARY KEY,
    Attendee_Name text,
    Attendee_Phone text,
    Attendee_Email text,
    Attendee_City text
);

-- 1. Create Registrations table with foreign key constraints
CREATE TABLE Registrations (
    Registration_Id serial PRIMARY KEY,
    Event_Id INT,
    Attendee_Id INT,
    Registration_Date date,
    Registration_Amount numeric,
    FOREIGN KEY (Event_Id) REFERENCES Events(Event_Id),
    FOREIGN KEY (Attendee_Id) REFERENCES Attendees(Attendee_Id)
);

-- 2. Data Creation
-- Sample data for Events
INSERT INTO Events (Event_Name, Event_Date, Event_Location, Event_Description)
VALUES
    ('Conference', '2023-12-15', 'Convention Center', 'Annual tech conference'),
    ('Workshop', '2023-10-20', 'Training Center', 'Web development workshop'),
    ('Seminar', '2023-11-05', 'University Auditorium', 'Marketing trends seminar');

-- Sample data for Attendees
INSERT INTO Attendees (Attendee_Name, Attendee_Phone, Attendee_Email, Attendee_City)
VALUES
    ('John Doe', '123-456-7890', 'john@example.com', 'New York'),
    ('Jane Smith', '987-654-3210', 'jane@example.com', 'Los Angeles'),
    ('Mike Johnson', '555-555-5555', 'mike@example.com', 'Chicago');

-- Sample data for Registrations
INSERT INTO Registrations (Event_Id, Attendee_Id, Registration_Date, Registration_Amount)
VALUES
    (1, 1, '2023-12-01', 50.00),
    (1, 2, '2023-11-25', 50.00),
    (2, 1, '2023-10-15', 75.00);

-- 3. Manage Event Details
-- a) Inserting a new event
INSERT INTO Events (Event_Name, Event_Date, Event_Location, Event_Description)
VALUES ('Exhibition', '2024-02-10', 'Art Gallery', 'Art exhibition');

-- b) Updating an event's information
UPDATE Events
SET Event_Location = 'Museum'
WHERE Event_Id = 4; -- Update the event with a specific ID

-- c) Deleting an event
DELETE FROM Events
WHERE Event_Id = 3; -- Delete the event with a specific ID

-- 4. Manage Track Attendees & Handle Events
-- a) Inserting a new attendee
INSERT INTO Attendees (Attendee_Name, Attendee_Phone, Attendee_Email, Attendee_City)
VALUES ('Sarah Lee', '333-333-3333', 'sarah@example.com', 'San Francisco');

-- b) Registering an attendee for an event
INSERT INTO Registrations (Event_Id, Attendee_Id, Registration_Date, Registration_Amount)
VALUES (1, 3, '2023-12-05', 50.00); -- Register Sarah Lee for the conference

-- 5. Develop queries
-- Retrieve event information
SELECT * FROM Events;

-- Generate attendee lists for a specific event
SELECT A.Attendee_Name
FROM Attendees A
INNER JOIN Registrations R ON A.Attendee_Id = R.Attendee_Id
WHERE R.Event_Id = 1; -- Replace 1 with the event ID you want to retrieve attendees for

-- Calculate event attendance statistics (count of attendees for each event)
SELECT E.Event_Name, COUNT(R.Attendee_Id) AS Attendee_Count
FROM Events E
LEFT JOIN Registrations R ON E.Event_Id = R.Event_Id
GROUP BY E.Event_Name;

