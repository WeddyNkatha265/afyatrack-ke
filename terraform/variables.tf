variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Name of the project for resource tagging"
  type        = string
  default     = "afyatrack-ke"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "ubuntu_ami" {
  description = "Ubuntu 24.04 AMI ID"
  type        = string
  default     = "ami-0360c520857e3138f"  #  AMI
}

variable "key_pair_name" {
  description = "Name of the existing AWS key pair"
  type        = string
  default     = "awse2eproject"  # downloaded key pair name
}