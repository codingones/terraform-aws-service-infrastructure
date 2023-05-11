resource "aws_iam_user" "service_deployer" {
  name = "${var.aws_organizational_unit}.${var.service}.infrastructure"
}

resource "aws_iam_group" "service_deployer_group" {
  name = "${var.service}.deployer"
}

resource "aws_iam_user_group_membership" "service_deployer_membership" {
  user = aws_iam_user.service_deployer.name

  groups = [
    aws_iam_group.service_deployer_group.name,
  ]
}

resource "aws_iam_access_key" "service_deployer_access_key" {
  user = aws_iam_user.service_deployer.name
}

resource "aws_iam_group_policy_attachment" "service_policy_attachment" {
  policy_arn = aws_iam_policy.service_policy.arn
  group      = aws_iam_group.service_deployer_group.name
}

resource "aws_iam_policy" "service_policy" {
  name        = "${var.service}.policy"
  description = "Policy that grants access to the needed AWS services"

  policy = var.service_policy
}