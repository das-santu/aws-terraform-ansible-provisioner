# Automating AWS Infrastructure Deployment with Terraform and Ansible

## Overview

This project sets up a network and compute resources on AWS for multiple environments (dev and prod) using Terraform and Ansible. The project is structured with modules for reusability and maintainability.

## Project Structure

- `modules/`: Contains reusable Terraform modules for network and compute resources.
- `envs/`: Contains environment-specific configurations.
  - `dev/`: Development environment.
  - `prod/`: Production environment.
- `ansible/`: Ansible Playbooks for Automated Configuration Management with Terraform
- `README.md`: Project documentation.

## Prerequisites
- AWS account with necessary credentials (access key and secret key)
- AWS CLI installed and configured with access and secret keys
- Terraform installed and configured
- Ansible installed and configured
- Familiarity with Terraform, Ansible, and AWS services

## How to Use

1. **Clone the repository to the local machine**:
    ```
    git clone https://github.com/das-santu/aws-terraform-ansible-provisioner.git
    cd aws-terraform-ansible-provisioner
    ```

1. **Initialize the Terraform backend**:
    ```
    terraform -chdir=envs/dev init
    terraform -chdir=envs/prod init
    ```

2. **Validate the configuration**:
    ```
    terraform -chdir=envs/dev validate
    terraform -chdir=envs/prod validate
    ```

3. **Plan the changes**:
    ```
    terraform -chdir=envs/dev plan -out=dev.tfplan
    terraform -chdir=envs/prod plan -out=prod.tfplan
    ```

4. **Apply the changes**:
    ```
    terraform -chdir=envs/dev apply -auto-approve dev.tfplan
    terraform -chdir=envs/prod apply -auto-approve prod.tfplan
    ```

5. **Destroy the enviroment**:
    ```
    terraform -chdir=envs/dev destroy -auto-approve
    terraform -chdir=envs/prod destroy -auto-approve
    ```

## Verify Web Application on EC2

Validate that the demo web application, running on a container and hosted on port **3000**, is operational. To confirm, follow these steps:

1. Obtain the public IP address of any EC2 instance and append port **3000** to it (e.g., **http://[ec2-public-ip]:3000**).
2. Open a web browser and navigate to the constructed URL. If the application is running, you should see the web application's user interface.

This step verifies that the Terraform Ansible provisioner has successfully deployed and configured the web application, making it accessible on the designated port, as expected.
