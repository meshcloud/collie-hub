resource "aws_iam_user" "user" {
  name = var.iam_user_name
}

resource "aws_iam_policy" "policy" {
  name        = var.iam_user_name
  description = "Permissions required to deploy the cloudfoundation (not operate it)"
  policy      = file(".//cfn-tf-deploy.policy.json")
}

resource "aws_iam_user_policy_attachment" "user-policy-attach" {
  user       = aws_iam_user.user.name
  policy_arn = aws_iam_policy.policy.arn
}

// todo: this needs better handling with rotation
resource "aws_iam_access_key" "key" {
  user = aws_iam_user.user.name
}