resource "aws_organizations_policy" "deny_outside_eu" {
  name = "deny_outside_eu"

  content = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "DenyAllOutsideEU",
            "Effect": "Deny",
            "NotAction": ${jsonencode(formatlist("%s:*", var.whitelisted_global_services))},
            "Resource": "*",
            "Condition": {
                "StringNotEquals": {
                    "aws:RequestedRegion": ${jsonencode(var.whitelisted_regions)}
                }
            }
        }
    ]
}
EOF
}

