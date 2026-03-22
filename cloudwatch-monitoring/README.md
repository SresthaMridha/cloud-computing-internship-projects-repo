# Project 7: Enable Monitoring and Logs Using Amazon CloudWatch

> Cloud Computing Internship — Skillfied  
> **Stack:** AWS EC2 · CloudWatch · IAM · Terraform

---

## Objective

Monitor an EC2 instance using Amazon CloudWatch — track CPU utilization metrics, collect system logs via the CloudWatch Agent, and trigger an alarm when thresholds are exceeded.

---

## Architecture

```
EC2 Instance
    |
    |-- CloudWatch Metrics (CPUUtilization)
    |       |
    |       +-- CloudWatch Alarm (threshold: 80%, period: 120s)
    |               |-- OK -> ALARM (CPU high)
    |               +-- ALARM -> OK (CPU normal)
    |
    +-- CloudWatch Agent
            |
            +-- CloudWatch Logs (/ec2/monitoring)
                    |
                    +-- Log Stream: {instance_id}
```

---

## Project Structure

```
cloudwatch-monitoring/
├── modules/
│   └── monitoring/
│       ├── main.tf         # CloudWatch log group, IAM role, alarm
│       ├── outputs.tf      # Module output: alarm_name
│       └── variables.tf    # Module input: instance_id
├── user_data/
│   └── cw-agent.sh        # Script to install CloudWatch Agent
├── main.tf                 # Root config — calls the monitoring module
├── outputs.tf              # Root output — exposes alarm_name
├── provider.tf             # AWS provider + Terraform version config
├── terraform.tfvars        # Variable values
└── variables.tf            # Root variable declarations
```

---

## Resources Created

| Resource | Purpose |
|----------|---------|
| `aws_cloudwatch_log_group` | Log group `/ec2/monitoring` with 7-day retention |
| `aws_iam_role` | IAM role with EC2 trust policy for CloudWatch Agent |
| `aws_iam_role_policy_attachment` | Attaches `CloudWatchAgentServerPolicy` |
| `aws_iam_instance_profile` | Instance profile to attach role to EC2 |
| `aws_cloudwatch_metric_alarm` | CPU alarm — triggers at >80% over 2x120s periods |

---

## CloudWatch Agent Setup

Since the EC2 instance already existed, the agent was installed manually via SSH.

**Install:**
```bash
wget https://s3.amazonaws.com/amazoncloudwatch-agent/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb
sudo dpkg -i amazon-cloudwatch-agent.deb
```

**Configure** (`/opt/aws/amazon-cloudwatch-agent/etc/config.json`):
```json
{
  "logs": {
    "logs_collected": {
      "files": {
        "collect_list": [
          {
            "file_path": "/var/log/syslog",
            "log_group_name": "/ec2/monitoring",
            "log_stream_name": "{instance_id}"
          }
        ]
      }
    }
  }
}
```

**Start:**
```bash
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
  -a fetch-config -m ec2 \
  -c file:/opt/aws/amazon-cloudwatch-agent/etc/config.json \
  -s
```

---

## Stress Testing

```bash
# Generate CPU load
yes > /dev/null &
yes > /dev/null &
yes > /dev/null &
yes > /dev/null &

# Stop load
pkill yes
```

**Observed:** CPU spiked to ~100% → alarm transitioned OK → ALARM. After stopping, ALARM → OK.

---

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/install) >= 1.5
- [AWS CLI](https://aws.amazon.com/cli/) configured with valid credentials
- An existing EC2 instance ID to monitor

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
| Instance details + monitoring tab | `screenshot/instance_details_and_monitoring.png` |
| Stress test via EC2 console | `screenshot/stress_test_ec2_console_using_aws_console.png` |

---

## License

This project is part of an internship programme and is intended for learning purposes only.
