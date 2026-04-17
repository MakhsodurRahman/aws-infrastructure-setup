## Step-by-Step Hands-on Terraform lab for creating S3 Bucket: Run Terraform from Your Local Machine

## Step 0: Prerequisites Checklist

You need:

-   An **AWS account**
-   AWS CLI configured on your local machine (`aws configure`)
-   Terraform installed on your computer

## Step 1: Create an IAM User (One-Time Setup)

### In AWS Console:

1.  Go to **IAM → Users → Create user**
    
2.  Username: `terraform-user`
    
3.  Select:
    
    -   **Programmatic access**
        
4.  Attach policy:
    
    -   `AmazonS3FullAccess`
        
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

## Step 5: Initialize Terraform

	terraform init

It ownloads:
-   AWS provider &
    
-   Initializes project

## Step 6: Validate Terraform Configuration

	terraform validate
**Expected:** Success! The configuration is valid.

## Step 7: See What Terraform Will Do (Safe Step)

	terraform plan
**It should show:**

Plan: 3 to add, 0 to change, 0 to destroy.

**Changes to Outputs:**
  + bucket_arn  = (known after apply)
  + bucket_name = "nure-terraform-s3-bucket-25"
    

## Step 8: Apply to Create S3 Bucket Using Terraform

	terraform apply
Enter a value (type): **yes** to confirm that you would like to create S3 Bucket

### You should see (if there's no error):
***Apply complete! Resources: 3 added, 0 changed, 0 destroyed.***

**Outputs:**

```bash
bucket_arn = "arn:aws:s3:::nure-terraform-s3-bucket-25"
bucket_name = "nure-terraform-s3-bucket-25"
```
## Step 9: Verify in AWS Console

1.  Go to **EC2 → S3**
    
2.  Look for:
  -   Bucket Name: `nure-terraform-s3-bucket-25`
        



## Step 9: Destroy (IMPORTANT)

	terraform destroy

Enter a value (type): **yes** to confirm that you would like to DESTROY all resources created by Terraform

**Output:** Destroy complete! Resources: 3 destroyed.

CHEERS!