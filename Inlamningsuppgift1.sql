drop database if exists shoeshop;
create database shoeshop;
use shoeshop;

create table customer (id int auto_increment not null,
first_name varchar(50) not null,
last_name varchar(50) not null,
street varchar(50) not null,
county varchar (50) not null,
primary key (id));

create table orders (id int auto_increment not null,
customerId int not null,
order_date date not null,
foreign key (customerId) references customer(id),
primary key (id));

create table category (id int auto_increment not null,
name varchar(50) not null,
primary key (id));

create table brand (id int auto_increment not null,
name varchar(50) not null,
primary key (id));

create table shoes (id int auto_increment not null,
size int not null,
brandId int,
color varchar(50) not null,
price double not null,
foreign key (brandId) references brand(id) on 
update cascade on delete set null, -- update om märke byter namn eller blir uppkö+t, delete om märke går i konkurs
primary key (id));

create table part_of_category (id int auto_increment not null,
shoesId int not null,
categoryId int not null,
foreign key (shoesId) references shoes(id),
foreign key (categoryId) references category(id),
primary key (id));

create table orders_info (id int auto_increment not null,
ordersId int not null,
shoesId int not null,
quantity int not null,
foreign key (ordersId) references orders(id),
foreign key (shoesId) references shoes(id),
primary key (id));

create table grade_choice (id int auto_increment not null,
choice varchar(50) not null,
primary key (id));

create table grade (id int auto_increment not null,
customerId int not null,
shoesId int not null,
grade_choiceId int not null,
comments varchar(100),
foreign key (customerId) references customer(id),
foreign key (shoesId) references shoes(id),
foreign key (grade_choiceId) references grade_choice(id),
primary key (id));

insert into customer (first_name, last_name, street, county) values ('Nick', 'Danielsson', 'Prg 52', 'Tyresö');
insert into customer (first_name, last_name, street, county) values ('Camilla', 'Skagerling', 'Prg 52', 'Tyresö');
insert into customer (first_name, last_name, street, county) values ('Johan', 'Rune', 'Abc 123', 'Lidingö');
insert into customer (first_name, last_name, street, county) values ('Peter', 'Almgren', 'Sikvägen', 'Tyresö');
insert into customer (first_name, last_name, street, county) values ('Maja', 'Rune', 'Def 123', 'Bromma');


insert into orders (customerId, order_date) values (1, '2020-12-20');
insert into orders (customerId, order_date) values (2, '2020-12-21');
insert into orders (customerId, order_date) values (1, '2021-01-05');
insert into orders (customerId, order_date) values (3, '2020-03-20');
insert into orders (customerId, order_date) values (4, '2020-03-10');
insert into orders (customerId, order_date) values (5, '2020-03-13');

insert into category (name) values ('Women');
insert into category (name) values ('Men');
insert into category (name) values ('Kids');
insert into category (name) values ('Sport');
insert into category (name) values ('Sandal');

insert into brand (name) values ('Ecco');
insert into brand (name) values ('Adidas');
insert into brand (name) values ('Puma');
insert into brand (name) values ('Tretorn');
insert into brand (name) values ('Nike');
insert into brand (name) values ('Timberland');
insert into brand (name) values ('Viking');


insert into shoes (size, brandId, color, price) values (38, 1, 'black', 500);
insert into shoes (size, brandId, color, price) values (40, 2, 'white', 800);
insert into shoes (size, brandId, color, price) values (43, 3, 'white', 900);
insert into shoes (size, brandId, color, price) values (45, 4, 'black', 1000);
insert into shoes (size, brandId, color, price) values (18, 5, 'grey', 700);
insert into shoes (size, brandId, color, price) values (35, 6, 'black/white', 750);
insert into shoes (size, brandId, color, price) values (44, 7, 'organge', 850);
insert into shoes (size, brandId, color, price) values (24, 3, 'pink', 600);

insert into part_of_category (shoesId, categoryId) values (1, 1);
insert into part_of_category (shoesId, categoryId) values (1, 5);
insert into part_of_category (shoesId, categoryId) values (2, 4);
insert into part_of_category (shoesId, categoryId) values (3, 4);
insert into part_of_category (shoesId, categoryId) values (4, 5);
insert into part_of_category (shoesId, categoryId) values (5, 3);
insert into part_of_category (shoesId, categoryId) values (6, 1);
insert into part_of_category (shoesId, categoryId) values (7, 4);
insert into part_of_category (shoesId, categoryId) values (8, 3);
insert into part_of_category (shoesId, categoryId) values (3, 2);

insert into orders_info (ordersId, shoesId, quantity) values (1, 1, 2);
insert into orders_info (ordersId, shoesId, quantity) values (1, 3, 1);
insert into orders_info (ordersId, shoesId, quantity) values (1, 2, 1);
insert into orders_info (ordersId, shoesId, quantity) values (2, 6, 3);
insert into orders_info (ordersId, shoesId, quantity) values (3, 8, 1);
insert into orders_info (ordersId, shoesId, quantity) values (4, 7, 2);
insert into orders_info (ordersId, shoesId, quantity) values (5, 8, 1);
insert into orders_info (ordersId, shoesId, quantity) values (6, 2, 1);

insert into grade_choice (choice) values ('Mycket nöjd'), ('Nöjd'), ('Ganska nöjd'), ('Missnöjd');

insert into grade (customerId, shoesId, grade_choiceId, comments) values (1, 1, 1, 'Jag flyger fram'), (4, 8, 4, 'Dålig kvalitet, dyrt!');