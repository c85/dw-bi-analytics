\echo "Checking row in DimDate Table"
select count(*) from public."DimDate" limit 5;
\echo "Checking row in DimTruck Table"
select count(*) from public."DimTruck" limit 5;
\echo "Checking row in DimStation Table"
select count(*) from public."DimStation" limit 5;
\echo "Checking row in FactTrips Table"
select count(*) from public."FactTrips" limit 5;