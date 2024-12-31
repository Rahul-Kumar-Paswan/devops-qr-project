output "vpc_id" {
  value       = aws_vpc.devops_vpc.id
  description = "The ID of the VPC"
}

output "vpc_cidr_block" {
  value       = aws_vpc.devops_vpc.cidr_block
  description = "The CIDR block of the VPC"
}

# output "public_subnet_id" {
#   value       = aws_subnet.devops_public_subnet.id
#   description = "The ID of the public subnet"
# }

output "public_subnet_id" {
  value = aws_subnet.devops_public_subnet[*].id
}

# output "private_subnet_id" {
#   value       = aws_subnet.devops_private_subnet.id
#   description = "The ID of the private subnet"
# }

output "igw_id" {
  value       = aws_internet_gateway.devops_igw.id
  description = "The ID of the Internet Gateway"
}

output "public_route_table_id" {
  value       = aws_route_table.devops_public_route.id
  description = "The ID of the public route table"
}
