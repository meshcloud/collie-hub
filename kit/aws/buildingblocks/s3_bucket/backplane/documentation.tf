output "documentation_md" {
  value = <<EOF
# AWS S3 Buildingblock Backplane

Prepares an IAM user that with the following policy attached:

```json
${data.aws_iam_policy_document.s3_full_access.json}
```

This user will be created in AWS account -> `${data.aws_caller_identity.current.account_id}`.

Outputs the following credentials:

- AWS_ACCESS_KEY_ID
- AWS_SECRET_ACCESS_KEY

These credentials can be used as environment variable (encrypted!) inputs when configuring the buildingblock definition.

To obtain the credentials, run the following command:

`collie foundation deploy <foundation> --platform aws --module buildingblocks/s3_bucket/backplane -- output credentials`

EOF
}
