-- The PADS
SELECT CONCAT(Name, '(', LEFT(Occupation, 1), ')')
FROM Occupations
ORDER BY Name;

SELECT CONCAT('There are a total of ', COUNT(Occupation), ' ', LOWER(Occupation), 's.')
FROM Occupations
GROUP BY Occupation
ORDER BY COUNT(Occupation), Occupation;

-- Binary Tree Nodes
SELECT n, 
CASE
    WHEN p IS NULL THEN 'Root'
    WHEN n IN (SELECT p FROM bst) THEN 'Inner'
    ELSE 'Leaf' END
FROM  bst
ORDER BY n;

-- New Companies
SELECT c.company_code, c.founder, 
COUNT(DISTINCT e.lead_manager_code), COUNT(DISTINCT (e.senior_manager_code)),
COUNT(DISTINCT e.manager_code), COUNT(DISTINCT e.employee_code)
FROM Company c JOIN Employee e ON c.company_code = e.company_code
GROUP BY c.company_code, c.founder
ORDER BY c.company_code;

-- Weather Observation Station 18
SELECT ROUND(ABS(MIN(Lat_n) - MAX(Lat_n)) + ABS(MIN(Long_w) - MAX(Long_w)), 4) 
FROM Station;

-- Weather Observation Station 19
SELECT ROUND(SQRT(POW(MAX(Lat_n) - MIN(Lat_n), 2) + POW(MAX(Long_w) - MIN(Long_w), 2)), 4) 
FROM Station;