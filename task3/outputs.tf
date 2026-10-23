output "roleA_arn" {
  value = aws_iam_role.roleA.arn
}

output "roleB_arn" {
  value = aws_iam_role.roleB.arn
}

output "roleC_arn" {
  value = aws_iam_role.roleC.arn
}

output "s3_bucket_name" {
  value = aws_s3_bucket.app_data.bucket
}

output "engine_access_key_id" {
  value     = aws_iam_access_key.engine.id
  sensitive = true
}

output "engine_secret_access_key" {
  value     = aws_iam_access_key.engine.secret
  sensitive = true
}

output "ci_access_key_id" {
  value     = aws_iam_access_key.ci.id
  sensitive = true
}

output "ci_secret_access_key" {
  value     = aws_iam_access_key.ci.secret
  sensitive = true
}

output "user1_encrypted_console_password" {
  value     = aws_iam_user_login_profile.user1.encrypted_password
  sensitive = true
}

output "user2_encrypted_console_password" {
  value     = aws_iam_user_login_profile.user2.encrypted_password
  sensitive = true
}
