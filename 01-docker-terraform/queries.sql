-- Question 3. Count Records
select count(*)
from green_taxi_trips
where date(lpep_dropoff_datetime) = date('2019-09-18')
    and date(lpep_pickup_datetime) = date('2019-09-18');

-- Question 4. Largest trip for each day
with trips_count as (
    select date(lpep_pickup_datetime) as pickup_date, sum(trip_distance) as total_distance
    from green_taxi_trips
    group by 1
    order by 2 desc
)
select pickup_date
from trips_count
where total_distance = (select max(total_distance) from trips_count);

-- Question 5. Three biggest pick up Boroughs
select tzl."Borough", sum(gtt.total_amount)
from green_taxi_trips gtt
left join taxi_zone_lookup tzl on tzl."LocationID" = gtt."PULocationID"
where tzl."Borough" <> 'Unknown'
    and date(gtt.lpep_pickup_datetime) = date('2019-09-18')
group by 1
order by 2 desc;

-- Question 6. Largest tip
with customer_pickup_astoria as (
    select gtt.*
    from green_taxi_trips gtt
    left join taxi_zone_lookup tzl on tzl."LocationID" = gtt."PULocationID"
    where extract('Year' from gtt.lpep_dropoff_datetime) = 2019
        and extract('Month' from gtt.lpep_dropoff_datetime) = 9
        and tzl."Zone" = 'Astoria'
)
select tzl."Zone", max(gtt.tip_amount)
from customer_pickup_astoria gtt
left join taxi_zone_lookup tzl on tzl."LocationID" = gtt."DOLocationID"
group by 1
order by 2 desc;