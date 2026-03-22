resource "aws_instance" "ec2" {
    ami = var.ami_id
    instance_type = var.instance_type
    user_data = file("${path.module}/../../user_data/apache.sh")
    vpc_security_group_ids = [aws_security_group.ec2_sg.id]

    tags = {
        Name = "apache-server"
    }
}

//security group
resource "aws_security_group" "ec2_sg" {
    name = "ec2-sg"

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}