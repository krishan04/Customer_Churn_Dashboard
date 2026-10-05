/*
=========================================
CHURN ANALYTICS  
=========================================

-> Churn by Plan Type 
-> Churn by Contract Type 
-> Churn by Gender 
-> Top 10 Cities by Churn 
-> Satisfaction vs Churn 
-> Support Tickets vs Churn 
-> Monthly Charges vs Churn 
-> Revenue Lost by Plan 
-> Top 10 High_Risk Customers 
-> Churn by Payment Method 
 
Author: Krishan04.
Project: Customer Churn Analytics & Prediction
=========================================
*/

-- Churn by Plan Type
 SELECT plan_type, COUNT(*) AS total_customers,
    SUM(CASE WHEN churn='Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN churn='Yes' THEN 1 ELSE 0 END)
        *100.0/COUNT(*),2
    ) AS churn_rate
FROM customers
GROUP BY plan_type
ORDER BY churn_rate DESC;

-- Churn by Contract Type 
SELECT contract_type, COUNT(*) AS total_customers,
    SUM(CASE WHEN churn='Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN churn='Yes' THEN 1 ELSE 0 END)
        *100.0/COUNT(*),2
    ) AS churn_rate
FROM customers
GROUP BY contract_type
ORDER BY churn_rate DESC;

-- Churn by Gender 
SELECT gender, COUNT(*) AS total_customers,
    SUM(CASE WHEN churn='Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN churn='Yes' THEN 1 ELSE 0 END)
        *100.0/COUNT(*),2
    ) AS churn_rate
FROM customers
GROUP BY gender;

-- Top 10 Cities by Churn
 SELECT city,
    SUM(CASE WHEN churn='Yes' THEN 1 ELSE 0 END) AS churned_customers
FROM customers
GROUP BY city
ORDER BY churned_customers DESC
LIMIT 10;
 
-- Satisfaction vs Churn 
SELECT churn, ROUND(AVG(satisfaction_score),2) AS avg_satisfaction
FROM customers
GROUP BY churn;

-- Support Tickets vs Churn 
SELECT churn,
    ROUND(AVG(support_tickets),2) AS avg_tickets
FROM customers
GROUP BY churn;

-- Monthly Charges vs Churn 
SELECT churn , 
    ROUND(AVG(monthly_charges),2) AS avg_monthly_charges
FROM customers
GROUP BY churn;

-- Revenue Lost by Plan 
SELECT plan_type,
    ROUND(SUM(total_charges),2) AS revenue_at_risk
FROM customers
WHERE churn='Yes'
GROUP BY plan_type
ORDER BY revenue_at_risk DESC;

-- Top 10 High_Risk Customers 
SELECT customer_name, city, plan_type, total_charges
FROM customers
WHERE churn='Yes'
ORDER BY total_charges DESC
LIMIT 10;

-- Churn by Payment Method
SELECT payment_method, COUNT(*) AS customers,
    SUM(CASE WHEN churn='Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN churn='Yes' THEN 1 ELSE 0 END)
        *100.0/COUNT(*),2
    ) AS churn_rate
FROM customers
GROUP BY payment_method
ORDER BY churn_rate DESC;

