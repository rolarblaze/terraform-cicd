module "vpc" {
  source   = "./modules/vpc"
  vpc_cidr = var.vpc_cidr

  vpc_subnets_cidr = var.vpc_subnets_cidr
}

module "sg" {
    source = "./modules/sg"
    vpc_id = module.vpc.vpc_id
}

module "ec2" {
    source = "./modules/ec2"
    subnets = module.vpc.subnet_id
    sg_id = module.sg.sg_id   
    
}

module "alb" {
  source = "./modules/alb"
  sg_id = module.sg.sg_id
  subnets = module.vpc.subnet_id
  vpc_id = module.vpc.vpc_id
  instances = module.ec2.instances
}

# module "ec2" {
#   source = "./modules/ec2"
#   sg_id = module.sg.sg_id
#   subnets = module.vpc.subnet_ids
# }
