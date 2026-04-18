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
