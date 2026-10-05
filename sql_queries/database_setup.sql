-- Database Creation  
CREATE DATABASE customer_churn_db;
USE customer_churn_db ;

-- Table Creation 
CREATE TABLE customers(
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    gender VARCHAR(20),
    age INT,
    city VARCHAR(50),
    join_date DATE,
    tenure_months INT,
    plan_type VARCHAR(30),
    monthly_charges DECIMAL(10,2),
    total_charges DECIMAL(12,2),
    contract_type VARCHAR(30),
    payment_method VARCHAR(50),
    support_tickets INT,
    satisfaction_score DECIMAL(3,1),
    churn VARCHAR(10)
);

SELECT COUNT(*) FROM customers ;  