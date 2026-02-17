########################################
# Break-Glass Admin Role
########################################

resource "aws_iam_role" "break_glass_admin" {
  name = "${var.environment}-break-glass-admin"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = var.admin_principal_arns
        }
        Action = "sts:AssumeRole"
        Condition = {
          Bool = {
            "aws:MultiFactorAuthPresent" = "true"
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "admin_policy" {
  role       = aws_iam_role.break_glass_admin.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

########################################
# Read-Only Role
########################################

resource "aws_iam_role" "read_only" {
  name = "${var.environment}-read-only"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = var.read_only_principal_arns
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "read_only_policy" {
  role       = aws_iam_role.read_only.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

