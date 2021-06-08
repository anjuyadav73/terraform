resource "aws_autoscaling_policy" "eks-cluster-asp" {
  name                   = "${aws_eks_cluster.eks.name}-managednodegroup"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_eks_node_group.eks-node-group.resources[0].autoscaling_groups[0].name

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 70.0
  }
}
