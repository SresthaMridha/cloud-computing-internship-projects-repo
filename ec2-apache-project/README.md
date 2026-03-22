# Project 5: Launch an EC2 Instance and Host a Web Server

> Cloud Computing Internship — Skillfied  
> **Stack:** AWS EC2 · Terraform · Apache2 · User Data

---

## Objective

Launch an EC2 instance on AWS using Terraform, configure a security group for HTTP and SSH access, and automatically deploy an Apache web server using a User Data bootstrap script.

---

## Project Structure

```
ec2-project/
├── modules/
│   └── ec2/
│       ├── main.tf         # EC2 instance + security group resources
│       ├── outputs.tf      # Module output: public_ip
│       └── variables.tf    # Module inputs: ami_id, instance_type
├── user_data/
│   └── apache.sh           # Bootstrap script: installs & starts Apache2
├── main.tf                  # Root config — calls the ec2 module
├── outputs.tf               # Root output — exposes public IP
├── provider.tf              # AWS provider + Terraform version config
├── terraform.tfvars         # Variable values
└── variables.tf             # Root variable declarations
```

---

## Resources Created

| Resource | Name | Details |
|----------|------|---------|
| `aws_instance` | apache-server | Ubuntu 24.04 LTS, t2.micro |
| `aws_security_group` | ec2-sg | Inbound: HTTP (80), SSH (22) — Outbound: all |

---

## Security Group Rules

| Direction | Protocol | Port | Source |
|-----------|----------|------|--------|
| Inbound | TCP | 80 | 0.0.0.0/0 |
| Inbound | TCP | 22 | 0.0.0.0/0 |
| Outbound | All | All | 0.0.0.0/0 |

---

## User Data Script

`user_data/apache.sh` runs automatically on first boot:

```bash
#!/bin/bash
apt update -y
apt install apache2 -y
systemctl start apache2
systemctl enable apache2
echo "<h1>Hello World from $(hostname -f)</h1>" > /var/www/html/index.html
```

---

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/install) >= 1.5
- [AWS CLI](https://aws.amazon.com/cli/) configured with valid credentials
- An AWS account with EC2 permissions

---

## Usage

```bash
terraform init
terraform validate
terraform plan
terraform apply   # outputs public_ip on success
terraform destroy
```

---

## Screenshots

| Step | Screenshot |
|------|-----------|
| Terraform apply output + public IP | `screenshots/cmd_showing_ip.png` |
| EC2 instance details | `screenshots/instance_details.png` |
| Security group rules | `screenshots/ec2_sg.png` |
| Apache web page in browser | `screenshots/web_output.png` |

---

## License

This project is part of an internship programme and is intended for learning purposes only.
