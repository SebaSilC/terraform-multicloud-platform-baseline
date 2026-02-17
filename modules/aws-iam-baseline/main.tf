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

########################################
# Guardrail Policy (Explicit Deny Controls)
########################################

resource "aws_iam_policy" "guardrail_deny_policy" {
  name        = "${var.environment}-guardrail-deny"
  description = "Prevents disabling audit and logging controls"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Deny"
        Action = [
          "cloudtrail:DeleteTrail",
          "cloudtrail:StopLogging",
          "logs:DeleteLogGroup",
          "logs:DeleteLogStream",
          "ec2:DeleteFlowLogs"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "guardrail_attachment" {
  role       = aws_iam_role.break_glass_admin.name
  policy_arn = aws_iam_policy.guardrail_deny_policy.arn
}
