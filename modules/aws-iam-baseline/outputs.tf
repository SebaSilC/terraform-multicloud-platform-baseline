output "break_glass_role_arn" {
  value = aws_iam_role.break_glass_admin.arn
}

output "read_only_role_arn" {
  value = aws_iam_role.read_only.arn
}
