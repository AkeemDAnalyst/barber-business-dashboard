CREATE DATABASE Barber_Tran
GO
USE Barber_Tran
GO
/*=============================================================================================================

            Busimess Exploratory Data Analysis (EDA) Question list (For Barber Data)
            
===============================================================================================================*/
SELECT 
    *
FROM Barber_Transactions

/*==============================================================================================    
    General Performance
==============================================================================================*/
 -- 1. What is the total revenue generated?
SELECT 
    SUM(Total_Amount) AS total_revenue
FROM Barber_Transactions

-- 2. What is the Average Amount Spent Per transaction ?
SELECT 
    AVG(Total_Amount) AS Average_transaction
FROM Barber_Transactions

-- 3. Which day of the week brings in the highest total revenue?
SELECT 
    Day_of_week,
    SUM(Total_Amount) AS total_revenue
FROM Barber_Transactions
GROUP BY Day_of_week
ORDER BY total_revenue DESC

-- 4. What is the Average Duration of services overall?
SELECT 
    AVG(Duration_Minutes) AS Average_Duration
FROM Barber_Transactions

-- 5. What is the total transportation fee collected so far?
SELECT 
SUM(Transportation_fee) AS total_transportation_fee
FROM Barber_Transactions
/*==============================================================================================    
    Service Insights
==============================================================================================*/
 -- 6. Which service_type brings in the most revenue?
 SELECT 
    Service_Type,
    SUM(Total_Amount) AS total_revenue
 FROM Barber_Transactions
 GROUP BY Service_Type
 ORDER BY total_revenue DESC 

 -- 7. Which service_category is most popular by number of customers?
 SELECT 
     COUNT(Transaction_ID) AS number_of_customers,
     Service_Category
 FROM Barber_Transactions
 GROUP BY Service_Category
 ORDER BY number_of_customers DESC

 -- 8. What's the average price for each service_type?
 SELECT 
    Service_Type,
    AVG(Price) AS Average_price
 FROM Barber_Transactions
 GROUP BY Service_Type
 ORDER BY Average_price  

 -- 9. Which Service_Type has the highest average customer satisfaction?
  SELECT 
    Service_Type,
    AVG(Customer_Satisfaction) AS Average_Customer_Satisfaction
 FROM Barber_Transactions
 GROUP BY Service_Type
 ORDER BY Average_Customer_Satisfaction DESC 

 -- 10. What's the average duration for each service_Type?
  SELECT 
    Service_Type,
    AVG(Duration_Minutes) AS Average_Duration_Minutes
 FROM Barber_Transactions
 GROUP BY Service_Type
 ORDER BY Average_Duration_Minutes 

/*==============================================================================================    
    Customer Behavior
==============================================================================================*/
 -- 11. How many new vs returning customers have you had?
 SELECT 
    Customer_Type,
     COUNT(Transaction_ID) AS number_of_customers
 FROM Barber_Transactions
 GROUP BY Customer_Type

 -- 12 is there any difference in satisfaction scores between new and returning customers?
 SELECT 
 COUNT(Transaction_ID) AS number_of_customers,
    Customer_Type,
  Customer_Satisfaction
 FROM Barber_Transactions
 GROUP BY Customer_Type, Customer_Satisfaction
 
 --13 Which gender vists more frequently?
 SELECT 
    COUNT(Transaction_ID) AS number_of_customers,
    Customer_Gender
 FROM Barber_Transactions
 GROUP BY Customer_Gender
/*==============================================================================================    
    Financial Performance 
==============================================================================================*/
-- 14. What is the average transportation fee per transaction?
SELECT 
    AVG(Transportation_fee) AS Average_Transportation_fee
FROM Barber_Transactions
-- 15. What is the avearge price-to-total ratio (price vs Total_amount)?
SELECT 
    AVG(CAST(Price AS FLOAT) / NULLIF(TOTAL_AMOUNT,0)) AS Avg_price_to_Total_Ratio
