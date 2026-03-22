# Project 2: Create an S3 Bucket and Manage Objects

> Cloud Computing Internship — Skillfied  
> **Stack:** AWS S3 · Terraform · AWS CLI

---

## Objective

Create an Amazon S3 bucket and perform basic file operations — upload, view, download, and delete objects — using Terraform for infrastructure provisioning and the AWS CLI for object management.

---

## Project Structure

```
s3-project/
├── files/
│   └── sample.txt          # File uploaded to the bucket
├── modules/
│   └── s3/
│       ├── main.tf         # S3 bucket + object resource definitions
│       ├── outputs.tf      # Module output: bucket name
│       └── variables.tf    # Module input variables
├── main.tf                 # Root config — calls the s3 module
├── outputs.tf              # Root output — exposes bucket name
├── provider.tf             # AWS provider + Terraform version config
├── terraform.tfvars        # Variable values
└── variables.tf            # Root variable declarations
```

---

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/install) >= 1.0
- [AWS CLI](https://aws.amazon.com/cli/) configured with valid credentials
- An AWS account with S3 permissions

---

## Usage

```bash
# Initialise Terraform and download providers
terraform init

# Validate configuration
terraform validate

# Preview changes
terraform plan

# Provision the S3 bucket and upload file
terraform apply

# Tear down all resources
terraform destroy
```

---

## AWS CLI Operations

```bash
# List objects in the bucket
aws s3 ls s3://<bucket-name>

# Download an object
aws s3 cp s3://<bucket-name>/sample.txt ./downloaded-sample.txt

# Delete all object versions (required when versioning is enabled)
aws s3api delete-objects --bucket <bucket-name> \
  --delete "$(aws s3api list-object-versions \
  --bucket <bucket-name> \
  --query '{Objects: Versions[].{Key:Key,VersionId:VersionId}}' \
  --output json)" --region ap-south-1

# Remove the now-empty bucket
aws s3 rb s3://<bucket-name> --region ap-south-1
```

---

## Errors & Fixes

| # | Error | Fix |
|---|-------|-----|
| 1 | `Unreadable module directory` — module path not found | Changed module source from `"s3"` to `"./modules/s3"` |
| 2 | `Invalid provider name` — `required_version` parsed as a provider | Added missing closing `}` in `required_providers` block |
| 3 | `Reference to undeclared module` — `module.s3_bucket` not found | Fixed reference to `module.s3.bucket_name` in root `outputs.tf` |
| 4 | `BucketAlreadyExists` — 409 on apply | Renamed bucket to a unique identifier in `terraform.tfvars` |
| 5 | `BucketNotEmpty` — delete failed despite removing objects | Versioning was on; deleted all versions via `s3api` before removing bucket |

---

## Screenshots

| Step | Screenshot |
|------|-----------|
| Bucket created | `screenshots/bucket_list.png` |
| Object uploaded | `screenshots/sample_txt_in_it.png` |
| CLI operations | `screenshots/cli_cmds.png` |
| Bucket deleted | `screenshots/deleting_bucket.png` |

---

## License

This project is part of an internship programme and is intended for learning purposes only.
