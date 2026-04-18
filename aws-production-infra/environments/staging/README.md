# Staging Environment - Skeleton
# Copy main.tf, variables.tf, and outputs.tf from dev and adjust environment/cidr values.

# example main.tf call for staging:
/*
module "vpc" {
  source = "../../modules/vpc"
  environment = "staging"
  # ... other vars
}
*/
