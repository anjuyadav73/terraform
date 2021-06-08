resource "aws_iam_role" "eks-node-role" {
  name = "${var.businessunit}-${var.environment}-${var.clustername}-ec2role"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
tags = local.common_tags
}

resource "aws_iam_role_policy_attachment" "eks-node-amazon-eksworker-nodepolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role = aws_iam_role.eks-node-role.name
}

resource "aws_iam_role_policy_attachment" "eks-node-amazoneks-cni-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role = aws_iam_role.eks-node-role.name
}

resource "aws_iam_role_policy_attachment" "eks-node-amazon-ec2container-registry-readonly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role = aws_iam_role.eks-node-role.name
}

resource "aws_iam_instance_profile" "eks-node" {
  name = "${var.businessunit}-${var.environment}-${var.clustername}-InstanceProfile"
  role = aws_iam_role.eks-node-role.name
}
