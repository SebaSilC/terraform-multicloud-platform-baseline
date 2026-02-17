# Terraform Multi-Cloud Platform Baseline

Production-oriented, modular Infrastructure-as-Code foundation implementing a secure AWS platform architecture structured for multi-cloud extensibility.

This repository reflects platform engineering practices rather than lab-style deployments.

---

## Architecture Overview

This project implements a layered platform foundation:

- Remote state bootstrap (S3 + DynamoDB locking)
- Environment isolation (dev / staging / prod)
- Modular network architecture (segmented VPC)
- IAM governance baseline with explicit deny guardrails
- Centralized audit logging (CloudTrail + encrypted S3)
- VPC Flow Logs for network visibility
- Standardized tagging abstraction
- CI validation with security scanning & plan generation

The structure is designed to scale across environments and extend to additional cloud providers.

---

## Repository Structure

```
bootstrap/
aws/                      # Remote state infrastructure

modules/
aws-network/              # VPC, subnets, routing, NAT, flow logs
aws-iam-baseline/         # Break-glass admin, read-only roles, guardrails
aws-logging-baseline/     # CloudTrail & centralized audit bucket
tagging/                  # Centralized tagging abstraction

platforms/
aws/
dev/
staging/
prod/

.github/workflows/
terraform-validation.yml  # CI validation & plan pipeline
```

---

## Environment Strategy

Each environment:

- Has isolated Terraform state
- Uses separate CIDR ranges
- Reuses the same modules
- Avoids Terraform workspaces
- Maintains deterministic configuration

---

## State isolation:

```
aws/dev/platform.tfstate
aws/staging/platform.tfstate
aws/prod/platform.tfstate
```

---

## Network Baseline

The network module implements:

- Segmented VPC architecture
- Public / private subnet separation
- Internet Gateway for public access
- NAT Gateway for private egress
- Explicit route table associations
- VPC Flow Logs with retention control

Single NAT is used for cost-aware dev baseline.  
Architecture can be extended to multi-AZ NAT for production resilience.

---

## IAM Governance Model

IAM baseline includes:

- MFA-enforced break-glass administrator role
- Scoped read-only role
- Explicit deny guardrail policy preventing:
  - CloudTrail deletion
  - Logging disablement
  - Flow log removal

Explicit deny overrides administrative permissions to protect the audit plane.

---

## Logging & Audit Baseline

Audit architecture includes:

- Multi-region CloudTrail
- Encrypted S3 log bucket
- Versioning enabled
- Public access blocked
- `prevent_destroy` lifecycle on audit bucket

This ensures tamper-resistant logging foundation.

---

## Tagging Strategy

Tagging is abstracted via a dedicated module to enforce:

- Environment tagging
- Project tagging
- ManagedBy metadata
- Future extensibility for cost center / ownership enforcement

Modules receive standardized tags from root configuration.

---

## CI / CD Validation Pipeline

GitHub Actions workflow:

- Runs on pull request
- Validates Terraform formatting
- Validates configuration
- Generates environment-specific plan
- Uploads plan artifacts
- Runs security scanning (tfsec + Checkov)

No automatic apply from pull requests.

This enforces shift-left infrastructure validation.

---

## Design Principles

- No hardcoded environments
- No mixed state usage
- No Terraform workspaces
- Modular separation of concerns
- Governance-first mindset
- Secure-by-default configuration
- Audit visibility preserved
- CI-enforced validation

---

## Future Extensions

- OPA policy-as-code enforcement
- Multi-account strategy
- Azure baseline parity
- Cost governance controls
- Centralized logging aggregation
- Production NAT HA model

---

## Author

Sebastian Silva C. - Cloud Engineer | Secure Infrastructure & Platform Automation - Berlin, Germany
