
# Account B: Trust policy allowing roleB from Account A
data "aws_iam_policy_document" "roleC_trust" {
  provider = aws.account_b

  statement {
    sid     = "AllowRoleBFromAccountA"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${var.account_a_id}:role/roleB"
      ]
    }
  }
}

resource "aws_iam_role" "roleC" {
  provider           = aws.account_b
  name               = "roleC"
  assume_role_policy = data.aws_iam_policy_document.roleC_trust.json
}

# Account B: Restrict roleC to one S3 bucket
data "aws_iam_policy_document" "roleC_s3_permissions" {
  provider = aws.account_b

  statement {
    sid     = "ListSpecificBucket"
    effect  = "Allow"
    actions = ["s3:ListBucket"]
    resources = [
      "arn:aws:s3:::${var.account_b_bucket_name}"
    ]
  }

  statement {
    sid    = "AccessObjectsInSpecificBucket"
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject"
    ]
    resources = [
      "arn:aws:s3:::${var.account_b_bucket_name}/*"
    ]
  }
}

resource "aws_iam_role_policy" "roleC_s3" {
  provider = aws.account_b
  name     = "roleC-s3-access"
  role     = aws_iam_role.roleC.id
  policy   = data.aws_iam_policy_document.roleC_s3_permissions.json
}

