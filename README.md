# DataAnalytics-Assessment
## High-Value Customers with Multiple Products
To solve this problem, the first thing I did was to create a filter list containing user ID, first name, last name, savings count, investment count, and total inflow. I got the filter list by completing the following steps:  
* I joined all three tables together using inner joins, First, I joined the user_customer and plans tables using an inner join, then I joined the savings table to them using an inner join
* After joining the tables, I extracted the user id, first name, and last name.
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
