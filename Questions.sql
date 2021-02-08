
-- Lista antalet produkter per kategori. Listningen ska innehålla kategori-namn och antalet produkter.

select count(poc.shoesid) as amount, c.name as category
from part_of_category poc
join category c
	on poc.categoryid = c.id
    group by c.name;
    
    
-- Skapa en kundlista med den totala summan pengar som varje kund har handlat för.
-- Kundens för- och efternamn, samt det totala värdet som varje person har shoppats för, skall visas.

select customer.first_name, customer.last_name, sum(shoes.price * orders_info.quantity) as Total
from customer
join orders
	on orders.customerid = customer.id
join orders_info
	on orders_info.ordersid = orders.id
join shoes
	on orders_info.shoesid = shoes.id
     group by customer.id;

 
-- Vilka kunder har köpt svarta sandaler i storlek 38 av märket Ecco? Lista deras namn.

select customer.first_name, customer.last_name
from customer
join orders
	on orders.customerid = customer.id
join orders_info
	on orders_info.ordersid = orders.id
join shoes
	on orders_info.shoesid = shoes.id
join part_of_category
	on shoes.id = part_of_category.shoesid
join category
	on category.id = part_of_category.categoryid
     where shoes.brandid like 1 and shoes.size like 38 and category.name like 'Sandal';


-- Skriv ut en lista på det totala beställningsvärdet per ort där beställningsvärdet är större än
-- 1000 kr. Ortnamn och värde ska visas. (det måste finnas orter i databasen där det har
-- handlats för mindre än 1000 kr för att visa att frågan är korrekt formulerad)

select customer.county, sum(shoes.price * orders_info.quantity) as Total
from customer
join orders
	on orders.customerid = customer.id
join orders_info
	on orders_info.ordersid = orders.id
join shoes
	on orders_info.shoesid = shoes.id
     group by customer.county
	 having sum(shoes.price * orders_info.quantity) > 1000;
     
     
-- Skapa en topp-5 lista av de mest sålda produkterna. 

select sum(orders_info.quantity) as Pairs_sold , orders_info.shoesid as Shoe_ID
from orders_info
join shoes
	on orders_info.shoesid = shoes.id
    group by orders_info.shoesid
    order by Pairs_Sold desc limit 5;
	

-- Vilken månad hade du den största försäljningen? (det måste finnas data som anger
-- försäljning för mer än en månad i databasen för att visa att frågan är korrekt formulerad)

select year(o.order_date) as Year_ , monthname(o.order_date) as Month_ , sum(s.price * oi.quantity) as Total_Sale
from orders o
join orders_info oi
	on o.id = oi.ordersid
join shoes s
	on oi.shoesid = s.id
    group by year_, month_
    order by Total_Sale desc; -- limit 1 ? 
