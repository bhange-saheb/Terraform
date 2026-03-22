region_name          = "us-east-1"
vpc_name             = "Production_vpc"
vpc_cidr_block       = "10.168.0.0/16"
public_subnets_cidr  = ["10.168.1.0/24", "10.168.2.0/24", "10.168.3.0/24"]
private_subnets_cidr = ["10.168.10.0/24", "10.168.20.0/24", "10.168.30.0/24"]
Azs                  = ["us-east-1a", "us-east-1b", "us-east-1c"]
ami_IDs = {
  us-east-1 = "ami-0ec10929233384c7f"
  us-east-2 = "ami-07062e2a343acc423"
}
Ec2_InstacneType = "t2.micro"
Ec2_Key          = "KomalIDKey"
environment      = "Prod"