#### EC2 outputs ####
output "ec2-instance-id" {
  value       = aws_instance.ec2-instance.*.id
  description = "Instance ID"
}

output "ec2-private-ip" {
  value       = aws_instance.ec2-instance.*.private_ip
  description = "Instance private IP"
}

output "ec2-private-dns" {
  value       = aws_instance.ec2-instance.*.private_dns
  description = "Instance Provate DNS"
}

output "ec2-Volume-id" {
  value       = var.create-ebs-volume == "true" ? aws_ebs_volume.ec2-ebs-volume.*.id : null
  description = "EBS volume ID"
}

output "ec2-subnet-id" {
  value       = var.subnet-id
  description = "Instance private IP"
}

