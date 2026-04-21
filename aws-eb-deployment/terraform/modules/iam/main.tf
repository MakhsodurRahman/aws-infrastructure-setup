# Service Role for Elastic Beanstalk
resource "aws_iam_role" "service_role" {
  name = "aws-elasticbeanstalk-service-role-custom"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "elasticbeanstalk.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "service_role_eb_health" {
  role       = aws_iam_role.service_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSElasticBeanstalkEnhancedHealth"
}

resource "aws_iam_role_policy_attachment" "service_role_eb_service" {
  role       = aws_iam_role.service_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSElasticBeanstalkService"
}

# Instance Profile for EC2 Instances
resource "aws_iam_role" "instance_role" {
  name = "aws-elasticbeanstalk-ec2-role-custom"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "instance_role_eb_web" {
  role       = aws_iam_role.instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWebTier"
}

resource "aws_iam_role_policy_attachment" "instance_role_ecr" {
  role       = aws_iam_role.instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = "eb-instance-profile-custom"
  role = aws_iam_role.instance_role.name
}

output "service_role_arn" {
  value = aws_iam_role.service_role.arn
}

output "instance_profile_name" {
  value = aws_iam_instance_profile.instance_profile.name
}
