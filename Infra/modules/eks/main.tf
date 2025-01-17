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

# Secrets Manager Policy Document for Nodes
data "aws_iam_policy_document" "secrets_manager" {
  statement {
    actions   = ["secretsmanager:GetSecretValue"]
    resources = ["arn:aws:secretsmanager:ap-south-1:242201305764:secret:aws-cred-OcpdHj"]
  }
}

# Attach Secrets Manager Policy to Node IAM Role
resource "aws_iam_role_policy" "node_secrets_policy" {
  role   = "AmazonEKSAutoNodeRole"
  policy = data.aws_iam_policy_document.secrets_manager.json
}

# Attach additional policy for Secrets Manager
resource "aws_iam_role_policy_attachment" "role_policy_attachment" {
  role       = "AmazonEKSAutoNodeRole"
  policy_arn = "arn:aws:iam::242201305764:policy/csi-eks-access-secret-manager"
}