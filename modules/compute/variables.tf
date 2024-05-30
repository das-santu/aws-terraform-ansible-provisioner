variable "instance_name" {
  description = "Name of the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "Type of EC2 instance (e.g., t2.micro)"
  type        = string
}

variable "instance_count" {
  description = "The number of instances to create"
  type        = number
}

variable "ami_id" {
  description = "ID of the AMI to use for the EC2 instance"
  type        = string
}

variable "subnet_ids" {
  description = "The IDs of the subnets"
  type        = list(string)
}

variable "key_name" {
  description = "SSH key name to use for the EC2 instance"
  type        = string
}

variable "security_groups" {
  description = "List of security group IDs to associate with the EC2 instance"
  type        = list(string)
}

variable "vpc_id" {
  description = "The VPC ID"
  type        = string
}

variable "environment" {
  description = "The environment to deploy (dev or prod)"
  type        = string
}