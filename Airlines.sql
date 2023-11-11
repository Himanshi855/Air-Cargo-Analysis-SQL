Create Database Airlines;
Use Airlines;
Select * from customer;
Alter Table customer
Add constraint PK primary key(customer_id);
Select * from ticket_details;
Select * from routes;
Alter Table routes
Add constraint PK1 primary key(route_id);
Select * from Passengers;
Alter Table routes
	Add constraint flights_num CHECK(flight_num IS NOT NULL);
Alter Table routes   
	Add constraint route UNIQUE(Route_id);
Alter Table routes
	Add constraint miles CHECK(distance_miles>0);
SELECT * FROM Passengers WHERE route_id BETWEEN 1 and 25;

SELECT COUNT(customer_id) Total_customers, SUM(price_per_ticket) Revenue_Sum from ticket_details WHERE class_id='Bussiness';

SELECT CONCAT(first_name, ' ',last_name) AS full_name from Customer;

SELECT e.customer_id, e.first_name, e.last_name, t.brand
FROM Customer e, ticket_details t
WHERE e.customer_id=t.customer_id AND t.no_of_tickets=1
ORDER BY customer_id ASC;

SELECT t.customer_id, e.first_name, e.last_name, t.brand
from Customer e, ticket_details t
WHERE e.customer_id= t.customer_id AND t.brand= 'Emirates'
ORDER BY t.customer_id;

SELECT class_id, COUNT(customer_id) from passengers
GROUP BY class_id HAVING COUNT(customer_id)>=1 AND class_id='Economy Plus';

SELECT IF(SUM(Price_per_ticket)>10000,"Yes Revenue has Crossed 10000", "no Revenue has Crossed not 10000") AS Total_Revenue FROM ticket_details;

CREATE USER 'second_user'@'127.0.0.1'
Identified by 'Hello@123';
GRANT All privileges ON *.* TO 'second_user'@'127.0.0.1';

SELECT customer_id, class_id, aircraft_id, max(price_per_ticket) OVER(PARTITION BY class_id)
FROM ticket_details;

SELECT customer_id, route_id from passengers WHERE route_id=4;

SELECT * FROM passengers WHERE route_id=4;

SELECT customer_id, aircraft_id, SUM(price_per_ticket) FROM ticket_details
GROUP BY ROLLUP(customer_id, aircraft_id);

CREATE VIEW Business_class AS
SELECT * FROM ticket_details WHERE class_id= 'Bussiness';
SELECT * FROM Business_class;

DELIMITER $$
CREATE PROCEDURE route3(IN route_id1 int, IN route_id2 int)
Begin
Select RD.route_id, PF.customer_id, c.first_name, c.last_name
from routes RD
inner join passengers PF
on RD.route_id= PF.route_id
left join customer c
using(customer_id)
where RD.route_id between route_id1 and route_id2;
END$$
call route3(4,6);

DELIMITER $$
Create procedure distance()
Begin
select * from routes
where distance_miles>2000;
END$$
call distance();

DELIMITER $$
Create procedure distancegroup(IN flight_num1 int)
Begin
Select *,
case
when distance_miles>=0 and distance_miles<=2000 then "short distance"
when distance_miles>=2000 and distance_miles<=6500 then "intermediate distance"
else "Long distance"
end as Category
from routes
where flight_num= flight_num1;
End $$
call distancegroup(1111);

DELIMITER &&
Create procedure complementary_service(IN customer_id1 int)
Begin
Select p_date, customer_id, class_id,
case
when class_id= "Bussiness" or class_id= "Economy plus" then "Complimentary services"
else "No complimentary service"
end as service_distribution
from ticket_details
where customer_id= customer_id1;
End &&
call complementary_service(27);

DELIMITER $$
Create procedure firstrecord()
Begin
Declare a varchar(20);
Declare b varchar(20);
Declare c int;
Declare cursor_1 cursor for select first_name, last_name, customer_id from customer
where last_name= "scott";
open cursor_1;
fetch cursor_1 into a,b,c;
select a as first_name, b as last_name, c as customer_id;
close cursor_1;
end $$
call firstrecord();









