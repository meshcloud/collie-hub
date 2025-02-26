run "verify" {
  assert {
    condition     = aws_s3_bucket.main.bucket == var.bucket_name
    error_message = "did not produce the correct bucket name"
  }

  assert {
    condition     = aws_s3_bucket.main.tags["managed-by"] == "meshStack"
    error_message = "incorrect tag value for 'managed-by'"
  }
}
