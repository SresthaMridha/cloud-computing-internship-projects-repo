output "instance_id" {
    value = aws_instance.ec2.id  
}

output "ebs_vol_id" {
    value = aws_ebs_volume.ebs_vol.id
}