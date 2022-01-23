--Write aggregation queries and create MQTs

--Grouping Sets Query
select 
    a.stationid,
    b.trucktype,
    SUM(a.wastecollected) as totalwastecollected
from public."FactTrips" as a
left join public."DimTruck" as b
on a.truckid = b.truckid
left join public."DimStation" as c
on a.stationid = c.stationid
group by grouping sets(a.stationid, b.trucktype, a.wastecollected)
order by b.trucktype, SUM(a.wastecollected) desc;

--Rollup Query
select 
	b.year,
	c.city,
	a.stationid,
	SUM(a.wastecollected) as totalwastecollected
from public."FactTrips" as a
left join public."DimDate" as b
on a.dateid = b.dateid
left join public."DimStation" as c
on a.stationid = c.stationid
group by rollup(b.year, c.city, a.stationid, a.wastecollected)
order by b.year, SUM(a.wastecollected) desc;

--Cube Query
select 
	b.year,
	c.city,
	a.stationid,
	AVG(a.wastecollected) as avgwastecollected
from public."FactTrips" as a
left join public."DimDate" as b
on a.dateid = b.dateid
left join public."DimStation" as c
on a.stationid = c.stationid
group by cube(b.year, c.city, a.stationid, a.wastecollected)
order by b.year, AVG(a.wastecollected) desc;

--Materialized Query Table (MQT)
CREATE TABLE IF NOT EXISTS maxwastestats (city, stationid, trucktype, maxwastecollected) AS
(select 
	d.city,
	a.stationid,
 	c.trucktype,
	AVG(a.wastecollected) as totalwastecollected
from public."FactTrips" as a
left join public."DimDate" as b
on a.dateid = b.dateid
left join public."DimTruck" as c
on a.truckid = c.truckid
left join public."DimStation" as d
on a.stationid = d.stationid
group by d.city, a.stationid, c.trucktype);