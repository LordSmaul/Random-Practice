-- User's Third Transaction - MySQL
-- https://datalemur.com/questions/sql-third-transaction
SELECT user_id, spend, transaction_date
FROM (
  SELECT user_id, spend, transaction_date,
  ROW_NUMBER() OVER (PARTITION BY user_id) AS row_num
  FROM transactions
) AS ranking
WHERE row_num = 3;

-- Second Highest Salary - MySQL
-- https://datalemur.com/questions/sql-second-highest-salary
SELECT MAX(salary) AS 2nd_salary
FROM employee
WHERE salary < (SELECT MAX(salary) FROM employee);

-- Sending vs. Opening Snaps - MySql
-- https://datalemur.com/questions/time-spent-snaps
WITH snap_time AS (
  SELECT age_bucket,
  SUM(CASE WHEN activity_type = 'open' THEN time_spent ELSE 0 END) AS open_time,
  SUM(CASE WHEN activity_type = 'send' THEN time_spent ELSE 0 END) AS send_time
  FROM activities a JOIN age_breakdown ab ON a.user_id = ab.user_id
  GROUP BY age_bucket 
)

SELECT age_bucket, 
ROUND(send_time / (send_time + open_time) * 100.0, 2) AS send_perc,
ROUND(open_time / (send_time + open_time) * 100.0, 2) AS open_perc
FROM snap_time;

-- Tweets' Rolling Average - PostgreSQL 14
-- https://datalemur.com/questions/rolling-average-tweets
SELECT user_id, tweet_date,
ROUND(AVG(tweet_count) OVER (PARTITION BY user_id ROWS 
BETWEEN 2 PRECEDING AND CURRENT ROW), 2) AS rolling_avg_3d 
FROM tweets;

-- Highest-Grossing Items - MySQL
-- https://datalemur.com/questions/sql-highest-grossing
WITH ranked_spending AS (
  SELECT category, product, SUM(spend) AS total_spend,
  RANK() OVER (PARTITION BY category ORDER BY SUM(spend) DESC) AS ranking
  FROM product_spend
  WHERE YEAR(transaction_date) = 2022
  GROUP BY category, product
)

SELECT category, product, total_spend FROM ranked_spending
WHERE ranking <= 2
ORDER BY category, total_spend DESC;

-- Top Three Salaries - PostgreSQL 14
-- https://datalemur.com/questions/sql-top-three-salaries
WITH ranked_salary AS (
    SELECT department_name, name, salary,
    DENSE_RANK() OVER (PARTITION BY d.department_id ORDER BY salary DESC) AS r
    FROM employee e JOIN department d ON e.department_id = d.department_id
)

SELECT department_name, name, salary
FROM ranked_salary
WHERE r <= 3
ORDER BY department_name, salary DESC, name;

-- Signup Activation Rate - PostgreSQL 14
-- https://datalemur.com/questions/signup-confirmation-rate
SELECT ROUND(COUNT(t.email_id)::DECIMAL / COUNT(e.email_id), 2) AS activation_rate
FROM emails e LEFT JOIN texts t 
ON e.email_id = t.email_id AND t.signup_action = 'Confirmed';

-- Spotify Streaming History - PostgreSQL 14
-- https://datalemur.com/questions/spotify-streaming-history
WITH history AS (
  SELECT user_id, song_id, song_plays
  FROM songs_history

  UNION ALL

  SELECT user_id, song_id, COUNT(song_id) AS song_plays
  FROM songs_weekly
  WHERE DATE(listen_time) <= '2022-08-04'
  GROUP BY user_id, song_id
)

SELECT user_id, song_id, SUM(song_plays) AS song_plays
FROM history
GROUP BY user_id, song_id
ORDER BY song_plays DESC;

-- Supercloud Customer - PostgreSQL 14
-- https://datalemur.com/questions/supercloud-customer
WITH customer_count AS (
    SELECT cc.customer_id, COUNT(DISTINCT p.product_category) AS product_count
    FROM customer_contracts cc JOIN products p ON cc.product_id = p.product_id
    GROUP BY cc.customer_id
)

SELECT customer_id
FROM customer_count
WHERE product_count = (SELECT COUNT(DISTINCT product_category) FROM products);