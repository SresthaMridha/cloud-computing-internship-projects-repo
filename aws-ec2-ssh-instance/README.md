[# 🖥️ AWS EC2 Instance Setup with Terraform

Provision and SSH into an EC2 instance on AWS using Terraform — no manual console clicking required.

---

## 📁 Project Structure

```
aws-ec2-ssh-instance/
├── provider.tf          # AWS provider and Terraform version config
├── variables.tf         # Input variable declarations
├── terraform.tfvars     # Variable values (region, AMI, instance type, etc.)
├── security_group.tf    # Security group with SSH (22) and HTTP (80) access
├── ec2_instance.tf      # EC2 instance + SSH key pair resources
└── outputs.tf           # Outputs: instance ID and public IP
```

---

## ⚙️ Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/install) >= 1.0
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) configured with valid credentials
- An SSH key pair generated locally

---

## 🚀 Usage

**1. Clone the repo**
```bash
git clone https://github.com/SresthaMridha/aws-ec2-ssh-instance.git
cd aws-ec2-ssh-instance
```

**2. Generate an SSH key pair**
```bash
ssh-keygen -t ed25519 -f ~/.ssh/ec2-key
```

**3. Update `terraform.tfvars` with your values**
```hcl
region          = "us-east-1"
project_name    = "aws-ec2-ssh-instance"
ami             = "ami-0ec10929233384c7f"   # x86_64 AMI
instance_type   = "t3.micro"
public_key_path = "~/.ssh/ec2-key.pub"
```

**4. Run Terraform**
```bash
terraform init
terraform validate
terraform plan
terraform apply
```

**5. SSH into the instance**
```bash
chmod 400 ~/.ssh/ec2-key
ssh -i ~/.ssh/ec2-key ubuntu@<public-ip>
```
> The public IP is printed as a Terraform output after `apply`.

---

## 🔐 Security Group Rules

| Port | Protocol | Purpose     |
|------|----------|-------------|
| 22   | TCP      | SSH access  |
| 80   | TCP      | HTTP access |

> ⚠️ CIDR is set to `0.0.0.0/0` for lab purposes. Restrict to your IP in production.

---

## 🧹 Cleanup

Destroy all provisioned resources when done:
```bash
terraform destroy
```

---

## 📌 Notes

- Use a **Nitro-based instance type** (e.g. `t3.micro`) — `t2.micro` does not support UEFI AMIs
- Make sure your AMI architecture matches your instance type (`x86_64` vs `arm64`)
- Private key permissions must be `400` or SSH will reject the key](https://github.com/SresthaMridha/cloud-computing-internship-projects-repo/tree/main/aws-ec2-ssh-instance)
