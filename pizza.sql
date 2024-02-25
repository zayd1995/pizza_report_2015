create database if not exists sales;
select * from pizza p ;
-- create procedure 
create procedure pizza ()
begin
	select * from pizza;
end

-- test procedure 
call pizza();

-- show  all columns  

SELECT column_name
FROM information_schema.columns
WHERE table_schema = 'sales'
  AND table_name = 'pizza';

 -- how many null value in every column
 
 select count(case when `order_date` is null then 1 end)as date_null,
 		count(case when `order_id` is null then 1 end)as id_null,
 		count(case when `order_time` is null then 1 end) as time_null,
 		count(case when `pizza_category` is null then 1 end) as ctgory_null,
 		count(case when `pizza_id` is null then 1 end) as pizzid_null,
 		count(case when `pizza_ingredients` is null then 1 end) as ingr_null,
 		count(case when `pizza_name` is null then 1 end) as name_null,
 		count(case when `pizza_name_id` is null then 1 end)as nameid_null,
 		count(case when `pizza_size` is null then 1 end)as size_id,
 		count(case when `quantity` is null then 1 end)as qnt_null,
 		count(case when `total_price` is null then 1 end)as price_null,
 		count(case when `unit_price` is null then 1 end)as uprice_null
 	from pizza p ;
 call pizza();

-- names of pizza 

select distinct `pizza_name`
	from pizza p 
	
-- name_id of pizza

select distinct pizza_name_id 	from pizza p ;
-- how many difference price we have 
select distinct unit_price from pizza p ;
-- how many pizza size we have 
select distinct pizza_size from pizza p ;
-- pizza names
select distinct pizza_name from pizza p ;

-- delete columns we dont need 

alter table pizza 
drop `pizza_ingredients`;

call pizza();

-- turn date column to the mysql format 
 select str_to_date(order_date,'%d/%m/%Y') as daten  from pizza p ;
-- change the form in colum

update pizza
set order_date = replace(order_date, '-', '/');// -- first we need to change date to all be d/m/Y with "/".
call pizza(); 
-- then we can change the formate 
select str_to_date(order_date, '%d/%m/%Y') from pizza p ;

update pizza 
set order_date = str_to_date(order_date, '%d/%m/%Y'); -- here we change the format

alter table pizza 
modify order_date date;

call pizza();
-- how many day we have 
select count(distinct order_date) from pizza p ;


-- the best selling day in year
select  distinct order_date as days , ceil(sum(total_price)) as total
from pizza p 
group by days
order by total desc;

-- the best selling day in every month
    call pizza();
   
   with fatt as (select month(order_date) as months,
   		  day(order_date) as days,
   		  sum(total_price) as total_price ,
   		  row_number() over(partition by month(order_date ) order by sum(total_price)desc) as ranked
   	from pizza 
    group by months , days
    ) 
select * from fatt
where ranked = 1
 ;

call pizza() 

-- select hour(order_time) as hour,
--	sum(total_price) as price,
--	sum(quantity) as quantity
-- from pizza p
--  where month(order_date) = 1
 --  and 	day(order_date) = 1
  -- group by hour 
  -- order by price desc;
  
-- best hour selling everyday
with hourly as (select month(order_date) as months,
	  day(order_date) as days,
	  hour(order_time) as hour,
	  sum(total_price) as total,
	  row_number () over(partition by month(order_date),day(order_date)order by sum(total_price)desc) as numb
	  from pizza
	  group by months , days , hour
	  )
	  select * from hourly
	  where numb =1;
	 
call pizza() ;
-- the best size selling
select pizza_size, sum(quantity)as quan from pizza 
group by pizza_size;

-- unit price 
select distinct unit_price from pizza 
order by unit_price desc;

-- the best size revenue
select pizza_size , round(sum(total_price), 2) as total 
from pizza p group by pizza_size 
order by total desc;
 call pizza() 
 
 -- categories type 
 select pizza_category, sum(quantity)  from pizza
 group by pizza_category ;
call pizza() ;

alter table pizza 
modify order_time time;

call pizza() ;

 -- pizza name id 

select pizza_name_id , count(pizza_name_id)as idname
from pizza 
group by pizza_name_id 
order by idname desc 

-- percentage pizzaidname 
with percent as (select pizza_name_id , count(pizza_name_id)as idname
					from pizza 
					group by pizza_name_id 
					order by idname desc
					)
			select *, idname /48620 *100  as percent
			from percent
			group by pizza_name_id;
	
call pizza()

-- revenue for every day 
select order_date , sum(total_price )
from pizza 
group by order_date ;

call pizza();

-- table for all  
select order_date,
	   hour(order_time) as htime ,
	   pizza_name,
	   pizza_category,
	   sum(quantity)as quantity ,
	   pizza_size,
	   unit_price ,
	   sum(total_price )as total
	from pizza p 
	group by order_date , htime, pizza_size ,unit_price ;

select pizza_name ,pizza_size, unit_price 
from pizza p 
group by unit_price  ;



	   
			

 























	
 		
 		

