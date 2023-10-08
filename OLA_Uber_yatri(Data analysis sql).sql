-- project name :- OLA_Uber_yatri data analysis


create table assemble(
	ID int primary key,	
	Assembly varchar
)

create table duration(
	id int not null,
	duration varchar
)


create table payment(
	id int,
	method varchar
)


create table trip(
	tripid int,
	faremethod int,
	fare bigint,
	loc_from int,
	loc_to int,
	driverid int,
	custid int,
	distance int,
	duration int
)


create table trip_details(
	tripid int,
	loc_from int,
	searches int,
	searches_got_estimate int,
	searches_for_quotes int,
	searches_got_quotes int,
	customer_not_cancelled int,
	driver_not_cancelled int,
	otp_entered	int,
	end_ride int
)



-- Import all the data from exel file to tables



select * from assembly
select * from duration
select * from payment
select * from trip
select * from trip_details



-- In this way or data tables are ready


Q1). Total number of trips

select count(distinct tripid) from trip



Q2).Total number of drivers

select count(distinct driverid) from trip



Q3).Total number of driver earning

select sum(fare) from trip



Q4).Total complete trips

select count(distinct tripid) from trip



Q5).Total number of search took place

select sum(searches) from trip_details



Q6).Total searches got estimate

select sum(searches_got_estimate) from trip_details



Q7).Total search of quotes

select sum(searches_for_quotes) from trip_details



Q8).Total trip by driver cancel

select count(*) - sum(driver_not_cancelled) from trip_details



Q9).Total OTP enter

select sum(otp_entered) from trip_details



Q10).Total end ride

select sum(end_ride) from trip_details



Q11).Average distance per trip

select avg(distance) from trip



Q12).Average fare per trip

select avg(fare) from trip



Q13).Total number of distance get traveled

select sum(distance) from trip



Q14).Which the most used payment method

select method from
(select p.method, count(t.faremethod) as "Total_count"
from trip t
join payment p
on t.faremethod = p.id
group by p.method
order by "Total_count" desc
limit 1) a



Q15).Highest payment is done by which method

select method from
(select p.method as "method", max(t.fare) as "highest_fare"
from trip t
join payment p
on t.faremethod = p.id
group by p.method
order by "highest_fare" desc
limit 1
) a



Q16).Which 2 locations has people visited most

select Assembly from
(select a.Assembly, count(t.loc_to) as "Total_trips"
from trip t
join assembly a
on a.ID = t.loc_to
group by a.Assembly
order by "Total_trips" desc
limit 2) b



Q17).Which two location has the most trip

select Assembly from assembly a inner join
(select loc_to, count(loc_to) as "Total_trips"
from trip
group by loc_to
order by "Total_trips" desc
limit 2) b
on a.ID = b.loc_to



Q18).Top 5 earning drivers

select driverid, sum(fare) as "Total_trip"
from trip
group by driverid
order by "Total_trip" desc
limit 5



Q19).Which duration has more trip

select duration from
(select d.duration, count(t.duration) as "Highest_duration"
from trip t
join duration d
on d.id = t.duration
group by d.duration
order by "Highest_duration" desc
limit 1)
a



Q20).Which driver, customer pair had more orders

select driverid, custid from 
(select driverid, custid, count(tripid) as "max_count"
from trip
group by driverid, custid
order by "max_count" desc
limit 2) a



Q21).Search to estimate rate

select (sum(searches_got_estimate)*100.00/sum(searches)) as "total percentage" from trip_details



Q22).Estimate to search for quote rate

select (sum(searches_got_quotes)*100.00/sum(searches)) as "total percentage" from trip_details



Q23).Which area got highest trips in which of  duration

select a.assembly,t.duration, count(distinct t.tripid) as "total"
from trip t
join assembly a
on t.loc_from = a.id
group by a.assembly, t.duration
order by "total" desc



Q24)Which duration got highest number of trips in each of the location

select duration, count(distinct tripid) as "highest_count"
from trip
group by duration
order by "highest_count" desc
limit 1







































