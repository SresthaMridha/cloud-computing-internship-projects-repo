
resource "aws_ebs_volume" "ebs_vol" {
    availability_zone = aws_instance.ec2.availability_zone
    size = var.volume_size
    tags = {
        Name = "${var.project_name}-ebs-volume"
    }
}

resource "aws_volume_attachment" "ebs_attach" {
    device_name = var.device_name1
    volume_id = aws_ebs_volume.ebs_vol.id
    instance_id = aws_instance.ec2.id
}