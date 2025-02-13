-- 2
create view view_film_category as 
select 
film.film_id,
film.title,
category.name as "CategoryName"
from film 
join film_category on film.film_id = film_category.film_id
join category on film_category.category_id = category.category_id;
-- 4
create view view_high_value_customers as
select
customer.customer_id,
customer.first_name,
customer.last_name,
sum(payment.amount) as "total_payment"
from customer
join payment on payment.customer_id = customer.customer_id
group by customer.customer_id,customer.first_name,customer.last_name
having sum(payment.amount) > 100;
-- 5
create index idx_rental_rental_date on rental(rental_date);
select * from rental where rental_date = '2005-06-14';
explain select * from rental where rental_date = '2005-06-14';
-- 6
delimiter &&
create procedure CountCustomerRentals (in customer_id int,out rental_count int)
begin
select count(*) into rental_count
from rental
where rental.customer_id = customer_id;
end &&
delimiter ;
-- 7
delimiter &&
create procedure GetCustomerEmail(in customer_id int, out email varchar(50))
begin
    select email into email 
    from customer 
    where customer_id = customer_id 
    limit 1;
end &&
delimiter ;
-- 8
drop index idx_rental_rental_date on rental;
drop procedure CountCustomerRentals;
drop procedure GetCustomerEmail;

