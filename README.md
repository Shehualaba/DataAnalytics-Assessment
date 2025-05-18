# DataAnalytics-Assessment
## High-Value Customers with Multiple Products
To solve this problem, the first thing I did was to create a filter list containing user ID, first name, last name, savings count, investment count, and total inflow. I got the filter list by completing the following steps:  
* I joined all three tables together using inner joins, First, I joined the user_customer and plans tables using an inner join, then I joined the savings table to them using an inner join
* After joining the tables, I extracted the user ID, first name, and last name.
* Then I got the savings count and investment count by using a condition statement to only count distinct savings IDs for customers with savings and investment accounts, respectively.
* I calculated the total inflow by finding the sum of the confirmed amount and dividing the result by 100 to convert it to naira
* Finally, I filtered out rows where the savings and investment count is not greater than 0 to return only customers that have a cross-selling opportunity.
 After getting the filtered list, I got the withdrawal list by extracting the owner_id, then I calculated the sum of the amount withdrawn and divided the result by 100 to convert it to naira. After getting both the filtered list and withdrawal list, I saved their result temporarily in memory using WITH.  

Finally, I joined the filtered list and withdrawal list using the left join to return every row from the filtered list. To get the final result, I did the following:  
* I extracted the ID as owner_id and concatenated the first and last name.
* I extracted savings and investment counts.
* Then I subtracted the amount withdrawn from the total inflow to get the total deposit.
* Finally, I ordered the generated table using the total deposit in descending order.

## Transaction Frequency Analysis
To solve this problem, the first thing I did was to extract the owner_id, Year, Month, and number of transactions by:
* Extracting the year and month of the transaction from the transaction date
* Extracting the number of transactions by counting the days transactions occur for each customer
* Filtering out rows where the  transaction date is Null.
* Then group by owner_id, month and year.
The result obtained was used as a subquery to get a new table containing the owner ID and average transaction per month for each customer. The final table was saved temporarily in memory as savings transaction.  
The savings transaction and user customer table were used to extract customer ID, average transaction per month, and frequency category through the following steps:
* Substituting the average transaction per month with the value of Null to zero.
* Using a conditional statement to categorize customers with an average transaction per month greater than 10, between 3 and 9, and less than 2 to High frequency, Medium frequency, and Low frequency, respectively.
The resulting table was used as a subquery to get the final table by:
* Extracting frequency category
* Counting the number of customers belonging to that category and also the average transactions per month for customers in the category.

## Account Inactivity Alert
To solve this problem, the first thing I did was to create a temporary table in memory through the following steps:  
* Extract the ID as the plan ID and owner ID from the plan table.
* I used a conditional statement to categorize the customer account plan into savings and investments.
* I used only columns where the customer either has an investment or savings plan.
The temporary table was saved as filtered_plan_list and was joined with the saving table, then I got the final result by:  
* Extracting plan ID, owner ID, and type from the joined tables
* I calculated the last transaction date by finding the Max of transaction date of each customer
* I calculated the inactivity date by getting the number of days between the current date and the last transaction date.
* I extracted only customers that have inactivity days greater than 365 as the final result.

## Customer Lifetime Value (CLV) Estimation
To solve this problem, the first thing I did was to extract customer tenure information from the user customer table by:
* I extracted the ID as the customer ID
* I concatenated the first and last names as name
* I extracted the number of months between the current date and the date they joined as tenure.
This table was saved temporarily in memory as customer tenure information. The next thing I did was to extract profit information from the savings table by:
* Extracting the owner ID and counting the number of transactions performed by each customer
* I calculated the average profit generated on each customer.
* I saved the table as customer tenure information
Finally, the two tables that were generated were joined together to get Customer Lifetime Value through the following steps:
* I extracted customer_id, name, tenure, and total_transactions from the joined tables.
* I calculated the estimated Customer Lifetime Value using the formula given in the assessment material.
* Finally, I ordered the generated result in descending order using the estimated Customer Lifetime Value.
