resource "aws_vpc" "devops_vpc" {
  cidr_block = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "${var.Name}_vpc"
  }
}

resource "aws_subnet" "devops_public_subnet" {
  count = var.no_of_subnets
  vpc_id = aws_vpc.devops_vpc.id
  cidr_block = element([var.public_subnet_cidr_1, var.public_subnet_cidr_2, var.public_subnet_cidr_3], count.index)
  availability_zone = element([var.public_subnet_az_1, var.public_subnet_az_2, var.public_subnet_az_3], count.index)
  map_public_ip_on_launch = true
  tags = {
    "Name" = "${var.Name}_public_subnet"
  }
}

# resource "aws_subnet" "devops_private_subnet" {
#   vpc_id = aws_vpc.devops_vpc.id
#   cidr_block = var.private_subnet_cidr
#   availability_zone = var.private_subnet_az
#   tags = {
#     "Name" = "${var.Name}_private_subnet"
#   }
# }

resource "aws_internet_gateway" "devops_igw" {
  vpc_id = aws_vpc.devops_vpc.id
  tags = {
    "Name" = "${var.Name}_igw"
  }
}

resource "aws_route_table" "devops_public_route" {
  vpc_id = aws_vpc.devops_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.devops_igw.id
  }
  tags = {
    Name = "${var.Name}-route-table"
  }
}

resource "aws_route_table_association" "devops_subnet_association" {
  count          = var.no_of_subnets
  subnet_id      = aws_subnet.devops_public_subnet[count.index].id
  route_table_id = aws_route_table.devops_public_route.id
}