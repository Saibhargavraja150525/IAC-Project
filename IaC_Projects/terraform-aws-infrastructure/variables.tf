variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "ap-south-1" # Mumbai
}

variable "project_name" {
  description = "Prefix used for naming and tagging resources"
  type        = string
  default     = "iac-demo"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "instance_type" {
  description = "EC2 instance type (check free-tier eligibility for your account and region)"
  type        = string
  default     = "t3.micro"
}

variable "allowed_ssh_cidr" {
  description = "Your public IP in CIDR form for SSH access, for example 203.0.113.10/32. No default on purpose."
  type        = string

  validation {
    condition     = can(cidrhost(var.allowed_ssh_cidr, 0)) && var.allowed_ssh_cidr != "0.0.0.0/0"
    error_message = "Provide a valid CIDR and do not open SSH to the whole internet (0.0.0.0/0)."
  }
}

variable "bucket_name" {
  description = "Globally unique S3 bucket name (lowercase letters, numbers and hyphens)"
  type        = string
}
