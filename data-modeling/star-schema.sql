-- Use this script to build out the wasteDW star schema
BEGIN;

DROP TABLE IF EXISTS public."MyFactTrips" cascade;
DROP TABLE IF EXISTS public."MyDimDate" cascade;
DROP TABLE IF EXISTS public."MyDimWaste" cascade;
DROP TABLE IF EXISTS public."MyDimZone" cascade;
DROP TABLE IF EXISTS public."DimDate" cascade;
DROP TABLE IF EXISTS public."DimStation" cascade;
DROP TABLE IF EXISTS public."DimTruck" cascade;
DROP TABLE IF EXISTS public."FactTrips" cascade;

CREATE TABLE IF NOT EXISTS public."DimTruck"
(
    truckid integer NOT NULL,
    trucktype varchar(10) NOT NULL,
    PRIMARY KEY (truckid)
);

CREATE TABLE IF NOT EXISTS public."MyDimDate"
(
    dateid integer NOT NULL,
    date date not null,
    year integer NOT NULL,
    month integer NOT NULL,
    monthname varchar(10) NOT NULL,
    quarter integer NOT NULL,
    quartername varchar(2) NOT NULL,
    day integer NOT NULL,
    weekday integer NOT NULL,
    weekdayname varchar(10),
    PRIMARY KEY (dateid)
);

CREATE TABLE IF NOT EXISTS public."MyDimWaste"
(
    tripid integer NOT NULL,
    wastetype varchar(20) NOT NULL,
    PRIMARY KEY (tripid)
);

CREATE TABLE IF NOT EXISTS public."MyDimZone"
(
    stationid integer NOT NULL,
    city varchar(50) NOT NULL,
    PRIMARY KEY (stationid)
);

CREATE TABLE IF NOT EXISTS public."MyFactTrips"
(
    tripid integer NOT NULL,
    dateid integer NOT NULL,
    stationid integer NOT NULL,
    truckid integer NOT NULL,
    wastecollected float NOT NULL,
    PRIMARY KEY (tripid)
);

-- Modified tables to load CSV files in Exercise 3
ALTER TABLE public."MyDimDate"
    RENAME TO "DimDate";

ALTER TABLE public."MyDimZone"
    RENAME TO "DimStation";

ALTER TABLE public."MyFactTrips"
    RENAME TO "FactTrips";

ALTER TABLE public."FactTrips"
    ADD FOREIGN KEY (truckid)
    REFERENCES public."DimTruck" (truckid)
    NOT VALID;

END;