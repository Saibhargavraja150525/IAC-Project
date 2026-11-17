# Cloud Infrastructure on AWS using Terraform

Infrastructure as Code project that provisions a small, secure web environment on AWS.

## What it builds
- VPC, public subnet, internet gateway and route table
- Security group: HTTP open to the world, SSH only from your own IP
- EC2 instance (Amazon Linux 2023) that installs nginx at launch through user data
- S3 bucket with versioning enabled and all public access blocked

## Design decisions (write your own reasons here too)
- Variables for region, CIDR ranges, instance type and names, so the code is reusable.
- SSH has no default CIDR and cannot be 0.0.0.0/0, so it is never opened to the whole internet by accident.
- Default tags (Project, ManagedBy) are applied to every resource.
- Outputs print the website URL and bucket name after apply.

## How to run
Prerequisites: Terraform 1.5+, an AWS account, and AWS CLI credentials configured (`aws configure`).

```bash
terraform init
terraform fmt
terraform validate

# create terraform.tfvars (it is git-ignored):
#   allowed_ssh_cidr = "YOUR.PUBLIC.IP/32"
#   bucket_name      = "your-unique-bucket-name-12345"

terraform plan
terraform apply
# open the website_url output in a browser
terraform destroy   # always run this when you finish, to avoid charges
```

## Cost note
Resources are small, but check your account's free-tier eligibility and always run `terraform destroy`.

## What I learned
(Add 3 to 4 lines in your own words: state files, plan vs apply, variables, security groups.)
