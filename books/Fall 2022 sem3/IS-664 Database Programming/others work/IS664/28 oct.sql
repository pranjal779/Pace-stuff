

-- Create Namespace 
DROP DATABASE IF EXISTS BHIRUDHW4;
CREATE DATABASE BHIRUDHW2;
USE BHIRUDHW2;

Create table if not exists flightdb(
year int,
month int,
DayofMonth int,
DayOfWeek int,
DepTime int,
CRSDepTime datetime,
ArrTime  datetime,
CRSArrTime datetime,
UniqueCarrier varchar(20),
FlightNum varchar(20),
TailNum varchar(20),
ActualElapsedTime int,
CRSElapsedTime int,
AirTime int,
ArrDelay int,
DepDelay int,
Origin 
Dest
Distance
TaxiIn
TaxiOut
Cancelled
CancellationCode
Diverted
CarrierDelay
WeatherDelay
NASDelay
SecurityDelay
LateAircraftDelay


create table if not exists airports(
 iata varchar(5) primary key ,
 airport varchar(20),
 city varchar(20),
 state varchar(20),
 country varchar(20),
 lat decimal(10,2),
 long decimal(10,2)
 );
