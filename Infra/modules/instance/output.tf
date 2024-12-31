output "ec2_instance_id" {
  value       = aws_instance.devops_ec2.id
  description = "The ID of the EC2 instance"
}

output "ec2_public_ip" {
  value       = aws_instance.devops_ec2.public_ip
  description = "The public IP address of the EC2 instance"
}

output "security_group_id" {
  value       = aws_security_group.devops_sg.id
  description = "The ID of the security group attached to the EC2 instance"
}
