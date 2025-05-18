-- This filters customers that have both savings and investment account
WITH filtered_list AS (SELECT 
	user_cust.id, 
    user_cust.first_name, 
    user_cust.last_name,
    COUNT(DISTINCT CASE WHEN plans.is_regular_savings = 1 THEN savings.id END) AS savings_count,
    COUNT(DISTINCT CASE WHEN plans.is_a_fund = 1 THEN savings.id END) AS investment_count,
    SUM(savings.confirmed_amount) / 100 AS total_inflow
FROM users_customuser AS user_cust
INNER JOIN plans_plan as plans
	ON user_cust.id = plans.owner_id
INNER JOIN savings_savingsaccount as savings
	ON plans.id = savings.plan_id
GROUP BY user_cust.id, user_cust.first_name, user_cust.last_name
HAVING savings_count>0 AND investment_count>0),
-- This aggregate the amount withdrawn by owner_id
withdraw_list AS (SELECT owner_id, SUM(amount_withdrawn)  / 100 AS amount_withdraw
FROM withdrawals_withdrawal
GROUP BY owner_id) 
-- This Joins both tables and extract the expected result
SELECT 
	id as owner_id,
    CONCAT(first_name, " ", last_name) AS name,
    savings_count,
    investment_count,
    ROUND(total_inflow - COALESCE(amount_withdraw,0), 2) As total_deposit
FROM filtered_list
LEFT JOIN withdraw_list
	ON filtered_list.id = withdraw_list.owner_id
ORDER BY total_deposit DESC