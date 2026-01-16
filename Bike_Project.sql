create database bike_db;
use bike_db;

select *from brands;
select *from categories;
select *from customers;
select *from order_items;
select *from orders;
select *from products;
select *from staffs;
select *from stocks;
select *from stores;


-- How many orders did each customer place?

select c.customer_id,c.first_name,count(o.order_id) as total_orders
from customers c
Join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.first_name
order by total_orders desc;

-- How many customers do we have in each state?
select state,
       count(customer_id) as total_customers
from customers
group by state
order by total_customers desc;

-- How many orders are completed, pending, or cancelled?
select
    order_status,
    count(*) as total_orders
from orders
group by order_status;

-- Which products are sold the most?

select p.product_name, sum(oi.quantity) as total_sold
from products p
join order_items oi on p.product_id = oi.product_id
group by p.product_name
order by total_sold desc;

-- Which store handled each order?
select
    o.order_id,
    s.store_name
from orders o
join stores s 
 o.store_id = s.store_id;

-- Which categories generate the most sales?
select 
    c.category_name,
    sum(oi.quantity * oi.list_price) as revenue
from categories c
join products p on c.category_id = p.category_id
join order_items oi on p.product_id = oi.product_id
group by c.category_name
order by revenue desc;


-- Which store earns the most revenue?
select 
    s.store_name,
    sum(oi.quantity * oi.list_price) as store_revenue
from stores s
join orders o on s.store_id = o.store_id
join order_items oi on o.order_id = oi.order_id
group by s.store_name
order by store_revenue desc;
