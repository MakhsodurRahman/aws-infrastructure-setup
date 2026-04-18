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
