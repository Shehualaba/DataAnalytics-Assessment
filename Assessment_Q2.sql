-- Calculate average transactions per month for each customer
WITH savings_transaction AS (
    SELECT 
        owner_id, 
        AVG(num_of_transaction) AS avg_tran_per_month
    FROM (
        SELECT 
            owner_id, 
            EXTRACT(YEAR FROM transaction_date) AS Year, 
            EXTRACT(MONTH FROM transaction_date) AS Month, 
            COUNT(transaction_date) AS num_of_transaction
        FROM 
            savings_savingsaccount
        WHERE 
            transaction_date IS NOT NULL
        GROUP BY 
            owner_id, 
            EXTRACT(YEAR FROM transaction_date),
            EXTRACT(MONTH FROM transaction_date)
    ) transactions_count
    GROUP BY 
        owner_id
)

-- Categorize customers
SELECT 
    frequency_category, 
    COUNT(id) AS customer_count, 
    ROUND(AVG(avg_tran_per_month), 1) AS avg_transactions_per_month
FROM (
    SELECT 
        user_cust.id, 
        COALESCE(avg_tran_per_month, 0) AS avg_tran_per_month,
        CASE 
            WHEN COALESCE(avg_tran_per_month, 0) >= 10 THEN 'High Frequency'
            WHEN COALESCE(avg_tran_per_month, 0) BETWEEN 3 AND 9 THEN 'Medium Frequency'
            ELSE 'Low Frequency' 
        END AS frequency_category
    FROM 
        users_customuser AS user_cust
    LEFT JOIN 
        savings_transaction AS savings
        ON user_cust.id = savings.owner_id
) final_table
GROUP BY 
    frequency_category;