# Project 5: Create IAM Users, Groups, and Policies

> **Cloud Computing Internship** — AWS + Terraform

## Objective

Create IAM users and groups, and assign permissions using policies.

## Problem Statement

Manage access to AWS resources by creating IAM users, groups, and attaching appropriate permissions — automated using Terraform as Infrastructure as Code (IaC).

---

## Project Overview

| Field | Details |
|---|---|
| Cloud Provider | Amazon Web Services (AWS) |
| IaC Tool | Terraform (v1.0+) |
| AWS Region | ap-south-1 (Mumbai) |
| IAM User | anshul |
| IAM Group | skillfied_mentors |
| Policy Attached | ReadOnlyAccess (AWS Managed) |

---

## Tasks

1. Create an IAM user
2. Create an IAM group
3. Attach a policy to the group
4. Add the user to the group
5. Login using IAM user credentials
6. Verify access permissions

---

## File Structure

```
project5-iam/
├── main.tf          # Core IAM resources
├── variables.tf     # Input variables
├── outputs.tf       # Output values
└── providers.tf     # AWS provider configuration
```

---

## Resources Created

| Resource | Type | Description |
|---|---|---|
| `aws_iam_user` | IAM User | Creates the user `anshul` |
| `aws_iam_user_login_profile` | Login Profile | Enables AWS Console login |
| `aws_iam_group` | IAM Group | Creates the group `skillfied_mentors` |
| `aws_iam_group_policy_attachment` | Policy Attachment | Attaches `ReadOnlyAccess` to the group |
| `aws_iam_group_membership` | Group Membership | Adds `anshul` to `skillfied_mentors` |

---

## Prerequisites

- AWS account with IAM administrative access
- [Terraform](https://developer.hashicorp.com/terraform/install) v1.0+
- AWS CLI configured (`aws configure`)

---

## Deployment

```bash
# 1. Initialize Terraform
terraform init

# 2. Preview changes
terraform plan

# 3. Apply configuration
terraform apply

# 4. Get outputs
terraform output
terraform output console_password   # retrieve the console password
```

---

## Login & Verification

**Task 5 — Login:**
1. Copy your 12-digit AWS Account ID from the IAM Dashboard
2. Open an incognito browser window
3. Go to `https://<account-id>.signin.aws.amazon.com/console`
4. Log in with username `anshul` and the password from `terraform output console_password`

**Task 6 — Verify:**
- Navigate to any AWS service (e.g., S3, EC2)
- Confirm you **can** view/list resources (ReadOnlyAccess)
- Confirm you **cannot** create or delete resources (policy enforced)

---

## Expected Outcome

An IAM user with controlled permissions through a group policy. The user can log in to the AWS Console and view resources but cannot make any modifications.

---

## Cleanup

```bash
terraform destroy
```

All IAM resources (user, group, policy attachment, login profile) will be removed from AWS.
