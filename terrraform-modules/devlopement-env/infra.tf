module "developement_infra" {
  source               = "../modules/network_componets"
  region_name          = var.region_name
  vpc_name             = var.vpc_name
  vpc_cidr_block       = var.vpc_cidr_block
  public_subnets_cidr  = var.public_subnets_cidr
  private_subnets_cidr = var.private_subnets_cidr
  Azs                  = var.Azs
}