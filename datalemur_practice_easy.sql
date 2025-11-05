-- Histogram of Tweets - MySQL
-- https://datalemur.com/questions/sql-histogram-tweets
SELECT num_tweets AS tweet_bucket, COUNT(user_id) as users_num
FROM (
    SELECT user_id, COUNT(tweet_id) as num_tweets FROM tweets
    WHERE YEAR(tweet_date) = 2022
    GROUP BY user_id 
  ) AS total_tweets
GROUP BY num_tweets;

-- Data Science Skills - MySQL
-- https://datalemur.com/questions/matching-skills
SELECT candidate_id
FROM candidates
WHERE skill IN ('Python', 'Tableau', 'PostgreSQL')
GROUP BY candidate_id
HAVING COUNT(skill) = 3
ORDER BY candidate_id;

-- Page With No Likes - MySQL
-- https://datalemur.com/questions/sql-page-with-no-likes
SELECT page_id
FROM pages
WHERE page_id NOT IN (SELECT page_id from page_likes)
ORDER BY page_id;

-- Unfinished Parts - PostgreSQL 14
-- https://datalemur.com/questions/tesla-unfinished-parts
SELECT part, assembly_step
FROM parts_assembly
WHERE finish_date IS NULL;

-- Laptop vs. Mobile Viewership - MySQL
-- https://datalemur.com/questions/laptop-mobile-viewership
SELECT
SUM(CASE WHEN device_type = 'laptop' THEN 1 ELSE 0 END) AS laptop_views,
SUM(CASE WHEN device_type != 'laptop' THEN 1 ELSE 0 END) AS mobile_views
FROM viewership;

-- Average Post Hiatus (Part 1) - MySQL
-- https://datalemur.com/questions/sql-average-post-hiatus-1
SELECT user_id,
DATEDIFF(MAX(DATE(post_date)), MIN(DATE(post_date))) AS days_between
FROM posts
WHERE YEAR(post_date) = 2021
GROUP BY user_id
HAVING COUNT(post_id) > 1;

-- Teams Power Users - PostgreSQL 14
-- https://datalemur.com/questions/teams-power-users
SELECT sender_id, COUNT(sender_id) AS message_count
FROM messages
WHERE EXTRACT(MONTH FROM sent_date) = '8' AND EXTRACT(YEAR FROM sent_date) = '2022'
GROUP BY sender_id
ORDER BY message_count DESC
LIMIT 2;

-- Duplicate Job Listings - MySQL
-- http://datalemur.com/questions/duplicate-job-listings
WITH job_count_total AS (
  SELECT company_id, title, description, COUNT(job_id) AS job_count
  FROM job_listings
  GROUP BY company_id, title, description
)

SELECT COUNT(company_id) AS duplicate_companies
FROM job_count_total
WHERE job_count > 1;

-- Cities With Completed Trades - PostgreSQL 14
-- https://datalemur.com/questions/completed-trades
SELECT users.city, COUNT(trades.order_id) AS total_orders
FROM trades JOIN users ON trades.user_id = users.user_id
WHERE trades.status = 'Completed'
GROUP BY users.city
ORDER BY total_orders DESC
LIMIT 3;

-- Average Review Ratings - PostgreSQL 14
-- https://datalemur.com/questions/sql-avg-review-ratings
SELECT EXTRACT(MONTH FROM submit_date) AS mth, product_id AS product, 
TRUNC(AVG(stars), 2) AS avg_stars
FROM reviews
GROUP BY mth, product;

-- Well Paid Employees - PostgreSQL 14
-- https://datalemur.com/questions/sql-well-paid-employees
SELECT emp.employee_id, emp.name AS employee_name 
FROM employee mgr INNER JOIN employee AS emp ON mgr.employee_id = emp.manager_id
WHERE emp.salary > mgr.salary;

-- App Click-through Rate (CTR) - PostgreSQL 14
-- https://datalemur.com/questions/click-through-rate
SELECT app_id,
ROUND(100.0 * SUM(CASE WHEN event_type = 'click' THEN 1 ELSE 0 END) 
/ SUM(CASE WHEN event_type = 'impression' THEN 1 ELSE 0 END), 2) AS ctr
FROM events 
WHERE EXTRACT(YEAR FROM timestamp) = 2022
GROUP BY app_id;

-- Second Day Configuration - MySQL
-- https://datalemur.com/questions/second-day-confirmation
SELECT user_id 
FROM emails JOIN texts ON emails.email_id = texts.email_id
WHERE signup_action = 'Confirmed' 
AND TIMESTAMPDIFF(DAY, signup_date, action_date) = 1;

-- IBM db2 Product Analysis - PostgreSQL 14
-- https://datalemur.com/questions/sql-ibm-db2-product-analytics
WITH employee_queries AS (
  SELECT e.employee_id, COUNT(DISTINCT q.query_id) AS unique_queries
  FROM employees e LEFT JOIN queries q ON e.employee_id = q.employee_id
  AND EXTRACT(MONTH FROM query_starttime) >= 7 AND EXTRACT(MONTH FROM query_starttime) < 10
  GROUP BY e.employee_id
)

SELECT unique_queries, COUNT(employee_id) AS employee_count
FROM employee_queries
GROUP BY unique_queries
ORDER BY unique_queries;

-- Cards Issued Difference - PostgreSQL 14
-- https://datalemur.com/questions/cards-issued-difference
SELECT card_name, 
MAX(issued_amount) - MIN(issued_amount) AS difference
FROM monthly_cards_issued
GROUP BY card_name
ORDER BY difference DESC;

-- Compressed Mean - MySQL
-- https://datalemur.com/questions/alibaba-compressed-mean
SELECT ROUND(SUM(CAST(item_count AS DECIMAL) * order_occurrences)
/ SUM(order_occurrences), 1) AS mean
FROM items_per_order;

-- Pharmacy Analytics (Part 1) - MySQL
-- https://datalemur.com/questions/top-profitable-drugs
SELECT drug, total_sales - cogs AS total_profit
FROM pharmacy_sales
ORDER BY total_profit DESC
LIMIT 3;

-- Pharmacy Analytics (Part 2) - MySQL
-- https://datalemur.com/questions/non-profitable-drugs
SELECT manufacturer, COUNT(drug) AS drug_count, 
SUM(cogs - total_sales) AS total_loss 
FROM pharmacy_sales
WHERE cogs > total_sales
GROUP BY manufacturer
ORDER BY total_loss DESC;

-- Pharmacy Analytics (Part 3) - MySQL
-- https://datalemur.com/questions/total-drugs-sales
SELECT manufacturer, 
CONCAT('$',ROUND(SUM(total_sales) / 1000000),' million') AS sale 
FROM pharmacy_sales
GROUP BY manufacturer
ORDER BY SUM(total_sales) DESC, manufacturer;

-- Patient Support Analysis (Part 1) - PostgreSQL 14
-- https://datalemur.com/questions/frequent-callers
SELECT COUNT(calls) as policy_holder_count
FROM (
  SELECT policy_holder_id
  FROM callers
  GROUP BY policy_holder_id
  HAVING COUNT(case_id) >= 3
  ) AS calls;