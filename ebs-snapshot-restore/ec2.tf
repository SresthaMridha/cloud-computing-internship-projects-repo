
resource "aws_security_group" "ec2_sg" {
  //connect to ssh to all
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    protocol = -1
    from_port = 0
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.project_name}-sg"
  }
}

//creating an ec2 instance
resource "aws_instance" "ec2" {
    ami = var.ami_id
    instance_type = var.instance_type
    availability_zone = var.availability_zone
    key_name = "EC2-Key"
    associate_public_ip_address = true
    tags = {
      Name = "${var.project_name}-instance"
    }
    vpc_security_group_ids = [aws_security_group.ec2_sg.id]
}

