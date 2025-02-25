output "credentials" {
  sensitive = true
  value = {
    AWS_ACCESS_KEY_ID     = aws_iam_access_key.buildingblock_s3_access_key.id
    AWS_SECRET_ACCESS_KEY = aws_iam_access_key.buildingblock_s3_access_key.secret
  }
}
