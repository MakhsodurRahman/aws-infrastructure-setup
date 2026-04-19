output "asg_name" {
  description = "The name of the auto scaling group"
  value       = aws_autoscaling_group.main.name
}

output "asg_arn" {
  description = "The ARN of the auto scaling group"
  value       = aws_autoscaling_group.main.arn
}

output "iam_role_name" {
  description = "The name of the IAM role for EC2"
  value       = aws_iam_role.ec2_role.name
}

output "ec2_sg_id" {
  description = "The ID of the EC2 security group"
  value       = aws_security_group.ec2_sg.id
}

output "docker_version_check_ssh" {
  description = "Command to check Docker version on your instance via SSH"
  value       = "ssh ubuntu@<INSTANCE_IP> 'docker --version'"
}

output "docker_version" {
  description = "The assigned Docker version"
  value       = "27.4.0"
}

output "nginx_version" {
  description = "The assigned Nginx version"
  value       = "1.26.2"
}
