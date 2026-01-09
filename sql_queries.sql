
-- Wealth Management Analytics SQL Queries

-- 1. Total Assets Under Management (AUM) per client
SELECT client_id, SUM(invested_amount) AS total_aum
FROM portfolios
GROUP BY client_id;

-- 2. Top 5 clients by total investment
SELECT client_id, SUM(invested_amount) AS total_investment
FROM portfolios
GROUP BY client_id
ORDER BY total_investment DESC
LIMIT 5;

-- 3. Portfolio return percentage
SELECT portfolio_id,
       (current_value - invested_amount) / invested_amount * 100 AS return_percentage
FROM portfolios;
