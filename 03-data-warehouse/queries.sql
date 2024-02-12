-- create external table
create or replace external table `green_taxi_rides.external_green_taxi_2022`
options (
  format = 'PARQUET',
  uris = ['gs://de_zoomcamp_green_taxi_trips_2022/green_tripdata_2022-*.parquet']
  );

-- create normal tables
create or replace table `green_taxi_rides.green_taxi_2022`
as select * from `green_taxi_rides.external_green_taxi_2022`;

-- Question 1: What is count of records for the 2022 Green Taxi Data??
select count(*) from `de-zoomcamp-2024-412300.green_taxi_rides.external_green_taxi_2022`;

-- Question 2: Count the distinct number of PULocationIDs for the entire dataset on both the tables.
select count(distinct(PULocationID)) from `de-zoomcamp-2024-412300.green_taxi_rides.external_green_taxi_2022`;
select count(distinct(PULocationID)) from `de-zoomcamp-2024-412300.green_taxi_rides.green_taxi_2022`;

-- Question 3: How many records have a fare_amount of 0?
select count(*) from `de-zoomcamp-2024-412300.green_taxi_rides.external_green_taxi_2022` where fare_amount = 0;

-- Question 4: Partitioned and clustered table
create or replace table `green_taxi_rides.green_taxi_2022_partitioned_clustered`
partition by
  date(lpep_pickup_datetime)
cluster by PUlocationID
as select * from `green_taxi_rides.external_green_taxi_2022`;

-- Question 5: Retrieve the distinct PULocationID between lpep_pickup_datetime 06/01/2022 and 06/30/2022 (inclusive)
select distinct(PULocationID)
from `de-zoomcamp-2024-412300.green_taxi_rides.green_taxi_2022`
where date(lpep_pickup_datetime) between '2022-06-01' and '2022-06-30';

select distinct(PULocationID)
from `de-zoomcamp-2024-412300.green_taxi_rides.green_taxi_2022_partitioned_clustered`
where date(lpep_pickup_datetime) between '2022-06-01' and '2022-06-30';

-- Question 8: Bytes Count
select * from `de-zoomcamp-2024-412300.green_taxi_rides.green_taxi_2022`;