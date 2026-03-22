# Project 3: Host a Static Website Using Amazon S3

> Cloud Computing Internship — Skillfied  
> **Stack:** AWS S3 · Terraform · Static Website Hosting

---

## Objective

Configure an S3 bucket to host a static website, upload an HTML file, enable public access, and access the site via the S3 website endpoint — all provisioned through Terraform.

---

## Project Structure

```
s3-website-project/
├── modules/
│   └── s3-website/
│       ├── main.tf         # S3 bucket, website config, public access, policy, object
│       ├── outputs.tf      # Module output: web_url
│       └── variables.tf    # Module input: bucket_name
├── website/
│   └── index.html          # Static HTML file served by the bucket
├── main.tf                 # Root config — calls the s3-website module
├── outputs.tf              # Root output — exposes web_url
├── provider.tf             # AWS provider + Terraform version config
├── terraform.tfvars        # Variable values
└── variables.tf            # Root variable declarations
```

---

## Resources Created

| Resource | Purpose |
|----------|---------|
| `aws_s3_bucket` | Creates the S3 bucket |
| `aws_s3_bucket_website_configuration` | Enables static website hosting with index.html |
| `aws_s3_bucket_public_access_block` | Disables all public access blocks |
| `aws_s3_bucket_policy` | Grants public `s3:GetObject` to all principals |
| `aws_s3_object` | Uploads index.html with `content_type = text/html` |

---

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/install) >= 1.5
- [AWS CLI](https://aws.amazon.com/cli/) configured with valid credentials
- An AWS account with S3 permissions

---

## Usage

```bash
terraform init
terraform validate
terraform plan
terraform apply   # outputs web_url on success
terraform destroy
```

---

## Screenshots

| Step | Screenshot |
|------|-----------|
| Bucket list | `screenshots/bucket_list.png` |
| Bucket contents (index.html) | `screenshots/bucket_content.png` |
| Terraform apply output + URL | `screenshots/cmd_showing_bucket_url.png` |
| Website in browser | `screenshots/website.png` |

---

## License

This project is part of an internship programme and is intended for learning purposes only.
