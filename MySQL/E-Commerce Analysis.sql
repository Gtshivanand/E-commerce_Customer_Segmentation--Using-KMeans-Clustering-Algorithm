CREATE database Ecommerce;

use Ecommerce;

SHOW TABLES;

DESCRIBE cust_data;


select*from cust_data;

# Q1.How many rows have missing or null values?

SELECT COUNT(*) AS Missing_Rows
FROM cust_data
WHERE Gender IS NULL OR Orders IS NULL;

# Q2. What percentage of customers have missing gender information?

SELECT 
    COUNT(*) AS Missing_Gender_Count, 
    (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM cust_data)) AS Percentage
FROM cust_data
WHERE Gender IS NULL
LIMIT 0, 1000;



#  Q3.What is the distribution of customers by gender?

SELECT Gender, COUNT(*) AS Cust_ID
FROM cust_data
GROUP BY Gender;

# Q4.Who are the top 10 customers based on the number of orders?

SELECT Cust_ID, Orders
FROM cust_data
ORDER BY Orders DESC
LIMIT 10;

# Q5.Which brands are the most popular?

SELECT 'Jordan' AS Brand, SUM(Jordan) AS Total
FROM cust_data
UNION ALL
SELECT 'Gatorade', SUM(Gatorade)
FROM cust_data
UNION ALL
SELECT 'Samsung', SUM(Samsung)
FROM cust_data
UNION ALL
SELECT 'Asus', SUM(Asus)
FROM cust_data
UNION ALL
SELECT 'Udis', SUM(Udis)
FROM cust_data
ORDER BY Total DESC
LIMIT 5;

# Q6.How many customers have missing gender information?

SELECT Cust_ID
FROM cust_data
WHERE Gender IS NULL;

# Q7.Do male and female customers differ in the average number of orders placed?

SELECT Gender, AVG(Orders) AS Avg_Orders
FROM cust_data
GROUP BY Gender;


# Q8.How many customers have not placed any orders?

SELECT COUNT(*) AS Zero_Orders_Customers
FROM cust_data
WHERE Orders = 0;

# Q9.What is the total number of orders placed by all customers?

SELECT SUM(Orders) AS Total_Orders
FROM cust_data;

# Q10.Which brand has the highest total purchases?

SELECT 
    'Jordan' AS Brand, SUM(Jordan) AS Total_Purchases
FROM cust_data
UNION ALL
SELECT 'Samsung', SUM(Samsung)
FROM cust_data
UNION ALL
SELECT 'Gatorade', SUM(Gatorade)
FROM cust_data
ORDER BY Total_Purchases DESC
LIMIT 1;

# Q11. Are there significant gender-based differences in preferences for specific brands?

SELECT Gender, SUM(Jordan) AS Jordan_Purchases, SUM(Samsung) AS Samsung_Purchases
FROM cust_data
GROUP BY Gender;

# Q12. Who are the top 5 customers based on total brand purchases?

SELECT Cust_ID, (Jordan + Gatorade + Samsung + Asus +  Microsoft) AS Total_Brand_Purchases
FROM cust_data
ORDER BY Total_Brand_Purchases DESC
LIMIT 5;

# Q13. How many customers purchased items from more than one brand?

SELECT Cust_ID, Brand_Count
FROM (
    SELECT 
        Cust_ID, 
        CASE WHEN Jordan > 0 THEN 1 ELSE 0 END +
        CASE WHEN Samsung > 0 THEN 1 ELSE 0 END +
        CASE WHEN Gatorade > 0 THEN 1 ELSE 0 END -- Add more brand columns as needed
        AS Brand_Count
    FROM cust_data
) AS Brand_Data
WHERE Brand_Count > 1;

# Q14. Who are the customers placing orders above the average count?

SELECT Cust_ID, Orders
FROM cust_data
WHERE Orders > (SELECT AVG(Orders) FROM cust_data);

# Q15. Is there a strong correlation between the number of orders and brand purchases?

SELECT Cust_ID, Orders, (Jordan + Samsung ) AS Total_Brand_Purchases
FROM cust_data;













