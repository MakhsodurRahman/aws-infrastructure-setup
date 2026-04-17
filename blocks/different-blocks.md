# Terraform Blocks

In Terraform, **blocks** are the fundamental building units used to describe **infrastructure as code**. Each block has a specific purpose and syntax.

Here are the **main Terraform blocks**

## 1. "terraform" Block

Used to configure Terraform itself.

### Purpose:
- Define required Terraform version

- Define required providers

- Configure backend (remote state)

  

###  Sample code:

```bash
terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

 backend "s3" {
    bucket = "tf-state-bucket"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"
  }
}
```


## 2. "provider" Block
Defines **which cloud or service** Terraform will talk to. One project can have **multiple providers**.

### Purpose:

-   Authentication
    
-   Region / endpoint configuration
  

###  Sample code:
```bash
provider "aws" {
  region = "ap-south-1"
}

```

## 3. "resource" Block
The **most important block** – it creates actual infrastructure.

### Purpose:

- Create, update, delete infrastructure
  

###  Sample code:

```bash
resource "aws_instance" "web" {
  ami           = "ami-0abcdef"
  instance_type = "t2.micro"
}
```
### Format:
```bash
resource "<PROVIDER>_<TYPE>" "<NAME>" { }
```

## 4. "variable" Block
Defines **input variables**.

### Purpose:
-   Make code reusable
    
-   Avoid hard-coding values

  

###  Sample code:

```bash
variable "instance_type" {
  type    = string
  default = "t2.micro"
}
```

###  Usage:

```bash
instance_type = var.instance_type
```

## 5. "output" Block
Displays values after `terraform apply`.

### Purpose:
-   Show useful information
    
-   Pass values to other modules

  

###  Sample code:

```bash
output "instance_ip" {
  value = aws_instance.web.public_ip
}
```

## 6. "locals" Block
Defines **local variables** (computed values).

### Purpose:
-   Reduce repetition
    
-   Improve readability

  
###  Sample code:

```bash
locals {
  env = "dev"
  name = "web-${local.env}"
}
```

###  Usage:

```bash
tags = {
  Name = local.name
}
```

## 7. "data" Block
Used to **read existing resources**.

### Purpose:
-   Fetch data from cloud/provider
    
-   Do not create resources

  

###  Sample code:

```bash
data "aws_ami" "latest_amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
}
```

## 8. "module" Block
Used to **reuse Terraform code**.

### Purpose:
-   Create reusable infrastructure components
    
-   Keep code clean and scalable

  

###  Sample code:

```bash
module "vpc" {
  source = "./modules/vpc"
  cidr   = "10.0.0.0/16"
}
```

##  "lifecycle" Block (inside resource)
Controls **resource behavior**.

### Purpose:
-   Prevent deletion
    
-   Ignore changes
    
-   Create before destroy

  

###  Sample code:

```bash
resource "aws_instance" "web" {
  ami = "ami-xyz"

  lifecycle {
    prevent_destroy = true
  }
}
```

CHEERS!