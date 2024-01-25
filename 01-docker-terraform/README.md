# Module 1 Homework Solutions

## Ingesting Dataset into Postgres
1. Start Postgres Docker container:
```bash
docker run -d \
  --name postgres-de-zoomcamp \
  -e POSTGRES_USER="admin" \
  -e POSTGRES_PASSWORD="admin" \
  -e POSTGRES_DB="ny_taxi" \
  -v $(pwd)/ny_taxi_postgres_data:/var/lib/postgresql/data \
  -p 5433:5432 \
  postgres:13
```
2. (Optional) Conect to Postgres database using psql:
```bash
psql -h localhost -d ny_taxi -U admin -W -p 5433
```
3. Create Conda virtual environment and install Python packages:
```bash
conda create -n py310-de-zoomcamp-yellowtrip python=3.10
conda activate py310-de-zoomcamp-yellowtrip
pip install -r requirements.txt
```
4. Ingest datasets into Postgres database:
```bash
GREEN_TRIPDATA_URL="https://github.com/DataTalksClub/nyc-tlc-data/releases/download/green/green_tripdata_2019-09.csv.gz"
TAXI_LOOKUP_URL="https://s3.amazonaws.com/nyc-tlc/misc/taxi+_zone_lookup.csv"

python ingest_green_tripdata.py \
  --user=admin \
  --password=admin \
  --host=localhost \
  --port=5433 \
  --db=ny_taxi \
  --table_name=green_taxi_trips \
  --url=${GREEN_TRIPDATA_URL}

python ingest_taxi_zone_lookup.py \
  --user=admin \
  --password=admin \
  --host=localhost \
  --port=5433 \
  --db=ny_taxi \
  --table_name=taxi_zone_lookup \
  --url=${TAXI_LOOKUP_URL}
```

## Homework Solutions
### Question 1. Knowing docker tags
Answer: `-- rm`

### Question 2. Understanding docker first run
Answer: `0.42.0`

Run docker with the python:3.9 image in an interactive mode and the entrypoint of bash:
```
docker run -it --rm python:3.9 bash
```

> #### **SQL HELP**
> - Reference [Ingesting Dataset into Postgres](#ingesting-dataset-into-postgres) to prepare Posgtres database.
> - Reference the SQL queries in the [queries.sql](./queries.sql) file.
>

### Question 3. Count records
Answer: `15612`

### Question 4. Largest trip for each day
Answer: `2019-09-26`

### Question 5. Three biggest pick up Boroughs
Answer: `"Brooklyn" "Manhattan" "Queens"`

### Question 6. Largest tip
Answer: `JFK Airport`

### Question 7. Terraform
Output:
```bash
$ terraform apply --auto-approve

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # google_bigquery_dataset.dataset will be created
  + resource "google_bigquery_dataset" "dataset" {
      + creation_time              = (known after apply)
      + dataset_id                 = "de_zoomcamp_green_tripdata"
      + delete_contents_on_destroy = false
      + etag                       = (known after apply)
      + id                         = (known after apply)
      + labels                     = (known after apply)
      + last_modified_time         = (known after apply)
      + location                   = "US"
      + project                    = "de-zoomcamp-2024-412300"
      + self_link                  = (known after apply)
    }

  # google_storage_bucket.data-lake-bucket will be created
  + resource "google_storage_bucket" "data-lake-bucket" {
      + force_destroy               = true
      + id                          = (known after apply)
      + location                    = "US"
      + name                        = "de_zoomcamp_green_tripdata"
      + project                     = (known after apply)
      + public_access_prevention    = (known after apply)
      + self_link                   = (known after apply)
      + storage_class               = "STANDARD"
      + uniform_bucket_level_access = true
      + url                         = (known after apply)

      + lifecycle_rule {
          + action {
              + type = "Delete"
            }
          + condition {
              + age                   = 30
              + matches_prefix        = []
              + matches_storage_class = []
              + matches_suffix        = []
              + with_state            = (known after apply)
            }
        }

      + versioning {
          + enabled = true
        }
    }

Plan: 2 to add, 0 to change, 0 to destroy.
google_bigquery_dataset.dataset: Creating...
google_storage_bucket.data-lake-bucket: Creating...
google_bigquery_dataset.dataset: Creation complete after 2s [id=projects/de-zoomcamp-2024-412300/datasets/de_zoomcamp_green_tripdata]
google_storage_bucket.data-lake-bucket: Creation complete after 3s [id=de_zoomcamp_green_tripdata]

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.
```

## Clean Up Setup
### 1. Stop & Remove Container
```bash
docker stop postgres-de-zoomcamp
docker rm postgres-de-zoomcamp
```
### 2. Delete Container Volume
```bash
rm -rf ny_taxi_postgres_data
```
### 3. Delete Conda virtual environment
```bash
conda env remove -n py310-de-zoomcamp-yellowtrip
```