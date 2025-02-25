data "aws_caller_identity" "current" {}

resource "aws_iam_user" "buildingblock_s3_user" {
  name = "buildingblock-s3-user"
}

data "aws_iam_policy_document" "s3_full_access" {
  statement {
    actions = [
      "s3:*",
    ]

    resources = [
      "arn:aws:s3:::*",
    ]
  }
}

resource "aws_iam_policy" "buildingblock_s3_policy" {
  name        = "buildingblock-s3-policy"
  description = "Policy for the ${aws_iam_user.buildingblock_s3_user.name} user"
  policy      = data.aws_iam_policy_document.s3_full_access.json
}

resource "aws_iam_user_policy_attachment" "buildingblock_s3_user_policy_attachment" {
  user       = aws_iam_user.buildingblock_s3_user.name
  policy_arn = aws_iam_policy.buildingblock_s3_policy.arn
}

resource "aws_iam_access_key" "buildingblock_s3_access_key" {
  user = aws_iam_user.buildingblock_s3_user.name
}
