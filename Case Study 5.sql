/*
1. Create a stored procedure to display the restaurant name, type and cuisine where the table booking is not zero.
*/

CREATE PROCEDURE DisplayRestaurantsWithBooking
AS
BEGIN
    SELECT RestaurantName, RestaurantType, CuisinesType
    FROM Jomato
    WHERE TableBooking > 0;
END;

/*
2. Create a transaction and update the cuisine type ‘Cafe’ to ‘Cafeteria’. Check the result and rollback it.
*/

BEGIN TRANSACTION;

UPDATE Jomato
SET Cuisinestype = 'Cafeteria'
WHERE Cuisinestype = 'Cafe';

-- Check the updated rows
SELECT * FROM Jomato WHERE Cuisinestype = 'Cafeteria';

-- Rollback the transaction
ROLLBACK TRANSACTION;

/*
3. Generate a row number column and find the top 5 areas with the highest rating of restaurants.
*/

WITH RankedAreas AS (
    SELECT Area, AVG(Rating) AS AvgRating,
           ROW_NUMBER() OVER (ORDER BY AVG(Rating) DESC) AS Rank
    FROM Jomato
    GROUP BY Area
)
SELECT Area, AvgRating
FROM RankedAreas
WHERE Rank <= 5;

/*
4. Use the while loop to display the 1 to 50.
*/

DECLARE @counter INT = 1;

WHILE @counter <= 50
BEGIN
    PRINT @counter;
    SET @counter = @counter + 1;
END;

/*
5. Write a query to Create a Top rating view to store the generated top 5 highest rating of restaurants.
*/

CREATE VIEW TopRatingRestaurants AS
SELECT TOP 5 RestaurantName, Cuisinestype, Rating
FROM Jomato
ORDER BY Rating DESC;

/*
6. Write a trigger that sends an email notification to the restaurant owner whenever a new record is inserted.
*/

CREATE TRIGGER SendEmailOnInsert
ON Jomato 
After INSERT
AS
BEGIN
    DECLARE @OwnerEmail NVARCHAR(100);
    DECLARE @RestaurantName NVARCHAR(100);

    SELECT @OwnerEmail = OwnerEmail, @RestaurantName = RestaurantName
    FROM inserted;

    IF @OwnerEmail IS NOT NULL AND @OwnerEmail != ''
               
END;
