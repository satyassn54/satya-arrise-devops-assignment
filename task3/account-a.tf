
# ============================================================
# Account A - IAM Users
# ============================================================

# Group1: CLI / Programmatic access
resource "aws_iam_user" "engine" {
  provider = aws.account_a
  name     = "engine"
}

resource "aws_iam_user" "ci" {
  provider = aws.account_a
  name     = "ci"
}

# Group2: Console + CLI access
resource "aws_iam_user" "user1" {
  provider = aws.account_a
  name     = var.account_a_user1
}

resource "aws_iam_user" "user2" {
  provider = aws.account_a
  name     = var.account_a_user2
}


# ============================================================
# Account A - IAM Groups
# ============================================================

resource "aws_iam_group" "group1" {
  provider = aws.account_a
  name     = "group1"
}

resource "aws_iam_group" "group2" {
  provider = aws.account_a
  name     = "group2"
}


# ============================================================
# Account A - Group Memberships
# ============================================================

resource "aws_iam_group_membership" "group1_members" {
  provider = aws.account_a
  name     = "group1-membership"
  users = [
    aws_iam_user.engine.name,
    aws_iam_user.ci.name
  ]
  group = aws_iam_group.group1.name
}

resource "aws_iam_group_membership" "group2_members" {
  provider = aws.account_a
  name     = "group2-membership"
  users = [
    aws_iam_user.user1.name,
    aws_iam_user.user2.name
  ]
  group = aws_iam_group.group2.name
}


# ============================================================
# Account A - Programmatic Access Keys
# ============================================================

resource "aws_iam_access_key" "engine" {
  provider = aws.account_a
  user     = aws_iam_user.engine.name
}

resource "aws_iam_access_key" "ci" {
  provider = aws.account_a
  user     = aws_iam_user.ci.name
}

resource "aws_iam_access_key" "user1" {
  provider = aws.account_a
  user     = aws_iam_user.user1.name
}

resource "aws_iam_access_key" "user2" {
  provider = aws.account_a
  user     = aws_iam_user.user2.name
}


# ============================================================
# Account A - Console Login Profiles for Group2
# ============================================================

resource "aws_iam_user_login_profile" "user1" {
  provider                = aws.account_a
  user                    = aws_iam_user.user1.name
  pgp_key                 = var.console_pgp_key
  password_reset_required = true
}

resource "aws_iam_user_login_profile" "user2" {
  provider                = aws.account_a
  user                    = aws_iam_user.user2.name
  pgp_key                 = var.console_pgp_key
  password_reset_required = true
}


# ============================================================
# roleA - All AWS services except IAM
# ============================================================

data "aws_iam_policy_document" "roleA_trust" {
  provider = aws.account_a

  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.account_a_id}:root"]
    }
  }
}

resource "aws_iam_role" "roleA" {
  provider           = aws.account_a
  name               = "roleA"
  assume_role_policy = data.aws_iam_policy_document.roleA_trust.json
}

data "aws_iam_policy_document" "roleA_permissions" {
  provider = aws.account_a

  # Allow all actions except IAM actions.
  statement {
    sid         = "AllowAllExceptIAM"
    effect      = "Allow"
    not_actions = ["iam:*"]
    resources   = ["*"]
  }

  # Explicitly deny IAM actions.
  statement {
    sid       = "DenyIAMActions"
    effect    = "Deny"
    actions   = ["iam:*"]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "roleA_policy" {
  provider    = aws.account_a
  name        = "roleA-admin-except-iam"
  description = "Allow administration of AWS services except IAM"
  policy      = data.aws_iam_policy_document.roleA_permissions.json
}

resource "aws_iam_role_policy_attachment" "roleA_attach" {
  provider   = aws.account_a
  role       = aws_iam_role.roleA.name
  policy_arn = aws_iam_policy.roleA_policy.arn
}


# ============================================================
# roleB - Can assume only roleC in Account B
# ============================================================

data "aws_iam_policy_document" "roleB_trust" {
  provider = aws.account_a

  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.account_a_id}:root"]
    }
  }
}

resource "aws_iam_role" "roleB" {
  provider           = aws.account_a
  name               = "roleB"
  assume_role_policy = data.aws_iam_policy_document.roleB_trust.json
}

data "aws_iam_policy_document" "roleB_permissions" {
  provider = aws.account_a

  statement {
    sid     = "AssumeOnlyRoleC"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    resources = [
      "arn:aws:iam::${var.account_b_id}:role/roleC"
    ]
  }
}

resource "aws_iam_role_policy" "roleB_policy" {
  provider = aws.account_a
  name     = "assume-roleC-only"
  role     = aws_iam_role.roleB.id
  policy   = data.aws_iam_policy_document.roleB_permissions.json
}


# ============================================================
# Allow Group1 and Group2 to assume roleB
# ============================================================

data "aws_iam_policy_document" "assume_roleB" {
  provider = aws.account_a

  statement {
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]
    resources = [aws_iam_role.roleB.arn]
  }
}

resource "aws_iam_group_policy" "group1_assume_roleB" {
  provider = aws.account_a
  name     = "assume-roleB"
  group    = aws_iam_group.group1.name
  policy   = data.aws_iam_policy_document.assume_roleB.json
}

resource "aws_iam_group_policy" "group2_assume_roleB" {
  provider = aws.account_a
  name     = "assume-roleB"
  group    = aws_iam_group.group2.name
  policy   = data.aws_iam_policy_document.assume_roleB.json
}

