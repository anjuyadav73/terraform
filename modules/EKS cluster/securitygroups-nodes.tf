# workers
resource "aws_security_group" "eks-node-sg" {
  name        = "${var.businessunit}-${var.environment}-${var.clustername}-nodesg"
  description = "Security group for all nodes in the cluster"
  vpc_id      = var.vpcid

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.common_tags
}

resource "aws_security_group_rule" "eks-node-sg-ingress-self" {
  description              = "Allow node to communicate with each other"
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.eks-node-sg.id
  source_security_group_id = aws_security_group.eks-cluster-sg.id
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "eks-node-sg-ingress-cluster" {
  description              = "Allow worker Kubelets and pods to receive communication from the cluster control plane"
  from_port                = 1025
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks-node-sg.id
  source_security_group_id = aws_security_group.eks-cluster-sg.id
  to_port                  = 65535
  type                     = "ingress"
}
