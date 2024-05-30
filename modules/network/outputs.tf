# VPC Output Values

# VPC ID
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "Public Subnet IDs of the VPC"
  value       = aws_subnet.public[*].id
}

output "security_group_ids" {
  description = "Security Group IDs of the VPC"
  value       = aws_security_group.main.id
}