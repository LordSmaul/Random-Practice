-- Select All
SELECT * FROM City;

-- Revising the Select Query I 
SELECT * FROM CITY
WHERE CountryCode = 'USA' AND Population > 100000;


-- Revising the Select Query II
SELECT Name FROM City
WHERE CountryCode = 'USA' AND Population > 120000;

-- Select By ID
SELECT * FROM City
WHERE ID = 1661;

-- Japanese Cities' Attributes
SELECT * FROM City
WHERE CountryCode = 'JPN';

-- Japanese Cities' Names
SELECT Name FROM City
WHERE CountryCode = 'JPN';

-- Weather Observation Station 1
SELECT City, State
FROM Station;

-- Weather Observation 2
SELECT ROUND(SUM(lat_n), 2), ROUND(SUM(long_w), 2)
FROM Station;

-- Weather Observation Station 3
SELECT DISTINCT City FROM Station
WHERE ID % 2 = 0;

-- Weather Observation Station 4
SELECT COUNT(City) - COUNT(DISTINCT City)
FROM Station;

-- Weather Observation Station 5
(SELECT City, LENGTH(City) AS len
FROM Station
ORDER BY len DESC
LIMIT 1)
UNION
(SELECT City, LENGTH(City) AS len
FROM Station
ORDER BY len, city
LIMIT 1)

-- Weather Observation Station 6
SELECT DISTINCT City FROM Station
WHERE LEFT(City, 1) IN ('a', 'e', 'i', 'o', 'u');

-- Weather Observation Station 7
SELECT DISTINCT City FROM Station
WHERE RIGHT(City, 1) IN ('a', 'e', 'i', 'o', 'u');

-- Weather Observation Station 8
SELECT DISTINCT City FROM Station
WHERE RIGHT(City, 1) IN ('a', 'e', 'i', 'o', 'u')
AND LEFT(City, 1) IN ('a', 'e', 'i', 'o', 'u');

-- Weather Observation Station 9
SELECT DISTINCT City FROM Station
WHERE LEFT(City, 1) NOT IN ('a', 'e', 'i', 'o', 'u');

-- Weather Observation Station 10
SELECT DISTINCT City FROM Station
WHERE SUBSTR(City, -1, 1) NOT IN ('a', 'e', 'i', 'o', 'u');

-- Weather Observation Station 11
SELECT DISTINCT City FROM Station
WHERE LEFT(City, 1) NOT IN ('a', 'e', 'i', 'o', 'u')
OR RIGHT(City, 1) NOT IN ('a', 'e', 'i', 'o', 'u');

-- Weather Observation Station 12
SELECT DISTINCT City FROM Station
WHERE LEFT(City, 1) NOT IN ('a', 'e', 'i', 'o', 'u')
AND RIGHT(City, 1) NOT IN ('a', 'e', 'i', 'o', 'u');

-- Weather Observation Station 13
SELECT ROUND(SUM(lat_n), 4) FROM Station
WHERE lat_n > 38.7880 AND lat_n < 137.2345;

-- Weather Observation Station 14
SELECT MAX(ROUND(lat_n, 4)) FROM Station
WHERE lat_n < 137.2345;

-- Weather Observation Station 15
SELECT ROUND(long_w, 4) FROM Station
WHERE lat_n < 137.2345
ORDER BY lat_n DESC
LIMIT 1;

-- Weather Observation Station 16
SELECT MIN(ROUND(lat_n, 4)) FROM Station
WHERE lat_n > 38.7780;

-- Weather Observation Station 17
SELECT ROUND(long_w, 4) FROM Station
WHERE lat_n > 38.7780
ORDER BY lat_n
LIMIT 1;

-- Higher Than 75 Marks
SELECT Name FROM Students
WHERE Marks > 75
ORDER BY RIGHT(Name, 3), ID;

-- Employee Names
SELECT Name FROM Employee
ORDER BY Name;

-- Employee Salaries
SELECT name FROM Employee
WHERE salary > 2000 AND months < 10;

-- Type of Triangle
SELECT
CASE 
    WHEN (A + B <= C) OR (A + C <= B) OR (B + C <= A) THEN "Not A Triangle"
    WHEN (A = B) AND (B = C) THEN "Equilateral"
    WHEN (A = B) OR (A = C) OR (B = C) THEN "Isosceles"
    ELSE "Scalene" END
FROM Triangles;

-- Revising Aggregations - The Count Function
SELECT COUNT(*) FROM City
WHERE Population > 100000;

-- Revising Aggregations - The Sum Function
SELECT SUM(Population) FROM City
WHERE District = 'California';

-- Revising Aggregations - Averages
SELECT AVG(Population) FROM City
WHERE District = 'California';

-- Average Population
SELECT ROUND(AVG(Population), 0) FROM City;

-- Japan Population
SELECT SUM(Population) FROM City
WHERE CountryCode = 'JPN';

-- Population Density Difference
SELECT MAX(Population) - MIN(Population) FROM City;

-- The Blunder
SELECT ROUND(AVG(Salary)) - ROUND(AVG(REPLACE(Salary, '0', '')))
FROM Employees;

-- Top Earners
SELECT months * salary, COUNT(employee_id)
FROM Employee
WHERE months * salary = (SELECT MAX(months * salary) FROM Employee)
GROUP BY months * salary;

-- Population Census
SELECT SUM(City.Population)
FROM City JOIN Country ON City.CountryCode = Country.Code
WHERE Continent = 'Asia';

-- African Cities
SELECT City.Name
FROM City JOIN Country ON City.CountryCode = Country.Code
WHERE Continent = 'Africa';

-- Average Population of Eaach Continent
SELECT Country.Continent, FLOOR(AVG(City.Population))
FROM City JOIN Country ON City.CountryCode = Country.Code
Group By Country.Continent;

-- Draw the Triangle 1
DELIMITER $$
CREATE PROCEDURE print_stars()
BEGIN
    DECLARE i INT DEFAULT 20;

    WHILE i > 0 DO
        SELECT REPEAT('* ', i) AS line;
        SET i = i - 1;
    END WHILE;
END$$
DELIMITER ;
CALL print_stars()

-- Draw the Trianlge 2
DELIMITER $$
CREATE PROCEDURE print_stars()
BEGIN
    DECLARE i INT DEFAULT 1;

    WHILE i < 21 DO
        SELECT REPEAT('* ', i) AS line;
        SET i = i + 1;
    END WHILE;
END$$
DELIMITER ;
CALL print_stars()