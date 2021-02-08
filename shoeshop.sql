drop database if exists shoeshop;
create database shoeshop;
use shoeshop;

create table customer(
id int not null auto_increment,
first_name varchar(50) not null,
last_name varchar(50) not null,
street varchar(50) not null,
county varchar(50) not null,
primary key (id));

create table orders(
id int not null auto_increment,
customerid int not null,
order_date date not null,
primary key (id),
foreign key (customerid) references customer(id));

create table category(
id int not null auto_increment,
name varchar(50) not null,
primary key(id));

create table brand(
id int not null auto_increment,
brand varchar(50) not null,
primary key(id));

create table shoes(
id int not null auto_increment,
size int not null,
brandid int,
color varchar(50) not null,
price double not null,
primary key(id),
foreign key(brandid) references brand(id) on update cascade on delete set null); -- update om märke byter namn eller blir uppköpt, delete om märke går i konkurs, plötsligt säljstop pga något.

create table part_of_category(
id int not null auto_increment,
shoesid int not null,
categoryid int not null,
primary key(id),
foreign key(shoesid) references shoes(id),
foreign key(categoryid) references category(id));

create table orders_info(
id int not null auto_increment,
ordersid int not null,
shoesid int not null,
quantity int not null,
primary key(id),
foreign key(ordersid) references orders(id),
foreign key(shoesid) references shoes(id));

create table grade_choice(
id int not null auto_increment,
choice varchar(50) not null,
primary key(id));

create table grade(
id int not null auto_increment,
customerid int not null,
shoesid int not null,
grade_choiceid int not null,
comments varchar(100),
primary key(id),
foreign key(customerid) references customer(id),
foreign key(shoesid) references shoes(id),
foreign key(grade_choiceid) references grade_choice(id));


insert into customer(id, first_name, last_name, street, county) values (1,'Nick', 'Danielsson', 'prg 52', 'Tyresö');
insert into customer(id, first_name, last_name, street, county) values (2,'Camilla', 'Skagerling', 'prg 52', 'Tyresö');
insert into customer(id, first_name, last_name, street, county) values (3,'Johan', 'Rune', 'abc123', 'Lidingö');
insert into customer(id, first_name, last_name, street, county) values (4,'Peter', 'Almgren', 'Sikvägen', 'Tyresö');
insert into customer(id ,first_name, last_name, street, county) values (5,'Maja', 'Rune', 'def123', 'Bromma');

insert into orders(customerid, order_date) values (1, '2020-12-20');
insert into orders(customerid, order_date) values (2, '2020-12-21');
insert into orders(customerid, order_date) values (1, '2021-01-05');
insert into orders(customerid, order_date) values (3, '2020-03-20');
insert into orders(customerid, order_date) values (4, '2020-03-10');
insert into orders(customerid, order_date) values (5, '2020-03-13');

insert into category(name) value ('Women');
insert into category(name) value ('Men');
insert into category(name) value ('Kids');
insert into category(name) value ('Sport');
insert into category(name) value ('Sandal');

insert into brand(brand) value ('Ecco');
insert into brand(brand) value ('Adidas');
insert into brand(brand) value ('Puma');
insert into brand(brand) value ('Tretorn');
insert into brand(brand) value ('Nike');
insert into brand(brand) value ('Timberland');
insert into brand(brand) value ('Viking');

insert into shoes(size, brandid, color, price) values (38, 1, 'Black', 500);
insert into shoes(size, brandid, color, price) values (40, 2, 'White', 800);
insert into shoes(size, brandid, color, price) values (43, 3, 'White', 900);
insert into shoes(size, brandid, color, price) values (45, 4, 'Black', 1000);
insert into shoes(size, brandid, color, price) values (18, 5, 'Grey', 700);
insert into shoes(size, brandid, color, price) values (35, 6, 'Black/white', 750);
insert into shoes(size, brandid, color, price) values (44, 7, 'Orange', 850);
insert into shoes(size, brandid, color, price) values (24, 3, 'Pink', 600);

insert into part_of_category(shoesid, categoryid) values (1, 1);
insert into part_of_category(shoesid, categoryid) values (1, 5);
insert into part_of_category(shoesid, categoryid) values (2, 4);
insert into part_of_category(shoesid, categoryid) values (3, 4);
insert into part_of_category(shoesid, categoryid) values (4, 5);
insert into part_of_category(shoesid, categoryid) values (5, 3);
insert into part_of_category(shoesid, categoryid) values (6, 1);
insert into part_of_category(shoesid, categoryid) values (7, 4);
insert into part_of_category(shoesid, categoryid) values (8, 3);
insert into part_of_category(shoesid, categoryid) values (3, 2);

insert into orders_info(ordersid, shoesid, quantity) values (1, 1, 2);
insert into orders_info(ordersid, shoesid, quantity) values (1, 3, 1);
insert into orders_info(ordersid, shoesid, quantity) values (1, 2, 1);
insert into orders_info(ordersid, shoesid, quantity) values (2, 6, 3);
insert into orders_info(ordersid, shoesid, quantity) values (3, 8, 1);
insert into orders_info(ordersid, shoesid, quantity) values (4, 7, 2);
insert into orders_info(ordersid, shoesid, quantity) values (5, 8, 1);
insert into orders_info(ordersid, shoesid, quantity) values (6, 2, 1);

insert into grade_choice(choice) values ('Mycket nöjd'), ('Nöjd'), ('Ganska nöjd'), ('Missnöjd');

insert into grade(customerid, shoesid, grade_choiceid, comments) values (1,1,1,'Jag flyger fram'), (4,8,4,'Dålig kvalité, dyrt!');

-- Vi valde att indexera namn i Customer tabellen, då den troligtvis kommer öka mest allteftersom kunderna ökar. Tabellen hade även många kolummner vilket ökar sökstiden.
create index first_name_idx
on customer (first_name);