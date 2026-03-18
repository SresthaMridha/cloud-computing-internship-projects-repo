resource "aws_instance" "ec2_instance"{
    ami           = var.ami
    instance_type = var.instance_type
    associate_public_ip_address = true
    tags = {
        Name = "${var.project_name}-ec2-instance"
        Project = var.project_name
    }
    vpc_security_group_ids = [aws_security_group.sg.id]
    //attach access key EC2-Key.pem
    key_name = aws_key_pair.keypair.key_name
}

resource "aws_key_pair" "keypair" {
  key_name   = "${var.project_name}-key"
  public_key = file(var.public_key_path)
}
