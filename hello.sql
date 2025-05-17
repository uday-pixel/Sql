select database();
use sakila;
select database();
show databases;
show tables;
select * from actor;
select  last_update,last_name from actor;

describe actor;
select * from actor where actor_id='5';
select * from actor where first_name='ED';
select * from actor where first_name='ED'and actor_id>100;
select * from actor where actor_id>10 and actor_id<25;
-- between operator
select * from actor where actor_id between 11 and 25;
select first_name from actor where actor_id=5; 
-- in operator(2,4)
select * from actor where actor_id in(2,5);

select * from actor where actor_id =2 or actor_id=5;

-- seleect statement
-- sql case-sensetive
-- sql multi-line query'
-- and or operator
-- between and in op
-- like op -> pattern pa kam karta hai
select * from actor where first_name='NICK';

-- like %[zero or more character]      _[only one chaarcter]
select * from actor where first_name like 'N%'; -- phela n % matlab starting char
select * from actor where first_name like '%t'; -- phela % last mai char means last character se data
select * from actor where first_name like 'S%T';-- aise data jiska first char s and last char t hai



-- 15-05-24

-- DISTINIT,COUNT
select distinct(FIRST_NAME) FROM ACTOR;
select COUNT(FIRST_NAME) FROM ACTOR;

-- FUNCTION
-- CODE REUSABLE
-- STRING FUNCTIONS
--  SCLALER FUNCTIONS  -- MULTI ROW FUNCTIONS
-- 1) ROW=> APPLY RESULT FOR EACH

SELECT FIRST_NAME ,LOWER(FIRST_NAME),UPPER(FIRST_NAME),LENGTH(FIRST_NAME)FROM ACTOR;

-- SUBSTR(COLUMN_NAME,INDEX,TOTAL_CHARACTER)
SELECT FIRST_NAME,substr(FIRST_NAME,2)FROM ACTOR;
SELECT FIRST_NAME,SUBSTR(FIRST_NAME,2,3)FROM ACTOR;
-- YOU CAN ACCESS DATA IN REVERSE USING SUBSTR()
SELECT FIRST_NAME,SUBSTR(FIRST_NAME,-3)FROM ACTOR;

SELECT FIRST_NAME,instr(FIRST_NAME,'E')FROM ACTOR; -- INDES DETA HAI 'E'CHAR KA SABSE PHELA JO MILEGA USKO
SELECT FIRST_NAME,LAST_NAME,concat(FIRST_NAME,'-',LAST_NAME,'$')FROM ACTOR;
SELECT FIRST_NAME,LAST_NAME,concat_ws('-',FIRST_NAME,LAST_NAME,'$')FROM ACTOR;

-- TRIM=>WHITE,CHARACTER

SELECT FIRST_NAME,'     HEY     ' FROM ACTOR;
SELECT FIRST_NAME,trim('     HEY     ' )FROM ACTOR; -- STARTING AUR ENDING KA SPACE KO REMOVE KAREGA BICH KA SPACE KO REMEOVE NHI KREGA

-- LOWER(),UPPER(),CONCAT()CONCAT_WS(),LENGTH().SUBSTR(),TRIM(),INSRT()---- THESRE ARE STRING FUNCTIONS
-- LPAD AND RPAD -- THESE ARE STRING FUNCTIONS

SELECT FIRST_NAME,RPAD(FIRST_NAME,6,'$') FROM ACTOR; -- RPAD RIGHT MAI EXTRA AD KAREGA

-- 16-5-25

-- dual sirf 1 row and 1 column in a table
 
 select 9*1233 from dual;
 
 -- now()
 select sysdate(),curdate(),curtime(),current_timestamp(),now() from dual;
 select now(),adddate(now(),2)from dual;
 select now(),adddate(now(),interval 2 month)from dual; -- month add karega
  select now(),adddate(now(),interval 2 week)from dual; -- week add karega
  
select datediff('2025-05-16 17:21:36','2025-05-30 17:21:36') from dual; -- difference calcualtae karta hai
select last_day(now()) from dual; -- month ka last day batata hai
select month(now()),year(now()) from dual; -- output 5	2025

select extract(year from now()) from dual; -- year batayga
select extract(month from now()) from dual; -- month
select extract(day from now()) from dual; -- day
select extract(week from now()) from dual; -- week
select extract(minute from now()) from dual; -- minute

-- access modifier =>%y,%m,%w -> y se year nikal dega ,m se month nikal dega 

select now(),date_format(now(),'thus year is %Y') from dual;

 -- scalar function --> jo single line mai work karta hai like sting function,date&timefunction and No functions (turncate and round function)
-- round aur turncate ,power(),floor(),ceil(),mod()  (((NO FUNCTIONS)))

select 24.325,round(24.625) from dual; -- round of 25
select 24.325,round(24.625,1) from dual;
select round(354.2,-2) from dual;

-- truncate() - without roundoff value ko extract karna hai toh turncate use karega
select round(367.37,1),truncate(364.37,1) from dual;

-- mod() -- reminder
select mod(11,2) from dual;

-- floor() lower value dega
select floor(10.999) from dual;

-- ceil() upper value dega
select ceil(10.999) from dual;


-- 
use sakila;
select * from actor;

-- if else (case)
select * from actor;
select actor_id,first_name,
case
	when mod(actor_id,2)=0 then "yes"
    when actor_id=5 then "####yes###"
    else "no"
end
from actor;




-- order by ,alias,multi-row function

-- 17-05-25

use sakila;
select * from actor order by first_name; -- data ko assending order mai arrange (order by)
select * from actor order by first_name,actor_id desc; -- descending mai karega (order by)
-- allias - just given name to your new column
select actor_id,actor_id+10 as "newactor" from actor;-- alias => as(keyword se denote karte hai)

-- multi row functions

select * from payment;

select distinct(customer_id)from payment; -- distinct function sirf unique value dega dublicate value hata kar
select count(customer_id)from payment; -- value count dega particular column ke\

select count(customer_id) as totalcustomer,
count(distinct(customer_id)) as uniquecustomer,
count(customer_id)-count(distinct(customer_id)) as repetativeCustomer
from payment; -- count - distinct(unique)= unique customer aya aur repetative kitna aya

select count(amount),sum(amount) ,avg(amount),min(amount),max(amount) from payment;
 -- sum ,avg,min,max     ((skip null value but count takes null value))
 --  aggregarte function - are the the function which is use to perform calculation over certain values and return a single value 
 -- kisi aggregate function ke sath normally kisi column kon select nahi kar sakta sirf pura column select hoga 
 
 -- group by
 -- similar values ka group
 -- in case if use group by on a column wahi column ab aap select se sath use kar sakta ho mhi toh 
 -- group by nhi use karsakte ho
 
 select sum(amount) from payment where customer_id=1;
  select sum(amount) from payment where customer_id=2;
   select sum(amount) from payment where customer_id=3;
   
   select * from payment;
   
   select customer_id,count(amount),sum(amount)
   from payment group by customer_id; -- group by example
   
   select amount,count(amount)
   from payment group by amount order by amount;
   
   select staff_id,count(rental_id),max(rental_id) ,sum(amount) from
   payment group by staff_id order by staff_id;
   
   select month(payment_date), count(customer_id),max(rental_id),min(rental_id),avg(amount)
   from payment group by (month(payment_date)) order by (month(payment_date));
   