-- Lista antalet produkter per kategori. Listningen ska innehålla kategori-namn och antalet
-- produkter
select category.name as Category, count(shoesId) as Number_of
from category
inner join part_of_category
on category.id = part_of_category.categoryId
group by category.name;

-- Skapa en kundlista med den totala summan pengar som varje kund har handlat för. Kundens
-- för- och efternamn, samt det totala värdet som varje person har shoppats för, skall visas.
select customer.first_name as Förnamn, customer.last_name as Efternamn, sum(shoes.price * orders_info.quantity) as Summa
from customer
inner join orders
on customer.id = orders.customerId
inner join orders_info
on orders_info.ordersId = orders.Id
inner join shoes
on orders_info.shoesId = shoes.Id
group by customer.id;

-- Vilka kunder har köpt svarta sandaler i storlek 38 av märket Ecco? Lista deras namn
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

-- Skriv ut en lista på det totala beställningsvärdet per ort där beställningsvärdet är större än
-- 1000 kr. Ortnamn och värde ska visas.
select customer.county as County, sum(shoes.price * orders_info.quantity) as Summa
from customer
inner join orders
	on customer.id = orders.customerId
inner join orders_info
	on orders_info.ordersId = orders.Id
inner join shoes
	on orders_info.shoesId = shoes.Id
group by customer.county
having summa > 1000;

-- Skapa en topp-5 lista av de mest sålda produkterna.
select shoes.id as Product, count(shoes.id) as count
from orders
inner join orders_info
	on orders_info.ordersId = orders.Id
inner join shoes
	on orders_info.shoesId = shoes.Id
group by shoes.id
order by count desc
limit 5;

-- Vilken månad hade du den största försäljningen?
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




