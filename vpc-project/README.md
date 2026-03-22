# Project 4: Create a VPC with Public and Private Subnets

> Cloud Computing Internship — Skillfied  
> **Stack:** AWS VPC · Terraform · AWS CLI

---

## Objective

Design and provision a basic network infrastructure using AWS VPC — one public subnet with internet access via an Internet Gateway, and one private subnet with local-only routing.

---

## Architecture

```
                    AWS Region: ap-south-1
              ┌─────────────────────────────────┐
              │         VPC: demo-vpc           │
              │         10.0.0.0/16             │
              │                                 │
              │  ┌──────────────────────────┐  │
              │  │  Public Subnet           │  │
              │  │  10.0.1.0/24             │  │
              │  │  Route: 0.0.0.0/0 → IGW  │  │
              │  └──────────────────────────┘  │
              │                                 │
              │  ┌──────────────────────────┐  │
              │  │  Private Subnet          │  │
              │  │  10.0.2.0/24             │  │
              │  │  Route: local only       │  │
              │  └──────────────────────────┘  │
              └──────────────┬──────────────────┘
                             │
                      Internet Gateway
                          (demo-igw)
                             │
                          Internet
```

---

## Project Structure

```
vpc-project/
├── modules/
│   └── vpc/
│       ├── main.tf         # VPC, subnets, IGW, route table resources
│       ├── outputs.tf      # Module outputs: vpc_id, subnet IDs
│       └── variables.tf    # Module inputs: CIDR blocks
├── main.tf                 # Root config — calls the vpc module
├── outputs.tf              # Root outputs — exposes IDs
├── provider.tf             # AWS provider + Terraform version config
├── terraform.tfvars        # Variable values
└── variables.tf            # Root variable declarations
```

---

## Resources Created

| Resource | Name | Details |
|----------|------|---------|
| `aws_vpc` | demo-vpc | CIDR: 10.0.0.0/16 |
| `aws_subnet` | demo-public-subnet | CIDR: 10.0.1.0/24 |
| `aws_subnet` | demo-private-subnet | CIDR: 10.0.2.0/24 |
| `aws_internet_gateway` | demo-igw | Attached to demo-vpc |
| `aws_route_table` | demo-public-rt | Route: 0.0.0.0/0 → IGW |
| `aws_route_table_association` | public_assoc | Links public subnet to public RT |

---

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/install) >= 1.5
- [AWS CLI](https://aws.amazon.com/cli/) configured with valid credentials
- An AWS account with VPC permissions

---

## Usage

```bash
terraform init
terraform validate
terraform plan
terraform apply
terraform destroy
```

---

## Screenshots

| Step | Screenshot |
|------|-----------|
| Terraform apply output | `screenshots/cmd_id_output.png` |
| VPC resource map | `screenshots/vpc_resourcemap.png` |
| Public subnet details | `screenshots/public_subnet.png` |
| Private subnet details | `screenshots/private_subnet.png` |
| Internet Gateway | `screenshots/igw.png` |
| Route table | `screenshots/route_table.png` |

---

## License

This project is part of an internship programme and is intended for learning purposes only.
