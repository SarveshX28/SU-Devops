variable "aws_region" {
  description = "AWS region for lab resources."
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Prefix for resource names."
  type        = string
  default     = "sarvesh-unit4-devops"
}

variable "ssh_allowed_cidr" {
  description = "Your public IP in CIDR form, e.g. 203.0.113.10/32. Never use 0.0.0.0/0."
  type        = string
  validation {
    condition     = can(cidrnetmask(var.ssh_allowed_cidr)) && var.ssh_allowed_cidr != "0.0.0.0/0"
    error_message = "Set ssh_allowed_cidr to a valid restricted CIDR, preferably your public IP /32."
  }
}

variable "key_pair_name" {
  description = "Name of an existing EC2 key pair in the selected region."
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type. Check availability and pricing in your region."
  type        = string
  default     = "t3.micro"
}
