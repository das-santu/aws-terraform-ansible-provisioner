locals {
  vpc_name               = "myvpc"
  vpc_cidr_block         = "10.0.0.0/16"
  vpc_availability_zones = ["ap-south-1a", "ap-south-1b"]
  vpc_public_subnets     = ["10.0.101.0/24", "10.0.102.0/24"]
  vpc_private_subnets    = ["10.0.1.0/24", "10.0.2.0/24"]
  security_group_ports   = [22, 80, 3000]
  vpc_enable_nat_gateway = true
  vpc_single_nat_gateway = true

  environment   = "dev"
  instance_name = "myweb-app"
  instance_type = "t2.micro"
  instance_count  = 3
  ami_id        = "ami-05e00961530ae1b55"
  key_name      = "itsme-key"

  ssh_private_key = "/home/vagrant/mp/itsme-key.pem"
  ssh_user        = "ubuntu"
}

module "network" {
  source = "../../modules/network"

  vpc_name               = "${local.environment}-vpc"
  vpc_cidr_block         = local.vpc_cidr_block
  vpc_availability_zones = local.vpc_availability_zones
  vpc_public_subnets     = local.vpc_public_subnets
  vpc_private_subnets    = local.vpc_private_subnets
  security_group_ports   = local.security_group_ports
}

module "compute" {
  source = "../../modules/compute"

  vpc_id         = module.network.vpc_id
  subnet_ids      = module.network.public_subnet_ids[*]
  environment    = local.environment
  instance_name  = local.instance_name
  instance_type  = local.instance_type
  instance_count = local.instance_count
  ami_id         = local.ami_id
  key_name       = local.key_name
  security_groups = [module.network.security_group_ids]
}

# Run Ansible playbook
resource "null_resource" "ansible_playbook" {

  count = length(module.compute.public_ip)

  provisioner "remote-exec" {
    inline = ["echo 'Wait for SSH is Ready'"]

    connection {
      type        = "ssh"
      user        = local.ssh_user
      private_key = file(local.ssh_private_key)
      host        = module.compute.public_ip[count.index]
    }
  }

  provisioner "local-exec" {
    command = <<EOT
      ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i '${module.compute.public_ip[count.index]},' -u ${local.ssh_user} --private-key ${local.ssh_private_key} ../../ansible/playbook.yaml
    EOT
  }
  depends_on = [module.compute]
}