FROM Barber_Transactions
-- 16. What's the revenue trend over time (daily or monthly)?
SELECT 
    Datename(MONTH, [DATE]) AS month_Name,
    SUM(Total_Amount) AS total_revenue
FROM Barber_Transactions
GROUP BY Datename(MONTH, [DATE])
ORDER BY total_revenue DESC

-- 17. What's the avearge Total_amount per day of week?
SELECT 
    Day_of_week,
    AVG(Total_Amount) AS Average_revenue
FROM Barber_Transactions
GROUP BY Day_of_week
ORDER BY Average_revenue DESC

--18. Which payment method is used often?
 SELECT 
    COUNT(Transaction_ID) AS number_of_customers,
    Payment_Method
 FROM Barber_Transactions
 GROUP BY Payment_Method

 -- 19. Which Payment method brings in the highest total revenue?
  SELECT 
    Payment_Method,
     SUM(Total_Amount) AS total_revenue
 FROM Barber_Transactions
 GROUP BY Payment_Method
 ORDER BY total_revenue DESC

 /*==============================================================================================    
   Customer Satisfaction 
==============================================================================================*/
-- 20. what's the average satisfaction score overall?
 SELECT 
     AVG(Customer_Satisfaction) AS Average_Customer_Satisfaction
 FROM Barber_Transactions
 ORDER BY Average_Customer_Satisfaction 

 -- 21. Which service_type gets the lowest average satisfaction?
  SELECT 
    Service_Type,
     AVG(Customer_Satisfaction) AS Average_Customer_Satisfaction
 FROM Barber_Transactions
 GROUP BY Service_Type
 ORDER BY Average_Customer_Satisfaction ASC

-- 22. is there a relationship between duration and satisfaction (longer service = happier customer)?
  SELECT 
     COUNT(Transaction_ID) AS number_of_customers,
     Duration_Minutes,
     Customer_Satisfaction
 FROM Barber_Transactions
 GROUP BY  Duration_Minutes,
           Customer_Satisfaction
ORDER BY number_of_customers 
-- 23. Does Total_amount influence satisfaction (do higher-paying customers rate higher)?
  SELECT 
     Customer_Satisfaction,
     SUM(Total_Amount) AS total_revenue
 FROM Barber_Transactions
 GROUP BY Customer_Satisfaction
ORDER BY total_revenue DESC

/*==============================================================================================    
   Deeper Business insights 
==============================================================================================*/
-- 24. Which day of the week has the highest average total_amount per transaction?
 SELECT 
      Transaction_ID,
      Day_of_week,
      AVG(Total_Amount) AS Average_revenue
 FROM Barber_Transactions
 GROUP BY  Transaction_ID,
           Day_of_week
ORDER BY Average_revenue DESC

-- 25. Which service_Category is most profitable (Total_amount - Transportation_fee)?
 SELECT 
     Service_Category,
     SUM(Total_Amount) AS total_revenue
 FROM Barber_Transactions
 GROUP BY Service_Category
ORDER BY total_revenue DESC

-- 26. Are there any patterns between Customer_Type and service_type (e.g., returning customers prefer beard trims)?
SELECT 
    COUNT(Transaction_ID) AS number_of_customers,
     Customer_Type,
     service_type
 FROM Barber_Transactions
 GROUP BY Customer_Type,
          service_type
ORDER BY number_of_customers 

-- 27. What's the average satisfaction per payment method?
 SELECT
      Payment_Method,
      AVG(Customer_Satisfaction) AS Average_Customer_Satisfaction
 FROM Barber_Transactions
 GROUP BY  Payment_Method
ORDER BY Average_Customer_Satisfaction DESC

-- 28. What's the peak time of day for most transactions?
SELECT 
       Time,
       COUNT(Transaction_ID) AS number_of_customers
 FROM Barber_Transactions
 GROUP BY   Time
ORDER BY number_of_customers DESC