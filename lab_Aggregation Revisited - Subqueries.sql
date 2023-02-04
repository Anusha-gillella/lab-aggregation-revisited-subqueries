use sakila;

-- Q1: Select the first name, last name, and email address of all the customers 
-- who have rented a movie.
select c.first_name, c.last_name, c.email from customer as c
where active = 1;


-- Q2: What is the average payment made by each customer (display the customer id, 
-- customer name (concatenated), and the average payment made).
select c.customer_id, concat(c.first_name,c.last_name)as full_name, round(avg(p.amount),1) as average_amount 
from customer c
join payment as p using(customer_id)
group by customer_id
order by customer_id;


-- Q3:Select the name and email address of all the customers who have rented the "Action" movies.

-- Q3.1:Write the query using multiple join statements
select concat(c.first_name, c.last_name) as full_name, c.email, cat.name from customer as c
join rental as r using(customer_id)
join inventory as i using(inventory_id)
join film as f using(film_id)
join film_category as fm using(film_id)
join category as cat using(category_id)
where cat.name = 'Action'
order by full_name;


-- Q3.2:Write the query using sub queries with multiple WHERE clause and IN condition
select * from (
	select concat(c.first_name, c.last_name) as full_name, c.email, cat.name from customer as c
	join rental as r using(customer_id)
	join inventory as i using(inventory_id)
	join film as f using(film_id)
	join film_category as fm using(film_id)
	join category as cat using(category_id)
	) sub1
where sub1.name = 'Action'
order by full_name;




-- Q3.3: Verify if the above two queries produce the same results or not
-- (duration to run the query is longer than using subqueries. A part from that 
--            they worked similar. Action movies are rented 1112 customers.)
-- using joins: Join statement is used to combine data or rows from two or more tables based on a common field between them.
-- Subquery: A subquery is a nested query (inner query) that’s used to filter the results of the outer query. 
--           Subqueries can be used as an alternative to joins. A subquery is typically nested inside the WHERE clause.




-- Q4: Use the case statement to create a new column classifying existing columns as either or high value 
-- transactions based on the amount of payment. If the amount is between 0 and 2, label should be low and if 
-- the amount is between 2 and 4, the label should be medium, and if it is more than 4, then it should be high.
select payment_id, 
	(case when amount >= 0 and amount <= 2 then Amount end) as low,
	(case when amount >= '3' and amount <= '4' then Amount end) as medium_A,
    (case when amount >=5 then Amount end) as high
from 
	(select payment_id, amount from payment
    ) sub1
order by payment_id;