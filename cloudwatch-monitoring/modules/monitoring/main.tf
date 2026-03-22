resource "aws_cloudwatch_log_group" "log_group" {
    name = "/ec2/monitoring"
    retention_in_days = 7
}

resource "aws_iam_role" "cw_role" {
    name = "CWRole"
    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Effect = "Allow"
                Principal = {
                    Service = "ec2.amazonaws.com"
                }
                Action = "sts:AssumeRole"
            }
        ]
    })
}

resource "aws_iam_role_policy_attachment" "cw_attach" {
    role = aws_iam_role.cw_role.name
    policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_iam_instance_profile" "profile" {
    name = "CWProfile"
    role = aws_iam_role.cw_role.name
}

resource "aws_cloudwatch_metric_alarm" "CPU" {
    alarm_name = "CPUUtilization"
    comparison_operator = "GreaterThanThreshold"
    evaluation_periods = "2"
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    period = "120"
    statistic = "Average"
    threshold = "80"
    alarm_description = "Alarm when CPU exceeds 80%"

    dimensions = {
      InstanceId = var.instance_id
    }
    
}