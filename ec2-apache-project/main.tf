module "ec2" {
    source = "./modules/ec2"
    instance_type = var.instance_type
    ami_id = var.ami_id
}