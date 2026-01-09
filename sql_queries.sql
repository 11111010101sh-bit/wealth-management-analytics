
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
-- Average return by risk profile
SELECT c.risk_profile,
       AVG((p.current_value - p.invested_amount) / p.invested_amount * 100) AS avg_return
FROM clients c
JOIN portfolios p ON c.client_id = p.client_id
GROUP BY c.risk_profile;

-- Clients inactive in the last 6 months
SELECT c.client_id
FROM clients c
LEFT JOIN portfolios p ON c.client_id = p.client_id
LEFT JOIN transactions t ON p.portfolio_id = t.portfolio_id
GROUP BY c.client_id
HAVING MAX(t.transaction_date) < CURRENT_DATE - INTERVAL '6 months';

-- Investment distribution by type
SELECT investment_type,
       COUNT(*) AS total_investments,
       SUM(invested_amount) AS total_amount
FROM portfolios
GROUP BY investment_type;

-- High-risk portfolios with below-average returns
SELECT p.portfolio_id
FROM portfolios p
JOIN clients c ON p.client_id = c.client_id
WHERE c.risk_profile = 'High'
AND (p.current_value - p.invested_amount) / p.invested_amount <
    (SELECT AVG((current_value - invested_amount) / invested_amount) FROM portfolios);

