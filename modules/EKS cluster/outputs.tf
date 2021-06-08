# outputs
locals {
  kubeconfig = <<KUBECONFIG

apiVersion: v1
clusters:
- cluster:
    server: ${aws_eks_cluster.eks.endpoint}
    certificate-authority-data: ${aws_eks_cluster.eks.certificate_authority[0].data}
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: aws
  name: aws
current-context: aws
kind: Config
preferences: {}
users:
- name: aws
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1alpha1
      command: aws-iam-authenticator
      args:
        - "token"
        - "-i"
        - "${aws_eks_cluster.eks.name}"
KUBECONFIG

}

# Join configuration

locals {
  config-map-aws-auth = <<CONFIGMAPAWSAUTH

apiVersion: v1
kind: ConfigMap
metadata:
  name: aws-auth
  namespace: kube-system
data:
  mapRoles: |
    - rolearn: ${aws_iam_role.eks-node-role.arn}
      username: system:node:{{EC2PrivateDNSName}}
      groups:
        - system:bootstrappers
        - system:nodes
    - rolearn: "arn:aws:iam::${var.aws-account-id}:role/Infrastructure-Deployer"
      groups:
        - system:masters
    - rolearn: "arn:aws:iam::${var.aws-account-id}:role/Administrator"
      groups:
        - system:masters
CONFIGMAPAWSAUTH

}

output "kubeconfig" {
  value = local.kubeconfig
  description = "Kube Config Output to be used by EKS Client"
}


output "cluster-endpoint" {
description = "The endpoint for your Kubernetes API server"
value       = aws_eks_cluster.eks.endpoint
}

output "eks-cluster-name" {
description = "The EKS Cluster Name"
value       = aws_eks_cluster.eks.name
}

output "config-map-aws-auth" {
description = "Config Map Output to be used by EKS Client Config"
value       = local.config-map-aws-auth
}

output "eks-node-role-arn" {
description = "The EKS node Role ARN"
value       = aws_iam_role.eks-node-role.arn
}

output "eks-node-sg" {
  value       = aws_security_group.eks-node-sg.id
  description = "EKS node security group ID"
}
output "eks-alb-tg-arn" {
  value       = aws_lb_target_group.eks-lb-tg.arn
}
