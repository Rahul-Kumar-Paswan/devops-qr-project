provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket          = "devops-qr-project"
    key             = "Terraform/terraform.tfstate"
    region          = "ap-south-1"
    #dynamodb_table = "Terraform-state-lock"
  }
}

module "vpc" {
  source               = "./modules/vpc"
  region               = var.region
  no_of_subnets        = var.no_of_subnets
  cidr_block           = var.cidr_block
  public_subnet_cidr_1   = var.public_subnet_cidr_1
  public_subnet_cidr_2   = var.public_subnet_cidr_2
  public_subnet_cidr_3   = var.public_subnet_cidr_3
  public_subnet_az_1     = var.public_subnet_az_1
  public_subnet_az_2     = var.public_subnet_az_2
  public_subnet_az_3     = var.public_subnet_az_3
  Name                   = var.Name
  # private_subnet_az    = var.private_subnet_az
}

module "Instance" {
  source         = "./modules/instance"
  ami            = var.ami
  instance_type  = var.instance_type
  Name           = var.Name
  vpc_id         = module.vpc.vpc_id
  subnet_id      = module.vpc.public_subnet_id[0]
}

# module "eks" {
#   source            = "./modules/eks"
#   cluster_name      =   var.cluster_name
#   cluster_version   = var.cluster_version
#   no_of_subnets     = var.no_of_subnets
#   eks_role_arn      = var.eks_role_arn
#   eks_node_role_arn = var.eks_node_role_arn
#   vpc_id            = module.vpc.vpc_id
#   subnet_ids        = module.vpc.public_subnet_id[*]
# }