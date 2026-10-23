# -------------------------
# S3 bucket in Account B
# -------------------------

resource "aws_s3_bucket" "app_data" {
  provider      = aws.account_b
  bucket        = var.bucket_name
  force_destroy = false

  tags = {
    Name        = var.bucket_name
    Environment = "arrise"
    Owner       = "Satya"
    ManagedBy   = "Terraform"
  }
}


resource "aws_s3_bucket_public_access_block" "app_data" {
  provider = aws.account_b
  bucket   = aws_s3_bucket.app_data.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}


resource "aws_s3_bucket_versioning" "app_data" {
  provider = aws.account_b
  bucket   = aws_s3_bucket.app_data.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "app_data" {
  provider = aws.account_b
  bucket   = aws_s3_bucket.app_data.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }

    bucket_key_enabled = false
  }
}


# -------------------------
# roleC trust policy
# Only roleB in Account A can assume roleC
# -------------------------


data "aws_iam_policy_document" "roleC_trust" {
  provider = aws.account_b

  statement {
    sid     = "TrustOnlyRoleBFromAccountA"
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


# -------------------------
# roleC: Full permissions on one bucket only
# -------------------------

data "aws_iam_policy_document" "roleC_permissions" {
  provider = aws.account_b

  statement {
    sid    = "BucketLevelAccess"
    effect = "Allow"

    actions = [
      "s3:*"
    ]

    resources = [
      aws_s3_bucket.app_data.arn
    ]
  }

  statement {
    sid    = "ObjectLevelAccess"
    effect = "Allow"

    actions = [
      "s3:*"
    ]

    resources = [
      "${aws_s3_bucket.app_data.arn}/*"
    ]
  }
}


resource "aws_iam_role_policy" "roleC_policy" {
  provider = aws.account_b
  name     = "single-bucket-full-access"
  role     = aws_iam_role.roleC.id
  policy   = data.aws_iam_policy_document.roleC_permissions.json
}




