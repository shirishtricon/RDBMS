-- Entity Diagram link: https://lucid.app/lucidchart/6ad9ba24-98a4-47a4-9038-1317580d6c4b/edit?viewport_loc=-11%2C-35%2C1480%2C649%2C0_0&invitationId=inv_1773f371-ccbb-40ac-8da0-aae356b282f6 --

-- 1) Prepare script to create table1 and table2 with primary key --
create table flights(
  flight_no int(3) not null,
  flight_name varchar(50) not null unique,
  origin_ariport varchar(50) not null,
  destinatin_airport varchar(50) not null,
  primary key(flight_no)
);

create table Passengers(
  passenger_id int(2) not null,
  passenger_name varchar(25) not null,
  passenger_age varchar(10) not null,
  flight_id varchar(10) not null,
  passenger_from_city varchar(25) not null,
  passsenger_to_city varchar(25) not null,
  primary key(passenger_id),
  foreign key(flight_id) references Flights(flight_no)
);


--4) script to add index to any column --
CREATE UNIQUE INDEX flight_index
ON flights (flight_name);


-- 5) Create insert queries to add around 4 to 8 rows in both the tables--
insert into flights values
(001, 'Air India', 'Mumbai', 'Bengaluru'),
(002, 'Indigo', 'Bengaluru', 'Delhi'),
(003, 'Spice Jet', 'Mumbai', 'Indore'),
(004, 'AirAsia India', 'Chennai', 'Varanasi'),
(005, 'Vistara', 'Ahmedabad', 'Indore');
-- output:
flight_no	 flight_name	   origin_ariport	 destinatin_airport
1	         Air India	     Mumbai	          Bengaluru
2	         Indigo	         Bengaluru	      Delhi
3	         Spice Jet	     Mumbai	          Indore
4	         AirAsia India   Chennai 	        Varanasi 

insert into Passengers values
(11, 'Virat Kohli', 25, 1, 'Mumbai', 'Bengaluru'),
(12, 'Rohit Sharma', 35, 3, 'Mumbai', 'Indore'),
(13, 'Shikhar Dhawan', 32, 5, 'Ahmedabad', 'Indore'),
(14, 'Hardik Pandya', 29, 2, 'Bengaluru ', 'Varanasi'), 
(15, 'Narendra', 62, 4, 'Ahmedabad', 'Indore');
--output: 
passenger_id	  passenger_name	  passenger_age	  flight_id	  passenger_from_city	  passsenger_to_city
11	            Virat Kohli	        25	            1	          Mumbai	              Bengaluru
12	            Rohit Sharma	      35	            3	          Mumbai	              Indore
13	            Shikhar Dhawan	    32	            5	          Ahmedabad	            Indore
14	            Hardik Pandya	      29	            2	          Bengaluru	            Varanasi
15	            Narendra	          62	            4	          Ahmedabad             Indore


--6) selects the passenger name ending with 'a' and passengers age less than 60 (using Where, not in, like and order by clause)--
select distinct passenger_name, passenger_age
from passengers, flights
where passenger_name like '%a' and passenger_id not in (select passenger_id from passengers where passenger_age > 60)
order by passenger_age ASC;
--output:
passenger_name	passenger_age
Hardik Pandya	    29
Rohit Sharma	    35


-- 7) retrieves the fligts and total number of fights that departs from 'Mumbai' (using GROUP BY and HAVING clause, with COUNT) --
select flight_no, count(flight_no)
from flights
Group by flight_name
having origin_airport = 'Mumbai';
-- output: 
flight_no	  count(flight_no)
1	            1
3	            1


-- 8) INNER JOIN query between tables --
select passenger_name, flight_no, passenger_from_city, passenger_to_city from flights
inner join passengers
on flights.flight_no = passengers.flight_id;
-- output: 
passenger_name	flight_no	  passenger_from_city	  passsenger_to_city
Virat Kohli	       1	            Mumbai	            Bengaluru
Rohit Sharma	     3	            Mumbai	            Indore
Shikhar Dhawan	   5	            Ahmedabad	          Indore
Hardik Pandya	     2	            Bengaluru	          Varanasi
Narendra	         4	            Ahmedabad	          Indore


-- 9) LEFT JOIN query between two tables --
SELECT passenger_name, flight_name
FROM passengers
LEFT JOIN flights
ON passengers.flight_id = flights.flight_no;
--output: 
passenger_name	  flight_name
Virat Kohli	      Air India
Rohit Sharma	    Spice Jet
Shikhar Dhawan	  Vistara
Hardik Pandya	    Indigo

