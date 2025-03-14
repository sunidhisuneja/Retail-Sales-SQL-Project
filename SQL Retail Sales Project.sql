---Create table---
Drop Table if exists Retail_Sales;
Create Table Retail_Sales
(
	transactions_id int primary key,
    sale_date date,
	sale_time time,
	customer_id int,
	gender varchar(10),
	age int,
	category varchar(15),
	quantity int,
	price_per_unit float,
	cogs float,
	total_sale float
);

Select * from Retail_Sales
limit 10;

Select count(*) from Retail_Sales;

--Cleaning of Data--
Select * from Retail_Sales
where 
transactions_id is null
or
sale_date is null
or
sale_time is null
or
customer_id is null
or
gender is null
or
age is null
or 
category is null
or 
quantity is null
or 
price_per_unit is null
or
cogs is null
or 
total_sale is null;

-- Deleting null values--

Delete from Retail_sales
where
transactions_id is null
or
sale_date is null
or
sale_time is null
or
customer_id is null
or
gender is null
or
age is null
or 
category is null
or 
quantity is null
or 
price_per_unit is null
or
cogs is null
or 
total_sale is null;

-- Exploration of Data--
-- How many sales we have?--
Select count(*) as totalsale from Retail_Sales;

--How many customers do we have?
Select count(Distinct customer_id) as totalcust from Retail_Sales;

--How many categories are there?
Select Distinct category from Retail_Sales; 

--Q-1 Write a SQL Query to retrieve all columns for sales made on "2022-11-05"?
Select * from Retail_Sales
where sale_date = '2022-11-05';

--Q-2 Write a SQL Query to retrieve all transactions where the category is "Clothing" and the quantity sold is more than 10 in the month of Nov-2022?
Select transactions_id from Retail_Sales
where category = 'Clothing' and quantity > 3
and to_char(sale_date,'YYYY-MM')='2022-11';

--Q-3 Write a SQL query to calculate the total sales(total_sale) for each category.
Select category,sum(total_sale),count(*) as total_orders
from Retail_Sales
group by category;

--Q-4 Write a SQL query to find the average age of customers who purchased items from the "Beauty" category.
Select Round(avg(age),2) as avg_age
from Retail_Sales
where category = 'Beauty';

--Q-5 Write a SQL query to find all the transactions where the total_sale is greater than 1000?
Select * from Retail_Sales
where total_sale>1000;

--Q-6 Write a SQL query to find the total number of transactions (transactions_id) made by each gender in each category.
Select category,gender,count(distinct transactions_id) as tot_trans from Retail_Sales
group by category,gender
order by category;

--Q-7 Write a SQL query to calculate the average sale of each month.Find out the best selling month in each year. 
With t1 as
( Select extract (year from sale_date) as year,extract (month from sale_date) as month,
  avg(total_sale) as avgsale,
  rank() over(partition by extract (year from sale_date) order by avg(total_sale) DESC) as rank
  from Retail_Sales
  group by year,month )
Select * from t1
where rank =1;
--in this case where condition cannot be used because the rank column has been created by us
-- So we will use CTE.
--order by year,avgsale desc

--Q-8 Write a SQL query to find out the top 5 customers based on highest total sales
Select customer_id,sum(total_sale) as totsale
from Retail_sales
group by customer_id
order by totsale desc
limit 5;

--Q-9 Write a SQL query to find the number of unique customers who purchased items from each category.
Select category,count(distinct customer_id) as uniquecustcount
from Retail_Sales
group by category;

--Q-10 Write a SQL query to create each shift and number of orders.
--Example Morning <=12,Afternoon between 12 and 17,Evening >=17
with t2 as
(
Select *,
CASE
	when extract(hour from sale_time)<12 then 'Morning'
	when extract(hour from sale_time) between 12 and 17 then 'Afternoon'
	else 'Evening'
END as Shift
from Retail_Sales
)
Select shift,count(*)as tot_ord from t2
group by shift

--end of project



