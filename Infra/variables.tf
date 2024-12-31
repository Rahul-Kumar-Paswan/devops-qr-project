# variables of vpc

variable "region" {
  default      = "ap-south-1"
}

variable "cidr_block" {
  default = "10.0.0.0/16"
}

variable "no_of_subnets" {
  default = 3
}

variable "public_subnet_cidr_1" {
  default = "10.0.1.0/24"
}

variable "public_subnet_cidr_2" {
  default = "10.0.2.0/24"
}

variable "public_subnet_cidr_3" {
  default = "10.0.3.0/24"
}

# variable "private_subnet_cidr" {
#   default = "10.0.5.0/24" 
# }

variable "public_subnet_az_1" {
  default = "ap-south-1a"
}

variable "public_subnet_az_2" {
  default = "ap-south-1b"
}

variable "public_subnet_az_3" {
  default = "ap-south-1c"
}

# variable "private_subnet_az" {
#   default = "ap-south-1b"
# }

variable "Name" {
  default = "devops"
}

# variables of instance

variable "ami" {
  default = "ami-0fd05997b4dff7aac"
}

variable "instance_type" {
  default = "t2.micro"  
}

# variables of eks

variable "cluster_name" {
  default = "my-devops-cluster"
}

variable "cluster_version" {
  default = "1.28"
}

variable "eks_role_arn" {
  default = "arn:aws:iam::242201305764:role/AmazonEKSAutoClusterRole"
}

variable "eks_node_role_arn" {
  default = "arn:aws:iam::242201305764:role/AmazonEKSAutoNodeRole"
}