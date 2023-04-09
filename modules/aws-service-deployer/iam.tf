resource "aws_iam_user" "service_deployer" {
  name = "${var.aws_organization}.${var.service}.infrastructure"
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
  policy_arn = var.service_deployer_group_policy_arn
  group      = aws_iam_group.service_deployer_group.name
}
