module "dev_ec2" {
  source            = "../modules/compute-components"
  ami_IDs           = var.ami_IDs
  Ec2_InstacneType  = var.Ec2_InstacneType
  Ec2_Key           = var.Ec2_Key
  sg_id             = module.dev_sg.sg_id
  region_name       = var.region_name
  environment       = var.environment
  public_subnets_id = module.developement_infra.public_subnets_id
  vpc_name          = module.developement_infra.vpc_name
  vpc_id            = module.developement_infra.vpc_id
  ec2_id            = module.dev_ec2.ec2_id
}


module "dev_sg" {
  source        = "../modules/security-componets"
  service_ports = ["80", "443", "445", "8080", "22", "3389"]
  vpc_id        = module.developement_infra.vpc_id
  vpc_name      = module.developement_infra.vpc_name
}
