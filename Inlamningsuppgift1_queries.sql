select category.name as Category, count(shoesId) as Number_of
from category
inner join part_of_category
on category.id = part_of_category.categoryId
group by category.name;

select customer.first_name as Förnamn, customer.last_name as Efternamn, sum(shoes.price * orders_info.quantity) as Summa
from customer
inner join orders
on customer.id = orders.customerId
inner join orders_info
on orders_info.ordersId = orders.Id
inner join shoes
on orders_info.shoesId = shoes.Id
group by customer.id;

select customer.first_name as Förnamn, customer.last_name as Efternamn
from customer
inner join orders
on customer.id = orders.customerId
inner join orders_info
on orders_info.ordersId = orders.Id
inner join shoes
on orders_info.shoesId = shoes.Id
inner join part_of_category
on shoes.id = part_of_category.shoesId
inner join category
on part_of_category.categoryId = category.id
-- where customer.id = (shoes.brandid =1) = (category.name = 'sandal') = (shoes.size = 38);
where (shoes.brandid like 1) and (category.name like 'sandal') and (shoes.size like 38);

select customer.county as County, sum(shoes.price * orders_info.quantity) as Summa
from customer
inner join orders
	on customer.id = orders.customerId
inner join orders_info
	on orders_info.ordersId = orders.Id
inner join shoes
	on orders_info.shoesId = shoes.Id
-- inner join part_of_category
	-- on shoes.id = part_of_category.shoesId
-- inner join category
	-- on part_of_category.categoryId = category.id
group by customer.county
having summa > 1000;


select shoes.id as Product, count(shoes.id) as count
from orders
inner join orders_info
	on orders_info.ordersId = orders.Id
inner join shoes
	on orders_info.shoesId = shoes.Id
group by shoes.id
order by count desc
limit 5;


select year (orders.order_date) as Year, month (orders.order_date) as Month, sum(orders_info.quantity*shoes.price) as Count
from orders
inner join orders_info
	on orders_info.ordersId = orders.Id
inner join shoes
	on orders_info.shoesId = shoes.id
group by year, month
order by Count desc
limit 1;


CREATE UNIQUE INDEX index_firstName
ON customer (first_name);
select * from customer use index(index_firstName);




