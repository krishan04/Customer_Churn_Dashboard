/*
=========================================
EXECUTIVE OVERVIEW 
=========================================

-> Total Customers 
-> Churned Customers 
-> Churn Rate 
-> Total Revenue 
-> Average Revenue Per Customer 
-> Revenue At Risk 
-> Customers By Plan 
-> Customers By Contract 
-> Average Satisfaction 
-> Average Monthly Charges 

Author: Krishan04.
Project: Customer Churn Analytics & Prediction
=========================================
*/

-- Total Customers
SELECT COUNT(*) AS total_customers FROM customers ;
  
-- Churned Customers
SELECT COUNT(*) AS churned_customers FROM customers WHERE churn = 'Yes' ;
 
-- Churn Rate 
SELECT ROUND(COUNT(CASE WHEN churn = 'Yes' THEN 1 END) * 100.0 / COUNT(*) , 2) AS churn_rate
FROM customers ;

-- Total Revenue
SELECT ROUND(SUM(total_charges) , 2) AS total_revenue FROM customers ;
 
-- Average Revenue Per Customer 
SELECT ROUND(AVG(total_charges) , 2) AS avg_customer_revenue FROM customers ;

-- Revenue At Risk 
SELECT ROUND(SUM(total_charges) , 2) AS revenue_at_risk FROM customers WHERE churn = 'Yes' ;

-- Customers By Plan
SELECT plan_type , COUNT(*) AS customers FROM customers GROUP BY plan_type ORDER BY customers DESC ; 
 
-- Customers By Contract 
SELECT contract_type , COUNT(*) AS customers FROM customers GROUP BY contract_type ORDER BY customers DESC ;

-- Average Satisfaction 
SELECT ROUND(AVG(satisfaction_score) , 2 ) AS avg_satisfaction FROM customers ;

-- Average Monthly Charges
SELECT ROUND(AVG(monthly_charges),2) AS avg_monthly_charges FROM customers;






