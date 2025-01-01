output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "The ID of the VPC"
}

output "vpc_cidr_block" {
  value       = module.vpc.vpc_cidr_block
  description = "The CIDR block of the VPC"
}

# output "public_subnet_id" {
#   value       = module.vpc.public_subnet_id
#   description = "The ID of the public subnet"
# }

output "public_subnet_id" {
  value = module.vpc.public_subnet_id
}

# output "private_subnet_id" {
#   value       = module.vpc.private_subnet_id
#   description = "The ID of the private subnet"
# }

output "igw_id" {
  value       = module.vpc.igw_id
  description = "The ID of the Internet Gateway"
}

output "public_route_table_id" {
  value       = module.vpc.public_route_table_id
  description = "The ID of the public route table"
}

# output "ec2_instance_id" {
#   value       = module.Instance.ec2_instance_id
#   description = "The ID of the EC2 instance"
# }

# output "ec2_public_ip" {
#   value       = module.Instance.ec2_public_ip
#   description = "The public IP address of the EC2 instance"
# }

# output "security_group_id" {
#   value       = module.Instance.security_group_id
#   description = "The ID of the security group attached to the EC2 instance"
# }

# output "cluster_endpoint" {
#   value = module.eks.cluster_endpoint
# }