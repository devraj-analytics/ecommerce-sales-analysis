-- Project: E-commerce Sales & Customer Analysis


-- Objective 1. Creating a new Database
Create Database ecommerce_db;

Use ecommerce_db;



-- Objective 2. Accessing the Contens from the Tables
Select * From olist_customers_dataset;
Select * From olist_orders_dataset;
Select * From olist_order_items_dataset;
Select * From olist_order_payments_dataset;
Select * From olist_products_dataset;



-- Objective 3. Total Revenue
Select Sum(P.payment_value) As Total_Revenue
From olist_orders_dataset O
Join olist_order_payments_dataset P On O.order_id = P.order_id
Where O.order_status = 'delivered';
-- Total Revenue of all sales that has been delivered = 15422461.77



-- Objective 4. Monthly Sales Trend
Select 
Year(order_purchase_timestamp) As Year,
Month(order_purchase_timestamp) As Month,
Sum(payment_value) As Revenue
From olist_orders_dataset O
Join olist_order_payments_dataset P
On O.order_id = P.order_id
Where O.order_status = 'delivered'
Group by Year(order_purchase_timestamp), Month(order_purchase_timestamp)
Order by Year, Month;
-- Revenue peaked in November 2017, likely due to seasonal sales events such as Black Friday



-- Objective 5. Top 10 Customers
Select Top 10
C.customer_unique_id,
Sum(P.payment_value) As Total_Spent
From olist_customers_dataset C
Join olist_orders_dataset O On C.customer_id = O.customer_id
Join olist_order_payments_dataset P
On O.order_id = P.order_id
Where O.order_status = 'delivered'
Group by C.customer_unique_id
Order by Total_Spent DESC;
-- Top 10 customers contribute a significant portion of total revenue, indicating a strong customer concentration.



-- Objective 6. Top Selling Products
Select Top 10
p.product_category_name,
Count (Distinct oi.order_id) As Total_orders
From olist_products_dataset p
Join olist_order_items_dataset oi On p.product_id = oi.product_id
Group by p.product_category_name
Order by Total_orders Desc;
-- The top product categories account for the highest number of orders, indicating strong demand concentration in a few categories.



-- Objective 7. Average Order Value
Select 
Sum(P.payment_value) / Count(DISTINCT O.order_id) As Avg_order_value
From olist_orders_dataset O
Join olist_order_payments_dataset P
On O.order_id = P.order_id
Where O.order_status = 'delivered';
-- Average order value = 159.85



-- Objective 8. Payment Method Analysis
Select payment_type,
Sum(payment_value) As Total_revenue
From olist_order_payments_dataset
Group by payment_type
Order by Total_revenue Desc;
-- Maximum Customers uses Credit card for Payment





--   Business Summary
-- * Total revenue generated was 15422461.77, indicating overall business scale
-- * Sales peaked in November 2017, suggesting strong seasonal demand (possibly due to sales events)
-- * A small group of customers contributes a large share of revenue (high-value customers)
-- * Certain product categories dominate order volume, indicating customer preference trends
-- * Average order value is relatively moderate, suggesting opportunity for upselling
-- * Majority of transactions are made through Credit Card, showing customer payment preference