# resource "aws_internet_gateway" "devops_igw" {
#   vpc_id = var.vpc_id
# }

data "aws_vpc" "existing_vpc" {
  id = var.vpc_id
}

resource "aws_eks_cluster" "devops_cluster" {
  name     = var.cluster_name
  version  = var.cluster_version
  role_arn = var.eks_role_arn
  vpc_config {
    subnet_ids = var.subnet_ids
  }
  depends_on = [data.aws_vpc.existing_vpc]
}

resource "aws_eks_node_group" "devops_node_group" {
  cluster_name    = aws_eks_cluster.devops_cluster.name
  node_group_name = "${var.cluster_name}-node-group"
  node_role_arn   = var.eks_node_role_arn
  subnet_ids      = var.subnet_ids
  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  instance_types = ["t3.medium"]
  depends_on = [aws_eks_cluster.devops_cluster]
}


# resource "eks" "devops_cluster" {

#   cluster_name    = var.cluster_name
#   cluster_version = var.cluster_version

#   cluster_endpoint_public_access = true
#   count = var.no_of_subnets

#   vpc_id                   = var.vpc_id

#   subnet_ids = [for i in range(var.no_of_subnets) : aws_subnet.devops_public_subnet[i].id]
#   control_plane_subnet_ids = [for i in range(var.no_of_subnets) : aws_subnet.devops_public_subnet[i].id]

#   eks_managed_node_groups = {
#     eks_nodes = {
#       desired_capacity = 2
#       max_capacity     = 3
#       min_capacity     = 1

#       instance_type = "t3.medium"
#     }
#   }
# }