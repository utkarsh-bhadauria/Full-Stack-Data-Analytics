create warehouse demowarehouse;
create database demodatabase;
use demodatabase;

show databases;

create or replace table sales_data_final(
order_id varchar(20) ,
order_date varchar(20) PRIMARY KEY,
ship_date	varchar(20),
ship_mode	varchar(20),
customer_name	varchar(30),
segment	varchar(20),
state	varchar(50),
country varchar(50),
market	varchar(20),
region  varchar(20),
product_id	varchar(50),
category varchar(20),
sub_category varchar(20),
product_name  varchar(150),
sales 	int,
quantity	int,
discount  float,
profit  float,
shipping_cost float,
order_priority varchar(20),
year  int

);

describe table sales_data_final;
select * from sales_data_final;
/*
1. Load the given dataset into snowflake with a primary key to Order Date column. 
2. Change the Primary key to Order Id Column. 
3. Check the data type for Order date and Ship date and mention in what data type 
it should be? 
4. Create a new column called order_extract and extract the number after the last 
‘–‘from Order ID column. 
5. Create a new column called Discount Flag and categorize it based on discount. 
Use ‘Yes’ if the discount is greater than zero else ‘No’. 
6. Create a new column called process days and calculate how many days it takes 
for each order id to process from the order to its shipment. 
7. Create a new column called Rating and then based on the Process dates give 
rating like given below. 
a. If process days less than or equal to 3days then rating should be 5 
b. If process days are greater than 3 and less than or equal to 6 then rating 
should be 4 
c. If process days are greater than 6 and less than or equal to 10 then rating 
should be 3 
d. If process days are greater than 10 then the rating should be 2.*/


---1. Load the given dataset into snowflake with a primary key to Order Date column.
---ANS----COMPLETED SEE THE CODE

create or replace table sales_data_final(
order_id varchar(20) ,
order_date varchar(20) PRIMARY KEY,
ship_date	varchar(20),
ship_mode	varchar(20),
customer_name	varchar(30),
segment	varchar(20),
state	varchar(50),
country varchar(50),
market	varchar(20),
region  varchar(20),
product_id	varchar(50),
category varchar(20),
sub_category varchar(20),
product_name  varchar(150),
sales 	int,
quantity	int,
discount  float,
profit  float,
shipping_cost float,
order_priority varchar(20),
year  int

);

describe table sales_data_final;
select * from sales_data_final;


---2. Change the Primary key to Order Id Column.

ALTER TABLE sales_data_final
DROP PRIMARY KEY;

ALTER TABLE sales_data_final
ADD PRIMARY KEY(order_id);

DESCRIBE TABLE sales_data_final;

---3. Check the data type for Order date and Ship date and mention in what data type it should be? 
---ANS---I HAVE ALREADY GIVEN DATE DATA TYPE WHILE CREATING A TABLE

---4. Create a new column called order_extract and extract the number after the last ‘–‘from Order ID column. 

--ANS--

select * from sales_data_final;

SELECT * , SUBSTRING(order_id ,9) AS order_extract from sales_data_final;

--- 5. Create a new column called Discount Flag and categorize it based on discount. Use ‘Yes’ if the discount is greater than zero else ‘No’. 


SELECT *, CASE
         WHEN discount > 0 THEN 'YES'
         ELSE 'NO'
         END AS Discount_Flag
from sales_data_final;

---6. Create a new column called process days and calculate how many days it takes for each order id to process from the order to its shipment. 

select * from sales_data_final;

select *, datediff(day,order_date,ship_date)  AS process_days from sales_data_final;

---7. Create a new column called Rating and then based on the Process dates give rating like given below. 
--a. If process days less than or equal to 3days then rating should be 5 
--b. If process days are greater than 3 and less than or equal to 6 then rating should be 4 
--c. If process days are greater than 6 and less than or equal to 10 then rating should be 3 
--d. If process days are greater than 10 then the rating should be 2.
 
 select *,datediff(day,order_date,ship_date)  AS process_days,
 CASE
 WHEN process_days <= 3 THEN 5
 WHEN process_days > 3 OR process_days <= 6  THEN 4
 WHEN  process_days > 6 OR process_days <= 10  THEN 3
 ELSE 2
 END AS RATING FROM sales_data_final;
 
 