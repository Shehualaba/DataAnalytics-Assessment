WITH filtered_plan_list AS (
    SELECT 
        id AS plan_id, 
        owner_id,
        CASE 
            WHEN is_a_fund = 1 THEN 'Savings'
            WHEN is_regular_savings = 1 THEN 'Investments' 
        END AS type
    FROM plans_plan
    WHERE is_a_fund = 1 OR is_regular_savings = 1
) 

SELECT 
    plan_list.plan_id, 
    plan_list.owner_id, 
    type, 
    MAX(transaction_date) AS last_transaction_date,
    DATEDIFF(CURRENT_DATE(), MAX(transaction_date)) AS inactivity_days
FROM filtered_plan_list AS plan_list
INNER JOIN savings_savingsaccount AS savings
    ON plan_list.plan_id = savings.plan_id
GROUP BY 
    plan_list.plan_id, 
    plan_list.owner_id,
    type
HAVING inactivity_days > 365