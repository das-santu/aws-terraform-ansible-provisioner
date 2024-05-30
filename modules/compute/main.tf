resource "aws_instance" "main" {
  count          = var.instance_count
  ami            = var.ami_id
  instance_type  = var.instance_type
  subnet_id      = element(var.subnet_ids, count.index)
  key_name       = var.key_name
  security_groups = var.security_groups

  tags = {
    Name = "${var.environment}-${var.instance_name}-${count.index}"
  }
}