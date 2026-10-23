
resource "aws_iam_user_policy" "ci_pipeline" {
  provider = aws.account_a
  name     = "ci-pipeline-least-privilege"
  user     = aws_iam_user.ci.name

  policy = file("${path.module}/ci-user-pipeline-policy.json")
}

