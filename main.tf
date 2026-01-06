module "vpc" {
source = "./modules/vpc"

vpc_cidr = "10.0.0.0/16"

public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]

azs = ["us-east-1a", "us-east-1b"]

}

module "compute" {
  source = "./modules/compute"

  vpc_id              = module.vpc.vpc_id
  public_subnet_id    = module.vpc.public_subnets[0]
  private_subnet_ids  = module.vpc.private_subnets

  bastion_sg_id = module.Security.bastion_sg_id
  ec2_sg_id     = module.Security.ec2_sg_id

  ami_id        = "ami-068c0051b15cdb816"
  key_name      = "my-keypair"

  target_group_arn = module.alb.target_group_arn

}

module "Security" {
  source = "./modules/Security"

  vpc_id = module.vpc.vpc_id
  my_ip  = "154.180.79.67/32"
}

module "alb" {
  source = "./modules/alb"

  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnets
  alb_sg_id          = module.Security.alb_sg_id
}
