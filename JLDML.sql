-- vilka kunder som handlar svarta dr martens
select Specification.color, Specification.brand, Customer.firstName
from CustomerOrder
inner join Customer on CustomerOrder.customerId = Customer.id
inner join OrderedProduct on CustomerOrder.id = OrderedProduct.orderId
inner join Product on OrderedProduct.productId = Product.id
inner join Specification on Product.specId = Specification.id
where Specification.color = 'White' and Specification.brand = 'Adidas';

-- produkter i varje kategori
-- right join för att visa kategorier som än inte har några produkter.
select Category.categoryName, count(ProductInCategory.categoryId) as productCount from ProductInCategory 
right join Category on Category.id = ProductInCategory.categoryId
group by Category.categoryName, ProductInCategory.categoryId;

-- totalen varje kund handlat för
-- left join för att få med de kunder som än inte lagt någon order. 
select Customer.firstName, Customer.lastName, sum(OrderedProduct.quantity) as productsOrdered, count(distinct CustomerOrder.id) as ordersPlaced, sum(OrderedProduct.quantity * Specification.price) as total from Customer
left join CustomerOrder on CustomerOrder.customerId = Customer.id 
left join OrderedProduct on OrderedProduct.orderId = CustomerOrder.id
left join Product on Product.id = OrderedProduct.productId
left join Specification on Specification.id = Product.specId
group by Customer.id;

-- total försäljning i varje stad
select Location.city, sum(OrderedProduct.quantity * Specification.price) as total from Customer
inner join Location on Location.id = Customer.locationId
inner join CustomerOrder on CustomerOrder.customerId = Customer.id
inner join OrderedProduct on OrderedProduct.orderId = CustomerOrder.id
inner join Product on Product.id = OrderedProduct.productId
inner join Specification on Specification.id = Product.specId
group by Location.id
having total > 1000;

-- top 5 sålda produkter
select Product.productName, Specification.brand, sum(OrderedProduct.quantity) as sold from OrderedProduct
inner join Product on Product.id = OrderedProduct.productId
inner join Specification on Specification.id = Product.specId
group by Product.id
order by sold desc 
limit 5;

-- månad med störst försäljning
select sum(OrderedProduct.quantity * Specification.price) as totalSales, count(distinct CustomerOrder.id) as totalOrders, date_format(CustomerOrder.dateOfOrder, '%Y-%M') as month
from CustomerOrder
inner join OrderedProduct on OrderedProduct.orderId = CustomerOrder.id
inner join Product on Product.id = OrderedProduct.productId
inner join Specification on Specification.id = Product.specId
group by month
order by totalSales desc limit 1;


