resource "aws_lb" "eks-lb" {
  name               = "${aws_eks_cluster.eks.name}-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.eks-node-sg.id]
  subnets            = [var.privatesubnet1,var.privatesubnet2]
  enable_deletion_protection = false

}

resource "aws_lb_target_group" "eks-lb-tg" {
  name     = "${aws_eks_cluster.eks.name}-tg"
  port     = 31440
  protocol = "HTTP"
  vpc_id   = var.vpcid
}

resource "aws_autoscaling_attachment" "asg-attachment-to-lb" {
  autoscaling_group_name = aws_eks_node_group.eks-node-group.resources[0].autoscaling_groups[0].name
  alb_target_group_arn   = aws_lb_target_group.eks-lb-tg.arn
}

resource "aws_lb_listener" "eks-alb-listner" {
  load_balancer_arn = aws_lb.eks-lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.eks-lb-tg.arn
  }
}
