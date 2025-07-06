CREATE TABLE Books (
	Book_ID SERIAL Primary Key,
	Title VARCHAR(100),
	Author VARCHAR(100),
	Genre VARCHAR(50),
	Published_Year INT,
	Price NUMERIC(10,2),
	Stock INT	
);

Alter Table Books  
Rename Column book_id to Book_ID;

CREATE TABLE Customers (
	Customer_ID SERIAL Primary Key,
	Name VARCHAR(100),
	Email VARCHAR(100),
	Phone VARCHAR(10),
	City VARCHAR(50),
	Country VARCHAR(150)
);

CREATE TABLE Orders (
	Order_ID SERIAL Primary Key,
	Customer_ID INT References Customers(Customer_ID),
	Book_ID INT References Books(Book_ID),
	Order_Date DATE,
	Quantity INT,
	Total_Amount NUMERIC(10,2)
);

copy books 
FROM 'D:/sql/All Excel Practice Files/SQL/Excel.CSV/Books.csv' DELIMITER ',' CSV HEADER;

copy books FROM 'D:\\sql\\All Excel Practice Files\\SQL\\Excel.CSV\\Books.csv' DELIMITER ',' CSV HEADER;


COPY Books(Book_ID, Title, Author, Genre, Published_Year, Price, Stock)
FROM 'D:\Books.csv'
DELIMITER ','
CSV HEADER ;

COPY Books(Book_ID, Title, Author, Genre, Published_Year, Price, Stock)
FROM 'D:/Course Updates/30 Day Series/SQL/CSV/Books.csv'
CSV HEADER;

Select * From Books;
Select * From Customers;
Select * From Orders;

--1 Retrieve all books in the "Fiction" genre?

SELECT *
FROM books
WHERE genre = 'Fiction';





--2 Find books published after the year 1950
SELECT *
FROM books
WHERE published_year > 1950;

--3) List all customers from the Canada
Select * From Customers;

SELECT *
FROM customers
WHERE country = 'Canada';

--4) Show orders placed in November 2023

SELECT *
FROM orders
WHERE order_date between '2023-11-01' and '2023-11-30';

--5) Retrieve the total stock of books available

SELECT SUM(stock) AS total_stock
FROM books;

--6) Find the details of the most expensive book

SELECT *
FROM books
ORDER BY price DESC
LIMIT 5;

--7) Show all customers who ordered more than 1 quantity of a book
SELECT *
FROM orders
WHERE quantity > 1;
--8) Retrieve all orders where the total amount exceeds $20

SELECT *
FROM books
WHERE price > 20;
--9) List all genres available in the Books table

 select distinct genre from books;
 
--10) Find the book with the lowest stock
SELECT *
FROM books
order by stock asc
;

--11) Calculate the total revenue generated from all orders 

select sum(total_amount) as "Revenue" from orders;

Select * From Books;
Select * From Customers;
Select * From Orders;

Advance Queries
--1) Retrieve the total number of books sold for each genre
select genre, sum (quantity) from
	books o
join orders q
on o.book_id = q.book_id
group by genre;

--2) Find the average price of books in the "Fantasy" genre
select  avg(price) as Avg_price from books 
where genre = 'Fantasy'
;


--3) List customers who have placed at least 2 orders
select c.name, count (o.order_id)  as Orders_count from 
	customers c
join orders o
on c.customer_id = o.customer_id
group by c.customer_id
Having count(o.order_id) >=2;



--4) Find the most frequently ordered book
select b.title, o.book_id, count (o.book_id ) as Order_count 
from 
	orders o
join books b
on o.book_id = b.book_id
group by o.book_id, b.title
order by order_count desc; 
  

--5) Show the top 3 most expensive books of 'Fantasy' Genre

select * from books 
where genre = 'Fantasy' 
order by price
limit 3 ;

--6) Retrieve the total quantity of books sold by each author

Select * From Books;
Select * From Orders;

select b.author,  sum ( o.quantity ) as total_books_sold
from Books b
join Orders o
on b.book_id=o.book_id
group by b.author;

--7) List the cities where customers who spent over $30 are located
Select * From Customers;
Select * From Orders;


select c.customer_id, C.name, c.city, sum(o.total_amount) as Total_amount from
	Customers c
Join Orders o
on c.customer_id=o.customer_id
Where o.total_amount > 30
group by c.customer_id,C.name, c.city
order by total_amount desc;



--8) Find the customer who spent the most on orders


--9) Calculate the stock remaining after fulfilling all orders