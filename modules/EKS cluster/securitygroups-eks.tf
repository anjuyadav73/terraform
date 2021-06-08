resource "aws_security_group" "eks-cluster-sg" {
  name        = "${var.businessunit}-${var.environment}-${var.clustername}-clustersg"
  description = "Cluster communication with worker nodes"
  vpc_id      = var.vpcid

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.common_tags
}

resource "aws_security_group_rule" "eks-cluster-sg-ingress-node-https" {
  description              = "Allow pods to communicate with the cluster API Server"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks-cluster-sg.id
  source_security_group_id = aws_security_group.eks-node-sg.id
  to_port                  = 443
  type                     = "ingress"
}

resource "aws_security_group_rule" "eks-cluster-sg-ingress-workstation-https" {
  cidr_blocks       = [var.vpc-cidr]
  description       = "Allow workstation to communicate with the cluster API Server"
  from_port         = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.eks-cluster-sg.id
  to_port           = 443
  type              = "ingress"
}

resource "aws_security_group_rule" "eks-cluster-sg-ingress-tfe-https" {
  #cidr_blocks       = ["10.60.5.202/32"]
  cidr_blocks       = ["10.60.4.0/22"]
  description       = "Access from RSS Terraform"
  from_port         = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.eks-cluster-sg.id
  to_port           = 443
  type              = "ingress"
}
