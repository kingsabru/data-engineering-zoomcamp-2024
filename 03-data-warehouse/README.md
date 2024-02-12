# Module 2 Homework Solutions

## Python Script Usage
### Create Virtual Environment
```bash
conda create -n py310-green-taxi-to-gcs python=3.10 -y
```
### Activate Virtual Enviroment
```bash
conda activate py310-green-taxi-to-gcs
```
### Run script
```bash
python green_taxi_trips_to_gcs.py
```

## Homework Solutions
### Question 1. What is count of records for the 2022 Green Taxi Data??
Answer: `840,402`

### Question 2: Count the distinct number of PULocationIDs for the entire dataset on both the tables.
Answer: `0 MB for the External Table and 6.41MB for the Materialized Table`

### Question 3: How many records have a fare_amount of 0?
Answer: `1622`

### Question 4: Partitioned and clustered table
Answer: `Partition by lpep_pickup_datetime Cluster on PUlocationID`

### Question 5: Retrieve the distinct PULocationID between lpep_pickup_datetime 06/01/2022 and 06/30/2022 (inclusive)
Answer: `12.82 MB for non-partitioned table and 1.12 MB for the partitioned table`

### Question 6: Where is the data stored in the External Table you created?
Answer: `GCP Bucket`

### Question 7: It is best practice in Big Query to always cluster your data?
Answer: `True`

### Question 8: Bytes Count
Answer: `That's becuase the data is actually stored in biqgquery than from the S3 bucket`