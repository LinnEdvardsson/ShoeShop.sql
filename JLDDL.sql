Drop database if exists LJShoeShop;  
create database LJShoeShop;  
use LJShoeShop;  

Create table Location (  
id int auto_increment primary key,  
city varchar(30) not null  
);  

Create table Customer (  
id int auto_increment primary key,  
firstName varchar(30) not null,  
lastName varchar(30) not null,  
sscr char(10) not null unique,  
locationId int,  
Foreign key (locationid) references Location(id) on delete set null 
);  


Create table CustomerOrder(  
id int auto_increment primary key,  
dateOfOrder timestamp default current_timestamp,  
customerId int,  
foreign key(customerId) references Customer(id) on delete set null 
);  

Create table Specification(  
id int auto_increment primary key,  
price int not null,  
shoeSize int not null,  
color char(10) not null,  
brand varchar(20) not null  
);  

Create table Product(  
id int auto_increment primary key,  
productName varchar(30) not null,  
specId int,  
foreign key(specId) references Specification(id) on delete set null 
);  

Create table Category(  
id int auto_increment primary key,  
categoryName varchar(30) not null  
);  

Create table Inventory(  
id int auto_increment primary key,  
quantity int not null,  
productId int,  
Foreign key (productId) references Product(id) on delete set null 
);  

Create table ProductInCategory(  
productId int,  
categoryId int,  
foreign key(productId) references Product(id) on delete cascade, 
foreign key(categoryId) references Category(id) on delete cascade 
);  


Create table OrderedProduct(  
orderId int,  
productId int,  
quantity int not null,  
foreign key (orderId) references CustomerOrder(id) on delete cascade, 
foreign key (productId) references Product(id) on delete set null  
); 


create index IX_sscr on Customer(sscr);

create index IX_productname on Product(productName);

insert into Location(City) values 
('Gävle'), 
('Eslöv'), 
('Mjölby'), 
('Stockholm'); 

insert into Customer (firstName, lastName, sscr, locationid) values  
('Per', 'Persson', '8910103434', (select id from Location where City = 'Stockholm')), 
('Anna', 'Andersson', '9509301127', (select id from Location where City = 'Stockholm')), 
('Olle', 'Olsson', '0112249099', (select id from Location where City = 'Mjölby')), 
('Lisa', 'Larsson', '0304164789', (select id from Location where City = 'Gävle')), 
('Kalle', 'von Sydow', '7902307711', (select id from Location where City= 'Eslöv')),
('Åke', 'Åkesson', '6812270404', (select id from Location where City= 'Mjölby')
);

insert into Category(categoryName) values 
('Sneaker'), 
('Boot'), 
('Sandal'), 
('Slip in'), 
('Heel'),
('Flip-flops');
 
insert into Specification (price, shoeSize, color, brand) values 
('1099', '37', 'Black', 'Dr Martens'), 
('999', '38', 'Brown', 'Tamaris'), 
('600', '36', 'White', 'Nike'), 
('1299', '40', 'Gold', 'Vagabond'), 
('1999', '39', 'White', 'Adidas'), 
('445', '37', 'Brown', 'Vagabond'), 
('1199', '38', 'Grey', 'Bianco'),
('899', '41', 'White', 'Birkenstock'),
('1999', '40', 'Green', 'Adidas');

insert into CustomerOrder(dateOfOrder, customerId) values 
('2025-01-10', '1'), 
('2025-01-11', '2'), 
('2024-12-20', '3'), 
('2024-12-30', '2'), 
('2025-01-20','5'), 
('2025-01-24', '4'); 
 
insert into Product(productName, specId) values 
('Jadon', '1'), 
('Panther', '2'), 
('Air Max 5', '3'), 
('Freeze', '4'), 
('Samba', '5'), 
('Brown breeze', '6'), 
('Leather Fox', '7'),  
('Arizona', '8'),
('Samba', '9');

insert into Inventory(quantity, productId) values 
('100', '1'), 
('150', '2'), 
('60', '3'), 
('200', '4'), 
('82', '5'), 
('40', '6'), 
('25', '7'), 
('110', '8'),
('20', '9');

Insert into ProductInCategory (productId, categoryId) values  
('1', '2'),
('1', '5'), 
('2', '3'), 
('2', '4'), 
('3', '1'), 
('4', '5'), 
('5', '3'), 
('5', '5'), 
('6', '1'), 
('7', '2'), 
('8', '4'); 
 
Insert into OrderedProduct(orderId, productId, quantity) values 
('1', '1', '1'),
('1', '2', '1'),
('2', '6', '2'),
('3', '2', '1'), 
('4', '1', '1'),
('4', '5', '1'), 
('5', '5', '2'), 
('6', '8', '7'),
('6', '4', '13');
