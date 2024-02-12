import pandas as pd
from google.cloud import storage
from io import BytesIO

def upload_to_gcs(df, gcs_file_path, bucket_name, credentials)-> None:
  storage_client = storage.Client.from_service_account_json(credentials)

  bucket = storage_client.bucket(bucket_name)
  blob = bucket.blob(gcs_file_path)

  buffer = BytesIO()

  df.to_parquet(buffer, index=False)

  print(f"Uploading {gcs_file_path} to {bucket_name}.")

  blob.upload_from_string(buffer.getvalue(), content_type='application/octet-stream')

  print(f"Upload {gcs_file_path} to {bucket_name} complete.")

def main() -> None:
  url = "https://d37ci6vzurychx.cloudfront.net/trip-data/green_tripdata_2022-{month}.parquet"

  bucket_name = "de_zoomcamp_green_taxi_trips_2022"

  # TODO: Update to read from env file.
  gcp_service_account = "../de-zoomcamp-2024-mbp-gcp-service-account.json"

  for month in range(1, 13):
    if month < 10:
      month = f"0{month}"

    file_name = f"green_tripdata_2022-{month}.parquet"

    print(f"Downloading {file_name}")


    df = pd.read_parquet(url.format(month=month), engine='pyarrow')

    upload_to_gcs(df, file_name, bucket_name, gcp_service_account)

if __name__ == '__main__':
  main()