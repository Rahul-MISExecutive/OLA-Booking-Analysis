CREATE DATABASE OLA_Bookings;

CREATE TABLE Bookings (
Date DATE,
Time TIME,
Booking_ID VARCHAR(100),
Booking_Status VARCHAR(100),
Customer_ID VARCHAR(100),
Vehicle_Type VARCHAR(100),
Pickup_Location VARCHAR(100),
Drop_Location VARCHAR(100),
V_TAT INT,
C_TAT INT,
Canceled_Rides_by_Customer TEXT,
Canceled_Rides_by_Driver TEXT,
Incomplete_Rides VARCHAR(50),
Incomplete_Rides_Reason VARCHAR(100),
Booking_Value BIGINT,
Payment_Method VARCHAR(100),
Ride_Distance INT,
Driver_Ratings NUMERIC(10,2),
Customer_Rating NUMERIC(10,2)
);

COPY
Bookings(Date, Time, Booking_ID, Booking_Status, Customer_ID, Vehicle_Type, Pickup_Location, Drop_Location, V_TAT, C_TAT, 
Canceled_Rides_by_Customer, Canceled_Rides_by_Driver, Incomplete_Rides, Incomplete_Rides_Reason, Booking_Value, Payment_Method, 
Ride_Distance, Driver_Ratings, Customer_Rating)
FROM 'C:\Bookings.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM Bookings;

--QUERIES:

-- 1. Retrieve all successful bookings:
CREATE VIEW Successful_Bookings AS
SELECT * FROM Bookings
WHERE Booking_Status = 'Success';

-- 2. Find the average ride distance for each vehicle type:
CREATE VIEW Average_Ride_Distance AS
SELECT Vehicle_Type, ROUND(AVG(Ride_Distance),2) AS Average_Ride_Distance
FROM Bookings
GROUP BY Vehicle_Type
ORDER BY Vehicle_Type;

-- 3. Get the total number of cancelled rides by customers:
CREATE VIEW Canceled_Rides_By_Customers AS
SELECT COUNT(Canceled_Rides_By_Customer) AS Total_Canceled_Rides
FROM Bookings;

-- 4. List the top 5 customers who booked the highest number of rides:
CREATE VIEW Highest_Number_Of_Rides AS
SELECT Customer_ID, COUNT(Booking_ID) AS Booking_Count
FROM Bookings
GROUP BY Customer_ID
ORDER BY Customer_ID DESC
LIMIT 5;

-- 5. Get the number of rides cancelled by drivers due to personal and car-related issues:
CREATE VIEW Canceled_Rides_By_Driver AS
SELECT COUNT(Canceled_Rides_By_Driver) AS Total_Canceled_Rides
FROM Bookings
WHERE Canceled_Rides_By_Driver = 'Personal & Car related issue';

-- 6. Find the maximum and minimum driver ratings for Prime Sedan bookings:
CREATE VIEW Max_Min_Ratings AS
SELECT MAX(Driver_Ratings) AS Max_Rating,
	   MIN(Driver_Ratings) AS Min_Rating
FROM Bookings
WHERE Vehicle_Type = 'Prime Sedan';

-- 7. Retrieve all rides where payment was made using UPI:
CREATE VIEW UPI_Payments AS
SELECT * FROM Bookings
WHERE Payment_Method = 'UPI';

-- 8. Find the average customer rating per vehicle type:
CREATE VIEW Average_Customer_Ratings AS
SELECT Vehicle_Type, ROUND(AVG(Customer_Rating),2) AS Average_Customer_Ratings
FROM Bookings
GROUP BY Vehicle_Type
ORDER BY Average_Customer_Ratings DESC;

-- 9. Calculate the total booking value of rides completed successfully:
CREATE VIEW Total_Successful_Rides_Value AS
SELECT SUM(Booking_Value) AS Total_Booking_Value
FROM Bookings
WHERE Booking_Status = 'Success';

-- 10. List all incomplete rides along with the reason:
CREATE VIEW Incomplete_Rides AS
SELECT * FROM Bookings
WHERE Incomplete_Rides = 'Yes';

--VIEWS ALL QUERIES RESULTS:

-- 1. Retrieve all successful bookings:
SELECT * FROM Successful_Bookings;

-- 2. Find the average ride distance for each vehicle type:
SELECT * FROM Average_Ride_Distance;

-- 3. Get the total number of cancelled rides by customers:
SELECT * FROM Canceled_Rides_By_Customers;

-- 4. List the top 5 customers who booked the highest number of rides:
SELECT * FROM Highest_Number_Of_Rides;

-- 5. Get the number of rides cancelled by drivers due to personal and car-related issues:
SELECT * FROM Canceled_Rides_By_Driver;

-- 6. Find the maximum and minimum driver ratings for Prime Sedan bookings:
SELECT * FROM Max_Min_Ratings;

-- 7. Retrieve all rides where payment was made using UPI:
SELECT * FROM UPI_Payments;

-- 8. Find the average customer rating per vehicle type:
SELECT * FROM Average_Customer_Ratings;

-- 9. Calculate the total booking value of rides completed successfully:
SELECT * FROM Total_Successful_Rides_Value;

-- 10. List all incomplete rides along with the reason:
SELECT * FROM Incomplete_Rides;