# Step-by-Step Hands-on Terraform lab for creating EC2 Machine: Run Terraform from Your Local Machine

## Step 0: Prerequisites Checklist

You need:

-   An **AWS account**
    
-   An **IAM user** with programmatic access
    
-   **Access Key & Secret Key**
    
-   Terraform installed on your computer

## Step 1: Create an IAM User (One-Time Setup)

### In AWS Console:

1.  Go to **IAM → Users → Create user**
    
2.  Username: `terraform-user`
    
3.  Select:
    
    -   **Programmatic access**
        
4.  Attach policy:
    
    -   `AmazonEC2FullAccess`
        
    -   (For lab purpose only; later use least privilege)
        
5.  Download:
    
    -   **Access Key**
        
    -   **Secret Key**
        

⚠️ **Save these securely** - you won’t see the secret again once you leave the AWS page.

## Step 2: Install AWS CLI

 ### Mac
	brew install awscli


 ### Ubuntu / Linux
	sudo apt update && sudo apt install awscli -y


 ### Windows
 -   Download from AWS official site
    
-   Install MSI package

!Verify:
```bash aws --version```

## Step 3: Configure AWS Credentials Locally

	aws configure

### This creates:

```bash
~/.aws/credentials
~/.aws/config
```
Terraform will automatically read from here.

## Step 4: Install Terraform

### Mac
```bash
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
```
### Linux
```bash
sudo apt-get install terraform -y
```
!Verify:

	terraform version

## Step 5: Create AWS Key-pare
make sure you have public key (**my-ec2-key**) in AWS created

## Step 6: Initialize Terraform

	terraform init

It ownloads:
-   AWS provider &
    
-   Initializes project

## Step 7: Validate Terraform Configuration

	terraform validate
**Expected:** Success! The configuration is valid.

## Step 8: See What Terraform Will Do (Safe Step)

	terraform plan
**It should show:**

-   1 EC2 instance will be created
    
-   No actual change yet

## Step 9: Apply to Create EC2 Instance Using Terraform

	terraform apply
Enter a value (type): **yes** to confirm that you would like to create EC2 instance

### You should see (if there's no error):
***Apply complete! Resources: 1 added, 0 changed, 0 destroyed.***

**Outputs:**

```bash
instance_id = "i-091fbfcae9216a1bf"
instance_public_ip = "52.37.138.5"
instance_name = "ec2-lab-dev"
```
## Step 10: Verify in AWS Console

1.  Go to **EC2 → Instances**
    
2.  Look for:
  -   Name: `ec2-lab-dev`
        
    -   Region: ``



## Step 11: Destroy (IMPORTANT)

	terraform destroy

Enter a value (type): **yes** to confirm that you would like to DESTROY all resources created by Terraform

CHEERS!