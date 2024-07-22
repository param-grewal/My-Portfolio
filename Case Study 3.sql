/*
1. Create a user-defined functions to stuff the Chicken into ‘Quick Bites’. Eg: ‘Quick Chicken Bites’.
*/

CREATE FUNCTION dbo.StuffChickenIntoQuickBites (@RestaurantName NVARCHAR(100))
RETURNS NVARCHAR(100)
AS
BEGIN
    DECLARE @ModifiedName NVARCHAR(100);
    
    -- Replace 'Quick Bites' with 'Quick Chicken Bites'
    SET @ModifiedName = REPLACE(@RestaurantName, 'Quick Bites', 'Quick Chicken Bites');
    
    RETURN @ModifiedName;
END;

/*
2. Use the function to display the restaurant name and cuisine type which has the maximum number of rating.
*/

SELECT TOP 1
    dbo.StuffChickenIntoQuickBites(RestaurantName) AS ModifiedRestaurantName,
    CuisinesType
FROM Jomato
WHERE Rating = (SELECT MAX(Rating) FROM Jomato);

/*
3. Create a Rating Status column to display the rating as ‘Excellent’ if it has more the 4
start rating, ‘Good’ if it has above 3.5 and below 5 star rating, ‘Average’ if it is above 3
and below 3.5 and ‘Bad’ if it is below 3 star rating.
*/

ALTER TABLE Jomato
ADD RatingStatus NVARCHAR(50);

UPDATE Jomato
SET RatingStatus =
    CASE
        WHEN Rating > 4 THEN 'Excellent'
        WHEN Rating > 3.5 THEN 'Good'
        WHEN Rating > 3 THEN 'Average'
        ELSE 'Bad'
    END;

/*
4. Find the Ceil, floor and absolute values of the rating column and display the current date
and separately display the year, month_name and day.
*/

SELECT 
    Rating,
    CEILING(Rating) AS CeilRating,
    FLOOR(Rating) AS FloorRating,
    ABS(Rating) AS AbsoluteRating,
    GETDATE() AS CurrentDate,
    YEAR(GETDATE()) AS CurrentYear,
    DATENAME(MONTH, GETDATE()) AS CurrentMonth,
    DAY(GETDATE()) AS CurrentDay
FROM Jomato; 

/*
5. Display the restaurant type and total average cost using rollup.
*/

SELECT 
    RestaurantType,
    AVG(AverageCost) AS TotalAverageCost
FROM Jomato
GROUP BY RestaurantType
WITH ROLLUP;


select * from jomato

