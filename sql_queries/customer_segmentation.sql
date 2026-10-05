/*
=========================================
CUSTOMER SEGMENTATION   
=========================================

-> Customer Segmentation 
-> Revenue Contribution by Segment 
-> Segment-Wise Churn Rate 
-> Top 10 Most Valuable Customers 
-> Customer Lifetime Value 
-> Top Cities by Revenue 
-> Plan-wise Revenue Contribution 
-> Average Tenure by Churn 
-> Churn by Age Group 
-> Customer Segment Distribution 
 
Author: Krishan04.
Project: Customer Churn Analytics & Prediction
=========================================
*/

-- Customer Segmentation
SELECT
CASE
    WHEN total_charges >= 80000 THEN 'VIP'
    WHEN total_charges >= 30000 THEN 'High Value'
    ELSE 'Regular'
END AS customer_segment,
COUNT(*) AS customers
FROM customers
GROUP BY customer_segment;

-- Revenue Contribution by Segment
SELECT
CASE
    WHEN total_charges >= 80000 THEN 'VIP'
    WHEN total_charges >= 30000 THEN 'High Value'
    ELSE 'Regular'
END AS customer_segment,
ROUND(SUM(total_charges),2) AS revenue
FROM customers
GROUP BY customer_segment
ORDER BY revenue DESC;

-- Segment-wise Churn Rate
SELECT
CASE
    WHEN total_charges >= 80000 THEN 'VIP'
    WHEN total_charges >= 30000 THEN 'High Value'
    ELSE 'Regular'
END AS customer_segment,

COUNT(*) AS customers,

SUM(
    CASE
        WHEN churn='Yes' THEN 1
        ELSE 0
    END
) AS churned_customers,

ROUND(
SUM(
    CASE
        WHEN churn='Yes' THEN 1
        ELSE 0
    END
)*100.0/COUNT(*)
,2) AS churn_rate

FROM customers
GROUP BY customer_segment
ORDER BY churn_rate DESC;

-- Top 10 Most Valuable Customers
SELECT
customer_name,
city,
plan_type,
total_charges
FROM customers
ORDER BY total_charges DESC
LIMIT 10;

-- Customer Lifetime Value
SELECT
ROUND(AVG(total_charges),2)
AS avg_customer_lifetime_value
FROM customers;

-- Top Cities by Revenue
SELECT
city,
ROUND(SUM(total_charges),2) AS revenue
FROM customers
GROUP BY city
ORDER BY revenue DESC
LIMIT 10;

-- Plan-wise Revenue Contribution
SELECT
plan_type,
ROUND(SUM(total_charges),2) AS revenue,
ROUND(
SUM(total_charges)*100.0/
(SELECT SUM(total_charges) FROM customers),
2
) AS revenue_percent
FROM customers
GROUP BY plan_type
ORDER BY revenue DESC;

-- Average Tenure by Churn
SELECT
churn,
ROUND(AVG(tenure_months),2) AS avg_tenure
FROM customers
GROUP BY churn;

-- Churn by Age Group
SELECT
CASE
    WHEN age < 25 THEN '18-24'
    WHEN age < 35 THEN '25-34'
    WHEN age < 45 THEN '35-44'
    WHEN age < 55 THEN '45-54'
    ELSE '55+'
END AS age_group,

COUNT(*) AS customers,

ROUND(
SUM(CASE WHEN churn='Yes' THEN 1 ELSE 0 END)
*100.0/COUNT(*),
2
) AS churn_rate

FROM customers
GROUP BY age_group
ORDER BY age_group;

-- Customer Segment Distribution
SELECT
CASE
    WHEN total_charges >= 80000 THEN 'VIP'
    WHEN total_charges >= 30000 THEN 'High Value'
    ELSE 'Regular'
END AS customer_segment,

COUNT(*) AS customers,

ROUND(
COUNT(*)*100.0/
(SELECT COUNT(*) FROM customers),
2
) AS customer_percent

FROM customers
GROUP BY customer_segment;



