# Production Environment - Skeleton
# Copy main.tf, variables.tf, and outputs.tf from dev and adjust environment/cidr values.

# example main.tf call for prod:
/*
module "vpc" {
  source = "../../modules/vpc"
  environment = "prod"
  # ... other vars
}
*/
