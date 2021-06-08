resource "aws_eks_cluster" "eks" {
  name     = "${var.businessunit}-${var.environment}-${var.clustername}"
  role_arn = aws_iam_role.eks-cluster-role.arn
  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  version = var.eks-version
  vpc_config {
    security_group_ids = [aws_security_group.eks-cluster-sg.id]
    subnet_ids = [var.privatesubnet1,var.privatesubnet2]
    endpoint_private_access = true
    endpoint_public_access = false
  }
  depends_on = [
    aws_iam_role_policy_attachment.eks-cluster-amazon-ekscluster-policy,
    aws_iam_role_policy_attachment.eks-cluster-amazon-eksservice-policy,
    aws_security_group.eks-cluster-sg
  ]
  tags = local.common_tags
}
