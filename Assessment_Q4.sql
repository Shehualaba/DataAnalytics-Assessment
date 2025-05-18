-- Extract customer_id, name and tenure
WITH customer_tenure_information AS (SELECT 
	id AS customer_id, 
    CONCAT(first_name," ", last_name) AS name, 
    TIMESTAMPDIFF(MONTH, date_joined, CURRENT_DATE) AS tenure
FROM users_customuser),
-- Extract owner_id, total transactions and Average Profit per transactions
customer_profit_information AS (SELECT 
	owner_id, 
	COUNT(transaction_date) AS total_transactions, 
	AVG((confirmed_amount/100) * 0.001) AS Avg_profit_per_transaction -- first converted to naira then got profit from it
FROM savings_savingsaccount
GROUP BY owner_id)
-- Get the final table containing Estimated customer lifetime Value
SELECT 
	customer_id, 
    name, tenure, 
    total_transactions, 
    ROUND((total_transactions/tenure) * 12 * Avg_profit_per_transaction, 2) AS estimated_clv
FROM customer_tenure_information AS ctf
INNER JOIN customer_profit_information as cpi
	ON ctf.customer_id = cpi.owner_id
ORDER BY estimated_clv DESC