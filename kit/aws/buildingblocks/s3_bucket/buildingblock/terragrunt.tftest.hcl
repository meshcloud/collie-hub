run "verify" {
  variables {
    bucket_name = "s3-bucket-bb-terragrunt-test"
  }

  assert {
    condition     = aws_s3_bucket.main.bucket == "s3-bucket-bb-terragrunt-test"
    error_message = "did not produce the correct bucket name"
  }

  assert {
    condition     = aws_s3_bucket.main.tags["managed-by"] == "meshStack"
    error_message = "incorrect tag value for 'managed-by'"
  }
}
