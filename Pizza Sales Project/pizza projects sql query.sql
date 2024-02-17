create database pizza_db;
use pizza_db;
select * from pizza_sales;
select sum(total_price) as Total_Revenue from pizza_sales;

select sum(total_price) / count(distinct order_id) as Average_order_value from pizza_sales;

select sum(quantity) as total_pizza_sold from pizza_sales;

select count(distinct order_id) as Total_orders from pizza_sales;

select sum(quantity) / count(distinct order_id) as avg_pizza_per_order from pizza_sales;

select dayname(dw, order_date ) as order_day,
count(distinct order_id) as total_orders
from pizza_sales
group by dayname(dw, order_date);

select dayofweek(order_date) as order_day,
count(distinct order_id) as total_orders
from pizza_sales
group by dayname(curedate(), order_date);

select dayname(month, order_date) as month_name,
count(distinct order_id)
from pizza_sales
group by dayname(month, order_date);

select pizza_category,
sum(total_price) * 100 / 
(select sum(total_price) from pizza_sales) as percentage_sales
from pizza_sales
group by pizza_category;

select pizza_size,
sum(total_price) * 100 /
(select sum(total_price) from pizza_sales) as percetage_sales
from pizza_sales
group by pizza_size;

# Top 5 best sellers by revenue, total quantity and orders;
select pizza_name, sum(total_price) as total_revenue from pizza_sales
group by pizza_name
order by total_revenue desc;


