resource "aws_eks_node_group" "eks-node-group" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "${aws_eks_cluster.eks.name}-managednodegroup"
  node_role_arn   = aws_iam_role.eks-node-role.arn
  subnet_ids      = [var.privatesubnet1,var.privatesubnet2]
  release_version = var.ami-release-version

  remote_access {
  source_security_group_ids  = [aws_security_group.eks-node-sg.id]
  ec2_ssh_key = var.ec2keypair

  }

  scaling_config {
    desired_size = var.scaling-desired-size
    max_size     = var.scaling-max-size
    min_size     = var.scaling-min-size
  }
  tags = local.common_tags
  depends_on = [
  aws_iam_role_policy_attachment.eks-node-amazon-eksworker-nodepolicy,
  aws_iam_role_policy_attachment.eks-node-amazoneks-cni-policy,
  aws_iam_role_policy_attachment.eks-node-amazon-ec2container-registry-readonly,
  aws_security_group.eks-node-sg
  ]
}
