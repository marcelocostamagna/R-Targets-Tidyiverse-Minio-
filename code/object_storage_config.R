s3_endpoint <- "http://minio:9000"
s3_bucket  <-  "targets-versioned"
s3_prefix  <-  "tarpref"

s3_service <- paws::s3(
  config =
    list(endpoint = s3_endpoint,
         credentials = list(
           creds = list(
             access_key_id = Sys.getenv("AWS_ACCESS_KEY_ID"),
             secret_access_key = Sys.getenv("AWS_SECRET_ACCESS_KEY")
           ))))

cat(s3_service$get_bucket_versioning(s3_bucket)$Status)
if (try(s3_service$get_bucket_versioning(s3_bucket)$Status) == "Enabled") {
  tar_option_set(resources = tar_resources(
    aws = tar_resources_aws(
      endpoint = s3_endpoint,
      bucket = s3_bucket,
      prefix = s3_prefix
    )),
    repository = "aws")
}
