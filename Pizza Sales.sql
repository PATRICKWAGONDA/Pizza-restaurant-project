SELECT TOP (1000) [pizza_id]
      ,[order_id]
      ,[pizza_name_id]
      ,[quantity]
      ,[order_date]
      ,[order_time]
      ,[unit_price]
      ,[total_price]
      ,[pizza_size]
      ,[pizza_category]
      ,[pizza_ingredients]
      ,[pizza_name]
  FROM [PIZZASALES].[dbo].[pizza_sales]

  ----Finding the Total Revenue
select SUM(total_price) as Total_Revenue
from pizza_sales

----Finding the Average Price
select AVG(total_price) as Average_Price
from pizza_sales 

----finding the total number of orders
Select count(distinct(order_id)) as Ordered_amount
from pizza_sales

----number of pizza ordered 
select sum(quantity) as Total_Pizza
from pizza_sales

-----Various types of pizza ordered 
----Medium 
select pizza_size
from pizza_sales
where pizza_size like 'M'

SELECT count(pizza_size) as Medium_Pizzas
from pizza_sales
where pizza_size like'M'


----Large
select pizza_size 
from pizza_sales
where pizza_size like 'L'

---total_large pizza ordered 
select count(pizza_size) as Large_pizzas
from pizza_sales
where pizza_size like 'L'


-----small
select pizza_size
from pizza_sales
where pizza_size like 'S'

----total small size pizza ordered 
select count(pizza_size) as Small_Pizzas
from pizza_sales
where pizza_size like 'S'


---finding Average order value
--by dividing total_revenue by total number of orders
select sum(total_price)/count(distinct(order_id)) as Order_Value
from pizza_sales

----breaking it down 
----large

select sum(total_price)/count(distinct(order_id)) as Large_Pizza_Value
from pizza_sales
where pizza_size like 'L'

---Medium
select sum(total_price)/count(distinct(order_id)) as Medium_pizza_value
from pizza_sales
where pizza_size like'M'

----Small
select sum(total_price)/count(distinct(order_id)) as Small_Pizza_value
from pizza_sales
where pizza_size like 'S'


-----total pizza sold
select sum( quantity) as total_pizza_sold
from pizza_sales


---------diffrent sizes
--LARGE
select sum(quantity) as Large_Pizza_Sold
from pizza_sales
where pizza_size like 'L'


----Medium
select sum(quantity) as Medium_pizza_sold
from pizza_sales
where pizza_size like 'M'

----Small
select sum(quantity) as Small_pizza_sold
from pizza_sales
where pizza_size like 'S'



--------Orders Placed 
select count(distinct(order_id))as Orders_placed
from pizza_sales

------Large 
select count(distinct(order_id))as Large_Ordered
from pizza_sales
where pizza_size like 'L'

-----Medium 
select count(distinct(order_id))as Medium_Ordered
from pizza_sales
where pizza_size like 'M'


----Small
select count(distinct(order_id))as Small_Ordered
from pizza_sales
where pizza_size like 'S'

-----Average Pizzas Per Order 
---Total pizzas sold divided by number of orders
select round(sum(quantity)/count(distinct(order_id)),2) as AVG_Order
from pizza_sales

----Breaking it down 
-----large 
select round(sum(quantity)/count(distinct(order_id)),2) as AVG_Large
from pizza_sales
where pizza_size like 'L'

------Medium
select round(sum (quantity)/count(distinct(order_id)),2) as AVG_Medium 
from pizza_sales

----Small
select Round(sum(quantity)/count(distinct(order_id)),2) as AVG_Small
from pizza_sales
where pizza_size like 'S'


-------trend from orders
------daily trend
select DATENAME(DW,order_date) as Order_day,count(distinct order_id) as total_orders
from pizza_sales
group by DATENAME(DW,order_date) 
order by DATENAME(DW,order_date)


------Hourly trend 
select DATEPART(Hour,order_time) Order_hours,count(distinct order_id) as total_orders
from pizza_sales
group by DATEPART(Hour,order_time)
order by DATEPART(Hour,order_time)


-----Percentage of sales by Pizza_Category
SELECT 
    pizza_category, 
    SUM(total_price) * 100.0 / (SELECT SUM(total_price) FROM pizza_sales) AS percentage_of_sales
FROM 
    pizza_sales
GROUP BY 
    pizza_category;

--------January
SELECT 
    pizza_category,
    SUM(total_price) AS Total_sales,
    SUM(total_price) * 100.0 / (SELECT SUM(total_price) FROM pizza_sales WHERE MONTH(order_date) = 1) AS PCT
FROM 
    pizza_sales
WHERE 
    MONTH(order_date) = 1
GROUP BY 
    pizza_category
ORDER BY 
    pizza_category;


	-----sales percentage by pizza size
	SELECT 
    pizza_size,
    SUM(total_price) AS Total_sales,
    SUM(total_price) * 100.0 / (SELECT SUM(total_price) FROM pizza_sales WHERE MONTH(order_date) = 1) AS PCT
FROM 
    pizza_sales
WHERE 
    MONTH(order_date) = 1
GROUP BY 
    pizza_size
ORDER BY 
    pizza_size;

	SELECT 
    TOP 5 pizza_name,
    SUM(quantity) AS Total_Pizza_Sold
FROM 
    pizza_sales
GROUP BY 
    pizza_name
ORDER BY 
    Total_Pizza_Sold DESC


	---worst sellers
	select top 5  pizza_name,sum(quantity) as total_pizza_sold
 from pizza_sales
 group by pizza_name
 order by total_pizza_sold asc
