/*
=========================================
ADVANCE CHURN INTELLIGENCE    
=========================================

-> Revenue Ranking by City 
-> Top Customer in Each city 
-> Churn Revenue Contribution 
-> Revenue Lost by Contract Type 
-> Top 10 Revenue Generating Customers 
-> Customer Revenue Quartiles 
-> Revenue by Satisfaction Category 
-> Churn Rate by Satisfaction Category 
-> Support Ticket Categories 
-> Executive Summary KPI 

Author: Krishan04.
Project: Customer Churn Analytics & Prediction
=========================================
*/

-- Revenue Ranking by City
SELECT
city,
ROUND(SUM(total_charges),2) AS revenue,
RANK() OVER(
ORDER BY SUM(total_charges) DESC ) AS revenue_rank
FROM customers
GROUP BY city;

-- Top Customer in Each City
WITH city_rank AS
(
SELECT
customer_name,
city,
total_charges,
ROW_NUMBER() OVER( PARTITION BY city ORDER BY total_charges DESC ) AS rn
FROM customers
)
SELECT * FROM city_rank
WHERE rn = 1;

-- Churn Revenue Contribution
SELECT
ROUND(
SUM(CASE WHEN churn='Yes' THEN total_charges ELSE 0 END )*100.0 
/ 
SUM(total_charges) ,2) AS revenue_risk_percent
FROM customers;

-- Revenue Lost by Contract Type
SELECT
contract_type,
ROUND( SUM(total_charges), 2) AS revenue_lost
FROM customers
WHERE churn='Yes'
GROUP BY contract_type
ORDER BY revenue_lost DESC;

-- Top 10 Revenue Generating Customers
SELECT
customer_name,
city,
plan_type,
total_charges
FROM customers
ORDER BY total_charges DESC
LIMIT 10;

-- Customer Revenue Quartiles (NTILE Window Function)
SELECT
customer_id,
customer_name,
total_charges,
NTILE(4) OVER( ORDER BY total_charges DESC) AS revenue_quartile
FROM customers LIMIT 10 ;

-- Revenue by Satisfaction Category
SELECT
CASE
WHEN satisfaction_score >= 4 THEN 'High Satisfaction'
WHEN satisfaction_score >= 3 THEN 'Medium Satisfaction'
ELSE 'Low Satisfaction'
END AS satisfaction_group,
COUNT(*) customers,
ROUND(SUM(total_charges),2) revenue
FROM customers
GROUP BY satisfaction_group;

-- Churn Rate by Satisfaction Category
SELECT
CASE
WHEN satisfaction_score >= 4 THEN 'High Satisfaction'
WHEN satisfaction_score >= 3 THEN 'Medium Satisfaction'
ELSE 'Low Satisfaction'
END AS satisfaction_group,
ROUND( SUM( CASE WHEN churn='Yes' THEN 1 ELSE 0 END ) *100.0 / COUNT(*) ,2 ) churn_rate
FROM customers
GROUP BY satisfaction_group;

-- Support Ticket Categories
SELECT
CASE
WHEN support_tickets <= 3 THEN 'Low'
WHEN support_tickets <= 7 THEN 'Medium'
ELSE 'High'
END AS ticket_group,
COUNT(*) customers,
ROUND( SUM( CASE WHEN churn='Yes' THEN 1 ELSE 0 END)*100.0 / COUNT(*) ,2) churn_rate
FROM customers
GROUP BY ticket_group;

-- Executive Summary KPI
SELECT COUNT(*) total_customers,
SUM( CASE WHEN churn='Yes' THEN 1 ELSE 0 END ) churned_customers,
ROUND(SUM(CASE WHEN churn='Yes'THEN 1 ELSE 0 END) * 100.0/ COUNT(*) ,2) churn_rate,
ROUND( SUM(total_charges), 2 ) total_revenue
FROM customers;



